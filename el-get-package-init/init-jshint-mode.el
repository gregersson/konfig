(require 'flymake-jshint)
;; (add-hook 'javascript-mode-hook
;;      (lambda () (flymake-mode t)))

;; (defcustom jshint-mode-mode "jslint"
;;   " Can be either jshint or jslint"
;;   :type 'string
;;   :group 'flymake-jshint)
(defun my-flymake-show-next-error()
  (interactive)
  (flymake-goto-next-error)
  (flymake-display-err-menu-for-current-line)
  )

;; S-M-n or M-N if you will
(global-set-key "\316" (lambda ()
                         (interactive)
                         (flymake-goto-next-error)))
;; S-M-p or M-P if you will
(global-set-key "\320" (lambda ()
                         (interactive)
                         (flymake-goto-prev-error)))
