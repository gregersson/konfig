(setq project-roots
      '(
	("Git Project"
         :root-contains-files (".git/index")
         :on-hit (lambda (p) 
		   (setq project-root-find-files-command "git ls-files")

		   ))
	("Mercurial Project"
         :root-contains-files (".hg/store")
         :on-hit (lambda (p) 
		   (setq project-root-find-files-command "hg locate")

		   ))
	("Qmake project"
         :root-contains-files ("main.cpp")
         ;; :filename-regex ,(regexify-ext-list '(h c cpp qml))
         ;; :exclude-paths ("*.app"))
         :on-hit (lambda (p) 
		   ;; Just run find files with some nice filetypes
		   (setq project-root-find-files-command "find . -iname \"*.h\" -o -iname \"*.cpp\" -o -iname \"*.pro\" -o -iname \"*.qml\"")
		   ;; Simple qmake
		   (setq project-root-configure-command "qmake")
		   ;; Compile
		   (setq project-root-compile-command "make -k -j")
		   ;; Clean
		   (setq project-root-clean-command "make clean")
		   ;; Grep the target file from the project, add prefix './' and execute
		   (setq project-root-run-command "` grep 'TARGET   ' Makefile | sed 's|.*= \\(.*\\)|./\\1|'`")
		   
		   ))
	)
      )


(defun ido-project-root-find-file ()
  "Use ido to select a file from the project."
  (interactive)
  (let (my-project-root project-files tbl)
    (unless project-details (project-root-fetch))
    (setq my-project-root (cdr project-details))
    
    (let ((command (concat "cd "
                    my-project-root
                    " && "
		    project-root-find-files-command)))
      ;;(message command)
      (setq project-files 
            (split-string 
             (shell-command-to-string command) "\n")))
    
    ;; populate hash table (display repr => path)
    (setq tbl (make-hash-table :test 'equal))
    (let (ido-list)
      (mapc (lambda (path)
              ;; format path for display in ido list
              (setq key path)
              ;; strip project root
              (setq key (replace-regexp-in-string my-project-root "" key))
              ;; remove trailing | or /
              (setq key (replace-regexp-in-string "\\(|\\|/\\)$" "" key))
              (puthash key path tbl)
              (push key ido-list)
              )
            project-files
            )
      (find-file (gethash (ido-completing-read "project-files: " ido-list) tbl)))))

(global-set-key "" (quote ido-project-root-find-file))
(global-set-key "f" (quote ido-project-root-find-file))
