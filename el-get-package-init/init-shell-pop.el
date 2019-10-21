(progn
  (require 'shell-pop)
  ;; Or "ansi-term" if you prefer
  ;; (shell-pop-set-internal-mode "eshell")

  ;; Give shell buffer 60% of window
  (shell-pop-set-window-height 60)

  ;; If you use "ansi-term" and want to use C-t
  ;; (defvar ansi-term-after-hook nil)
  ;; (add-hook 'ansi-term-after-hook
  ;;           '(lambda ()
  ;;              (define-key term-raw-map (kbd "C-t") 'shell-pop)))
  ;; (defadvice ansi-term (after ansi-term-after-advice (run))
  ;;  (org-hooks 'ansi-term-after-hook))
  ;; (ad-activate 'ansi-term)
  (global-set-key (kbd "M-T") 'shell-pop)
  (setq shell-pop-full-span t)
  )
