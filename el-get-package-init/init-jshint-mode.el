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

(global-set-key "\356" (lambda ()
                         (interactive)
                         (flymake-goto-next-error)))

(global-set-key "\360" (lambda ()
                         (interactive)
                         (flymake-goto-prev-error)))
