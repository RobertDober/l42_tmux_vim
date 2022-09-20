# l42_tmux_vim

Command tmux from inside vim

## Synopsis

This plugin serves almost exclusively in the context where neovim is running inside
a tmux session. Nevertheless this plugin can also be used to communicate with tmux sessions
from the outside.
However in that case the user must switch to the tmux_session in question by hand.

If we are inside the same session we will be able to, e.g., while editing a ruby spec file,
launch the command `bundle exec rspec <name of the file>:<maybe line number>` from nvim
and switch to it automatically.

Other workflows implemented in this version are:

- Switch to window left/right with or without repeating the last command (in true `,.` vim philosophy)
- Switch to an alternate window (which has to be defined in a global variable), again repeating or not the last command

All these commands are mapped to normal mode keys, and these mappings can be configured by means of global variables, c.f. below

And there are more elaborate commands, that expose many tmux commands like `select-window` or `send-keys`.

Power users can always use the `Tmux` command which will translate to `:system("tmux ....")`

## Installation

Some alternatives:

- With plug or pathogene 

- automatic startup
   ```sh
   cd ~/.config/nvim/pack/start
   git clone https://github.com/RobertDober/l42_tmux_vim.git
   ```

- optional startup
   ```sh
   cd ~/.config/nvim/pack/opt
   git clone https://github.com/RobertDober/l42_tmux_vim.git

   echo "packadd! l42_tmux_vim" >> ~/.config/nvim/init.vim # or elswhere in your startup scripts
   ```


Check installation with the `L42TmuxVimVersion` command


## Commands

### Move Commands

All these commands write the current buffer before moving away

#### Just switch to neighboring window

- `L42MvToWindowLeft` mapped to `<Leader>hh`  can be overridden by setting `g:l42_tmux_mv_to_window_left`
- `L42MvToWindowRight` mapped to `<Leader>ll`  can be overridden by setting `g:l42_tmux_mv_to_window_right`

#### Just switch to your alternate window

- `L42MvToAlternateWindow` only defined if you define `g:l42_tmux_alternate_window`.
`g:l42_tmux_mv_to_alternate_window` can be changed with the `L42TmuxSetAlternateWindow` command (or `let g:l42....` of course)
Mapped to `<Leader>uu`, can be overridden by setting `g:l42_tmux_mv_to_alternate_window`

#### Switch to any window

- `L42MvToWindow` mapped to `<Leader>ww` and can be overridden by setting `g:l42_tmux_mv_to_window`
    **N.B.** this will leave you in the command line and you need to complete with the window's address

### Move Commands and run last shell command

All these commands write the current buffer before moving away

#### Switch to neighboring window and run last command

- `L42MvToWindowLeftAndAgain` mapped to `<Leader>tl`  can be overridden by setting `g:l42_tmux_mv_to_window_left_and_again`
- `L42MvToWindowRightAndAgain` mapped to `<Leader>tr`  can be overridden by setting `g:l42_tmux_mv_to_window_right_and_again`

#### Switch to alternate window and run last command

- `L42MvToAlternateWindowAndAgain` only defined if you define `g:l42_tmux_alternate_window`
`g:l42_tmux_mv_to_alternate_window` can be changed with the `L42TmuxSetAlternateWindow` command (or `let g:l42....` of course)
Mapped to `<Leader><Leader>ta`, can be overridden by setting `g:l42_tmux_mv_to_alternate_window_and_again`

#### Switch to any window and run last command

- `L42MvToWindowAndAgain` mapped to `<Leader>tw` and can be overridden by setting `g:l42_tmux_mv_to_window_and_again`
    **N.B.** this will leave you in the command line and you need to complete with the window's address

### File Specific Commands

#### `L42TmuxTest` commmand

It is mapped to `<Leader>tt` and an be remapped to `g:l42_tmux_test_command`

This command is file and context specific

#### RSpec commands (inside files which names match `*_spec.rb`)

If launched inside such a file it will, first save the file, and then, by default launch `rspec` with this file in the window called `tests` and switch there
This is governed by the following variables

- `l42_tmux_ruby_test_command` which defaults to `bundle exec rspec`
- `l42_tmux_ruby_test_window` which defaults to `tests`

Depending on the line your cursor is the following arguments are sent to the `l42_tmux_ruby_test_command`

- expanded name of the file with : and the line number appended if the line starts with `describe`, `context` or `it`
- nothing if on an empty line (runs the whole test suite)
- expanded name of the file in all other cases

#### Busted commands (inside files which names match `*_spec.lua`)

coming soon

#### Mix test commands (inside files which names match `*_test.exs`)

coming soon

### Make your own commands

If you know a little bit of lua you can easily create your own tmux related commands, either by extending the above defined commands in VimL or lua or,
if you want dynamic behavior by calling `l42.tmux.custom_command` of which the API is described hereafter.

You can require it as follows

#### `l42.tmux.custom_command`

`cc` (if required as such), is called with a table containing the following keys

- `cmd` _required_: this is the command that will be sent to the destination window
- `dest` _optional_ defaults to `l42_tmux_alternate_window`: this designates the destination window by its name
- `params` _optional_ defaults to the empty string: this will be appended to `cmd`
- `match` _optional_ defaults to `.*`: command will only be sent to `dest` if current line matches `match`
- `path_match` _optional_ defaults to `.*`: command will only be sent to `dest` if current buffer's path matches `path_match`
  *N.B.* these are [Lua Patterns](https://www.lua.org/pil/20.2.html) **not** regexen.
- `select` _optional_ defaults to `true`: set this to `false` if you do not wish tmux to select the `dest` window

You can also call `cc` with many of these tables here is an example which mimmicks how the tmux.test_command() works

```lua
local cc = require'l42.tmux.custom_command'
local ctxt = require'l42.context'

local function my_cmd()
  local ctxt = ctxt() -- evaluate context only now when invoking the command
  local rspec_window = ctxt.api.get_var('l42_tmux_ruby_test_window')
  cc(ctxt,
    {
      -- if in an rspec file and a context line
      {
        cmd = ctxt.api.get_var('l42_tmux_ruby_test_command'), -- reads g:l42_tmux_ruby_test_command
        dest = rspec_window,
        path_match = '_spec%.rb$',
        match = '^%s*context%s', -- we are at the beginning of an RSpec context block ...
        params = ctxt.file_path .. ':' .. ctxt.lnb, -- ... therefore we tell rspec to execute this file with the line number
      },
      -- if in an rspec file
      {
        cmd = ctxt.api.get_var('l42_tmux_ruby_test_command'), -- reads g:l42_tmux_ruby_test_command
        dest = rspec_window,
        path_match = '_spec%.rb$',
      },
      -- if in an elixir test file we know our test shell is in the alternate window 
      {
        cmd = 'mix test',
        path_match = '_test%.exs$',
        match = '^%s*test%s'
        params = ctxt.file_path .. ':' .. ctxt.lnb
      },
      -- else we want just to save the vim buffer in the window to our right (contrieved)
      {
        cmd = ':w!',
        dest = '+1',
        select = false
    })
end
```
