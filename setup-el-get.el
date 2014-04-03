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
       ;; Customize which packages you want to install and activate
       '(
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
         ;;jedi;; Python auto-completion.
         ace-jump-mode;; Jump quickly to a word or character
         ack-and-a-half
         auto-complete;; Auto completion
         autopair
         buffer-move;; Move buffers around
         color-theme
         diff-hl
         el-get
         emacs-w3m
         escreen;;
         expand-region
         flymake
         flymake-cursor
         ;;flymake-json
         flymake-mode
         fm
         ;; git-gutter-fringe
         google-maps
         goto-last-change;; Move pointer back to last change
         graphviz-dot-mode
         guess-offset;; Guesses the tab width from current indentation
         ;; helm
         highlight-indentation;; Visual indicator for current indentation block
         ;; idle-highlight-mode
         idomenu
         js2-mode
         js2-refactor
         jshint-mode
         ;;json-mode
         lua-mode
         magit;; Git integration
         monky
         multiple-cursors
         nyan-mode;; Nyan cat buffer scrollbar
         project-root
         undo-tree ;; Better undo/redo handling
         smart-compile+;; M-x compile replacement. Determines default compile command from filename.
         smart-scan
         smex;; M-x pimpifier
         sunrise-commander;; Midnight commander clone
         tern ;; Javascript magic
         vkill;; Kill processes from emacs
         ws-butler
         yasnippet
         yasobjc
         )
       (mapcar 'el-get-source-name el-get-sources))
      )

(el-get 'sync my-packages)
