-- local dbg = require("debugger")
-- dbg.auto_where = 2

local api = vim.api

return function()
  return {
    api = api,
    cursor = api.nvim_win_get_cursor(0),
    file_name = api.nvim_eval('expand("%:t")'),
    file_path = api.nvim_eval('expand("%")'),
    line = api.nvim_get_current_line(),
    lnb = api.nvim_win_get_cursor(0)[1]
  }
end
