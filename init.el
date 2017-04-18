(if (file-exists-p "/Users/greget/konfig")
    (setq konfig-home "/Users/greget/konfig/")
  )
(if (file-exists-p "/Users/gregersson/konfig")
    (setq konfig-home "/Users/gregersson/konfig/")
  )
(setq ns-use-srgb-colorspace t)
;; Add the configuration folder to the load path for el files.
(setq load-path (cons konfig-home load-path))

;;; A quick & ugly PATH solution to Emacs on Mac OSX
(if (string-equal "darwin" (symbol-name system-type))
    (progn
      (setenv "PATH" (concat "/usr/local/bin:/usr/local/sbin:/usr/local/texlive/2014/bin/x86_64-darwin:" (getenv "PATH")))
      (setq exec-path (append exec-path '("/usr/local/bin")))
      (setq exec-path (append exec-path '("/Library/TeX/texbin/")))
      (setq exec-path (append exec-path '("/usr/local/sbin")))
      )
  )

;; key bindings for osx meta and alt keys
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'none)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )

(setenv "LUA_PATH" "/Users/greget/src/lualint/?.lua;")

;; -- end of Required variables

;; Required goodies for some kd/kdext-stuffz
;;(require 'thingatpt)

;;(require 'package)
;;(add-to-list 'package-archives
;;             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Load el-get packages
(load-library "setup-el-get.el")

;; Setup project-root paths and rules
(load-library "setup-project-root.el")

;; ;; Clone kd-repos if needed
;; (if  (file-exists-p (concat konfig-home "kd-repos"))
;;     (progn
;;       ;; The following will be done if the kd-repos are present

;;       ;; Avoid ugly tmp-files
;;       (load-library "kd-repos/kdext/kdext-autosave-settings.el")
;;       ;; Helpers to insert braces
;;       (load-library "kd-repos/kdext/kdext-insertion-functions.el")
;;       )
;;   (progn
;;     ;; There are no kd-repos, clone them!
;;     (dired-create-directory (concat konfig-home "kd-repos"))
;;     (call-process "hg" nil "messages" nil "clone" "https://bitbucket.org/dnils/kd" (concat konfig-home "kd-repos/kd"))
;;     (call-process "hg" nil "messages" nil "clone" "https://bitbucket.org/dnils/kdext" (concat konfig-home "kd-repos/kdext"))
;;     )
;;   )

;; IDO!
(ido-mode t)
(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)

(global-set-key  (kbd "C-z") '(lambda()
                                (interactive)
                                ))
(global-set-key  (kbd "<f6>") 'bury-buffer)
(global-set-key  (kbd "S-<f6>") '(lambda()
                                   (interactive)
                                   (kill-buffer (buffer-name))))

;; Insert spaces instead of tabs
(setq-default indent-tabs-mode nil)

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
(setq whitespace-style '(face
                         empty
                         tabs
                         ;; lines-tail
                         trailing))
(global-whitespace-mode t)

(setq tags-table-list
           '("/tmp"))

;; Follow the compilation buffer!
(setq compilation-scroll-output t)

;; nuke whitespaces when writing to a file
;; (add-hook 'before-save-hook 'whitespace-cleanup)

(load-library "torped.el")

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

(defun backward-delete-if-word (arg)
  (interactive "p")
  (if (thing-at-point 'word)
      (backward-delete-word arg)
    (delete-backward-char arg)
      )
  )

(global-set-key [backspace] (quote backward-delete-if-word))
(global-set-key (kbd "DEL") (quote backward-delete-if-word))
(global-set-key [C-backspace] (quote backward-delete-char))
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


;; Initialize slime-helper from quicklisp
;; (load (expand-file-name "~/src/quicklisp/slime-helper.el"))

(setq inferior-lisp-program "sbcl")

;; Backup files handling
(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
        (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )

;; (electric-layout-mode 1)
(electric-indent-mode 1)
(electric-pair-mode 1)

(subword-mode 1)

(defun autorefresh-chrome-hook()
  (interactive)
  (shell-command
   "osascript ~/konfig/autorefresh.scpt"))
(add-hook 'javascript-mode-hook
          (lambda () 
            (add-hook 'after-save-hook 'autorefresh-chrome-hook nil 'make-it-local)))
(add-hook 'js2-mode-hook
          (lambda () 
            (add-hook 'after-save-hook 'autorefresh-chrome-hook nil 'make-it-local)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :foundry "nil" :slant normal :weight normal :height 181 :width normal)))))
(set-face-attribute 'default nil :height 120)

;; Lisp specific defuns

(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

;; C-c C-e
(global-set-key [3 5] 'eval-and-replace)

(defun activate-desktop ()
  (progn
    (setq desktop-dirname             "~/.emacs.d/"
          desktop-base-file-name      "emacs.desktop"
          desktop-base-lock-name      "emacs.desktop.lock"
          desktop-path                (list desktop-dirname)
          desktop-save                t
          desktop-files-not-to-save   "^$" ;reload tramp paths
;;          desktop-files-not-to-save "*magit" ;ignore magit files
          desktop-load-locked-desktop nil)
    (desktop-save-mode 1)
    )
  )

(if (eq window-system 'ns)
    (activate-desktop)
    )


;; Eclipse pain-points
;; cmd-q immediately quits eclipse
;; No way to stop the process you just started (logging hogs computer cpu)
;;

;;--------------
;; todos:
;; fix fuzzy matching for ac-complete, other stuff too?
;; show-paren-mode?
;; semantic ac-complete?  gtags?
;; if !yasnippet, mark placeholder text
;; qrr alias etc.
;; tramp-mode
;; path to file in bottom of buffer
;; linenumbers, percent, gutter summary?
;; popup-shell in folder of file.
;; projectile istället för project-root
;; See http://anirudhsasikumar.net/blog/2005.01.21.html for handling sensitive files
;; helm and helm-swoop?
;; key-chord.el!
;; whitespace hungry deletion
;; visible-mark / bookmarks
;; eww
;; smart-scan
;; deft
;; builtin keys...
;; return act as control_r?
;; super key? option on osx..
;; fix modifier keys in terminal mode!
;; image sizes for images! maybe in dired?
;; ace-jump all visible buffers / AVY!
;; img-linkify
;; emacs-mac 24.4
;; swank-js! checkout emacs-rocks
;; ack default folder...
;; fancy-narrow might be useful..
;; a clever which-func-mode would be nice, breadcrumbs? 
;; handy functions from github
;; (setq header-line-format mode-line-format)
;; smarttabs
;; doremi
;; remove whitespace before colon, color : "#ff0000" -> color: "#ff0000", code style enforcement?
;; elpy for python development
;; discover-mode!?=!? discover js2-refactor by nicolas petton
;; indent-guide https://github.com/zk-phi/indent-guide
;; phi-search https://github.com/zk-phi/phi-search

(defun calculate-expression-and-replace (start end)
  (interactive "r")
  (let ((text (buffer-substring-no-properties start end)))
    (kill-region start end)
    (insert (calc-eval text))
    )
  )

(color-theme-initialize)
(color-theme-rotor)
(set-face-attribute 'highlight nil :foreground 'unspecified)
(set-face-attribute 'highlight nil :background 'unspecified)
(set-face-foreground 'highlight nil)
(set-face-underline-p 'highlight t)
(set-face-attribute hl-line-face nil :underline t)

(defun align-regexp-repeated (start stop regexp)
  "Like align-regexp, but repeated for multiple columns. See http://www.emacswiki.org/emacs/AlignCommands"
  (interactive "r\nsAlign regexp: ")
  (let ((spacing 1)
        (old-buffer-size (buffer-size)))
    ;; If our align regexp is just spaces, then we don't need any
    ;; extra spacing.
    (when (string-match regexp " ")
      (setq spacing 0))
    (align-regexp start stop
                  ;; add space at beginning of regexp
                  (concat "\\([[:space:]]*\\)" regexp)
                  1 spacing t)
    ;; modify stop because align-regexp will add/remove characters
    (align-regexp start (+ stop (- (buffer-size) old-buffer-size))
                  ;; add space at end of regexp
                  (concat regexp "\\([[:space:]]*\\)")
                  1 spacing t)))

(defun local-set-minor-mode-key (mode key def)
  "Overrides a minor mode keybinding for the local
   buffer, by creating or altering keymaps stored in buffer-local
   `minor-mode-overriding-map-alist'."
  (let* ((oldmap (cdr (assoc mode minor-mode-map-alist)))
         (newmap (or (cdr (assoc mode minor-mode-overriding-map-alist))
                     (let ((map (make-sparse-keymap)))
                       (set-keymap-parent map oldmap)
                       (push `(,mode . ,map) minor-mode-overriding-map-alist) 
                       map))))
    (define-key newmap key def)))
(global-set-key "\M-/" 'hippie-expand)


(defun my-find-file-check-if-large-file()
  "If a file is over a given size, do specific stuff"
  (when (> (buffer-size) (* 1024 1024))
    (fundamental-mode)
    (set (make-variable-buffer-local 'line-number-mode) nil) ;; Disable line numbers
    (set (make-variable-buffer-local 'column-number-mode) nil);; Disable column numbers
    (jit-lock-mode nil) ;; Disable clever font locking
    (setq bidi-display-reordering nil) ;; Might speed up long line files
    (flymake-mode nil)
    (flyspell-mode nil)
    (glasses-mode nil)
    (font-lock-mode nil)
    (highlight-changes-mode nil)
    ))

(add-hook 'find-file-hook 'my-find-file-check-if-large-file)
