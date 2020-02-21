(require 'package)

;; (setq url-proxy-services
;;       '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
;;         ("http" . "localhost:8118")
;;         ("https" . "localhost:8118")))

(setq package-check-signature nil)
(setq package-archives
      '(("gnu" . "https://elpa.emacs-china.org/gnu/")
        ("melpa" . "https://elpa.emacs-china.org/melpa/")
	))

(package-initialize)


(unless package-archive-contents
  (package-refresh-contents))

(dolist (package '(paredit restclient json-mode typescript-mode
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
(setq-default truncate-lines t)
(custom-set-variables
 '(lsp-enable-on-type-formatting nil)
)

(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)
(add-hook 'json-mode-hook #'lsp)

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
(add-hook 'typescript-mode-hook #'lsp)

(add-hook 'conf-mode-hook (lambda () (display-line-numbers-mode t))) 
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
