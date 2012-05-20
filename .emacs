;; -*- mode: emacs-lisp -*-
;; ------------------------------------------------------------------------------
;;
;;  Marc's .emacs file
;;
;; ------------------------------------------------------------------------------

;; Time-stamp: <2008-08-04 01:29:25 marc>

;; Common Lisp functions
(eval-when-compile (require 'cl))

;; Add a timestamp like the one above:
(add-hook 'write-file-hooks 'time-stamp)

;; If you're a vi-addict, then you might enjoy viper:
;; (add-hook 'viper-load-hook '(lambda () (viper-set-expert-level 5)))

;; Maintain a directory of personal info files
(add-to-list 'Info-default-directory-list (expand-file-name "~/info"))

;; Tabs in source code are just too much trouble
(setq-default indent-tabs-mode nil)

;; Abbrev mode
(setq-default abbrev-mode t)
(if (file-exists-p abbrev-file-name) (read-abbrev-file abbrev-file-name))
(setq save-abbrevs t)

(add-to-list 'load-path (expand-file-name "~/emacs"))
(add-to-list 'load-path (expand-file-name "~/emacs/python-mode"))

;; ------------------------------------------------------------------------------
;;  ECB (Emacs Code Browser) and CEDET (Collection of Emacs
;;  Development Environment Tools) stuff
;; ------------------------------------------------------------------------------

;; (add-to-list 'load-path (expand-file-name "~/emacs"))
;; (add-to-list 'load-path (expand-file-name "~/emacs/ecb"))
;; (add-to-list 'load-path (expand-file-name "~/emacs/cedet"))
;; (add-to-list 'load-path (expand-file-name "~/emacs/cedet/speedbar"))
;; (add-to-list 'load-path (expand-file-name "~/emacs/cedet/semantic"))
;; (add-to-list 'load-path (expand-file-name "~/emacs/cedet/eieio"))

;; (setq semantic-load-turn-useful-things-on t)
;; Replace the path below with the install location for cedet.
;; (load-file "~/emacs/cedet/common/cedet.el")

;; (require 'semantic-sb)
;; (require 'ecb)
;; (require 'cedet)  ; Collection of Emacs DEvelopment Tools
;; (require 'ecb)    ; Emacs Code Browser

(when (featurep 'semanticdb)
  (setq semanticdb-default-save-directory "/tmp/emacs-semantic")
  (when (not (file-exists-p semanticdb-default-save-directory))
    (make-directory semanticdb-default-save-directory)))

;; ------------------------------------------------------------------------------
;;  Custom
;; ------------------------------------------------------------------------------

(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(current-language-environment "English")
 '(ecb-options-version "2.32")
 '(ecb-source-path (quote ("/" ("/home/marca/ysm" "ysm"))))
 '(ecb-wget-setup (quote cons))
 '(global-font-lock-mode t nil (font-lock))
 '(iswitchb-mode t nil (iswitchb))
 '(ldap-host-parameters-alist (quote (("exchange.corp.yahoo.com"))))
 '(save-place t nil (saveplace))
 '(scroll-bar-mode nil)
 '(show-paren-mode t nil (paren))
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(tool-bar-mode nil nil (tool-bar))
 '(transient-mark-mode t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))

;; Console mode menus suck - No menus if we're not in X11
(when (and (null window-system) 
	   (eq menu-bar-mode t))
  (menu-bar-mode nil))

;; Try to detect password prompts in the shell and hide the password
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

;;
;;  Key bindings
;;
(global-set-key [help]     'overwrite-mode)
; (global-set-key "\C-w"     'backward-kill-word)
; (global-set-key "\C-x\C-k" 'kill-region)
; (global-set-key "\C-c\C-k" 'kill-region)
; (global-set-key [(control h)] 'delete-backward-char)
; (keyboard-translate ?\C-h ?\C-?)
(global-set-key "\M-[1;5C"    'forward-word)      ; Ctrl+right   => forward word
(global-set-key "\M-[1;5D"    'backward-word)     ; Ctrl+left    => backward word

;; Show which line and column marker is in
(setq line-number-mode t)
(setq column-number-mode t)

;; Nice implementation of vi dot command
(require 'dot-mode)
(add-hook 'find-file-hooks 'dot-mode-on)

;; Control-Tab to toggle between buffers
(global-set-key [C-tab] '(lambda () 
			   (interactive) 
			   (switch-to-buffer nil)))

(global-set-key [f1] 'help-command)
(define-key global-map "\M-g" 'goto-line)
(define-key emacs-lisp-mode-map "\C-ce" 'eval-buffer)

;; hippie-expand
(define-key global-map (read-kbd-macro "M-RET") 'hippie-expand)

;; More useful version of upcase word
(global-set-key "\M-u" '(lambda () 
			  (interactive) 
			  (backward-word 1)
			  (upcase-word 1)))

;; Tempo
;; This is a way to hook tempo into cc-mode
(defvar c-tempo-tags nil
  "Tempo tags for C mode")
(defvar c++-tempo-tags nil
  "Tempo tags for C++ mode")

;;; C-Mode Templates and C++-Mode Templates (uses C-Mode Templates also)
(require 'tempo)
(setq tempo-interactive t)

;;
;;  C mode settings
;;
(defun marc-c-stuff ()
  (local-set-key (read-kbd-macro "C-<return>") 'tempo-complete-tag)
  (local-set-key (read-kbd-macro "C-c TAB") 'tempo-forward-mark)
  (define-key c-mode-map "\C-m" 'newline-and-indent)
  (define-key c-mode-map (read-kbd-macro "C-c TAB") 'tempo-forward-mark)
  (define-key c-mode-map (read-kbd-macro "C-\\") 'tempo-forward-mark)
  (define-key c-mode-map (read-kbd-macro "<f7>") 'compile)
  (tempo-use-tag-list 'c-tempo-tags)
  (setq c-macro-preprocessor "/home/y/bin/cpp -C")
  (setq compile-command "gmake")
  (c-toggle-hungry-state 1))

;; (defun indent-or-complete ()
;;   "Complete if point is at end of line, and indent line."
;;   (interactive)
;;   (if (looking-at "$")
;;       (hippie-expand nil))
;;   (indent-for-tab-command))

;; (add-hook 'find-file-hooks 
;; 	  '(lambda ()
;; 	     (local-set-key (kbd "<tab>") 'indent-or-complete)))

(add-hook 'c-mode-hook     '(lambda () (marc-c-stuff)))
(add-hook 'c++-mode-hook   '(lambda () (marc-c-stuff)))

;;; Preprocessor Templates (appended to c-tempo-tags)

(tempo-define-template "c-include"
		       '("include <" r ".h>" > n
			 )
		       "include"
		       "Insert a #include <> statement"
		       'c-tempo-tags)

(tempo-define-template "c-ifdef"
		       '("ifdef " (p "ifdef-clause: " clause) > n> p n
			 "#else /* !(" (s clause) ") */" n> p n
			 "#endif /* " (s clause)" */" n>
			 )
		       "ifdef"
		       "Insert a #ifdef #else #endif statement"
		       'c-tempo-tags)

(tempo-define-template "c-ifndef"
		       '("ifndef " (p "ifndef-clause: " clause) > n
			 "#define " (s clause) n> p n
			 "#endif /* " (s clause)" */" n>
			 )
		       "ifndef"
		       "Insert a #ifndef #define #endif statement"
		       'c-tempo-tags)
;;; C-Mode Templates

(tempo-define-template "c-if"
		       '(> "if (" (p "if-clause: " clause) ")" n>
                           "{" > n>
                           > r n
                           "}" > n>
                           )
		       "if"
		       "Insert a C if statement"
		       'c-tempo-tags)

(tempo-define-template "c-else"
		       '(> "else" n>
                           "{" > n>
                           > r n
                           "}" > n>
                           )
		       "else"
		       "Insert a C else statement"
		       'c-tempo-tags)

(tempo-define-template "c-if-else"
		       '(> "if (" (p "if-clause: " clause) ")"  n>
                           "{" > n
                           > r n
                           "}" > n
                           "else" > n
                           "{" > n>
                           > r n
                           "}" > n>
                           )
		       "ifelse"
		       "Insert a C if else statement"
		       'c-tempo-tags)

(tempo-define-template "c-while"
		       '(> "while (" (p "while-clause: " clause) ")" >  n>
                           "{" > n
                           > r n
                           "}" > n>
                           )
		       "while"
		       "Insert a C while statement"
		       'c-tempo-tags)

(tempo-define-template "c-for"
		       '(> "for (" (p "for-clause: " clause) ")" >  n>
                           "{" > n
                           > r n
                           "}" > n>
                           )
		       "for"
		       "Insert a C for statement"
		       'c-tempo-tags)

(tempo-define-template "c-for-i"
		       '(> "for (" (p "variable: " var) " = 0; " (s var)
                           " < "(p "upper bound: " ub)"; " (s var) "++)" >  n>
                           "{" > n
                           > r n
                           "}" > n>
                           )
		       "fori"
		       "Insert a C for loop: for(x = 0; x < ..; x++)"
		       'c-tempo-tags)

(tempo-define-template "c-main"
		       '(> "int main(int argc, char *argv[])" >  n>
                           "{" > n>
                           > r n
                           > "return 0 ;" n>
                           > "}" > n>
                           )
		       "main"
		       "Insert a C main statement"
		       'c-tempo-tags)

(tempo-define-template "c-if-malloc"
		       '(> (p "variable: " var) " = ("
                           (p "type: " type) " *) malloc (sizeof(" (s type)
                           ") * " (p "nitems: " nitems) ") ;" n>
                           > "if (" (s var) " == NULL)" n>
                           > "error_exit (\"" (buffer-name) ": " r ": Failed to malloc() " (s var) " \") ;" n>
                           )
		       "ifmalloc"
		       "Insert a C if (malloc...) statement"
		       'c-tempo-tags)

(tempo-define-template "c-if-calloc"
		       '(> (p "variable: " var) " = ("
                           (p "type: " type) " *) calloc (sizeof(" (s type)
                           "), " (p "nitems: " nitems) ") ;" n>
                           > "if (" (s var) " == NULL)" n>
                           > "error_exit (\"" (buffer-name) ": " r ": Failed to calloc() " (s var) " \") ;" n>
                           )
		       "ifcalloc"
		       "Insert a C if (calloc...) statement"
		       'c-tempo-tags)

(tempo-define-template "c-switch"
		       '(> "switch (" (p "switch-condition: " clause) ")" n>
                           "{" >  n>
                           "case " (p "first value: ") ":" > n> p n
                           "break;" > n> p n
                           "default:" > n> p n
                           "break;" > n
                           "}" > n>
                           )
		       "switch"
		       "Insert a C switch statement"
		       'c-tempo-tags)

(tempo-define-template "c-case"
		       '(n "case " (p "value: ") ":" > n> p n
			   "break;" > n> p
			   )
		       "case"
		       "Insert a C case statement"
		       'c-tempo-tags)

(tempo-define-template "c++-class"
		       '("class " (p "classname: " class) p > n>
                         " {" > n
                         "public:" > n
                         "" > n
			 "protected:" > n
                         "" > n
			 "private:" > n
                         "" > n
			 "};" > n
			 )
		       "class"
		       "Insert a class skeleton"
		       'c++-tempo-tags)

;; What it says. Keeps the cursor in the same relative row during
;; pgups and dwns.
(setq scroll-preserve-screen-position t)

;;----------------------------------------------------------------------------
;; Tweak built-in behaviors
;;----------------------------------------------------------------------------
;; make cursor stay in the same column when scrolling
(defadvice scroll-up (around ewd-scroll-up first act)
  "Keep cursor in the same column."
  (let ((col (current-column)))
    ad-do-it
    (move-to-column col)))
                                
(defadvice scroll-down (around ewd-scroll-down first act)
  "Keep cursor in the same column."
  (let ((col (current-column)))
    ad-do-it                          
    (move-to-column col))) 

;; Tramp
(setq tramp-default-method "scp")

(put 'upcase-region 'disabled nil)

(require 'icomplete)
(icomplete-mode t)

;;----------------------------------------------------------------------------
;; Awesome buffer switcher and file finder
;;----------------------------------------------------------------------------
(require 'ido)
(ido-mode t)

;;----------------------------------------------------------------------------
;; Desktop
;;----------------------------------------------------------------------------
(require 'desktop)

;; Enable some useful modes
(and (fboundp 'auto-image-file-mode) (auto-image-file-mode 1))
(and (fboundp 'auto-insert-mode)     (auto-insert-mode     1))
(and (fboundp 'recentf-mode)         (recentf-mode         1))

;;----------------------------------------------------------------------------
;; Annoyances
;;----------------------------------------------------------------------------
(fset 'yes-or-no-p 'y-or-n-p) ; Use "y or n" answers instead of full
			      ; words "yes or no"
(setq inhibit-startup-message t)

;;----------------------------------------------------------------------------
;; Compilation stuff
;;----------------------------------------------------------------------------
;; I don't like it that the compilation window takes up 1/2 of the
;; frame by default. So, I use the following, which works well most of
;; the time:

(setq compilation-window-height 8)
    
;; I also don't like that the compilation window sticks around after a
;; successful compile. After all, most of the time, all I care about
;; is that the compile completed cleanly. Here's how I make the
;; compilation window go away, only if there was no compilation
;; errors:

;; (setq compilation-finish-function
;;       (lambda (buf str)
;;         (if (string-match "exited abnormally" str)
;;             ;; there were errors
;;             (message "compilation errors, press C-x ` to visit")
;;           ;; no errors, make the compilation window go away in 0.5 seconds
;;           (run-at-time 0.5 nil 'delete-windows-on buf)
;;           (message "NO COMPILATION ERRORS!"))))
    
;;----------------------------------------------------------------------------
;; Misc
;;----------------------------------------------------------------------------
(require 'pager nil t)

;; When saving files, set execute permission if #! is in first line.
;; From http://www.rubygarden.org/ruby?EmacsExtensions
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; Don't ask if ok to open .emacs, since it's a symlink to a file under
;; Subversion version control
(setq vc-follow-symlinks t)

;;
;; Experiment with lotus 123 style interface
;;

(require '123-menu)

(123-menu-defmenu marc-menu-root
  ("a" "[A]bbrev"    '123-menu-display-menu-marc-menu-abbrev)
  ("b" "[B]uffer"    '123-menu-display-menu-marc-menu-buffer)
  ("c" "[C]ode"      '123-menu-display-menu-marc-menu-code)
  ("e" "[E]val"      '123-menu-display-menu-marc-menu-eval)
  ("f" "[F]ile"      '123-menu-display-menu-marc-menu-file)
  ("m" "[M]arks"     '123-menu-display-menu-marc-menu-marks)
  ("r" "[R]ect"      '123-menu-display-menu-marc-menu-rect)
  ("s" "[S]earch"    '123-menu-display-menu-marc-menu-search)
  ("v" "[V]ersion"   '123-menu-display-menu-marc-menu-version)
  ("w" "[W]indow"    '123-menu-display-menu-marc-menu-window)
  )

(123-menu-defmenu marc-menu-abbrev
  ("g" "[G]lobal"              'add-global-abbrev)
  ("m" "[M]ode-specific"       'add-mode-abbrev)
  ("i" "[I]nverse"             '123-menu-display-menu-marc-menu-abbrev-inverse)
  )

(123-menu-defmenu marc-menu-abbrev-inverse
  ("g" "[G]lobal"              'inverse-add-global-abbrev)
  ("m" "[M]ode-specific"       'inverse-add-mode-abbrev)
  )

(123-menu-defmenu marc-menu-buffer
  ("k" "[K]ill"                'kill-buffer)
  ("l" "[L]ist"                'list-buffers)
  ("r" "[R]ename"              'rename-buffer)
  )

(123-menu-defmenu marc-menu-code
  ("c" "[C]omment region"      'comment-region)
  ("u" "[U]ncomment region"    'uncomment-region)
  )

(123-menu-defmenu marc-menu-eval
  ("b" "[B]uffer"              'eval-buffer)
  ("l" "[L]ast sexp"           'eval-last-sexp)
  ("r" "[R]egion"              'eval-region)
  )

(123-menu-defmenu marc-menu-file
  ("d" "[D]ired"               'dired)
  ("f" "[F]ind"                'find-file)
  ("i" "[I]nsert"              'insert-file)
  ("s" "[S]ave"                'save-buffer)
  )

(123-menu-defmenu marc-menu-marks
  ("j" "[J]ump"                'bookmark-jump)
  ("s" "[S]et"                 'bookmark-set)
  )

(123-menu-defmenu marc-menu-rect
  ("k" "[K]ill"                'kill-rectangle)
  ("y" "[Y]ank"                'yank-rectangle)
  ("o" "[O]pen"                'open-rectangle)
  )

(123-menu-defmenu marc-menu-search
  ("i" "[I]ncremental"         'isearch-forward)
  ("o" "[O]ccur"               'occur)
  )

(123-menu-defmenu marc-menu-version
  ("a" "[A]nnotate"            'vc-annotate)
  ("d" "[D]iff"                'vc-diff)
  ("l" "[L]og"                 'vc-print-log)
  )

(123-menu-defmenu marc-menu-window
  ("1" "[1]window"             'delete-other-windows)
  ("o" "[O]ther"               'other-window)
  ("v" "[V]ert split"          'split-window-vertically)
  ("h" "[H]oriz split"         'split-window-horizontally)
  )

(define-key global-map "\C-xm" '123-menu-display-menu-marc-menu-root)

;;----------------------------------------------------------------------------
;; Python
;;----------------------------------------------------------------------------

;; (require 'python-mode)
(autoload 'python-mode "python-mode" nil t)

;;----------------------------------------------------------------------------
;; Ruby
;;----------------------------------------------------------------------------

(autoload 'ruby-mode "ruby-mode" "Load ruby-mode")
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))

;;----------------------------------------------------------------------------
;; Haskell
;;----------------------------------------------------------------------------

(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))



;; Add color to a shell running in emacs 'M-x shell'
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 
	  'ansi-color-for-comint-mode-on)

;; Control-Tab to toggle between buffers
(global-set-key [C-tab] '(lambda () 
			   (interactive) 
			   (switch-to-buffer nil)))





;; Get the macro make-help-screen when this is compiled,
;; or run interpreted, but not when the compiled code is loaded.
;; (eval-when-compile (require 'help-macro))

;; (fset 'marc-123 marc-123-map)

;; (make-help-screen help-for-marc-123-map
;; 		  "r:rect c:c-mode b:buffers m:marks ?"
;; 		  "Marc's map"
;; 		  marc-123-map)

;;----------------------------------------------------------------------------
;; SLIME
;;----------------------------------------------------------------------------

(add-to-list 'load-path "~/emacs/slime")
(when (require 'slime nil t)
  (slime-setup)
  (add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
  (add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
  ;; Optionally, specify the lisp program you are using. Default is "lisp"
                                        ; (setq inferior-lisp-program "/usr/bin/clisp -K full") 
  (setq inferior-lisp-program "/usr/local/bin/sbcl") 
  (setq slime-backend "swank-sbcl.lisp"))


;;----------------------------------------------------------------------------
;;
;; In C++ mode, I want find-tag to pull in the whole symbol name
;; (e.g.: HostdApp::Init; not just Init). 
;; I'm using ffap (Find File At Point), which is weird, but it works.
;;
(when (and (require 'ffap nil t) (fboundp 'ffap-string-at-point))
  (add-hook 'c++-mode-hook 
            '(lambda ()
               (put major-mode
                    'find-tag-default-function #'ffap-string-at-point))))

;;----------------------------------------------------------------------------

;; (load-library "erlang-start")