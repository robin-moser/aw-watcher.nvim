local function get_filename() return vim.fn.expand("%p") or "" end

local function get_filetype() return vim.bo.filetype end

local function search_git_root()
    local root_dir
    for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
        if vim.fn.isdirectory(dir .. "/.git") == 1 then
            root_dir = dir
            break
        end
    end
    return root_dir
end

local function set_project_name()
    local project = search_git_root() or vim.fn.getcwd()
    vim.b.project_name = vim.fs.normalize(project):gsub(".*/", "")
end

local function set_branch_name()
    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n", "")
    vim.b.branch_name = branch == "" and "unknown" or branch
    return vim.b.branch_name
end

local has_notify, notify = pcall(require, "notify")
if has_notify then
    function notify(msg, level)
        vim.schedule(function() notify(msg, level, { title = "Activity Watcher" }) end)
    end
else
    function notify(msg, level)
        vim.schedule(function() vim.notify("[Activity Watcher] " .. msg, level) end)
    end
end

return {
    get_filename = get_filename,
    get_filetype = get_filetype,
    set_project_name = set_project_name,
    set_branch_name = set_branch_name,
    notify = notify,
}
