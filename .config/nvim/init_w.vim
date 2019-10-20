for f in split(glob('$HOME/dotfiles/nvimw_config/*.vim'), '\n')
    exe 'source' f
endfor
