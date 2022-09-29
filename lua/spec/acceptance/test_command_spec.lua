-- local dbg = require("debugger")
-- dbg.auto_where = 2
local stub = require'spec.helpers.stub_vim'
local api = stub.api
local stub_vim = stub.stub_vim
local stubber = stub.stubber

local tmux = require'l42.tmux'
describe("send test commands for rspec", function()
  before_each(function()
    api.reset_output()
    stub_vim{
      lines = {"", "# a comment", "  describe 'alpha'", "  context 'beta'", "  it 'gamma'"},
      path = "some_spec.rb",
    }
    stubber.var("l42_tmux_ruby_test_command", "bundle exec rspec")
    stubber.var("l42_tmux_ruby_test_window", "tests")
  end)
  it("call whole suite on empty line", function()
    stubber.cursor(1, 999)
    tmux.test_command()
    assert.are.same({"system", {"tmux send-keys -t :=tests 'bundle exec rspec' C-m"}}, vim.api._called()[1])
    assert.are.same({"system", {"tmux select-window -t :=tests"}}, vim.api._called()[2])
  end)
  it("call file with filenumber for describe line", function()
    stubber.cursor(3, 999)
    tmux.test_command()
    assert.are.same({"system", {"tmux send-keys -t :=tests 'bundle exec rspec some_spec.rb:3' C-m"}}, vim.api._called()[1])
    assert.are.same({"system", {"tmux select-window -t :=tests"}}, vim.api._called()[2])
  end)
  it("call file with filenumber for context line", function()
    stubber.cursor(4, 999)
    tmux.test_command()
    assert.are.same({"system", {"tmux send-keys -t :=tests 'bundle exec rspec some_spec.rb:4' C-m"}}, vim.api._called()[1])
    assert.are.same({"system", {"tmux select-window -t :=tests"}}, vim.api._called()[2])
  end)
  it("call file with filenumber for it line", function()
    stubber.cursor(5, 999)
    tmux.test_command()
    assert.are.same({"system", {"tmux send-keys -t :=tests 'bundle exec rspec some_spec.rb:5' C-m"}}, vim.api._called()[1])
    assert.are.same({"system", {"tmux select-window -t :=tests"}}, vim.api._called()[2])
  end)
  it("call file in any other case", function()
    stubber.cursor(2, 999)
    tmux.test_command()
    assert.are.same({"system", {"tmux send-keys -t :=tests 'bundle exec rspec some_spec.rb' C-m"}}, vim.api._called()[1])
    assert.are.same({"system", {"tmux select-window -t :=tests"}}, vim.api._called()[2])
  end)
end)

describe("send test commands for mix", function()
  before_each(function()
    api.reset_output()
    stub_vim{
      lines = {"", "# a comment", "  describe 'alpha'", "", "  test 'gamma'"},
      path = "some_test.exs",
    }
    stubber.var("l42_tmux_elixir_test_command", "mix test")
    stubber.var("l42_tmux_elixir_test_window", "tests")
  end)

  it("call whole suite on empty line", function()
    stubber.cursor(1, 999)
    tmux.test_command()
    assert.are.same({"system", {"tmux send-keys -t :=tests 'mix test' C-m"}}, vim.api._called()[1])
    assert.are.same({"system", {"tmux select-window -t :=tests"}}, vim.api._called()[2])
  end)
  it("call file with filenumber for describe line", function()
    stubber.cursor(3, 999)
    tmux.test_command()
    assert.are.same({"system", {"tmux send-keys -t :=tests 'mix test some_test.exs:3' C-m"}}, vim.api._called()[1])
    assert.are.same({"system", {"tmux select-window -t :=tests"}}, vim.api._called()[2])
  end)
  it("call file with filenumber for test line", function()
    stubber.cursor(5, 999)
    tmux.test_command()
    assert.are.same({"system", {"tmux send-keys -t :=tests 'mix test some_test.exs:5' C-m"}}, vim.api._called()[1])
    assert.are.same({"system", {"tmux select-window -t :=tests"}}, vim.api._called()[2])
  end)
  it("call file in any other case", function()
    stubber.cursor(2, 999)
    tmux.test_command()
    assert.are.same({"system", {"tmux send-keys -t :=tests 'mix test some_test.exs' C-m"}}, vim.api._called()[1])
    assert.are.same({"system", {"tmux select-window -t :=tests"}}, vim.api._called()[2])
  end)
end)
