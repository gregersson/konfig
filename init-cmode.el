(defun base-cc-style ()
  (c-set-style "stroustrup")  
  (setq tab-width 4)
  (setq c-basic-offset tab-width)
  (setq indent-tabs-mode nil) ;; force only spaces for indentation
  (auto-complete-mode 1)
  (c-set-offset 'innamespace '0)
)

(c-add-style "template-coding-style"
         '((c-basic-offset . 3)
           (c-comment-only-line-offset . 0)
           (c-hanging-braces-alist . ((substatement-open before after)))
           (c-offsets-alist . ((topmost-intro        . 0)
                   (topmost-intro-cont   . 0)
                   (substatement         . 3)
                   (substatement-open    . 0)
                   (statement-case-open  . 3)
                   (statement-cont       . 3)
                   (access-label         . -3)
                   (inclass              . 3)
                   (inline-open          . 3)
                   (innamespace          . 0)
                   ))))

(setq cc-other-file-alist
      '(("\\.cc\\'"  (".hh" ".h"))
        ("\\.hh\\'"  (".cc" ".C"))

        ("\\.c\\'"   (".h"))
        ("\\.h\\'"   (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))

        ("\\.m\\'"    (".h"))
        ("\\.mm\\'"    (".h"))

        ("\\.C\\'"   (".H"  ".hh" ".h"))
        ("\\.H\\'"   (".C"  ".CC"))

        ("\\.CC\\'"  (".HH" ".H"  ".hh" ".h"))
        ("\\.HH\\'"  (".CC"))

        ("\\.c\\+\\+\\'" (".h++" ".hh" ".h"))
        ("\\.h\\+\\+\\'" (".c++"))

        ("\\.cpp\\'" (".hpp" ".hh" ".h" "_p.h"))
        ("\\.hpp\\'" (".cpp"))

        ("\\.cxx\\'" (".hxx" ".hh" ".h"))
        ("\\.hxx\\'" (".cxx"))))
(add-to-list 'auto-mode-alist '("\\.m$" . objc-mode))
(add-to-list 'auto-mode-alist '("\\.mm$" . objc-mode))
(add-hook 'c-mode-common-hook 'base-cc-style)

;;(load-library "kd-repos/kdext/kdext-expand-member.el")
(defun kd-bracketize2()
  (interactive)

  (let ((statement-start-position nil)
  	(root-position nil)
  	(search-cond nil)
	(bracket-diff nil)
  	)

    (save-excursion
      (c-beginning-of-statement 1)
      (setq statement-start-position (point))
      )

    (save-excursion
      (setq root-position (point))
      (setq search-cond t)
      (while search-cond
      	(progn
      	  (if (not (eq (search-backward ":" nil t)  nil))
      	      (if (> (point) statement-start-position)
      		  (setq root-position (point))
      		(setq search-cond nil)
      		)
      	    (setq search-cond nil)
      	    )	  
      	  )
      	)
      )
    (setq bracket-diff (- (count-matches "\\[" statement-start-position root-position)
			  (count-matches "\\]" statement-start-position root-position))
		     )
    (save-excursion
      (goto-char root-position)
      (search-backward " ")
      (backward-sexp)
      
      ;; For var.x.y situations
      (while (eq (preceding-char) ?.)
	  (backward-sexp)
	  )
      (if (<= bracket-diff 0)
	  (insert-string "[")
	)
      )
    (insert-string "]")
    )
  )
(define-key objc-mode-map "]" 'kd-bracketize2)
(define-key c-mode-base-map (kbd "C-\366") 'kdext-add-braces-with-semicolon) ;; C-ö
(define-key c-mode-base-map (kbd "C-C C-s") 'idomenu)

(c-add-style "qt-gnu" '("gnu" 
                        (c-access-key .
"\\<\\(signals\\|public\\|protected\\|private\\|public slots\\|protected slots\\|private slots\\):")
                         (c-basic-offset . 4)))
