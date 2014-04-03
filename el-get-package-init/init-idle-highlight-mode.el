(defun activate-idle-highlight-mode-hook ()
  (idle-highlight-mode t))

(add-hook 'emacs-lisp-mode-hook 'activate-idle-highlight-mode-hook)
(add-hook 'c-mode-common-hook 'activate-idle-highlight-mode-hook)
(add-hook 'javascript-mode-hook 'activate-idle-highlight-mode-hook)
(add-hook 'js2-mode-hook 'activate-idle-highlight-mode-hook)
