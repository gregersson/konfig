(progn
  (require 'auto-complete)
  (add-to-list 'ac-dictionary-directories (expand-file-name "dict" pdir))

  (require 'auto-complete-config)
  (ac-config-default)
  (setq-default ac-sources '(ac-source-yasnippet
                             ac-source-abbrev
                             ac-source-dictionary
                             ac-source-words-in-same-mode-buffers)
                )
  )
