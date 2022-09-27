-- local dbg = require("debugger")
-- dbg.auto_where = 2
local reduce = require'l42.tools.fn'.reduce
local range = require'l42.tools.fn'.range

describe("reduce and correct order in reducer", function()
  it("substracting", function()
    assert.is_equal(-55, reduce(range(1, 10), 0, function(acc, value) return acc - value end))
  end)
end)

describe("empty table, reducer is not called", function()
  it("does not fail", function()
    assert.is_equal(42, reduce({}, 42, function(a, v) assert(false) end))
  end)
end)
--SPDX-License-Identifier: Apache-2.0
