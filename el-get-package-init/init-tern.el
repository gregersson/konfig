;; Add path to actual emacs files in tern
(add-to-list 'load-path (concat el-get-dir "tern/emacs/"))
(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)
     ))

(defun tern-hook ()
     (define-key tern-mode-keymap (kbd "C-c c") 'tern-get-type)
     (define-key tern-mode-keymap [(control ?c) (control ?c)] nil)
     )
(add-hook 'tern-mode-hook 'tern-hook)
