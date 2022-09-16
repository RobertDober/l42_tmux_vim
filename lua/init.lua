-- local dbg = require("debugger")
-- dbg.auto_where = 2

local api = vim.api
local tmux = require'l42.tmux'
local t = require'l42.tools'

api.nvim_set_var('l42_tmux_vim_version', '0.1.0-beta4')

local ta = t.init_var('l42_tmux_mv_to_alternate_window', 'ta')
local tl = t.init_var('l42_tmux_mv_to_window_left', 'tl')
local tr = t.init_var('l42_tmux_mv_to_window_right', 'tr')

t.create_command('L42MvToAlternateWindow', tmux.mv_to_alternate_window, {}, '<Leader>' .. ta)
t.create_command('L42MvToWindowLeft', tmux.mv_to_window_left, {}, '<Leader>' .. tl )
t.create_command('L42MvToWindowRight', tmux.mv_to_window_right, {}, '<Leader>' .. tr)

t.create_command('L42TmuxVimVersion', tmux.version, {}, '<Leader>' .. 'vers')
