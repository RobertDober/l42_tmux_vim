-- local dbg = require("debugger")
-- dbg.auto_where = 2
local random_string = require'spec.helpers.random'.random_string
local stub = require'spec.helpers.stub_vim'

local tmux = require'l42.tmux'
describe("movement functions", function()
  before_each(stub.api.reset_output)
  it("can move to the left", function()
    vim.api.reset_output()
    tmux.mv_to_window_left()
    assert.are.same({"system", {"tmux select-window -t :-1"}}, vim.api._called()[1])
  end)
  it("can move to the right", function()
    vim.api.reset_output()
    tmux.mv_to_window_right()
    assert.are.same({"system", {"tmux select-window -t :+1"}}, vim.api._called()[1])
  end)
  it("can move to the alternate window #alt", function()
    value = random_string("alt_window")
    stub.stubber.var("l42_tmux_alternate_window", value)
    tmux.mv_to_alternate_window()
    assert.are.same({"system", {"tmux select-window -t :=" .. value}}, vim.api._called()[1])
  end)

  it("can move to the left and again", function()
    tmux.mv_to_window_left_and_again()
    assert.are.same({"system", {"tmux send-keys -t :-1 'Up' C-m"}}, vim.api._called()[1])
    assert.are.same({"system", {"tmux select-window -t :-1"}}, vim.api._called()[2])
  end)
  it("can move to the right and again", function()
    tmux.mv_to_window_right_and_again()
    assert.are.same({"system", {"tmux send-keys -t :+1 'Up' C-m"}}, vim.api._called()[1])
    assert.are.same({"system", {"tmux select-window -t :+1"}}, vim.api._called()[2])
  end)
  it("can move to the alternate window and again", function()
    value = random_string("alt_window")
    stub.stubber.var("l42_tmux_alternate_window", value)
    tmux.mv_to_alternate_window_and_again()
    assert.are.same({"system", {"tmux send-keys -t :=" .. value .. " 'Up' C-m"}}, vim.api._called()[1])
    assert.are.same({"system", {"tmux select-window -t :=" .. value}}, vim.api._called()[2])
  end)
end)
--SPDX-License-Identifier: Apache-2.0
