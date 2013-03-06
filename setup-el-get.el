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
	  :after (progn
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
	  :after (progn
		   (require 'ace-jump-mode)
		   ;; C-' 
		   (global-set-key [67108903] 'ace-jump-char-mode)
		   )
	  )
   (:name qml-mode
	  :type git
	  :url "https://github.com/cataska/qml-mode.git"
	  :after (progn
		   (require 'qml-mode)
		   (add-to-list 'auto-mode-alist '("\\.qml$" . qml-mode))
		   )
	  )
;;   (:name highlight-indentation :type git
;;	  :url "https://github.com/antonj/Highlight-Indentation-for-Emacs.git"
;;	  :after (progn
;;		   (require 'highlight-indentation)
;;		   (set-face-background 'highlight-indentation-face "#f3f3e8")
;;		   (set-face-background 'highlight-indentation-current-column-face "#c3b3b3")
;;		   )
;;	  )
   ;; (:name minimap :type git
   ;; 	  :url "https://github.com/dustinlacewell/emacs-minimap.git"
   ;; 	  :after (progn
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
	  :after (progn
		   (require 'yasnippet)
		   ;;(yas/initialize)

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
	  :after (progn
		   (require 'thesaurus)
		   (defun get-thesaurus-api-key-from-file ()
		     "Return thesaurus api key file content."
		     (with-temp-buffer
		       (if (file-exists-p "~/Dropbox/dotfiles/thesaurusapikey.txt")
			   (progn
			     (insert-file-contents "~/Dropbox/dotfiles/thesaurusapikey.txt")
			     (while (search-forward "
" nil t)
			       (replace-match "" nil t))
			     )
		       (buffer-string))))
		   (setq thesaurus-bhl-api-key (get-thesaurus-api-key-from-file))
		   (setq thesaurus-prompt-mechanism 'dropdown-list)
		   )
	  )


   (:name lua-mode :type elpa)
   ;; (:name sml-modeline :type elpa
   ;; 	  :after (progn
   ;; 		   (scroll-bar-mode -1)
   ;; 		   (sml-modeline-mode t)
   ;; 		   ))
   (:name nyan-mode :type git
	  :url "https://github.com/TeMPOraL/nyan-mode.git"
	  :module "nyan-mode"
	  :after (progn
		   (scroll-bar-mode -1)
		   (require 'nyan-mode)
		   (nyan-mode t)
		   ))
   ;; (:name ectags-select :type git
   ;; 	  :url "https://github.com/emacsmirror/ectags-select.git"
   ;; 	  :module "ectags-select"
   ;; 	  :after (progn
   ;; 		   (global-set-key "\M-." 'ectags-select-find-tag-at-point)
   ;; 		   )
   ;; 	  )
	  
   (:name etags-select :type git
	  :url "https://github.com/emacsmirror/etags-select.git"
	  :module "ectags-select"
	  :after (progn
		   (global-set-key "\M-." 'etags-select-find-tag-at-point)
		   )
	  )
   (:name project-root
	  :type http-tar
	  :module "project-root"
	  :options ("xzf")
	  :url "https://bitbucket.org/piranha/project-root/get/tip.tar.gz"
	  ;;:url "http://hg.piranha.org.ua/project-root/archive/tip.tar.gz"
	  :after (progn
		   (require 'project-root)
		   (global-set-key (kbd "<C-f7>") (lambda ()
						  (interactive)
						  (project-root-configure)
						  ))
		   (global-set-key (kbd "<S-f7>") (lambda ()
						  (interactive)
						  (project-root-clean)
						  ))
		   (global-set-key (kbd "<f7>") (lambda ()
						  (interactive)
						  (project-root-compile)
						  ))
		   (global-set-key (kbd "<f5>") (lambda ()
						  (interactive)
						  (project-root-run)
						  ))
		   (global-set-key (kbd "<C-f5>") (lambda ()
						  (interactive)
						  (project-root-debug)
						  ))
		   (global-set-key (kbd "<M-f5>") (lambda ()
						  (interactive)
						  (project-root-leakcheck)
						  ))
		   ))
   (:name shell-pop :type http
	  :url "http://www.emacswiki.org/emacs/download/shell-pop.el"
	  :after (progn
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
;;(:name auto-complete
;;	  :type git
;;	  :url "https://github.com/YorkZ/auto-complete.git"
;;	  ;;:depends popup
;;	  :load-path "."
;;	  :post-init (progn
;;		       (require 'auto-complete)
;;		       (add-to-list 'ac-dictionary-directories (expand-file-name "dict" pdir))
;;		       (require 'auto-complete-config)
;;		       (ac-config-default)))
;;

   ;; (:name kdcomplete :type git :url "https://github.com/BinaryPeak/kdcomplete"
   ;; 	  :depends (auto-complete yasnippet)
   ;; 	  :after (progn
   ;; 		   (load-library "kdcomplete.el")
   ;; 		   )
   ;; 	  )
   (:name graphviz-dot-mode :type git :url "https://github.com/remvee/graphviz-dot-mode.git"
	  :after (progn
		   (load-library "graphviz-dot-mode.el")
		   (setq graphviz-dot-auto-indent-on-semi nil)
		   )
	  )
   (:name sunrise-commander
	  :type git
	  :url "https://github.com/escherdragon/sunrise-commander.git"
	  :features sunrise-commander

	  )
;;   (:name org-confluence
;;	  :type git
;;	  :url "https://github.com/hgschmie/org-confluence.git"
;;	  :features org-confluence
;;	  :depends (org-mode)
;;	  )
   (:name smex
   	  :after (progn
   		   (setq smex-save-file "~/.emacs.d/.smex-items")
   		   (global-set-key (kbd "M-x") 'smex)
   		   (global-set-key (kbd "M-X") 'smex-major-mode-commands)))
   (:name magit
	  :after (progn
		   (global-set-key (kbd "C-x C-z") 'magit-status)))
   (:name mo-git-blame
    :type git
    :url "http://github.com/mbunkus/mo-git-blame.git"
    :depends (magit)
    )
;;   (:name ws-trim
;;	  :type git
;;	  :url "https://github.com/emacsmirror/ws-trim.git"
;;	  :after (progn
;;		   (require 'ws-trim)
;;		   (global-ws-trim-mode t)
;;		   )
;;	  )
   (:name goto-last-change		; move pointer back to last change
	  :after (progn
		   ;; when using AZERTY keyboard, consider C-x C-_
		   ;; TODO: better keybinding!
		   (global-set-key (kbd "C-x C-/") 'goto-last-change))
	  )
   (:name js2-mode :type git :url "https://github.com/mooz/js2-mode.git" :module "js2-mode")
   (:name redo+ :type git
	  :url "https://github.com/emacsmirror/redo-plus.git"
	  :after (progn
		   ;; Better undo / redo handling
		   (require 'redo+)
		   (global-set-key  [?\M-_] 'redo)
		   )

	  )
   ;; (:name hl-line+ :type elpa :module "hl-line+")
   ;; (:name vline :type elpa :module "vline")
   ;; (:name col-highlight :type elpa :module "col-highlight" :depends (vline))
   ;; (:name crosshairs :type elpa :module "crosshairs" :depends (hl-line+ col-highlight))
   (:name json-mode :type git :url "https://github.com/joshwnj/json-mode.git"
   	  :after (progn
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
   (:name guess-offset :type git :url "https://github.com/emacsmirror/guess-offset.git"
	  :description "Guesses the tab width from the current indentation"
   	  :after (progn
		   (progn
		     (require 'guess-offset)
		     )
		   )
	  )
   (:name gdb-mi :type git :url "https://github.com/emacsmirror/gdb-mi.git"
	  )
   (:name idomenu :type emacswiki :url "http://www.emacswiki.org/emacs/download/idomenu.el"
	  :after (progn
		   (progn 
		     (require 'idomenu)
		     (global-set-key  (kbd "C-c C-s") 'idomenu)
		     )))
   ;; (:name member-functions
   ;; 	  :type git
   ;; 	  :url "https://github.com/emacsmirror/member-functions.git"
   ;; 	  :after (progn
   ;; 		   (progn
   ;; 		     (autoload 'expand-member-functions "member-functions" "Expand C++ member function declarations" t)
   ;; 		     (add-hook 'c++-mode-hook (progn 
   ;; 						(local-set-key "\C-cm" #'expand-member-functions)
   ;; 						))))
   ;; 	  )
;;   (:name org-mode :type git :url "https://orgmode.org/org-mode.git"
;;    	  )

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
   json-mode
   ace-jump-mode
   project-root
   highlight-indentation
;;   kdcomplete
   thesaurus
   fuzzy
))




;;
;; Some recipes require extra tools to be installed
;;
;; Note: el-get-install requires git, so we know we have at least that.
;;
;; (when (el-get-executable-find "cvs")
;;   ;; the debian addons for emacs
;;   (add-to-list 'my:el-get-packages 'emacs-goodies-el))

(when (el-get-executable-find "svn")
  (loop for p in '(psvn    		; M-x svn-status
		   yasnippet)		; powerful snippet mode

	do (add-to-list 'my:el-get-packages p)))

;; Append the package lists
(setq my:el-get-packages
      (append
       my:el-get-packages
       (loop for src in el-get-sources collect (el-get-source-name src))))

; (defun print-elements-of-list (list)
;;        "Print each element of LIST on a line of its own."
;;        (while list
;;          (print (car list))
;;          (setq list (cdr list))))
;;(print-elements-of-list my:el-get-packages)


;; install new packages and init already installed packages
(el-get 'sync my:el-get-packages)
