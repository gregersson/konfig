(add-to-list 'load-path "~/.emacs.d/el-get/el-get")


;; (unless (require 'el-get nil 'noerror)
;;   (require 'package)
;;   (add-to-list 'package-archives
;;                '("melpa" . "http://melpa.org/packages/"))
;;   (package-refresh-contents)
;;   (package-initialize)
;;   (package-install 'el-get)
;;  (require 'el-get))

;;(require 'el-get-elpa)
;; Build the El-Get copy of the package.el packages if we have not
;; built it before.  Will have to look into updating later ...

;;(unless (file-directory-p el-get-recipe-path-elpa)
;;  (el-get-elpa-build-local-recipes))

(unless (require 'el-get nil 'noerror)
   (with-current-buffer
       (url-retrieve-synchronously
        "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
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
        ))

(setq my-packages
      (append
       ;; Customize which packages you want to install and activate
       '(
	 avy
         ;; anything-complete
         ;; anything-extension
         ;; anything-match-plugin
         ;; ethan-wspace
         ;; git-gutter-fringe
         ;; idle-highlight-mode
         ;; slime
         ;; yasnippet
         ;; zencoding-mode
         ;;ace-jump-mode;; Jump quickly to a word or character
         ;;autopair
         ;;buffer-move;; Move buffers around
         ;;diff-hl
         ;;discover
         ;;discover-js2-refactor
         ;;eclim
         ;;emacs-w3m
         ;;escreen;;
         ;;etags-select
         ;;flx-ido
         ;;flymake-cursor
         ;;flymake-json
         ;;fm
         ;;free-keys
         ;;gdb-mi
         ;;google-maps
         ;;goto-last-change;; Move pointer back to last change
         ;;guess-offset;; Guesses the tab width from current indentation
         ;;guide-key
         ;;highlight-indentation;; Visual indicator for current indentation block
         ;;ido-vertical-mode
         ;;idomenu
         ;;jedi;; Python auto-completion.
         ;;js2-mode
         ;;js2-refactor
         ;;jshint-mode
         ;;lua-mode
         ;;monky
         ;;popwin
         ;;project-root
         ;;rainbow-mode
         shell-pop
         ;;smart-compile+;; M-x compile replacement. Determines default compile command from filename.
         ;;sunrise-commander;; Midnight commander clone
         ;;tern ;; Javascript magic
         ;;undo-tree ;; Better undo/redo handling
         ;;vkill;; Kill processes from emacs
         ;;whitespace-cleanup-mode
         ;;ws-trim
         ;;yasobjc
         ack-and-a-half
         anything
         auto-complete;; Auto completion
         color-theme
         company-mode
         cucumber
         el-get
         exec-path-from-shell
         expand-region
         find-file-in-project
         flymake
         flymake-mode
         graphviz-dot-mode
         helm
         json-mode
         magit;; Git integration
         multiple-cursors
         nyan-mode;; Nyan cat buffer scrollbar
         org-mode
         projectile
         smart-forward
         smart-scan
         smex;; M-x pimpifier
         string-edit
         swift-mode
         undohist
         window-purpose
         ws-butler
         )
       (mapcar 'el-get-source-name el-get-sources))
      )

(el-get 'sync my-packages)
