" if (exists('g:loaded_ctrlp_ripgrep') && g:loaded_ctrlp_ripgrep)
"       \ || v:version < 700 || &cp
"   finish
" endif
" let g:loaded_ctrlp_ripgrep = 1

let s:ripgrep_var = {
  \ 'init': 'ctrlp#ripgrep#init()',
  \ 'accept': 'ctrlp#ripgrep#accept',
  \ 'lname': 'ripgrep',
  \ 'sname': 'ripgrep',
  \ 'type': 'path',
  \ 'exit': 'ctrlp#ripgrep#exit()',
  \ 'sort': 0,
  \ 'specinput': 0,
  \ }

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:ripgrep_var)
else
  let g:ctrlp_ext_vars = [s:ripgrep_var]
endif

function! ctrlp#ripgrep#exec(word)

  " grep pattarn
  if empty(a:word)
    " If not set, the word under the cursor
    let s:pattern = expand('<cword>')
  else
    let s:pattern = a:word
  endif

  let s:list = split(
    \ system( "rg --vimgrep" . ' ' . g:ripgrep_options . ' ' . s:pattern ), 
    \"\n"
    \ )

  if len(s:list) == 0
    echo("No results found for: ".s:pattern)
  else
    cal ctrlp#init(ctrlp#ripgrep#id())
  endif

endfunction

function! ctrlp#ripgrep#init()
  return s:list
endfunction

function! ctrlp#ripgrep#accept(mode, str)
  " Exit ctrlp
  call ctrlp#exit()
  " open file
  let [path, line, column; rest] = split(a:str, ':')
  call ctrlp#acceptfile(a:mode, path)
  call cursor(line, column)
endfunction

function! ctrlp#ripgrep#exit()
  " Clear results
  if exists('s:list')
    unlet! s:list
  endif
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#ripgrep#id()
  return s:id
endfunction

