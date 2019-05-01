;;; global configurations
(add-hook 'before-save-hook 'delete-trailing-whitespace)
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
  :config
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (global-company-mode)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t)
  (setq completion-ignore-case t)
  (push 'company-lsp company-backends))

(use-package company-lsp)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package go-mode
  :commands go-mode
  :mode (("\\.go?\\'" . go-mode))
  :defer t
  :init
  (add-hook 'go-mode-hook #'lsp)
  ;;; can not install gopls to use bingo?
  (setq lsp-clients-go-server-args `("--format-style=goimports"))
  :config
  (add-hook 'before-save-hook 'lsp-format-buffer))

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

(use-package rainbow-delimiters
  :defer t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;;; for flycheck
(provide 'init)
;;; init.el ends here
