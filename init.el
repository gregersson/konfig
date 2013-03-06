;; Required variables!
(if (file-exists-p "/Users/greget/konfig")
    (setq konfig-home "/Users/greget/konfig/")
  )
(if (file-exists-p "/Users/pgregersson/konfig")
     (setq konfig-home "/Users/pgregersson/konfig/")
     )
(setq load-path (cons konfig-home load-path))
(setq el-get-user-package-directory "/Users/greget/konfig/package-configs")

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
       '("\\(.\\|\n\\)*\nnamespace " . c++-mode)
       '("\\(.\\|\n\\)*\n#include <QObject>" . c++-mode)
       )
      magic-mode-alist))

(load-library "init-cmode.el")
(global-set-key  [?\M-o] 'ff-find-other-file)
(global-set-key  [C-M-up] 'ff-find-other-file)
(global-set-key  [C-M-down] 'ff-find-other-file)

;; IDO!
(ido-mode t)

(global-set-key  (kbd "<f6>") 'bury-buffer)
(global-set-key  (kbd "S-<f6>") '(lambda()
				   (interactive)
				   (kill-buffer (buffer-name))))

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

;; ;; Show kill ring in other buffer
;; (require 'browse-kill-ring)
;; ;; M-y shows kill ring in other buffer.
;; (browse-kill-ring-default-keybindings)
;; ;; Restore windows after selecting something from kill-ring browser
;; (setq browse-kill-ring-quit-action 'save-and-restore)

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

; Fix the x / emacs cut & paste mystery
(setq x-select-enable-clipboard t)


(require 'thingatpt)

(if (file-exists-p "setup-rim.el") 
    (load-library "setup-rim.el")
  )

(defun quick-rgrep (term)
   (interactive (list (completing-read "Search Term: " nil nil nil (thing-at-point 'word))))
  (grep-compute-defaults)

  (with-project-root
      (rgrep term "*.cc *.[ch]xx *.[ch]pp *.[CHh] *.CC *.HH *.[ch]++ *.qml *.descriptor" default-directory)))
(global-set-key "\M-r" 'quick-rgrep)

;; Make ediff split windows horizontally as default.
(setq ediff-split-window-function 'split-window-horizontally)


(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers


(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

(setq tags-table-list
           '("/tmp"))

;; Follow the compilation buffer!
(setq compilation-scroll-output t)

;; nuke whitespaces when writing to a file
;; (add-hook 'before-save-hook 'whitespace-cleanup)


(defun uniq-lines (beg end)
  "Unique lines in region.
Called from a program, there are two arguments:
BEG and END (region to sort)."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (not (eobp))
        (kill-line 1)
        (yank)
        (let ((next-line (point)))
          (while
              (re-search-forward
               (format "^%s" (regexp-quote (car kill-ring))) nil t)
            (replace-match "" nil nil))
          (goto-char next-line))))))


(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))


(global-set-key [M-up] 'move-text-up)
(global-set-key [M-down] 'move-text-down)

(defun init-project-root ()
  (interactive)
  (progn
    ;; (load-library "init.el")
    (load-library "setup-rim.el")
    (setup-project-root-tad)
    (project-root-goto-root)
    )
  )

(global-set-key (kbd "C-c l")
  (lambda ()
    (interactive)
    (goto-line (line-number-at-pos) (window-buffer (next-window)))))

(global-set-key (kbd "C-x t w")
		'doremi-window-height+
		)

(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))
(defun backward-delete-word (arg)
  "Delete characters backward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-word (- arg)))
(global-set-key [backspace] (quote backward-delete-word))
(global-set-key (kbd "DEL") (quote backward-delete-word))
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
