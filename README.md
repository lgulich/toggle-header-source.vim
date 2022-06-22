# toggle-header-source.vim

Easily toggle between source and header files.

## Description
Some assumptions: 

* The filenames of the header and body (implementation) are identical
  except for the extension or the directory.
  - That is, `foo.c` <-> `foo.h` is supported, 
  - whereas  `foo.c` <-> `bar.h` is not supported.
* The matching file is located in one of the following:
  - the project path that vim was opened at (or any of its children)
  - the same folder as the original file (or any of its children)
  - the grand-grand-parent-folder of the original file (or any of   
    its children)

Based on these assumptions, you should not need to reconfigure when you 
switch between repositories.

If multiple matching files are present the plugin will automatically 
toggle to the closest one.

## Installation
Copy `toggle_header_source.vim` into your ~/.vim/plugin directory.
Or `:source toggle_header_source.vim` to load it into your running session.

You can set a keyboard shortcut if you want by placing something like: 
```
  map <F5> :call ToggleHeaderSource()<CR>
```
in your `~/.vimrc` file.  Yes, the `<CR>` is literally there at the end
as the four characters shown.

### Installing with Vundle
Add `Plug 'lgulich/toggle_header_source.vim'` to your your plugin definitions
in your `.vimrc`

## Comparison to CurtineIncSw.vim
When multiple matching files are present this plugin will chose the file
which is located the closest in the file system, CurtineIncSw.vim will just
choose a random one.

