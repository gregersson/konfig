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
