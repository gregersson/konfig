
(defun autorefresh-chrome-hook()
       (interactive)
       (shell-command
        "osascript ~/konfig/autorefresh.scpt"))
