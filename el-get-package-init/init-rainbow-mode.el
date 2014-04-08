(defun activate-rainbow-hook ()
  (rainbow-mode 1))
(add-hook 'js2-mode-hook 'activate-rainbow-hook)
(add-hook 'javascript-mode-hook 'activate-rainbow-hook)
