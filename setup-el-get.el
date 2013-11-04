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
       '(;; Customize which packages you want to install and activate
         ;; anything
         ;; anything-complete
         ;; anything-extension
         ;; anything-match-plugin
         ;; ethan-wspace
         ;; slime
         ;; ws-trim
         ;; zencoding-mode
         ;;company
         ;;etags-select
         ;;gdb-mi
         ;;redo+ ;; Better undo/redo handling
         ace-jump-mode;; Jump quickly to a word or character
         auto-complete;; Auto completion
         buffer-move;; Move buffers around
         el-get
         escreen;;
         google-maps
         goto-last-change;; Move pointer back to last change
         graphviz-dot-mode
         guess-offset;; Guesses the tab width from current indentation
         highlight-indentation;; Visual indicator for current indentation block
         idomenu
         ;;jedi;; Python auto-completion.
         js2-mode
         flymake-mode
         flymake-json
         json-mode
         lua-mode
         magit;; Git integration
         monky
         nyan-mode;; Nyan cat buffer scrollbar
         project-root
         qml-mode;;
         shell-pop;; Handy terminal access
         smart-compile+;; M-x compile replacement. Determines default compile command from filename.
         smex;; M-x pimpifier
         sunrise-commander;; Midnight commander clone
         vkill;; Kill processes from emacs
         yasnippet
         yasobjc
         )
       (mapcar 'el-get-source-name el-get-sources))
      )

(el-get 'sync my-packages)
