(progn
  (load-library "json-mode/json-mode.el")
  (defun beautify-json ()
    (interactive)
    (let ((b (if mark-active (min (point) (mark)) (point-min)))
          (e (if mark-active (max (point) (mark)) (point-max))))
      (shell-command-on-region b e
                               "python -mjson.tool" (current-buffer) t)))
  (define-key json-mode-map (kbd "C-c C-f") 'beautify-json)

  )
