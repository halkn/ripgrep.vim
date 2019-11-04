let s:jobs = []

function! s:rg_err_cb(ch, line)
  echomsg a:line
endfunction

function! s:rg_out_cb(ch, line)
  caddexpr a:line
endfunction

function! ripgrep#rg_start(arg)
  " grep pattarn
  if empty(a:arg)
    " If not set, the word under the cursor
    let l:pattern = expand('<cword>')
  else
    let l:pattern = a:arg
  endif

  let l:rg_command = join(["rg","--vimgrep", g:ripgrep_options ,l:pattern,"."], " ")
  call setqflist([])
  let l:job = job_start(
  \ [&shell, &shellcmdflag, l:rg_command],{
  \ 'out_cb': function('s:rg_out_cb'),
  \ 'err_cb': function('s:rg_err_cb'),
  \ })
  call add(s:jobs, l:job)
  copen
  wincmd p
endfunction

function! ripgrep#rg_stop()
  for l:job in s:jobs
    call job_stop(l:stop)
  endfor
  let s:jobs = []
endfunction
