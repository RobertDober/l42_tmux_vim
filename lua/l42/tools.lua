local dbg = require("debugger")
dbg.auto_where = 2

local api = vim.api

local function p(value)
  echo(vim.inspect(value), true)
end

local function create_cmd(cmd_name, cmd_value, cmd_options, mapping)
  local cmd_options = cmd_options or {}
  api.nvim_create_user_command(cmd_name, cmd_value, cmd_options)

  if mapping then
    dbg()
    api.nvim_command('map ' .. mapping .. ' :' .. cmd_name .. '<CR>')
  end
end

local function echo(message, history, options)
  local history = history or false
  local options = options or {}
  api.nvim_echo({{message}}, history, options)
end

local function get_var(name, default)
  local getter = function()
    return vim.api.nvim_get_var(name)
  end
  -- Exception Handling à la Lua
  local ok, val = pcall(getter)
  if ok then
    return val
  else
    return default
  end
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
  create_command = create_cmd,
  echo = echo,
  get_var = get_var,
  init_var = init_var,
  p = p
}
