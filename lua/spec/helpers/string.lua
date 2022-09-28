-- local dbg = require("debugger")
-- dbg.auto_where = 2

local map = require'l42.tools.fn'.map

local function split(inputstr, sep)
  if sep == "" then
    return map(inputstr)
  end
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

return {
  split = split
}
--SPDX-License-Identifier: Apache-2.0
