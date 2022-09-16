-- local dbg = require("debugger")
-- dbg.auto_where = 2

local api = vim.api

local function echo(message, history, options)
  local history = history or false
  local options = options or {}
  api.nvim_echo({{message}}, history, options)
end
-- Exception Handling à la Lua
local function get_var(name)
  local getter = function()
    vim.api.nvim_get_var(name)
  end
  return pcall(getter)
end

local function init_var(name, value)
  local old_value = get_var(name)
  if old_value then
    return old_value
  end

  api.nvim_set_var(name, value)
  return value
end

return {
  create_command = create_command,
  echo = echo,
  get_var = get_var,
  init_var = init_var
}
