-- local dbg = require("debugger")
-- dbg.auto_where = 2

local t = require'l42.tools'
local api = vim.api

return function()
  return {
    api = api,
    alternate_window = t.get_var('l42_tmux_alternate_window'),
    cursor = api.nvim_win_get_cursor(0),
    file_name = api.nvim_eval('expand("%:t")'),
    file_path = api.nvim_eval('expand("%")'),
    line = api.nvim_get_current_line(),
    lnb = api.nvim_win_get_cursor(0)[1]
  }
end
