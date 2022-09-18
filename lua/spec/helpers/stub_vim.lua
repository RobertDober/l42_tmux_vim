-- local dbg = require("debugger")
-- dbg.auto_where = 2
local lst = require 'l42.tools.list'
local split = require'l42.tools.string'.split

local _buffer = {
  cursor = {1, 0},
  lines = {},
  filename = "",
  path = ""
}

local _called = {
}

local _commands = {

}
local _options = {
}

local _evaluations = {
}

local _marks = {
}

local _user_commands = {
}

local _variables = {
}

local _vim = {
  api = {
    nvim_call_function = function(fname, params)
      table.insert(_called, {fname, params})
    end,
    nvim_command = function(cmd)
      table.insert(_commands, cmd)
    end,
    nvim_create_user_command = function(name, value, options)
      table.insert(_user_commands, {name, value, options})
    end,
    nvim_get_current_line = function()
      return _buffer.lines[_buffer.cursor[1]]
    end,
    nvim_win_get_cursor = function(_)
      return _buffer.cursor
    end,
    nvim_buf_get_lines = function(_, lnb1, lnb2, _)
      local lnb2 = lnb2
      if lnb2 < 0 then
        lnb2 = #_buffer.lines + 1 + lnb2
      end
      return lst.slice(_buffer.lines, lnb1 + 1, lnb2)
    end,
    nvim_buf_get_mark = function(_, mark)
      return _marks[mark] or {0, 0}
    end,
    nvim_buf_get_option = function(_, name)
      return _options[name]
    end,
    nvim_eval = function(cmd)
      return _evaluations[cmd]
    end,
    nvim_get_var = function(name)
      value = _variables[name]
      if value then
        return value
      end
      error("not found")
    end,
    nvim_set_var = function(name, value)
      _variables[name] = value
    end,
    nvim_win_set_cursor = function(_, cursor)
      _buffer.cursor = cursor
    end,
    nvim_buf_set_lines = function(_, lnb1, lnb2, _, lines)
      _buffer.lines = lst.replace(_buffer.lines, lnb1 + 1, lnb2, lines)
    end,

    reset_output = function()
      _called = {}
      _called = {}
      _commands = {}
      _options = {}
      _evaluations = {}
      _marks = {}
      _user_commands = {}
    end,

    reset_input = function()
      _variables= {}
    end,
    -- for inspection in tests
    _called = function() return _called end,
    _commands = function() return _commands end,
    _user_commands = function() return _user_commands end,
    _executed_commands = function() return _commands end,
    _variables = function() return _variables end,
  },
  inspect = tostring,
  __stubbed__ = true,
}

vim = vim or _vim

local stubber_api = {
  evaluation = function(cmd, result)
    _evaluations[cmd] = result
  end,
  cursor = function(...)
    _buffer.cursor = {...}
  end,
  lines = function(...)
    _buffer.lines = {...}
  end,
  option = function(key, value)
    _options[key] = value
  end,
  set_mark = function(mark, position)
    _marks[mark] = position
  end,
  var = function(key, value)
    _variables[key] = value
  end,
}

local function _set_marks_for_selection(selection)
  _marks["<"] = selection[1]
  _marks[">"] = selection[2]
end

local function _stub_path(path)
  local filename = split(path, "/")
  filename = filename[#filename]
  _evaluations['expand("%")'] = path
  _evaluations['expand("%:t")'] = filename
  _buffer.path = path
  _buffer.filename = filename
end

local function _stub_evaluations(evaluations)
  for _, evaluation in ipairs(evaluations) do
    _evaluations[evaluation[1]] = evaluation[2]
  end
end

local function _stub_vim(params)
  if params.evaluation then
    _evaluations[params.evaluation[1]] = params.evaluation[2]
  end
  if params.evaluations then
    _stub_evaluations(params.evaluations)
  end
  if params.cursor then
    _buffer.cursor = params.cursor
  end
  if params.lines then
    _buffer.lines = params.lines
  end
  if params.option then
    _options[params.option[1]] = params.option[2]
  end
  if params.ft then
    _options["filetype"] = params.ft
  end
  if params.path then
    _stub_path(params.path)
  end
  if params.selection then
    _set_marks_for_selection(params.selection)
  end
  if params.var then
    _variables[params.var[1]] = params.var[2]
  end
end

return {
  api = _vim.api,
  stub_vim = _stub_vim,
  stubber = stubber_api,
}
