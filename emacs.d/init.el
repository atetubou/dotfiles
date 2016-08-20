(require 'cask "~/.cask/cask.el")
(cask-initialize)

(keyboard-translate ?\C-h ?\C-?)
(scroll-bar-mode -1)
(blink-cursor-mode 1)


(show-paren-mode t)

;;;====================================
;;;; Buffer 設定
;;;===================================
;;; iswitchb は、バッファ名の一部の文字を入力することで、
;;; 選択バッファの絞り込みを行う機能を実現します。
;;; バッファ名を先頭から入力する必要はなく、とても使いやすくなります。
(iswitchb-mode 1) ;;iswitchbモードON
;;; C-f, C-b, C-n, C-p で候補を切り替えることができるように。
(add-hook 'iswitchb-define-mode-map-hook
      (lambda ()
        (define-key iswitchb-mode-map "\C-n" 'iswitchb-next-match)
        (define-key iswitchb-mode-map "\C-p" 'iswitchb-prev-match)
        (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
        (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)))


;;; 起動時の画面はいらない
(setq inhibit-startup-message t)

(ac-config-default)

(yas-global-mode 1)


(setq completion-ignore-case t)
(global-auto-revert-mode 1)

(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; 行番号・桁番号を modeline に表示する
(line-number-mode t)   ; 行番号
(column-number-mode t) ; 桁番号

(setq-default tab-width 2 indent-tabs-mode nil)


;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'c++-mode-hook (lambda () (flycheck-select-checker 'c/c++-gcc)))
(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++1y")))
(add-hook 'python-mode-hook '(lambda () (flycheck-mode 0)))


(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;;http://tokikane-tec.blogspot.jp/2012/11/emacs_11.html
(setq backup-directory-alist
  (cons (cons ".*" (expand-file-name "~/.emacs.d/backup"))
        backup-directory-alist))
(setq auto-save-file-name-transforms
  `((".*", (expand-file-name "~/.emacs.d/backup/") t)))

;http://cortyuming.hateblo.jp/entry/20120429/p2
(bash-completion-setup)


(add-hook 'before-save-hook 'delete-trailing-whitespace)

; (require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c++-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)


(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)


(let ((envs '("PATH" "GOPATH")))
  (exec-path-from-shell-copy-envs envs))
