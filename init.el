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

(dolist (package '(paredit restclient 
                   json-mode typescript-mode vue-mode vue-html-mode
                   dap-mode lsp-java lsp-haskell
                   dante cider gradle-mode nix-mode
                   ))
  (unless (package-installed-p package)
    (package-install package)))

;; -----------------
;; common
;; -----------------
(require 'flycheck)
(electric-indent-mode 0)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default truncate-lines t)

(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)
(add-hook 'conf-mode-hook (lambda () (display-line-numbers-mode t))) 


;; -----------------
;; nix mode
;; -----------------
(use-package nix-mode
  :mode "\\.nix\\'"
  :init 
  (add-hook 'haskell-mode-hook 'flycheck-mode))

;; -----------------
;; common lsp
;; -----------------
(require 'lsp)
(setq lsp-file-watch-ignored
  '(".idea" ".ensime_cache" ".eunit" "node_modules"
            ".git" ".hg" ".fslckout" "_FOSSIL_"
            ".bzr" "_darcs" ".tox" ".svn" ".stack-work"
            "build"))
(custom-set-variables
 '(lsp-enable-on-type-formatting nil)
)

;; -----------------
;; json mode
;; -----------------
(add-hook 'json-mode-hook #'lsp)

;; -----------------
;; typescript mode
;; -----------------
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
(add-hook 'typescript-mode-hook #'lsp)

;; -----------------
;; vue mode
;; -----------------
;; yarn global add vue-language-server
;; yarn global add vscode-css-languageserver-bin
(add-hook 'vue-mode-hook #'lsp)
(with-eval-after-load 'lsp-mode
  (mapc #'lsp-flycheck-add-mode '(typescript-mode js-mode css-mode vue-html-mode)))
;; -----------------
;; c mode
;; -----------------
;; nix-env -f ~/.nix-defexpr/channels/nixos-20.03 -iA clang-tools
(add-hook 'c++-mode-hook #'lsp)

;; -----------------
;; haskell mode
;; -----------------
;; (require 'lsp-haskell)
;; (add-hook 'haskell-mode-hook #'lsp)
(use-package dante
  :ensure t
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  (add-hook 'haskell-mode-hook 'dante-mode)
  )

;; -----------------
;; java mode
;; -----------------
(require 'dap-java)
(require 'lsp-java)

;; nix-env -f ~/.nix-defexpr/channels/nixos-20.03 -iA lombok
(setq path-to-lombok (car (file-expand-wildcards "/nix/store/*-lombok-*/share/java/lombok.jar") ) )
(setq lsp-java-vmargs
      `("-noverify"
        "-Xmx1G"
        "-XX:+UseG1GC"
        "-XX:+UseStringDeduplication"
        ,(concat "-javaagent:" path-to-lombok)
        ,(concat "-Xbootclasspath/a:" path-to-lombok)))

(add-hook 'java-mode-hook #'lsp)
(add-hook 'java-mode-hook (lambda ()
                            (setq c-default-style "java")
                            (setq c-basic-offset 4)
                            (display-line-numbers-mode t)
                            (gradle-mode 1)
                            ))

