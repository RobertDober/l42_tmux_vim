-- local dbg = require("debugger")
-- dbg.auto_where = 2

local stub = require'spec.helpers.stub_vim'
local api = stub.api
local stubber = stub.stubber
local random_string = require 'spec.helpers.random'.random_string

local tmux = require'l42.tmux'
describe("displays version", function()
  it("as a string", function()
    local version = random_string("version")
    stubber.var('l42_tmux_vim_version', version)
    tmux.version()
    local output = vim.api._echoed()[1]
    assert.is_equal(output, 'l42_tmux_vim v' .. version)
  end)
end)
--SPDX-License-Identifier: Apache-2.0
