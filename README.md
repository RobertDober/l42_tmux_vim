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

- `L42MvToWindowLeft` mapped to `<Leader>tl`  `tl` can be overridden by setting `g:l42_tmux_mv_to_window_left`
- `L42MvToWindowRight` mapped to `<Leader>tr` `rl` can be overridden by setting `g:l42_tmux_mv_to_window_right`

- `L42MvToAlternateWindow` only defined if you define `g:l42_tmux_alternate_window`.
`g:l42_tmux_mv_to_alternate_window` can be changed with the `L42TmuxSetAlternateWindow` command (or `let g:l42....` of course)
Mapped to `<Leader>ta`, `ta` can be overridden by setting `g:l42_tmux_mv_to_alternate_window`
