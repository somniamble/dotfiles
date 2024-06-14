(in-package :lem-user)

; 
; (when (asdf:find-system :lem-pareto nil)
;   (asdf:load-system :lem-pareto)
;   ;; Enable Paredit and Pareto along with Lisp mode
;   (add-hook *find-file-hook*
;             (lambda (buffer)
;               (when (eq (buffer-major-mode buffer)
;                         'lem-lisp-mode:lisp-mode)
;                 (change-buffer-mode buffer 'lem-paredit-mode:paredit-mode t)
;                 ;(change-buffer-mode buffer 'lem-pareto-mode:pareto-mode t)
;                 ))))

; ; Start in vi-mode
(lem-vi-mode:vi-mode)

(load-theme "hardcore")
 
; ; For now start by loading the init file
; (find-file "~/.lem/init.lisp")
; 
; (ql:quickload "lem/legit")


; How do I rebind an editor variable?

;(setf (variable-value 'lem-vi-mode:leader-key) "Space")



;(setf (variable-value (find-editor-variable 'leader-key)) "Space")

(setf (variable-value 'lem-vi-mode:leader-key :global) "Space")

(defun current-major-mode ()
  (lem:mode-name (lem:buffer-major-mode (lem:current-buffer))))

(defun major-mode-is-p (mode-name)
  (string-equal (current-major-mode) mode-name))

(define-command rosin/vinegar () ()
  "Changes to directory mode in the current directory, or goes up a dir"
    (if (major-mode-is-p "Directory")
        (lem/directory-mode::directory-mode-up-directory)
        (find-file (current-directory))))

; some meta commands
(define-command rosin/open-init () ()
  (find-file "~/.lem/init.lisp"))

; doesn't work right now
(define-command rosin/open-lem-source () ()
  (find-file (ql:where-is-system :lem)))

; (lem-vi-mode/registers:paste-yank)
; (lem-vi-mode/commands:vi-paste-after)

; Oh HELL yes

(define-key lem-vi-mode:*normal-keymap* "Leader f b" 'lem/list-buffers:list-buffers)
(define-key lem-vi-mode:*normal-keymap* "Leader p f" 'lem-core/commands/project:project-find-file)
(define-key lem-vi-mode:*normal-keymap* "Leader f f" 'find-file)
(define-key lem-vi-mode:*normal-keymap* "Leader f Space" 'lem/grep::grep)
(define-keys lem-vi-mode:*visual-keymap*
  ("<" 'lem-core/commands/edit:delete-indentation))
(define-keys lem-vi-mode:*normal-keymap*
  ("-" 'rosin/vinegar)
  ; just vim window stuff
  ("C-w v" 'split-active-window-horizontally)
  ("C-w s" 'split-active-window-vertically)
  ; meta
  ("Leader m i" 'rosin/open-init)
  ("Leader m l" 'rosin/open-lem-source)
  ("Leader m r" 'rosin/focus-internal-repl)
  ("g d" 'lem/language-mode:find-definitions)
  ("g r" 'lem/language-mode:find-references)
  ("g t" 'lem/frame-multiplexer:frame-multiplexer-next)
  ("g T" 'lem/frame-multiplexer:frame-multiplexer-prev)
  ("Leader a n" 'lem/frame-multiplexer:frame-multiplexer-create-with-new-buffer-list))

(define-key *global-keymap* "C-h k" 'describe-key)
(define-key *global-keymap* "C-h b" 'describe-bindings)

; How can I pop open a prompt?
; Types of popups:

; helpful: 
; https://github.com/garlic0x1/.lem/blob/master/src/places.lisp

; This gives us a "drop-down from top" kind of window
; which you "type out" of
; (with-pop-up-typeout-window (out (make-buffer "*foo*") :erase t :read-only t)
;   (write-string "foo" out))

; This one gives us a prompt asking for a string, and immediately yields it to the caller
; (princ (prompt-for-string "Foo: "))


; There are a whole bunch of these -- the `prompt-for-*` family
 ; and fuzzy finding?
; (lem-core::fuzzy-match-p  "sla" "night slave") ; => T
  ; it would be nice if I had a function that showed me the package
; that a particular command is from
; that's apropos
; apropos-command
; lisp-apropos

; so I can call this, and cache ?
;(buffer-filename)
(defvar *harpooned* '() "A list of harpooned files")

(define-command rosin/harpoon-current-file () ()
  (let ((harpooned (config :harpooned nil))
        (current (buffer-filename)))
    (format t "Adding ~a to ~a" current harpooned)
    (setf (config :harpooned) (adjoin current harpooned :test #'string-equal))))

(define-command rosin/go-to-harpooned () ()
  (let ((harpooned (config :harpooned nil)))
    ))

; how do I get the current file?

;; I wish I had something like the telescope keybindings thing from neovim

; (define-key *language-mode-keymap* "C-M-a" 'beginning-of-defun)
; (define-key *language-mode-keymap* "C-M-e" 'end-of-defun)
; (define-key *language-mode-keymap* "Tab" 'indent-line-and-complete-symbol)
; (define-key *global-keymap* "C-j" 'newline-and-indent)
; (define-key *global-keymap* "M-j" 'newline-and-indent)
; (define-key *language-mode-keymap* "C-M-\\" 'indent-region)
; (define-key *language-mode-keymap* "M-;" 'comment-or-uncomment-region)
; (define-key *language-mode-keymap* "M-." 'find-definitions)
; (define-key *language-mode-keymap* "M-_" 'find-references)
; (define-key *language-mode-keymap* "M-?" 'find-references)

; (define-key *language-mode-keymap* "M-," 'pop-definition-stack)
; (define-key *language-mode-keymap* "C-M-i" 'complete-symbol)
; (define-key *global-keymap* "M-(" 'insert-\(\))
; (define-key *global-keymap* "M-)" 'move-over-\))


; This doesn't do what I think it does
(define-command rosin/focus-internal-repl () ()
  (let ((buffer (lem-lisp-mode::repl-buffer)))
    (if buffer
        (lem-lisp-mode::lisp-switch-to-repl-buffer)
        (progn (lem-core:call-command 'lem-lisp-mode/internal:start-lisp-repl nil)
               (lem-core:call-command 'lem-lisp-mode/internal:slime-self-connect nil)))))

; hook settin:

(add-hook *prompt-after-activate-hook*
          (lambda ()
            ; (setf lem/completion-mode::*completion-reverse* t)
            (call-command 'lem/prompt-window::prompt-completion nil)))

(add-hook *prompt-deactivate-hook*
          (lambda ()
            ; (setf lem/completion-mode::*completion-reverse* nil)
            (lem/completion-mode:completion-end)))


(setf lem-core::*default-prompt-gravity* :bottom-display)
(setf lem/prompt-window::*prompt-completion-window-gravity* :horizontally-above-window)
(setf lem/prompt-window::*fill-width* t); how do we make it so that our micros repl uses roswell's quicklisp dist?

; do we have a repl?
(rosin/focus-internal-repl)
; (lem/prompt-window:current-prompt-window)


;;;;; tree sitter stuff: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; use this library: https://github.com/death/cl-tree-sitter
; sudo pacman -S tree-sitter-cli
; and clone this to ~/treesitters: https://github.com/tree-sitter/tree-sitter-c-sharp
; build tree sitters in ~/treesitters
; copy .so file to /usr/lib
; then we can import it like so:
; (cl-tree-sitter:register-language :csharp "tree-sitter-c-sharp")
; but this doesn't work
; (cl-tree-sitter:parse-string :csharp "public static int main() { return 0; }")
; the alien function "c_sharp" is undefined
; back to square one

;; Putting "space" in the global keymap unfortunately makes everything quite slow
;(define-keys *global-keymap*
;  ("Space x" 'execute-command)) 


; image buffer stuff
; (pop-to-buffer (lem-sdl2/image-buffer::open-image-buffer "/home/rosin/toopowerful.png"))
; (pop-to-buffer (lem-sdl2/image-buffer::open-image-buffer "/home/rosin/vlcsnap-2022-03-19-12h48m30s651.png"))
;(pop-to-buffer (lem-sdl2/image-buffer::open-image-buffer "/home/rosin/repairer.png"))

; (lem-sdl2/drawing:
; (lem-sdl2/image-buffer::open-image-buffer "/home/rosin/repairer.png") 
; (format nil "~a" (cmd:$sh "ls -1 /home/rosin/*.png"))




;

;; The variable W is unbound.
;; [Condition of type UNBOUND-VARIABLE]
;; 
;; Restarts:
;; 0: [CONTINUE] Retry using W.
;; 1: [USE-VALUE] Use specified value.
;; 2: [STORE-VALUE] Set specified value and use it.
;; 3: [RETRY] Retry SLIME interactive evaluation request.
;; 4: [*ABORT] Return to SLIME's top level.
;; 5: [ABORT] abort thread (#<THREAD "worker" RUNNING {1007FF0003}>)
;; 
;; Backtrace:

;; 0: (SB-INT:SIMPLE-EVAL-IN-LEXENV W #<NULL-LEXENV>)
;; 1: (EVAL W)
;; 2: ((LAMBDA NIL :IN MICROS:INTERACTIVE-EVAL))
;; --more--



; figure out how to see, on the status line, the last command that fired


;  just like the M-x prefix
;  I think it does something like "command mode"


