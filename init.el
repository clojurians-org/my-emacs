(require 'package)

;; (setq url-proxy-services
;;   '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
;;     ("http" . "localhost:8118")
;;     ("https" . "localhost:8118")))

(setq package-check-signature nil)
(setq package-archives
      '(("gnu" . "https://elpa.emacs-china.org/gnu/")
        ("melpa" . "https://elpa.emacs-china.org/melpa/")
	))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package '(paredit restclient
		   dante cider lsp-java))
  (unless (package-installed-p package)
    (package-install package)))


(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)

(require 'lsp-java)
(add-hook 'java-mode-hook #'lsp)
