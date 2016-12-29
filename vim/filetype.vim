if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
	au! BufNewFile,BufRead *.pc setf esqlc
	au! BufNewFile,BufRead *.sqc setf esqlc
	au! BufNewFile,BufRead *.ec setf esqlc
augroup END
