(add-hook 'find-file-hook 'flymake-find-file-hook)
(progn
  (when (load "flymake" t)
    (defun flymake-pylint-init ()
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
             (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
        (list "epylint" (list local-file))))
    (add-to-list 'flymake-allowed-file-name-masks
                 '("\\.py\\'" flymake-pylint-init))
    (defadvice flymake-display-warning (warning)
      "Display a warning to the user, using minibuffer instead of annoying message-box"
      (message warning))))

;; Overwrite flymake-display-warning so that no annoying dialog box is
;; used.

;; This version uses lwarn instead of message-box in the original version. 
;; lwarn will open another window, and display the warning in there.
(defun flymake-display-warning (warning) 
  "Display a warning to the user, using lwarn"
  (lwarn 'flymake :warning warning))

;; Using lwarn might be kind of annoying on its own, popping up windows and
;; what not. If you prefer to recieve the warnings in the mini-buffer, use:
(defun flymake-display-warning (warning) 
  "Display a warning to the user, using lwarn"
  (message warning))
