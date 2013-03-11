(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

;; Add initialization files
(setq el-get-user-package-directory (concat konfig-home "el-get-package-init/"))

;; Add local recipes
(add-to-list 'el-get-recipe-path (concat konfig-home "el-get-recipes" ))

;; local sources
(setq el-get-sources
      '(
        (:name magit
               :after (global-set-key (kbd "C-x C-z") 'magit-status))

        ))

(setq my-packages
      (append
       '(
         el-get
         vkill;; Kill processes from emacs
         google-maps
         yasnippet
         buffer-move;; Move buffers around
         ace-jump-mode;; Jump quickly to a word or character
         qml-mode;;
         ;; yasobjc
         highlight-indentation;; Visual indicator for current indentation block
         lua-mode
         nyan-mode;; Nyan cat buffer scrollbar
         etags-select
         project-root
         shell-pop;; Handy terminal access
         auto-complete;; Auto completion
         graphviz-dot-mode
         sunrise-commander;; Midnight commander clone
         smex;; M-x pimpifier
         magit;; Git integration
         goto-last-change;; Move pointer back to last change
         js2-mode
         redo+ ;; Better undo/redo handling
         json-mode
         guess-offset;; Guesses the tab width from current indentation
         ;;gdb-mi
         idomenu
         escreen;;
         ;; zencoding-mode
         ;; anything
         ;; anything-complete
         ;; anything-extension
         ;; anything-match-plugin
         ;; ws-trim
         ;; ethan-wspace
         ;;company
         )
       (mapcar 'el-get-source-name el-get-sources))
      )

(el-get 'sync my-packages)

;;(el-get-user-package-directory
