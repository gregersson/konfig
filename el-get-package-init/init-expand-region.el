(global-set-key (kbd "C--") 'er/expand-region)
(global-set-key (kbd "C-S-SPC") 'er/expand-region)
(global-set-key (kbd "C-M-SPC") '(lambda ()
                                   (interactive)
                                   (er/expand-region -1))) ;; OSX Special characters are in the way, changed the shortcut in system preferences->keyboard->shortcuts -> Add app shortcut for "Special Characters..." to something not conflicting.
