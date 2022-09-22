-- local dbg = require("debugger")
-- dbg.auto_where = 2


local api = vim.api
local t = require 'l42.tools'

-- Forward Declarations
local tmux_cmd

local function compile_dest(dest, lazy)
  if lazy then
    return ' -t ' .. dest .. ' '
  else
    return ' -t :=' .. dest .. ' '
  end
end

local function select_window(dest)
  local dest = dest or t.get_var_or('l42_tmux_alternate_window')
  tmux_cmd('select-window', dest)
end

local function send_keys(keys, dest, no_return)
  local dest = dest or t.get_var_or('l42_tmux_alternate_window')
  local suffix = " C-m"
  if no_return then
    suffix = ""
  end
  tmux_cmd('send-keys', dest, "'" .. keys .. "'" .. suffix)
end

tmux_cmd = function(cmd, dest, args)
  local args = args or ''
  command = 'tmux ' .. cmd .. compile_dest(dest) .. args
  t.system_cmd(command)
end

return {
  compile_dest  = compile_dest,
  select_window = select_window,
  send_keys     = send_keys,
  tmux_cmd      = tmux_cmd
}
