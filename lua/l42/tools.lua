-- local dbg = require("debugger")
-- dbg.auto_where = 2

local api = vim.api

local function p(value)
  echo(vim.inspect(value), true)
end

local function create_cmd(cmd_name, cmd_value, cmd_options, mapping)
  local cmd_options = cmd_options or {}
  api.nvim_create_user_command(cmd_name, cmd_value, cmd_options)

  if mapping then
    api.nvim_command('map ' .. mapping .. ' :' .. cmd_name .. '<CR>')
  end
end

local function echo(message, history, options)
  local history = history or false
  local options = options or {}
  api.nvim_echo({{message}}, history, options)
end

local function get_var(name, default, and_set)
  local ok, val = pcall(function() return api.nvim_get_var(name) end)
  if ok then
    return val
  else
    if and_set then
      api.nvim_set_var(name, default)
    end
    return default
  end
end

local function get_var_or(name, handler)
  local ok, val = pcall(function() return api.nvim_get_var(name) end)
  if ok then
    return val
  else
    if type(handler) == 'function' then
      return handler(name)
    elseif type(handler) == 'string' then
      error("attempt to read undefined variable: g:" .. name .. "; " .. string)
    else
      error("attempt to read undefined variable: g:" .. name)
    end
  end
end


local function init_var(name, value)
  return get_var(name, value, true)
end

local function system_cmd(cmd)
  api.nvim_call_function('system', {cmd})
end

return {
  create_command = create_cmd,
  echo = echo,
  get_var = get_var,
  get_var_or = get_var_or,
  init_var = init_var,
  p = p,
  system_cmd = system_cmd,
}
