-- local dbg = require("debugger")
-- dbg.auto_where = 2
local stub = require'spec.helpers.stub_vim'
require 'init'
local tmux = require'l42.tmux'

describe("user_commands", function()
  it("move to alternate window", function()
    assert.are.same({'L42MvToAlternateWindow', tmux.mv_to_alternate_window, {}}, vim.api._user_commands()[1])
  end)
  it("move to left window", function()
    assert.are.same({'L42MvToWindowLeft', tmux.mv_to_window_left, {}}, vim.api._user_commands()[2])
  end)
  it("move to right window", function()
    assert.are.same({'L42MvToWindowRight', tmux.mv_to_window_right, {}}, vim.api._user_commands()[3])
  end)
  it("move to alternate window and again", function()
    assert.are.same({'L42MvToAlternateWindowAndAgain', tmux.mv_to_alternate_window_and_again, {}}, vim.api._user_commands()[4])
  end)
  it("move to left window and again", function()
    assert.are.same({'L42MvToWindowLeftAndAgain', tmux.mv_to_window_left_and_again, {}}, vim.api._user_commands()[5])
  end)
  it("move to right window and again", function()
    assert.are.same({'L42MvToWindowRightAndAgain', tmux.mv_to_window_right_and_again, {}}, vim.api._user_commands()[6])
  end)
end)
