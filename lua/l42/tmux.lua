-- local dbg = require("debugger")
-- dbg.auto_where = 2

local api = vim.api
local t = require'l42.tools'

local function compile_destination(window)
  if string.match(window, "^[-+]") then
    return " -t :" .. window
  end
  return " -t :=" .. window
end

local function switch_to(destination)
  api.nvim_command("write!")
  local destination = compile_destination(destination)

  local command = 'tmux select-window' .. destination
  -- t.echo("call: " .. command, true)
  api.nvim_call_function('system', {command})
end

local function again(window)
  api.nvim_command("write!")
  local destination = compile_destination(window)
  local command = "tmux send-keys" .. destination .. 'Up C-m'
end

function mv_to_alternate_window()
  local alt_window = t.get_var('l42_tmux_alternate_window')

  if alt_window then
    switch_to(alt_window)
  end
end

local function mv_to_window_left()
  switch_to('-1')
end

local function mv_to_window_right()
  switch_to('+1')
end

local function version()
  local current_version = api.nvim_get_var('l42_tmux_vim_version')
  t.echo("l42_tmux_vim v" .. current_version)
end

return {
  mv_to_alternate_window = mv_to_alternate_window,
  mv_to_window_left = mv_to_window_left,
  mv_to_window_right = mv_to_window_right,
  version = version
}
