function! SwitchToFile(file_pattern)
  " We try to find the matching file. Our approach is to start as close as
  " possible (i.e. in the same folder) and then increase the search path if not
  " found by also searching in parent folders.
  let dirname=fnamemodify(expand("%:p"), ":h")

  " Find file in same folder.
  let cmd="find " . dirname . " -type f -iregex \""  . a:file_pattern . "\" -print -quit"
  let target_file=system(cmd)
  if len(target_file) > 0
    exe "edit " target_file
    return 0
  endif

  " Find file in parent folder.
  let cmd="find " . dirname . "/.. -type f -iregex \""  . a:file_pattern . "\" -print -quit"
  let target_file=system(cmd)
  if len(target_file) > 0
    exe "edit " target_file
    return 0
  endif

  " Find file in grandparent folder.
  let cmd="find " . dirname . "/../.. -type f -iregex \""  . a:file_pattern . "\" -print -quit"
  let target_file=system(cmd)
  if len(target_file) > 0
    exe "edit " target_file
    return 0
  endif

  " Find file in grand-grandparent folder.
  let cmd="find " . dirname . "/../../.. -type f -iregex \""  . a:file_pattern . "\" -print -quit"
  let target_file=system(cmd)
  if len(target_file) > 0
    exe "edit " target_file
    return 0
  endif

  " Find file in project root folder.
  let cmd="find . -type f -iregex \""  . a:file_pattern . "\" -print -quit"
  let target_file=system(cmd)
  if len(target_file) > 0
    exe "edit " target_file
    return 0
  endif

  echom "Could not find matching file: " . a:file_pattern
  return 1
endfun

function! ToggleHeaderSource()
  if match(expand("%"), '\.c') > 0
    " We are in a source file. We need to find header file.
    let pattern_for_matching_file = substitute(".*\\\/" . expand("%:t"), '\.c\(.*\)', '.h[a-z]*', "")
  elseif match(expand("%"), "\\.h") > 0
    " We are in a header file. We need to find source file.
    let pattern_for_matching_file = substitute(".*\\\/" . expand("%:t"), '\.h\(.*\)', '.c[a-z]*', "")
  endif

  call SwitchToFile(pattern_for_matching_file)
endfun

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
