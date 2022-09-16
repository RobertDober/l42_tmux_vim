-- local dbg = require("debugger")
-- dbg.auto_where = 2

local api = vim.api
local tmux = require'l42.tmux'
local t = require'l42.tools'

api.nvim_set_var('l42_tmux_vim_version', '0.1.0-beta4')

t.init_var('l42_tmux_mv_to_window_left', 'tl')
t.init_var('l42_tmux_mv_to_window_right', 'rl')

api.nvim_create_user_command('L42TmuxVimVersion', tmux.version, {})
api.nvim_create_user_command('L42MvToWindowLeft', tmux.mv_to_window_left, {})
api.nvim_create_user_command('L42MvToWindowRight', tmux.mv_to_window_right, {})
