-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ctxt = require 'l42.context'
local cmds = require 'l42.tmux.commands'
local api = vim.api

local missing_alt_win =
  'Must indicate an alternate window in `g:l42_tmux_alternate_window` or provide a `dest` key in your command spec entry'

local function _issue_command(ctxt, entry)
  local dest = entry.dest or ctxt.alternate_window or error(missing_alt_win)

  local command = entry.cmd
  if entry.params then
    command = command .. ' ' .. entry.params
  end
  cmds.send_keys(command, dest)

  if entry.select == nil or entry.select then
    cmds.select_window(dest)
  end
end

local function _eval_spec_if_applies(ctxt, entry)
  local ft = entry.filetype or entry.ft
  if ft then
    if ft ~= api.nvim_get_option("filetype") then
      return false
    end
  end

  if entry.path_match then
    if not string.match(ctxt.file_path, entry.path_match) then
      return false
    end
  end

  local match = entry.match or ".*"
  if string.match(ctxt.line, match) then
    _issue_command(ctxt, entry)
    return true
  end
end

local function _find_and_eval_spec(ctxt, spec)
  for _, entry in ipairs(spec) do
    if _eval_spec_if_applies(ctxt, entry) then
      return true
    end
  end
  return false
end

return function(spec)
  local ctxt = ctxt()
  if type(spec[1]) == 'table' then
    _find_and_eval_spec(ctxt, spec)
  else
    _eval_spec_if_applies(ctxt, spec)
  end
end
