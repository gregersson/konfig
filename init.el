;; Required variables!
(setq konfig-home "/Users/greget/konfig/")
(setq load-path (cons konfig-home load-path))
(setq el-get-user-package-directory "Users/greget/konfig/package-configs")

;;; A quick & ugly PATH solution to Emacs on Mac OSX
(if (string-equal "darwin" (symbol-name system-type))
    (setenv "PATH" (concat "/usr/local/bin:/usr/local/sbin:" (getenv "PATH"))))

;; 
(setenv "LUA_PATH" "/Users/greget/src/lualint/?.lua;")

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

      ;; Avoid ugly tmp-files
      (load-library "kd-repos/kdext/kdext-autosave-settings.el")
      ;; Helpers to insert braces
      (load-library "kd-repos/kdext/kdext-insertion-functions.el")
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

;; Go to next error if available
(global-set-key (kbd "<f4>") 'next-error)
;; Go to previous error if available
(global-set-key (kbd "S-<f4>") 'previous-error)

;; Overwrite selection when pasting / yanking!
(delete-selection-mode 1)

;; make searches case insensitive
(setq case-fold-search t)

;; Comment or uncomment region
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)

;; Remove toolbar icons
(tool-bar-mode -1)

;; Use y-n instead of yes-no
(fset 'yes-or-no-p 'y-or-n-p)

;; Suppress GNU startup message
(setq inhibit-startup-message t)

;; Show column
(column-number-mode 1)

;; Show parenthesis near cursor
(show-paren-mode 1)

;; Disable beeping
(setq visible-bell t)

;; Require files to end in newline
(setq require-final-newline t)

;; Scroll closer to the caret
(setq scroll-step 2)

;; Center cursors on pgdown/up
(setq scroll-preserve-screen-position t)

;; Default width 80
(setq-default fill-column 80)

;; Remember lots of command history!
(setq list-command-history-max 1000)

;; Show the name of the file being edited in the title bar
(setq frame-title-format '("%b" (buffer-file-name ": %f")) )

;; Ask questions in the minibuffer instead of dialogs
(setq-default use-dialog-box nil)

;; Highlight the current line please
(global-hl-line-mode 1)

;; Alias for query replace
(defalias 'qrr 'query-replace-regexp)
;; Alias for recursive grep
(defalias 'r 'rgrep)

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

;; Everybody loves goto-line
(global-set-key "\M-g" 'goto-line)

;; Grep tool goodness
(require 'grep)
;; Include .m and .mm files in the filetype alias 'cchh'
(add-to-list
 'grep-files-aliases
 '("cchh" .  "*.cc *.[ch]xx *.[ch]pp *.[CHh] *.CC *.HH *.[ch]++ *.m *.mm")
 )

;; Make ediff split windows horizontally as default.
(setq ediff-split-window-function 'split-window-horizontally)


(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers


;;--------------
;; todos:
;; fix fuzzy matching for ac-complete, other stuff too?
;; {} electric pairing
;; whitespace-mode?
;; show-paren-mode?
;; semantic ac-complete?  gtags?
;; if !yasnippet, mark placeholder text
;; qrr alias etc.
;; q_property yasnippet eller liknande.
;; tramp-mode
;; minibuffer completions
;; path to file in bottom of buffer
;; linenumbers, percent, gutter summary?
;; qml-mode
;; popup-shell in folder of file.

