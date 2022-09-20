-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function _matches(ctxt, entry)
  if string.match(ctxt.line, entry.line) then
    if entry.params then
      return entry.cmd .. ' ' .. entry.params
    else
      return entry.cmd
    end
  end
end

local function compile(ctxt, context_description)
  for _, entry in ipairs(context_description) do
    match = _matches(ctxt, entry)
    if match then
      return match
    end
  end
  return false
end

return {
  compile = compile
}
