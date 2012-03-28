;; Set up ELPA to have more repositories!
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/") 
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("SC"   . "http://joseito.republika.pl/sunrise-commander/")
			 )
      )

(require 'cl)				; common lisp goodies, loop

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
 '((:name buffer-move			; have to add your own keys
	  :after (lambda ()
		   (global-set-key (kbd "<C-S-up>")     'buf-move-up)
		   (global-set-key (kbd "<C-S-down>")   'buf-move-down)
		   (global-set-key (kbd "<C-S-left>")   'buf-move-left)
		   (global-set-key (kbd "<C-S-right>")  'buf-move-right)))
   (:name yasnippet :type elpa)
   (:name lua-mode :type elpa)
   (:name project-root 
	  :type http-tar 
	  :options ("xzf") 
	  :url "http://hg.piranha.org.ua/project-root/archive/tip.tar.gz"
	  :after (lambda () 
		   (require 'project-root)
		   ))
   (:name kdcomplete :type git :url "https://github.com/BinaryPeak/kdcomplete"
	  :after (lambda ()
		   (load-library "kdcomplete.el")
		   )
	  )
   (:name sunrise-commander :type elpa)
   (:name eproject :type elpa
	  :after (lambda () 
		   ;; Set correct eproject keybindings here.

		   ))
   (:name smex				; a better (ido like) M-x
   	  :after (lambda ()
   		   (setq smex-save-file "~/.emacs.d/.smex-items")
   		   (global-set-key (kbd "M-x") 'smex)
   		   (global-set-key (kbd "M-X") 'smex-major-mode-commands)))
   (:name magit				; git meet emacs, and a binding
	  :after (lambda ()
		   (global-set-key (kbd "C-x C-z") 'magit-status)))

   (:name goto-last-change		; move pointer back to last change
	  :after (lambda ()
		   ;; when using AZERTY keyboard, consider C-x C-_
		   (global-set-key (kbd "C-x C-/") 'goto-last-change))
	  )
   (:name redo+ :type elpa)
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
 '(el-get				; el-get is self-hosting
   escreen            			; screen for emacs, C-\ C-h
   php-mode-improved			; if you're into php...
   auto-complete			; complete as you type with overlays
   zencoding-mode			; http://www.emacswiki.org/emacs/ZenCoding
   color-theme		                ; nice looking emacs
   color-theme-tango	                ; check out color-theme-solarized
   js2-mode
   anything
   anything-complete
   anything-extension
   anything-match-plugin
;;   eproject
   redo+
   lua-mode
   smex
   sunrise-commander
   json-mode
   ace-jump-mode
   project-root
   kdcomplete
))




;;
;; Some recipes require extra tools to be installed
;;
;; Note: el-get-install requires git, so we know we have at least that.
;;
(when (el-get-executable-find "cvs")
  (add-to-list 'my:el-get-packages 'emacs-goodies-el)) ; the debian addons for emacs

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
