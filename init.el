;; Required variables!
(setq konfig-home "/Users/greget/konfig/")
(setq load-path (cons konfig-home load-path))
(setq el-get-user-package-directory "Users/greget/konfig/package-configs")

;;; A quick & ugly PATH solution to Emacs on Mac OSX
(if (string-equal "darwin" (symbol-name system-type))
    (setenv "PATH" (concat "/usr/local/bin:/usr/local/sbin:" (getenv "PATH"))))

;; -- end of Required variables

;; Required goodies for some kd/kdext-stuffz
(require 'thingatpt)

;; Load el-get packages
(load-library "setup-el-get.el")

;; Setup project-root paths and rules
(load-library "setup-project-root.el")

;; Clone kd-repos if needed
(if  (file-exists-p (concat konfig-home "kd-repos"))
    (progn 
      ;; The following will be done if the kd-repos are present
      (load-library "kd-repos/kdext/kdext-autosave-settings.el")  ;; Avoid ugly tmp-files
      (load-library "kd-repos/kdext/kdext-insertion-functions.el") ;; Helpers to insert braces
      )
  (progn 
    ;; There are no kd-repos, clone them!
    (dired-create-directory (concat konfig-home "kd-repos"))
    (call-process "hg" nil "messages" nil "clone" "https://bitbucket.org/dnils/kd" (concat konfig-home "kd-repos/kd"))
    (call-process "hg" nil "messages" nil "clone" "https://bitbucket.org/dnils/kdext" (concat konfig-home "kd-repos/kdext"))
    )
  )

;; Major modes
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))

;; C-style major modes
(setq magic-mode-alist
  (append (list  
       '("\\(.\\|\n\\)*\n@implementation" . objc-mode)
       '("\\(.\\|\n\\)*\n@interface" . objc-mode)
       '("\\(.\\|\n\\)*\n@protocol" . objc-mode)
       '("\\(.\\|\n\\)*\nsignals:" . c++-mode)
       '("\\(.\\|\n\\)*\nslots:" . c++-mode)
       '("\\(.\\|\n\\)*\n#include <QObject>" . c++-mode)
       )
      magic-mode-alist))

(load-library "init-cmode.el")
(global-set-key  [?\M-o] 'ff-find-other-file)
(global-set-key  [C-M-up] 'ff-find-other-file)
(global-set-key  [C-M-down] 'ff-find-other-file)

;; IDO!
(ido-mode t)

;; Better undo / redo handling
(require 'redo+)
(global-set-key  [?\M-_] 'redo)

(global-set-key [f4] (quote next-error)) ; Go to next error if available 
(delete-selection-mode 1) ; Overwrite selection!
(setq case-fold-search t)   ; make searches case insensitive
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region) ; Comment or uncomment region


(tool-bar-mode -1)			    ;; Remove toolbar icons
(fset 'yes-or-no-p 'y-or-n-p)		    ;; Use y-n instead of yes-no
(setq inhibit-startup-message t)	    ;; Suppress GNU startup message
(column-number-mode 1)			    ;; Show column
(show-paren-mode 1)			;; Show parenthesis near cursor
(setq visible-bell t)			;; Disable beeping
(setq require-final-newline t)		;; Require files to end in 
(setq scroll-step 2)  ;; Scroll closer to the caret
(setq scroll-preserve-screen-position t) ;; Center cursors on pgdown/up
(setq-default fill-column 80) ;; Default width 80 
(setq list-command-history-max 1000) ;; Remember lots of command history!

;; Show the name of the file being edited in the title bar
(setq frame-title-format '("%b" (buffer-file-name ": %f")) )

(setq-default use-dialog-box nil) ;; Ask questions in the minibuffer instead of dialogs
(global-hl-line-mode 1) ;; Highlight the current line please

(defalias 'qrr 'query-replace-regexp) ;; Alias for query replace
(defalias 'r 'rgrep) ;; Alias for recursive grep

;; Tramp default to type ssh
(setq tramp-default-method "ssh") 

;; Show kill ring in other buffer
(require 'browse-kill-ring) 
;; M-y shows kill ring in other buffer.
(browse-kill-ring-default-keybindings) 
;; Restore windows after selecting something from kill-ring browser
(setq browse-kill-ring-quit-action 'save-and-restore) 

;; A library that saves the last position in files
(require 'saveplace)
;; Activate it!
(setq-default save-place t) 

;; Infinite messages buffer length!
(setq messages-buffer-max-lines t)

;; Grep tool goodness
(require 'grep)
;; Include .m and .mm files in the filetype alias 'cchh'
(add-to-list 
 'grep-files-aliases
 '("cchh" .  "*.cc *.[ch]xx *.[ch]pp *.[CHh] *.CC *.HH *.[ch]++ *.m *.mm")
 )



;;--------------
;; todos:
;; fix fuzzy matching for ac-complete, other stuff too?
;; {} electric pairing
;; whitespace-mode?
;; show-paren-mode?
;; semantic ac-complete?  gtags?
;; kdc-restart
;; if !yasnippet, mark placeholder text 
;; qrr alias etc.
;; q_property yasnippet eller liknande.
;; Y/N
;; tramp-mode
;; minibuffer completions
;; path to file in bottom of buffer
;; linenumbers, percent, gutter summary?
;; m-g goto line
