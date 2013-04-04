(progn
  (let* ((snippetdir (concat
                      (car yas/root-directory)
                      "/objc-mode/")))
    (message (concat "mkdir -p " snippetdir))
    (shell-command (concat "mkdir -p " snippetdir))
    (shell-command
     (concat
      "find /Applications/Xcode.app/Contents/Developer/Platforms/"
      "iPhoneOS.platform/Developer/SDKs/iPhoneOS6.1.sdk/System/"
      "Library/Frameworks -name \"*.h\" | xargs "
      "~/.emacs.d/el-get/yasobjc/yasobjc.rb -o "
      snippetdir
      ))
    )
  )
