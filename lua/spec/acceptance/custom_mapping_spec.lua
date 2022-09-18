local dbg = require("debugger")
dbg.auto_where = 2

local random_string = require'spec.helpers.random'.random_string
local stub = require'spec.helpers.stub_vim'

local alt = ',alt'
local left = ',left'
local right = ',right'

local alt_again = ',altagain'
local left_again = ',leftagain'
local right_again = ',rightagain'

stub.stubber.var("l42_tmux_mv_to_alternate_window", alt)
stub.stubber.var("l42_tmux_mv_to_window_left", left)
stub.stubber.var("l42_tmux_mv_to_window_right", right)
stub.stubber.var("l42_tmux_mv_to_alterate_window_and_again", alt_again)
stub.stubber.var("l42_tmux_mv_to_window_left_and_again", left_again)
stub.stubber.var("l42_tmux_mv_to_window_right_and_again", right_again)
require 'init'

describe("custom mappings", function()
  it("Move to alternate window", function()
    assert.are.same('map '..alt..' :L42MvToAlternateWindow<CR>', vim.api._commands()[1])
  end)
  it("Move to left window", function()
    assert.are.same('map '..left..' :L42MvToWindowLeft<CR>', vim.api._commands()[2])
  end)
  it("Move to right window", function()
    assert.are.same('map '..right..' :L42MvToWindowRight<CR>', vim.api._commands()[3])
  end)

  it("Move to alternate window and again", function()
    assert.are.same('map '..alt_again..' :L42MvToAlternateWindowAndAgain<CR>', vim.api._commands()[4])
  end)
  it("Move to left window_and_again", function()
    assert.are.same('map '..left_again..' :L42MvToWindowLeftAndAgain<CR>', vim.api._commands()[5])
  end)
  it("Move to right window_and_again", function()
    assert.are.same('map '..right_again..' :L42MvToWindowRightAndAgain<CR>', vim.api._commands()[6])
  end)
end)
