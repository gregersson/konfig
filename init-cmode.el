(defun base-cc-style ()
  (c-set-style "stroustrup")  
  (setq tab-width 4)
  (setq c-basic-offset tab-width)
  (setq indent-tabs-mode nil) ;; force only spaces for indentation
  (auto-complete-mode 1)
  
)

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

        ("\\.cpp\\'" (".hpp" ".hh" ".h"))
        ("\\.hpp\\'" (".cpp"))

        ("\\.cxx\\'" (".hxx" ".hh" ".h"))
        ("\\.hxx\\'" (".cxx"))))
(add-to-list 'auto-mode-alist '("\\.m$" . objc-mode))
(add-to-list 'auto-mode-alist '("\\.mm$" . objc-mode))
(add-hook 'c-mode-common-hook 'base-cc-style)

(defun bracket-hook2 ()
  (interactive)
  (self-insert-command 1)
  (save-excursion

(let* ((insert-pos (point))
       (expression-start-pos (progn 
			       (undo-boundary)
			       (search-backward-regexp "\\;")
			       (forward-char)
			       (point)
			       )
			     )
       (bracket-diff (- (count-matches "\\[" expression-start-pos insert-pos)
			(count-matches "\\]" expression-start-pos insert-pos))
		     )
       (beginning-braces (count-matches "\\[" expression-start-pos insert-pos))

       )
  
  (if (= beginning-braces 0)
      (progn 
	;; If no beginning braces, go to the right of '='
	(search-forward-regexp "=")
	(while (or
;;	     (eq (char-before) " ")
	     (eq (following-char) "=")
	     (eq (following-char) " ")
	     )
	  (forward-char)
	  )
	(forward-char)
	)
    (progn
      ;; Go to first beginning brace.
      (search-forward-regexp "\\[")
      )
    )
  (insert "[")
;;  (message (number-to-string bracket-diff))
  )))

(define-key objc-mode-map "]" 'bracket-hook2)
