# l42_tmux_vim

Command tmux from inside vim

## Installation

Some alternatives:

- With plug or pathogene 

- put into `~/.config/nvim/pack/start`

- put into `~/.config/nvim/pack/opt`
  `packadd! l42_tmux_vim` in your startup scripts


Check installation with the `L42TmuxVimVersion` command

## Commands

### Move Commands

All these commands write the current buffer before moving away

- `L42MvToWindowLeft` mapped to `<Leader>hh`  can be overridden by setting `g:l42_tmux_mv_to_window_left`
- `L42MvToWindowRight` mapped to `<Leader>ll`  can be overridden by setting `g:l42_tmux_mv_to_window_right`

- `L42MvToAlternateWindow` only defined if you define `g:l42_tmux_alternate_window`.
`g:l42_tmux_mv_to_alternate_window` can be changed with the `L42TmuxSetAlternateWindow` command (or `let g:l42....` of course)
Mapped to `<Leader>uu`, can be overridden by setting `g:l42_tmux_mv_to_alternate_window`

### Move Commands and run last shell command

All these commands write the current buffer before moving away

- `L42MvToWindowLeftAndAgain` mapped to `<Leader>tl`  can be overridden by setting `g:l42_tmux_mv_to_window_left_and_again`
- `L42MvToWindowRightAndAgain` mapped to `<Leader>tr`  can be overridden by setting `g:l42_tmux_mv_to_window_right_and_again`

- `L42MvToAlternateWindowAndAgain` only defined if you define `g:l42_tmux_alternate_window`.
`g:l42_tmux_mv_to_alternate_window` can be changed with the `L42TmuxSetAlternateWindow` command (or `let g:l42....` of course)
Mapped to `<Leader><Leader>ta`, can be overridden by setting `g:l42_tmux_mv_to_alternate_window_and_again`
