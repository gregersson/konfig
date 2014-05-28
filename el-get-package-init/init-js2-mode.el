(autoload 'js2-mode "js2-mode" nil t)
(autoload 'js2-highlight-vars-mode "js2-highlight-vars" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(defun my-js2-mode-hook ()
  (define-key js2-mode-map [(control a)] 'js2-beginning-of-line)
  (define-key js2-mode-map [(control e)] 'js2-end-of-line)
  )

 
(add-hook 'js2-mode-hook 'my-js2-mode-hook)
