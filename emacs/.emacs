(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages"))
; (package-initialize) unnecessary call to 'package-initialize' in init file

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
 '(helm-completion-style 'emacs)
 '(package-selected-packages
   '(org-roam yaml-mode dockerfile-mode docker slime-docker magit lispyville lispy elpy monokai-theme undo-fu-session undo-fu use-package powerline helm slime evil-visual-mark-mode))
 '(setq backup-directory-alist t))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)
(make-directory "~/.emacs.d/backups/" t)

(setq package-enable-at-startup nil)
(package-initialize)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(use-package evil
  :ensure t ;; installs evil package if not installed
  :init	    ;; tweak evil's configuration before loading it
					;  (setq evil-search-module 'evil-search)
  (setq evil-undo-system 'undo-fu)
  (setq evil-want-fine-undo t)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
					;  (setq evil-shit-round nil)
					;  (setq evil-want-C-u-scroll t)
  :config ;; tweak evil after loading it)
  (require 'evil)
  (evil-mode t)
  (evil-define-key 'insert 'global (kbd "<tab>l") 'evil-window-right)
  (evil-define-key 'insert 'global (kbd "<tab>j") 'evil-window-down)
  (evil-define-key 'insert 'global (kbd "<tab>k") 'evil-window-up)
  (evil-define-key 'insert 'global (kbd "<tab>h") 'evil-window-left)
  (evil-define-key 'normal 'global (kbd "<tab>l") 'evil-window-right)
  (evil-define-key 'normal 'global (kbd "<tab>j") 'evil-window-down)
  (evil-define-key 'normal 'global (kbd "<tab>k") 'evil-window-up)
  (evil-define-key 'normal 'global (kbd "<tab>h") 'evil-window-left))


(use-package lispy
  :init
  (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
  (add-hook 'lisp-mode-hook (lambda () (lispy-mode 1)))
  :ensure t)

(use-package lispyville
  :init
  (add-hook 'lispy-mode-hook #'lispyville-mode)
  :ensure t)

(use-package undo-fu
  :ensure t
  :config
  ;(global-undo-tree-mode -1)
  (define-key evil-normal-state-map "u" 'undo-fu-only-undo)
  (define-key evil-normal-state-map "\C-r" 'undo-fu-only-redo))

(use-package undo-fu-session
  :ensure t)


(use-package helm
  :ensure t
  :config
  (global-set-key (kbd "M-x") 'helm-M-x)
  (require 'helm)
  (helm-mode 1))

(use-package slime
  :ensure t
  :config
  (setq inferior-lisp-program "/usr/bin/sbcl"))

;; themese
(use-package monokai-theme
  :ensure t)

;;(use-package elpy
;;  :ensure t
;;  :config
;;  (elpy-enable))

(use-package org
  :ensure t
  :config
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (setq org-log-done t)
  (require 'org))

(use-package magit
  :ensure t)

(use-package docker
  :ensure t
  :bind ("C-c d" . docker ))

(use-package yaml-mode
  :ensure t)

(load-file "~/.emacs.d/configuration/init-org-roam.el")

(load-theme 'monokai t)

(global-set-key (kbd "C-< C->") (kbd "C-u C-x C-e ^i;; => C-["))
(show-paren-mode 1)

(require 'paren)
;; (setq show-paren-style 'mixed)
;; (setq show-paren-style 'expression)
(setq show-paren-style 'parenthesis)
(show-paren-mode +1)


;;(global-linum-mode t)

;; startup stuff
(setq inhibit-startup-screen t) 
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
