;; Required variables!
(setq load-path (cons "~/konfig/" load-path))
(setq el-get-user-package-directory "~/konfig/package-configs")
;; -- end of Required variables

;; Load el-get packages
(load-library "setup-el-get.el")

;; Clone kd-repos if needed
(if (not (file-exists-p "kd-repos"))
    (progn 
      (call-process "hg" nil "messages" nil "clone" "https://bitbucket.org/dnils/kd" "kd-repos/kd")
      (call-process "hg" nil "messages" nil "clone" "https://bitbucket.org/dnils/kdext" "kd-repos/kdext")
      )
  )

(load-library "kd-repos/kdext/kdext-autosave-settings.el")  ;; Avoid ugly tmp-files


