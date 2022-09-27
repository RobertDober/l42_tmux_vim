-- local dbg = require("debugger")
-- dbg.auto_where = 2

local api = vim.api
local tmux = require'l42.tmux'
local t = require'l42.tools'

api.nvim_set_var('l42_tmux_vim_version', '0.1.0-beta4')

local ta = t.init_var('l42_tmux_mv_to_alternate_window', '<Leader>uu')
local tl = t.init_var('l42_tmux_mv_to_window_left', '<Leader>hh')
local tr = t.init_var('l42_tmux_mv_to_window_right', '<Leader>ll')
local taa = t.init_var('l42_tmux_mv_to_alternate_window_again', '<Leader>ta')
local tla = t.init_var('l42_tmux_mv_to_window_left_again', '<Leader>tl')
local tra = t.init_var('l42_tmux_mv_to_window_right_again', '<Leader>tr')
local tt  = t.init_var('l42_tmux_test_command', '<Leader>tt')
t.init_var('l42_tmux_ruby_test_command', 'bundle exec rspec')
t.init_var('l42_tmux_ruby_test_window', 'tests')


t.create_cmd('L42MvToAlternateWindow', tmux.mv_to_alternate_window, {}, ta)
t.create_cmd('L42MvToWindowLeft', tmux.mv_to_window_left, {}, tl )
t.create_cmd('L42MvToWindowRight', tmux.mv_to_window_right, {}, tr)
t.create_cmd('L42MvToAlternateWindowAndAgain', tmux.mv_to_alternate_window_and_again, {}, taa)
t.create_cmd('L42MvToWindowLeftAndAgain', tmux.mv_to_window_left_and_again, {}, tla )
t.create_cmd('L42MvToWindowRightAndAgain', tmux.mv_to_window_right_and_again, {}, tra)

t.create_cmd('L42TmuxTest', tmux.test_command, {}, tt)

t.create_cmd('L42TmuxVimVersion', tmux.version, {}, '<Leader>vers')
