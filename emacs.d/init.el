(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/") package-archives)
(push '("melpa" . "http://melpa.milkbox.net/packages/") package-archives)
(package-initialize)

(require 'undo-tree)
(global-undo-tree-mode)
(setq undo-tree-auto-save-history t)
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)
(evil-commentary-mode 1)
(require 'evil-matchit)
(global-evil-matchit-mode 1)
(require 'evil-snipe)
(evil-snipe-mode 1)
(setq evil-snipe-repeat-keys t)
(setq evil-snipe-scope 'visible)
(setq evil-snipe-repeat-scope 'whole-visible)
(setq evil-snipe-enable-highlight t)
(setq evil-snipe-enable-incremental-highlight t)
(evil-snipe-override-mode 1)
(require 'evil-surround)
(global-evil-surround-mode 1)
(require 'linum-relative)
(add-hook 'prog-mode-hook 'linum-mode)
(require 'evil-magit)
(require 'evil-org)

;; Make Emacs aware of Vim modelines.  I think [the package][1] isn't available on MELPA,
;; Marmalade or GNU ELPA, so I'm using a Git submodule and installing it manually.
;; [1]: https://github.com/cinsk/emacs-vim-modeline
(add-to-list 'load-path "~/.emacs.d/emacs-vim-modeline/")
(require 'vim-modeline)
(add-to-list 'find-file-hook 'vim-modeline/do)

;; https://github.com/emacs-helm/helm
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(helm-mode 1)

(global-set-key (kbd "C-x g") 'magit-status)

(require 'ox-reveal)

;; https://github.com/slime/slime
(setq inferior-lisp-program "sbcl")
(setq slime-contribs '(slime-fancy))

;; http://emacswiki.org/emacs/SetFonts
;; M-x describe-font
(set-face-attribute 'default nil :family "Ubuntu Mono" :foundry "DAMA"
 :slant 'normal :weight 'normal :height 70 :width 'normal)
;; (set-face-attribute 'default nil :family "Source Code Pro" :foundry
;;  "ADBO" :slant 'normal :weight 'semi-bold :height 60 :width 'normal)
;; ;; (set-face-attribute 'default nil :family "Inconsolatazi4" :foundry
;;   "PfEd" :slant 'normal :weight 'normal :height 80 :width 'normal)

(load-theme 'monokai t)
;; (load-theme 'zenburn t)

(setq show-paren-delay 0)
(show-paren-mode 1)

(blink-cursor-mode 0)

(column-number-mode 1)
(display-battery-mode 1)

(require 'saveplace)
(setq-default save-place 1)

(menu-bar-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)

;; vim: tw=90 sts=-1 sw=3 et
