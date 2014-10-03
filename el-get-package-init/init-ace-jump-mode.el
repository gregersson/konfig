(progn
  ;; C-' 
  (global-set-key [67108903] 'ace-jump-mode)
  (add-hook 'org-mode-hook
            '(lambda ()
               (define-key org-mode-map (kbd "C-'") nil);; I want ace-jump-mode for this key
               ))
  )
