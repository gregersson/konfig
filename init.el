;; Required variables!
(setq konfig-home "/Users/greget/konfig/")
(setq load-path (cons konfig-home load-path))
(setq el-get-user-package-directory "Users/greget/konfig/package-configs")
;; -- end of Required variables

;; Load el-get packages
(load-library "setup-el-get.el")

;; Clone kd-repos if needed
(if  (file-exists-p (concat konfig-home "kd-repos"))
    (progn 
      ;; The following will be done if the kd-repos are present
      (load-library "kd-repos/kdext/kdext-autosave-settings.el")  ;; Avoid ugly tmp-files
      )
  (progn 
    ;; There are no kd-repos, clone them!
    (dired-create-directory (concat konfig-home "kd-repos"))
    (call-process "hg" nil "messages" nil "clone" "https://bitbucket.org/dnils/kd" (concat konfig-home "kd-repos/kd"))
    (call-process "hg" nil "messages" nil "clone" "https://bitbucket.org/dnils/kdext" (concat konfig-home "kd-repos/kdext"))
    )
  )

(setq magic-mode-alist
  (append (list  
       '("\\(.\\|\n\\)*\n@implementation" . objc-mode)
       '("\\(.\\|\n\\)*\n@interface" . objc-mode)
       '("\\(.\\|\n\\)*\n@protocol" . objc-mode))
      magic-mode-alist))
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))

(load-library "init-cmode.el")
(global-set-key  [?\M-o] 'ff-find-other-file)
(global-set-key  [C-M-up] 'ff-find-other-file)
(global-set-key  [C-M-down] 'ff-find-other-file)

(ido-mode t)

(require 'redo+)
(global-set-key  [?\M-_] 'redo)

(global-set-key [f4] (quote next-error))

(delete-selection-mode 1)
(setq case-fold-search t)   ; make searches case insensitive
(semantic-mode t)
(auto-complete-mode t)


(setq tramp-default-method "ssh")


