for f in split(glob('./nvim_config/*.vim'), '\n')
    exe 'source' f
endfor
