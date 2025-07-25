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

local function get_filename()
    local full_path = vim.fn.expand("%:p") or ""
    local git_root = search_git_root()
    if git_root and full_path:find(git_root, 1, true) == 1 then
        -- +2 to skip the trailing slash
        return full_path:sub(#git_root + 2)
    end
    -- fallback to just filename
    return vim.fn.expand("%:t") or ""
end

local function get_filetype() return vim.bo.filetype end

local function set_project_name()
    local project = search_git_root() or vim.fn.getcwd()
    vim.b.project_name = vim.fs.normalize(project)
end

local function set_branch_name()
    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null"):gsub("\n", "")
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
