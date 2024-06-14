(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lspkeymap-prefix "C-c l") 	;any time we hit C-c l, we get LSP mode 
  :config
  ;; descriptions about what keys do
  ;; (lsp-enable-which-key-integration t) ; disabled for now because of reasons
  )

(use-package csharp-mode
  :mode "\\.cs\\'"
  :hook (csharp-mode . lsp-deferred)
  :config
  ;; (setq lsp-csharp-omnisharp-roslyn-server-dir "~/winuser/cache/lsp/omnisharp-roslyn/latest/omnisharp-roslyn")
  ;; (setq lsp-csharp-omnisharp-roslny-store-path "~/winuser/cache/lsp/omnisharp-roslyn/latest/omnisharp-roslyn.zip")
  ;; (setq lsp-csharp-server-install-dir "~/winuser/cache/lsp/omnisharp-roslyn")
  (setq lsp-csharp-server-path "~/winuser/wsl-cache/lsp/OmniSharp.exe")
  )

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3))
