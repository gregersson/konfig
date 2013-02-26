(add-to-list 'el-get-sources
	     '(:name anything 
		     :type elpa
		     :after (lambda () 
			      ;;(global-set-key (kbd "<C-M-x>") 'anything)
			      (global-set-key "\230" (quote anything))
			      )))

(add-to-list 'el-get-sources
	     '(:name anything-complete 
		     :type elpa
		     :url
		     :depends anything))

(add-to-list 'el-get-sources
	     '(:name anything-extension 
		     :type elpa
		     :depends anything))

(add-to-list 'el-get-sources
	     '(:name anything-match-plugin 
		     :type elpa
		     :depends anything))
