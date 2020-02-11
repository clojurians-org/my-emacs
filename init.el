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
                   dap-mode lsp-java
        		   dante cider 
                   ))
  (unless (package-installed-p package)
    (package-install package)))

;; -----------------
;; common
;; -----------------
(electric-indent-mode 0)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(custom-set-variables '(lsp-enable-on-type-formatting nil))

(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)

;; -----------------
;; java mode
;; -----------------
(require 'dap-java)
(require 'lsp-java)
(add-hook 'java-mode-hook #'lsp)
(add-hook 'java-mode-hook (lambda ()
                            (setq c-default-style "java")
                            (setq c-basic-offset 4)
                            (display-line-numbers-mode t)
                            ))
