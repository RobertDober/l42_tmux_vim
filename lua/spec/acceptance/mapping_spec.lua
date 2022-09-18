-- local dbg = require("debugger")
-- dbg.auto_where = 2
local stub = require'spec.helpers.stub_vim'
require 'init'

describe("mappings", function()
  it("Move to alternate window", function()
    assert.are.same('map <Leader>uu :L42MvToAlternateWindow<CR>', vim.api._commands()[1])
  end)
  it("Move to left window", function()
    assert.are.same('map <Leader>hh :L42MvToWindowLeft<CR>', vim.api._commands()[2])
  end)
  it("Move to right window", function()
    assert.are.same('map <Leader>ll :L42MvToWindowRight<CR>', vim.api._commands()[3])
  end)

  it("Move to alternate window and again", function()
    assert.are.same('map <Leader>ta :L42MvToAlternateWindowAndAgain<CR>', vim.api._commands()[4])
  end)
  it("Move to left window_and_again", function()
    assert.are.same('map <Leader>tl :L42MvToWindowLeftAndAgain<CR>', vim.api._commands()[5])
  end)
  it("Move to right window_and_again", function()
    assert.are.same('map <Leader>tr :L42MvToWindowRightAndAgain<CR>', vim.api._commands()[6])
  end)
end)
