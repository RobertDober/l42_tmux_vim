-- local dbg = require("debugger")
-- dbg.auto_where = 2

local stub = require'spec.helpers.stub_vim'
local api = stub.api
local commands = require'l42.tmux.commands'
local random_string = require'spec.helpers.random'.random_string

describe('compile_dest', function()
  local dest = random_string("dest")
  it('can compile a destination strictly', function()
    assert.is_equal(commands.compile_dest(dest), ' -t :=' .. dest .. ' ')
  end)
  it('or can compile a destination lazyly', function()
    assert.is_equal(commands.compile_dest(dest, true), ' -t ' .. dest .. ' ')
  end)
end)
--SPDX-License-Identifier: Apache-2.0

