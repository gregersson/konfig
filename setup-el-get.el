;; Set up ELPA to have more repositories!
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("SC"   . "http://joseito.republika.pl/sunrise-commander/")
			 )
      )

; common lisp goodies, loop
(require 'cl)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

;; now either el-get is `require'd already, or have been `load'ed by the
;; el-get installer.

;; set local recipes
(setq
 el-get-sources
 '((:name buffer-move
	  :after (lambda ()
		   ; Setup key bindings
		   (global-set-key (kbd "<C-S-up>")     'buf-move-up)
		   (global-set-key (kbd "<C-S-down>")   'buf-move-down)
		   (global-set-key (kbd "<C-S-left>")   'buf-move-left)
		   (global-set-key (kbd "<C-S-right>")  'buf-move-right)))
   ;; (:name emacs-w3m
   ;; 	  :description "A simple Emacs interface to w3m"
   ;; 	  :type cvs
   ;; 	  :module "emacs-w3m"
   ;; 	  :url ":pserver:anonymous@cvs.namazu.org:/storage/cvsroot"
   ;; 	  :build `("autoconf" ("./configure" ,(concat "--with-emacs=" el-get-emacs)) "make")
   ;; 	  :build/windows-nt ("sh /usr/bin/autoconf" "sh ./configure" "make")
   ;; 	  :info "doc")
   (:name ace-jump-mode
	  :website "http://www.emacswiki.org/emacs/AceJump"
	  :description "a quick cursor location minor mode for emacs"
	  :type git
	  :url "https://github.com/winterTTr/ace-jump-mode"
	  :after (lambda ()
		   ;; C-' 
		   (global-set-key [67108903] 'ace-jump-mode)
		   )
	  )
   (:name qml-mode
	  :type git
	  :url "https://github.com/cataska/qml-mode.git"
	  :after (lambda ()
		   (require 'qml-mode)
		   (add-to-list 'auto-mode-alist '("\\.qml$" . qml-mode))
		   )
	  )
   (:name highlight-indentation :type git
	  :url "https://github.com/antonj/Highlight-Indentation-for-Emacs.git"
	  :after (lambda ()
		   (require 'highlight-indentation)
		   (set-face-background 'highlight-indentation-face "#f3f3e8")
		   (set-face-background 'highlight-indentation-current-column-face "#c3b3b3")
		   )
	  )
   ;; (:name minimap :type git
   ;; 	  :url "https://github.com/dustinlacewell/emacs-minimap.git"
   ;; 	  :after (lambda ()
   ;; 		   (require 'minimap)
   ;; 		   (setq minimap-font-face '((default :family "DejaVu Sans Mono" :height 50)))
   ;; 		   (setq minimap-update-delay 0)
   ;; 		   (setq minimap-always-recenter t)
   ;; 		   (setq minimap-recenter-type 'relative)
   ;; 		   (setq minimap-width-fraction 0.2)
   ;; 		   )
   ;; 	  )
   (:name yasnippet :type git
	  :url "https://github.com/capitaomorte/yasnippet.git"
	  :after (lambda ()
		   (require 'yasnippet)
		   (yas/initialize)

		   ;; Develop in ~/konfig/snippets, but also
		   ;; use standard snippet directory
		   (setq yas/root-directory '("~/konfig/snippets"
					      "~/.emacs.d/el-get/yasnippet/snippets"))

		   ;; Map `yas/load-directory' to every element
		   (mapc 'yas/load-directory yas/root-directory)
		   )
	  )
   (:name fuzzy :type elpa)
   (:name thesaurus :type http
	  :url "http://www.emacswiki.org/emacs/download/thesaurus.el"
	  :after (lambda ()
		   (require 'thesaurus)
		   (defun get-thesaurus-api-key-from-file ()
		     "Return thesaurus api key file content."
		     (with-temp-buffer
		       (insert-file-contents "~/Dropbox/dotfiles/thesaurusapikey.txt")
		       (while (search-forward "
" nil t)
			 (replace-match "" nil t))
		       (buffer-string)))
		   (setq thesaurus-bhl-api-key (get-thesaurus-api-key-from-file))
		   (setq thesaurus-prompt-mechanism 'dropdown-list)
		   )
	  )


   (:name lua-mode :type elpa)
   (:name sml-modeline :type elpa
	  :after (lambda ()
		   (scroll-bar-mode -1)
		   (sml-modeline-mode t)
		   ))
   (:name project-root
	  :type http-tar
	  :module "project-root"
	  :options ("xzf")
	  :url "http://hg.piranha.org.ua/project-root/archive/tip.tar.gz"
	  :after (lambda ()
		   (global-set-key (kbd "<C-f7>") (lambda ()
						  (interactive)
						  (with-project-root (compile project-root-configure-command))))
		   (global-set-key (kbd "<S-f7>") (lambda ()
						  (interactive)
						  (with-project-root (compile project-root-clean-command))))
		   (global-set-key (kbd "<f7>") (lambda ()
						  (interactive)
						  (with-project-root (compile project-root-compile-command))))
		   (global-set-key (kbd "<f5>") (lambda ()
						  (interactive)
						  (with-project-root (compile project-root-run-command))))
		   (global-set-key (kbd "<C-f5>") (lambda ()
						  (interactive)
						  (with-project-root (gud-gdb (concat "`" project-root-binary-command "`")))))
		   ))
   (:name shell-pop :type http
	  :url "http://www.emacswiki.org/emacs/download/shell-pop.el"
	  :after (lambda ()
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
		   ;; (defadvice ansi-term (after ansi-term-after-advice (org))
		   ;;  (run-hooks 'ansi-term-after-hook))
		   ;; (ad-activate 'ansi-term)
		   (global-set-key (kbd "M-§") 'shell-pop)
		   )
	  )
   (:name auto-complete
	  :type git
	  :url "https://github.com/YorkZ/auto-complete.git"
	  :depends popup
	  :load-path "."
	  :post-init (lambda ()
		       (require 'auto-complete)
		       (add-to-list 'ac-dictionary-directories (expand-file-name "dict" pdir))
		       (require 'auto-complete-config)
		       (ac-config-default)))

   (:name kdcomplete :type git :url "https://github.com/BinaryPeak/kdcomplete"
	  :depends (auto-complete yasnippet)
	  :after (lambda ()
		   (load-library "kdcomplete.el")
		   )
	  )
   (:name sunrise-commander :type elpa)
   (:name smex
   	  :after (lambda ()
   		   (setq smex-save-file "~/.emacs.d/.smex-items")
   		   (global-set-key (kbd "M-x") 'smex)
   		   (global-set-key (kbd "M-X") 'smex-major-mode-commands)))
   (:name magit
	  :after (lambda ()
		   (global-set-key (kbd "C-x C-z") 'magit-status)))

   (:name goto-last-change		; move pointer back to last change
	  :after (lambda ()
		   ;; when using AZERTY keyboard, consider C-x C-_
		   ;; TODO: better keybinding!
		   (global-set-key (kbd "C-x C-/") 'goto-last-change))
	  )
   (:name js2-mode :type git :url "https://github.com/mooz/js2-mode.git" :module "js2-mode")
   (:name redo+ :type elpa)
   ;; (:name hl-line+ :type elpa :module "hl-line+")
   ;; (:name vline :type elpa :module "vline")
   ;; (:name col-highlight :type elpa :module "col-highlight" :depends (vline))
   ;; (:name crosshairs :type elpa :module "crosshairs" :depends (hl-line+ col-highlight))
   (:name json-mode :type git :url "https://github.com/joshwnj/json-mode.git"
   	  :after (lambda ()
		   (progn
		     (load-library "json-mode/json-mode.el")
		     (defun beautify-json ()
		       (interactive)
		       (let ((b (if mark-active (min (point) (mark)) (point-min)))
			     (e (if mark-active (max (point) (mark)) (point-max))))
			 (shell-command-on-region b e
						  "python -mjson.tool" (current-buffer) t)))
		     (define-key json-mode-map (kbd "C-c C-f") 'beautify-json)

		     )
		   )
	  )
   )
 )

;;(load-library "recipes/recipe-company.el")
(load-library "recipes/recipe-anything.el")

;; now set our own packages
(setq
 my:el-get-packages
 '(el-get
   escreen
   php-mode-improved
   auto-complete
   zencoding-mode
   color-theme
   color-theme-tango
   anything
   anything-complete
   anything-extension
   anything-match-plugin
   redo+
   lua-mode
   smex
   sunrise-commander
   json-mode
   ace-jump-mode
   project-root
   kdcomplete
   thesaurus
   fuzzy
))




;;
;; Some recipes require extra tools to be installed
;;
;; Note: el-get-install requires git, so we know we have at least that.
;;
(when (el-get-executable-find "cvs")
  ;; the debian addons for emacs
  (add-to-list 'my:el-get-packages 'emacs-goodies-el))

(when (el-get-executable-find "svn")
  (loop for p in '(psvn    		; M-x svn-status
		   yasnippet)		; powerful snippet mode

	do (add-to-list 'my:el-get-packages p)))

;; Append the package lists
(setq my:el-get-packages
      (append
       my:el-get-packages
       (loop for src in el-get-sources collect (el-get-source-name src))))

;; (defun print-elements-of-list (list)
;;        "Print each element of LIST on a line of its own."
;;        (while list
;;          (print (car list))
;;          (setq list (cdr list))))
;;(print-elements-of-list my:el-get-packages)


;; install new packages and init already installed packages
(el-get 'sync my:el-get-packages)
