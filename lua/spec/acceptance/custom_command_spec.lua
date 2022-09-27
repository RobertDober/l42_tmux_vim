-- local dbg = require("debugger")
-- dbg.auto_where = 2
local stub = require'spec.helpers.stub_vim'
local api = stub.api
local stub_vim = stub.stub_vim
local stubber = stub.stubber

local cc = require'l42.tmux.custom_command'
local alt_window = require'spec.helpers.random'.random_string("alt win")
local dest = ' -t :=' .. alt_window

describe("MVP", function()
  before_each(function()
    api.reset_output()
    stub_vim{
      lines = {"", "# a comment", "  describe 'alpha'", "  context 'beta'", "  it 'gamma'"},
      ft    = "elixir",
      path  = "dir/base.ext",
      var   = {'l42_tmux_alternate_window', alt_window}
    }
  end)
  it('does not need any context', function()
    cc{
      cmd = "hello world"
    }
    assert.are.same({"system", {"tmux send-keys" .. dest .. " 'hello world' C-m"}}, vim.api._called()[1])
    assert.are.same({"system", {"tmux select-window" .. dest}}, vim.api._called()[2])
  end)

  describe('matching lines', function()
    it('matches a comment', function()
      stubber.cursor(2)
      cc{
        cmd = "on comment",
        match = "^%s*#%s",
        select = false,
      }
      assert.are.same({"system", {"tmux send-keys" .. dest .. " 'on comment' C-m"}}, vim.api._called()[1])
      assert.is_nil(vim.api._called()[2])
    end)
    it('does not match a comment', function()
      stubber.cursor(3)
      cc{
        cmd = "on comment",
        match = "^%s*#%s",
        select = false,
      }
      assert.is_nil(vim.api._called()[1])
    end)
  end)

  describe('matching filetypes', function()
    it('matches the filetype', function()
      cc{
        cmd = "this is elixir",
        ft  = "elixir",
      }
      assert.are.same({"system", {"tmux send-keys" .. dest .. " 'this is elixir' C-m"}}, vim.api._called()[1])
      assert.are.same({"system", {"tmux select-window" .. dest}}, vim.api._called()[2])
    end)
    it('does not match the filetype', function()
      stubber.option("filetype", "ruby")
      cc{
        cmd = "this is elixir",
        ft  = "elixir",
      }
      assert.is_nil(vim.api._called()[1])
    end)
  end)

  describe('matching path names', function()
    it('matches the path #wip', function()
      cc{
        cmd = 'echo',
        path_match = '^dir.*%.ext$',
        params = 'world'
      }
      assert.are.same({"system", {"tmux send-keys" .. dest .. " 'echo world' C-m"}}, vim.api._called()[1])
      assert.are.same({"system", {"tmux select-window" .. dest}}, vim.api._called()[2])
    end)
    it('does not match the path #wip', function()
      cc{
        cmd = 'echo',
        path_match = '^else.*%.ext$',
        params = 'world'
      }
      assert.is_nil(vim.api._called()[1])
    end)
  end)

  describe('matching more patterns', function()
    it('matches the first pattern', function()
      cc{
        {
          cmd = 'first',
          ft  = 'elixir',
        },
        {
          cmd = 'second',
          ft  = 'ruby'
        }
      }
      assert.are.same({"system", {"tmux send-keys" .. dest .. " 'first' C-m"}}, vim.api._called()[1])
      assert.are.same({"system", {"tmux select-window" .. dest}}, vim.api._called()[2])
      assert.is_nil(vim.api._called()[3])
    end)
    it('matches the second pattern', function()
      cc{
        {
          cmd = 'first',
          ft  = 'ruby',
        },
        {
          cmd = 'second',
          ft  = 'elixir'
        }
      }
      assert.are.same({"system", {"tmux send-keys" .. dest .. " 'second' C-m"}}, vim.api._called()[1])
      assert.are.same({"system", {"tmux select-window" .. dest}}, vim.api._called()[2])
      assert.is_nil(vim.api._called()[3])
    end)
    it('matches none', function()
      cc{
        {
          cmd = 'first',
          ft  = 'ruby',
        },
        {
          cmd = 'second',
          ft  = 'python'
        }
      }
      assert.is_nil(vim.api._called()[1])
    end)
  end)
end)
