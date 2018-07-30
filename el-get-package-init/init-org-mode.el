(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map (kbd "C-'") nil);; I want ace-jump-mode for this key
             ))
(setq org-agenda-files '("~/org"))
