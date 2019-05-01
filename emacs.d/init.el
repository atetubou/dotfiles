;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)


(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(helm rainbow-delimiters use-package go-mode lsp-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; global configurations
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(keyboard-translate ?\C-h ?\C-?)
(setq backup-directory-alist '((".*" . "~/.emacs.d/backup")))
(setq default-tab-width 4)
(show-paren-mode 1)

;;; package specific configurations
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

(use-package helm-config
  :defer t
  :bind
  (
   ("C-x C-f" . 'helm-find-files)
   ("M-x" . 'helm-M-x)
   ("M-y" . 'helm-show-kill-ring)
   )
  :config
  (helm-mode 1)
  (helm-autoresize-mode t)
)

(use-package rainbow-delimiters-mode
  :defer t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
