;; Required variables!
(setq load-path (cons "~/konfig/" load-path))
(setq el-get-user-package-directory "~/konfig/package-configs")
;; -- end of Required variables

(defvar autosave-dir
 (concat "/tmp/emacs_autosaves/" (user-login-name) "/"))
(defvar backup-dir (concat "/tmp/emacs_backups/" (user-login-name) "/"))
(make-directory backup-dir t)
(setq backup-directory-alist (list (cons "." backup-dir)))


(load-library "setup-el-get.el")
