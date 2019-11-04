# ripgrep.vim

It is Vim Plugin for using the [ripgrep][1].  

## Usage

Search under the current directory,The result is output to the QuickFix list.  
The search uses the job function of Vim8.0 and is executed asynchronously.

```vim
:Rg <string|pattern>
:Rgstop
```

It also integrates [ctrlp.vim][2] extension.  

```vim
:CtrlPRg <string|pattern>
```

Both functions search for the word under the cursor if no argument is given.

## Config

The default for the rg command option is `--hidden`.
If you want to change it, set `g:ripgrep_options` in your vimrc.

## License

MIT

[1]: https://github.com/BurntSushi/ripgrep
[2]: https://github.com/ctrlpvim/ctrlp.vim
