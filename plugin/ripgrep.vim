if exists('g:loaded_ripgrep_vim')
  finish
endif
let g:loaded_ripgrep_vim = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=* CtrlPRg call ctrlp#ripgrep#exec(<q-args>)
command! -nargs=* Rg call ripgrep#rg_start(<q-args>)
command! Rgstop call ripgrep#rg_stop()

if exists('g:ripgrep_options')
	let g:ripgrep_options .= ''
else
  let g:ripgrep_options = '--hidden'
endif

let &cpo = s:save_cpo
unlet s:save_cpo
