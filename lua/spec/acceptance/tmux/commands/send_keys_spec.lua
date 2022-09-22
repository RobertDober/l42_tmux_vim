-- local dbg = require("debugger")
-- dbg.auto_where = 2

local stub = require'spec.helpers.stub_vim'
local api = stub.api
local random = require'spec.helpers.random'
local alt_window = random.random_string("alt win")
local speced_window = random.random_string("spec win")
local keys = random.random_string("keys")
local send_keys = "'" .. keys .. "'"

local stubber = stub.stubber
-- local stub_vim = stub.stub_vim

local commands = require'l42.tmux.commands'

describe('send_keys', function()
  before_each(api.reset_output)

  it('sends the keys to the default window', function()
    stubber.var('l42_tmux_alternate_window', alt_window)
    commands.send_keys(keys)
    assert.are.same({"system", {"tmux send-keys -t :=" .. alt_window .. " " .. send_keys .. " C-m" }}, vim.api._called()[1])
  end)

  it('sends the keys to the specified window', function()
    commands.send_keys(keys, speced_window)
    assert.are.same({"system", {"tmux send-keys -t :=" .. speced_window .. " " .. send_keys .. " C-m" }}, vim.api._called()[1])
  end)

  it('can avoid the return at the end of the line', function()
    commands.send_keys(keys, speced_window, true)
    assert.are.same({"system", {"tmux send-keys -t :=" .. speced_window .. " " .. send_keys }}, vim.api._called()[1])
  end)
end)
