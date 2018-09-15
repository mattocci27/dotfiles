for f in split(glob('$HOME/dotfiles/nvim_config/*.vim'), '\n')
    exe 'source' f
endfor
