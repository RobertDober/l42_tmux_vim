-- local dbg = require("debugger")
-- dbg.auto_where = 2

local stub = require'spec.helpers.stub_vim'
local api = stub.api
local random = require'spec.helpers.random'
local alt_window = random.random_string("alt win")
local speced_window = random.random_string("spec win")

local stubber = stub.stubber
-- local stub_vim = stub.stub_vim

local commands = require'l42.tmux.commands'

describe('select_window', function()
  before_each(api.reset_output)
  it('issues the necessary command for the default destination (alternate window)', function()
    stubber.var('l42_tmux_alternate_window', alt_window)
    commands.select_window()
    assert.are.same({"system", {"tmux select-window -t :=" .. alt_window .. " " }}, vim.api._called()[1])
  end)

  it('issues the necessary command for the indicated destination', function()
    commands.select_window(speced_window)
    assert.are.same({"system", {"tmux select-window -t :=" .. speced_window .. " " }}, vim.api._called()[1])
  end)
end)

