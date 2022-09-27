-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ctxt = require'l42.context'
local api  = vim.api

local t  = require'l42.tools'
local cc = require'l42.tmux.custom_command'
local c = require'l42.tmux.commands'

function mv_to_alternate_window()
  local alt_window = t.get_var_or('l42_tmux_alternate_window')

  if alt_window then
    c.select_window(alt_window)
  end
end

function mv_to_alternate_window_and_again()
  local alt_window = t.get_var('l42_tmux_alternate_window')

  if alt_window then
    c.send_keys('Up', alt_window)
    c.select_window(alt_window)
  end
end

local function mv_to_window_left()
  c.select_window('-1')
end

local function mv_to_window_left_and_again()
  c.send_keys('Up', '-1')
  c.select_window('-1')
end

local function mv_to_window_right()
  c.select_window('+1')
end

local function mv_to_window_right_and_again()
  c.send_keys('Up', '+1')
  c.select_window('+1')
end

local function _rspec_test_command(ctxt)
  local cmd = t.get_var('l42_tmux_ruby_test_command')
  local dest = t.get_var('l42_tmux_ruby_test_window')
  local line = ctxt.file_path .. ":" .. ctxt.lnb

  cc{
    {
      match = "^%s*context%s",
      cmd = cmd,
      dest = dest,
      params = line
    },
    {
      match = "^%s*describe%s",
      cmd = cmd,
      dest = dest,
      params = line
    },
    {
      match = "^%s*it%s",
      cmd = cmd,
      dest = dest,
      params = line
    },
    {
      cmd = cmd,
      dest = dest,
      match = "^%s*$",
    },
    {
      match = ".*",
      cmd = cmd,
      dest = dest,
      params = ctxt.file_path
    }
  }

  if context_command then
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
