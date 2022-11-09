local cmd = vim.cmd

-- Replace common punctuation
-- iabbrev <buffer> -- –
-- iabbrev <buffer> --- —
-- iabbrev <buffer> << «
-- iabbrev <buffer> >> »

-- Open most folds
vim.api.nvim_command("setlocal foldlevel=6")

-- Default formatting
cmd([[
  let g:pencil#mode_indicators = {'hard': 'H', 'auto': 'A', 'soft': 'S', 'off': '',}
  let g:pencil#wrapModeDefault = 'soft'
  let g:pencil#cursorwrap = 0
]])

cmd([[
  augroup pencil
    autocmd!
    autocmd FileType markdown,md,mkd call pencil#init({'wrap': 'soft', 'autoformat': 1})
    autocmd FileType text         call pencil#init()
  augroup END

  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!
]])
