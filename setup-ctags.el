(let ((tags-prog "ctags") )
    (call-process tags-prog nil nil nil
    		  "-e"
    		  "-a"
    		  "-f"
    		  (expand-file-name "/tmp/TAGS")
    		  "--language-force=c++"
    		  "--extra=-q+f"
    		  "--fields=+a+f+i+k+K-l+m+n+s+S+z+t"
    		  "--c++-kinds=+c+d+e+f+g-l+m+n+p+s+t+u+v-x"
    		  (concat "-L " (expand-file-name source-file )))
