(defun magit-status-dedicated()
  (interactive)
  (magit-status)
  (run-at-time "2 sec" nil 'purpose-mode)
  (run-at-time "2 sec" nil 'purpose-toggle-window-buffer-dedicated)
  )

(setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)

(global-set-key (kbd "C-x C-z") 'magit-status-dedicated)
(defun magit-toggle-whitespace ()
  (interactive)
  (if (member "-w" magit-diff-options)
      (magit-dont-ignore-whitespace)
    (magit-ignore-whitespace)))

(defun magit-ignore-whitespace ()
  (interactive)
  (add-to-list 'magit-diff-options "-w")
  (magit-refresh))

(defun magit-dont-ignore-whitespace ()
  (interactive)
  (setq magit-diff-options (remove "-w" magit-diff-options))
  (magit-refresh))
(eval-after-load "magit" 
  '(define-key magit-status-mode-map (kbd "W") 'magit-toggle-whitespace))

(setq magit-diff-refine-hunk 'all)
