 ;; make initial setup better
(setq inhibit-startup-message t) ; Disable the startup message
(scroll-bar-mode -1) ; Disable visual scrollbar
;; (tool-bar-mode -1)
					;Disable toolbar
(tooltip-mode -1) ; Disable tooltips
(set-fringe-mode 10) ; Get breathing room?
;; (menu-bar-mode -1)
					; Disable the menu bar

(setq visible-bell t)

(load-theme 'tango-dark)

;;Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


;; initialize package sources
(require 'package) (setq package-archives '(("melpa"
. "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/") ("elpa"
			 . "https://elpa.gnu.org/packages/")))

(package-initialize)
;; Refresh package listings
(unless package-archive-contents
  (package-refresh-contents))

;; Get the esteemed USE-PACKAGE package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package) (setq use-package-always-ensure t)

;; Ivy setup
(use-package ivy
  :diminish ; removes the ivy minor mode from the list in the modeline
  ;; For the C-s keybinding bring up swiper
  :bind (("C-s" . swiper)
	 ;; Map keys for when ivy is displayed in the minibuffer
	 :map ivy-minibuffer-map ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done) ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config (ivy-mode 1)
  :ensure t)


(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (counsel-mode 1)
  (setq ivy-initial-inputs-alist nil)
  :ensure t)

(use-package magit
  :ensure t)


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

(use-package undo-fu :ensure t
  :config
  ;(global-undo-tree-mode -1)
  (define-key evil-normal-state-map "u" 'undo-fu-only-undo)
  (define-key evil-normal-state-map "\C-r" 'undo-fu-only-redo))

(use-package undo-fu-session
  :ensure t)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :ensure t)

(use-package doom-themes
  :init (load-theme 'doom-dracula t)
  :ensure t)

(use-package all-the-icons
  :if (display-graphic-p)
  :commands all-the-conds-install-fonts
  :init
  (unless (find-font (font-spec :name "all-the-icons"))
    (all-the-icons-install-fonts t)))

(use-package all-the-icons-dired
  :if (display-graphic-p)
  :hook (dired-mode . all-the-icons-dired-mode)
  :ensure t)

(use-package lispy
  :init
  (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
  (add-hook 'lisp-mode-hook (lambda () (lispy-mode 1)))
  :ensure t)

(use-package lispyville
  :init
  (add-hook 'lispy-mode-hook #'lispyville-mode)
  :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("6c98bc9f39e8f8fd6da5b9c74a624cbb3782b4be8abae8fd84cbc43053d7c175" "d268b67e0935b9ebc427cad88ded41e875abfcc27abd409726a92e55459e0d01" "7eea50883f10e5c6ad6f81e153c640b3a288cd8dc1d26e4696f7d40f754cc703" "1f1b545575c81b967879a5dddc878783e6ebcca764e4916a270f9474215289e5" default))
 '(org-hide-emphasis-markers t)
 '(package-selected-packages
   '(docker-cli dockerfile-mode docker-compose-mode clhs company-box sly-macrostep sly-asdf company which-key lispyville cl-libify yaml-mode yaml company-restclient ob-restclient restclient helpful ivy-rich which-key rainbow-delimiters magit org-roam use-package undo-fu-session undo-fu lispyville doom-themes doom-modeline command-log-mode all-the-icons-dired))
 '(safe-local-variable-values '((url-max-redirections . 0))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))

;; (use-package slime
;;   :ensure t
;;   :config
;;   (setq inferior-lisp-program "/usr/bin/sbcl")
;;   (setq slime-contribs '(slime-asdf slime-scratch)))

(make-directory "~/.emacs.d/autosaves/" t)
(make-directory "~/.emacs.d/backups/" t)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(global-display-line-numbers-mode 'relative)
(setq display-line-numbers-type 'relative)

(use-package company
  :ensure t
  :hook
  (lisp-mode . company-mode)
  (sly-mrepl-mode . company-mode)
  (emacs-lisp-mode . company-mode)
  ;; :delight
  :bind (:map company-active-map
	      ("C-j" . company-select-next)
	      ("C-k" . company-select-previous)
	      ("C-l" . company-complete-selection)
	      ("<tab>" . company-complete-selection))
  (:map sly-mode-map
	("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0)
  ;; (:map lsp-mode-map
  ;; 	("<tab>" . company-indent-or-complet-common))
  )
;; (use-package company-box
;;   :ensure t
;;   :hook (company-mode . company-box-mode))

(use-package sly
  :ensure t
  :init
  :config
  (setq inferior-lisp-program "/usr/bin/sbcl")
  
  (add-to-list 'sly-contribs 'sly-scratch 'append)
  (add-to-list 'sly-contribs 'sly-asdf 'append)
  (add-to-list 'sly-contribs 'sly-macrostep 'append)
  (sly-setup))

(use-package sly-asdf
  :ensure t
  :requires sly)

(use-package sly-macrostep
  :ensure t
  :requires sly)

(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package rainbow-delimiters
  ;; prog-mode is the base mode of any programming language mode
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  ;; anything in the init hook is run regardless of whether the package is loaded or not
  :init (which-key-mode)
  :diminish which-key-mode
  ;; Config block is only evaluated when the package is loaded
  :config
  (setq which-key-idle-delay 0.1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ;; use [remap] to reference the mapping of a particular command/defun
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package clhs
  :config
  (setq common-lisp-hyperspec-root "file:///usr/share/doc/clhs/HyperSpec/"))

;; Load the org-roam stuff
(load-file "~/.emacs.d/configuration/init-org-roam.el")

(defun is-wsl-p ()
  (file-exists-p "/etc/wsl.conf"))

;; (defun is-work-pc-p ())

;; (defun is-linux-p ())

;; (defun is-windows-p ())

(use-package restclient
  :ensure t)

(use-package company-restclient
  :ensure t)

(use-package ob-restclient
  :ensure t
  :config
  (add-languages-to-org-babel 'restclient)
  ;; (org-babel-do-load-languages
  ;;  'org-babel-load-languages
  ;;  '((restclient . t)))
  )


;; (defun org-toggle-emphasis ()
;;   "Toggle hiding/showing of org emphasis markers"
;;   (interactive)
;;   (if org-hide-emphasis-markers
;;       (set-variable 'org-hide-emphasis-markers nil)
;;     (set-variable 'org-hide-emphasis-markers t))
;;   (org-mode-restart))

(define-key org-mode-map (kbd "C-c e") 'visible-mode)

;; src block indentation / edititng / syntax highlighting
(setq org-src-preserve-indentation t
      org-src-window-setup 'current-window
      org-src-strip-leading-and-trailing-blank-lines t
      org-src-tab-acts-natively t)

(defun append-unique (seq1 seq2)
  (append seq1
	  (remove-if (lambda (item) (find item seq1 :test #'equal)) seq2)))

(defun add-languages-to-org-babel (&rest languages)
  (let ((babel-current (symbol-value 'org-babel-load-languages)))
    (setq org-babel-load-languages
	  (append-unique babel-current
		  (mapcar (lambda (lang) (cons lang t)) languages)))))


(add-languages-to-org-babel 'emacs-lisp 'python 'sh)

(progn 
  (sly-scratch)
  (sly))
