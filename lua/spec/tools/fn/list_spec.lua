-- local dbg = require("debugger")
-- dbg.auto_where = 2

local list = require'l42.tools.list'
describe('append', function()
  it('appends two lists and applies a function', function()
    local inc = function(a) return a + 1 end
    local lhs = {1, 2, 3}
    local rhs = {4}
    local result = list.append(lhs, rhs, inc)
    assert.are.same({2, 3, 4, 5}, result)
  end)
end)

describe('concat', function()
  it("appends many lists", function()
    assert.are.same(
      {1, 2, 3, 4, 5},
      list.concat({1, 2}, {3}, {}, {4, 5}))
  end)
end)
--SPDX-License-Identifier: Apache-2.0
