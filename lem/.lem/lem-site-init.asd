;; don't edit !!!
(asdf/parse-defsystem:defsystem "lem-site-init"
  :components ((:module "src"
                :components ((:file "config")
                             (:file "misc")
                             (:file "keybinds")))))
