-- local dbg = require("debugger")
-- dbg.auto_where = 2

local api = vim.api
local tmux = require'l42.tmux'
local t = require'l42.tools'

api.nvim_set_var('l42_tmux_vim_version', '0.1.0-beta4')

local ta = t.get_var('l42_tmux_mv_to_alternate_window', '<Leader>uu')
local tl = t.get_var('l42_tmux_mv_to_window_left', '<Leader>hh')
local tr = t.get_var('l42_tmux_mv_to_window_right', '<Leader>ll')
local taa = t.get_var('l42_tmux_mv_to_alternate_window_again', '<Leader>ta')
local tla = t.get_var('l42_tmux_mv_to_window_left_again', '<Leader>tl')
local tra = t.get_var('l42_tmux_mv_to_window_right_again', '<Leader>tr')


t.create_command('L42MvToAlternateWindow', tmux.mv_to_alternate_window, {}, ta)
-- t.create_command('L42MvToWindowLeft', tmux.mv_to_window_left, {}, tl )
-- t.create_command('L42MvToWindowRight', tmux.mv_to_window_right, {}, tr)
-- t.create_command('L42MvToAlternateWindowAndAgain', tmux.mv_to_alternate_window_and_again, {}, taa)
-- t.create_command('L42MvToWindowLeftAndAgain', tmux.mv_to_window_left_and_again, {}, tla )
-- t.create_command('L42MvToWindowRightAndAgain', tmux.mv_to_window_right_and_again, {}, tra)

-- t.create_command('L42TmuxVimVersion', tmux.version, {}, '<Leader>vers')
