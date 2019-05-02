(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; global configurations
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(column-number-mode t)
(keyboard-translate ?\C-h ?\C-?)
(setq backup-directory-alist '((".*" . "~/.emacs.d/backup")))
(setq default-tab-width 4)
(show-paren-mode 1)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


;;; https://nukosuke.hatenablog.jp/entry/straight-el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(setq straight-use-package-by-default t)


;;; package specific configurations
(use-package company
  :bind
  (:map company-active-map
		("C-n" . company-select-next)
        ("C-p" . company-select-previous)
		)
  :config
  (global-company-mode)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t)
  (setq completion-ignore-case t)
  (push 'company-lsp company-backends))

(use-package company-lsp)

(use-package flycheck
  :init (global-flycheck-mode))

(use-package flycheck-rust
  :commands rust-mode
  :defer t)

(use-package go-mode
  :commands go-mode
  :defer t
  :init
  (add-hook 'go-mode-hook #'lsp)
  (setq gofmt-command "goimports")
  :config
  (add-hook 'before-save-hook 'gofmt-before-save))

(use-package helm
  ;;; Should not have ":defer t".
  :bind
  (
   ("C-x C-f" . 'helm-find-files)
   ("C-x b" . 'helm-mini)
   ("M-x" . 'helm-M-x)
   ("M-y" . 'helm-show-kill-ring)
   )
  :config
  (helm-autoresize-mode t)
  (helm-mode 1)
)

(use-package lsp-mode
  :defer t
  :init
  (add-hook 'c++-mode-hook #'lsp))

(use-package magit)

(use-package rainbow-delimiters
  :defer t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package rust-mode
  :commands rust-mode
  :defer t
  :init
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
  (add-hook 'rust-mode-hook #'lsp)
  :config
  (add-hook 'before-save-hook 'lsp-format-buffer))

(use-package smart-mode-line
  :config
  (setq sml/theme 'dark)
  (sml/setup))

;;; for flycheck
(provide 'init)
;;; init.el ends here
