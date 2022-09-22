-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ctxt = require'l42.context'
local api = vim.api

local t = require'l42.tools'
local compile_context_command = require'l42.tmux.context_commands'.compile

local function compile_destination(window)
  if string.match(window, "^[-+]") then
    return " -t :" .. window
  end
  return " -t :=" .. window
end

local function send_keys(destination, keys, do_write)
  if do_write then
    api.nvim_command("write!")
  end

  local destination = compile_destination(destination)

  local command = 'tmux send-keys' .. destination .. ' ' .. keys
  -- t.echo("call: " .. command, true)
  api.nvim_call_function('system', {command})
end

local function switch_to(destination, do_not_write)
  if not do_not_write then
    api.nvim_command("write!")
  end
  local destination = compile_destination(destination)

  local command = 'tmux select-window' .. destination
  -- t.echo("call: " .. command, true)
  api.nvim_call_function('system', {command})
end

function mv_to_alternate_window()
  local alt_window = t.get_var_or('l42_tmux_alternate_window')

  if alt_window then
    switch_to(alt_window)
  end
end

function mv_to_alternate_window_and_again()
  local alt_window = t.get_var('l42_tmux_alternate_window')

  if alt_window then
    send_keys(alt_window, 'Up C-m')
    switch_to(alt_window)
  end
end

local function mv_to_window_left()
  switch_to('-1')
end

local function mv_to_window_left_and_again()
  send_keys('-1', 'Up C-m')
  switch_to('-1')
end

local function mv_to_window_right()
  switch_to('+1')
end

local function mv_to_window_right_and_again()
  send_keys('+1', 'Up C-m')
  switch_to('+1')
end

local function _rspec_test_command(ctxt)
  local cmd = t.get_var('l42_tmux_ruby_test_command')
  local line = ctxt.file_path .. ":" .. ctxt.lnb

  local context_command = compile_context_command(ctxt, {
    {
      line = "^%s*context%s",
      cmd = cmd,
      params = line
    },
    {
      line = "^%s*describe%s",
      cmd = cmd,
      params = line
    },
    {
      line = "^%s*it%s",
      cmd = cmd,
      params = line
    },
    {
      line = "^%s*$",
      cmd = cmd,
    },
    {
      line = ".*",
      cmd = cmd,
      params = ctxt.file_path
    }
  })

  if context_command then
    local ruby_test_window = t.get_var('l42_tmux_ruby_test_window')
    send_keys(ruby_test_window, "'" .. context_command .. "' C-m", true)
    switch_to(ruby_test_window, true)
  end

end
local function test_command()
  local ctxt = ctxt()
  if string.match(ctxt.file_name, "_spec%.rb$") then
    return _rspec_test_command(ctxt)
  end
end

local function version()
  local current_version = t.get_var('l42_tmux_vim_version', 'unknown')
  t.echo("l42_tmux_vim v" .. current_version)
end

return {
  mv_to_alternate_window = mv_to_alternate_window,
  mv_to_alternate_window_and_again = mv_to_alternate_window_and_again,
  mv_to_window_left = mv_to_window_left,
  mv_to_window_left_and_again = mv_to_window_left_and_again,
  mv_to_window_right = mv_to_window_right,
  mv_to_window_right_and_again = mv_to_window_right_and_again,
  test_command = test_command,
  version = version
}
