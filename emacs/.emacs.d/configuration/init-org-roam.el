(use-package org-roam
  :ensure t
  :init		       ; init is executed before the package is loaded
  (setq org-roam-v2-ack t)
  :custom
  ;; (let ((dir (file-name-directory "~/Notes/Roam/")))
  ;;   (unless (file-exists-p dir)
  ;;     (make-directory dir t)
  ;;     (make-directory "~/Notes/Roam/daily/")))
  (org-roam-directory "~/Notes/Roam")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert)
	 :map org-mode-map
	 ("C-M-i"   . completion-at-point))
  :config
  (org-roam-setup))
;; This doesn't work. Don't know why!
;; (setq org-roam-node-display-template "${title} ${tag}")

