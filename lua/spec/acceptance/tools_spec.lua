-- local dbg = require("debugger")
-- dbg.auto_where = 2

local stub = require'spec.helpers.stub_vim'
local random_string = require'spec.helpers.random'.random_string

local tools = require'l42.tools'

describe('get_var_or', function()
  local get = tools.get_var_or
  context('return values', function()
    it("can get an existing variable's value", function()
      local name = 'my_var'
      local value = random_string("value")
      stub.stubber.var(name, value)
      assert.is_equal(value, get(name))
    end)
    it("can return a hanlder's default value", function()
      local name = 'my_other_var'
      local result = random_string("result")
      local handler = function() return result end
      assert.is_equal(result, get(name, handler))
    end)
  end)

  context('raises an error', function()
    it("customized error message for an unexistant variable", function()
      local name = 'my_other_var'
      local ok, message = pcall(function() get(name, "no!") end)
      assert.is_false(ok)
      local expected =  'attempt to read undefined variable: g:my_other_var; no!'
      assert.is_equal(expected, string.match(message, expected .. '$'))
    end)
    it("default error message for an unexistant variable", function()
      local name = 'my_other_var'
      local ok, message = pcall(function() get(name) end)
      assert.is_false(ok)
      local expected =  'attempt to read undefined variable: g:my_other_var'
      assert.is_equal(expected, string.match(message, expected .. '$'))
    end)
  end)
end)
