(add-to-list 'el-get-sources
	     '(:name pymacs :type elpa))
(add-to-list 'el-get-sources
	       '(:name pysmell :type elpa depends: pymacs))
(add-to-list 'el-get-sources
	       '(:name gtags :type elpa))
(add-to-list 'el-get-sources
	       '(:name dabbrev :type elpa))
(add-to-list 'el-get-sources
	       '(:name company 
		      :type elpa
		      :depends pysmell gtags dabbrev
		      :after (lambda ()
			       (setq company-backends '(company-elisp 
							company-ropemacs
							company-xcode
							company-gtags
							company-dabbrev-code
							company-keywords
							company-files 
							company-dabbrev)
				     ))))
