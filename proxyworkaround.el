
(setq url-proxy-services '(
			   ("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
			   ("http" . "devproxy.se.shb.biz:8088")
			   ("https" . "devproxy.se.shb.biz:8088")
(require 'cl)
(load-library "~/src/scratch/noflet.el")
(load-library "~/src/scratch/curl-for-url.el.1")
(curl-for-url-install)
