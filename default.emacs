;;;; package --- Summary
;;;; Commentary:
;;;; Code:

;; TODO: On the cut/copy whole line thing, kill the leading whitespace


;; TODO: Check if in daemon- if #t bind qq to kill-frame, if #f bind qq to quit-emacs or whatever

;;(setq debug-on-error t)

(load "~/.emacs.d/init.el")
;;(add-to-list 'load-path "~/.elisp/")

(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https:////marmalade-repo.org/packages/"))
;;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(prelude-require-packages '(
                            ;;paren-face ;; Fucks up rainbow parens- eh.
                                        ;tern
                                        ;tern-auto-complete
                                        ;region-bindings-mode
                            ;easy-kill ;; 'easy-mark, and kill-ring-save replacement
                                        ; visible-mark !!! ERRORS OUT!
                            scheme-complete
                            ;;quack
                            on-screen
                            hungry-delete
                            all-ext ; !!!
                            react-snippets
                            hydra ; Handled
                            key-chord ; Handled
                            ;;skewer-mode ; server
                            impatient-mode ; !!!
                            helm-css-scss ; !!!
                                        ;swiper-helm ; !!!

                                        ;helm-spaces
                                        ;on-screen ; Highlights prev vis bufer after scroll
                                        ;palimpsest ; send text instead of delete
                            revive
                            smart-forward
                            spray ; !!!
                            chicken-scheme
                            geiser ; scheme stuff
                            minimap
                            ace-isearch
                            expand-region ; Handled
                            goto-chg ; Handled
                                        ;parscope
                            free-keys
                            pager
                                        ;quickrun
                            helm-swoop
                            yasnippet
                                        ; swiper
                                        ;write-good
                                        ;recursive-narrow ; ?
                                        ;pinot-search ; Search
                                        ;auto-yasnippet
                                        ;better-registers
                                        ;buffer-stack
                                        ;downplay-mode ; apply face to everything but region or line
                                        ;dna-mode
                                        ;elnode ; non-blockign io webserver (like node.js)
                                        ;fountain-mode ; Screenwriting
                                        ;fuel ; For FACTOR programming
                                        ;hl-anything
                                        ;key-combo ; Cycling- commands sequentially through repeated press of single key
                                        ;lively ; Interactively updating text
                                        ;macro-math
                                        ;mwim ; move where I mean, smart begin/end
                                        ;mykie
                                        ;region-bindings-mode ; mark set-diff binds
                                        ;sauron ; Listens for and handles various "events"
                                        ;ace-window full path ace-jump-mode
                                        ;helm-imenu-anywhere
                            ;achievements
                            ))


(require 'flycheck)
(require 'yasnippet)
(require 'goto-chg)
(require 'undo-tree)
(require 'prelude-helm-everywhere)
(require 'hungry-delete)
(require 'on-screen)
(require 'spray)
(require 'expand-region)
(require 'helm-swoop)
;;(require 'ace-isearch)
(require 'simple-httpd)
(require 'all-ext); Might cause buffer editing problems in helm-occur?
(require 'smart-forward)
(require 'chicken-scheme)
(require 'smartparens)

;;(require 'parscope)
;;(require 'freekeys)
(require 'pager)
;;(require 'quickrun)

;; Set/Enable Global Stuff

(setq ring-bell-function 'ignore)

(set-default-font "DejaVu Sans Mono-9") ; Set default to match Xresources
(setq guru-warn-only nil)
(setq whitespace-line-column 160) ;; Expand the line limit from 80 column enforcement
(setq whitespace-style '(face lines-tail))
(disable-theme 'zenburn)
(setq redisplay-dont-pause t)
(setq next-line-add-newlines t)
(fset 'yes-or-no-p 'y-or-n-p)
(scroll-bar-mode -1)
(setq tab-width 2)
(setq initial-scratch-message "")
(setq aw-leading-char-style 'path)

(projectile-global-mode)
(global-undo-tree-mode)
(key-chord-mode +1)
(helm-mode 1)
(helm-projectile-on)
(global-hungry-delete-mode)
(on-screen-global-mode +1)
(global-ace-isearch-mode +1)


(yas-global-mode)
;;(add-to-list 'yas/snippet-dirs prelude-snippets-dir)
;;(add-to-list 'yas/snippet-dirs prelude-personal-snippets-dir)

;; Settings

(setq initial-major-mode (quote text-mode))
(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match t)
(helm-autoresize-mode 1)
(setq projectile-completion-system 'helm)
(setq-default js2-basic-offset 2)
(setq js-indent-level 2)

(setq web-mode-content-types-alist
      '(("jsx" . "\\.js[x]?\\'")))

(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))

(setq web-mode-extra-auto-pairs
      '(("jsx" . (("beg" "end")))))

(custom-set-variables
 '(web-mode-attr-indent-offset 2)
 '(web-mode-code-indent-offset 2)
 '(web-mode-markup-indent-offset 2))

(flycheck-define-checker jsxhint-checker
  "A JSX syntax and style checker based on JSXHint."

  :command ("jsxhint" source)
  :error-patterns
  ((error line-start (1+ nonl) ": line " line ", col " column ", " (message) line-end))
  :modes (web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (equal web-mode-content-type "jsx")
              ;; enable flycheck
              (flycheck-select-checker 'jsxhint-checker)
              (flycheck-mode))))


;; Hooks
(add-hook 'after-init-hook #'global-flycheck-mode)
;;(add-hook 'prog-mode-hook 'turn-on-origami-mode)
;;(add-hook 'scheme-mode-hook 'smartparens-mode)

;; JSX web-mode setup

(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions, and commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Fuck these keybindings directly
(global-set-key "\C-x\C-z" nil)
(global-set-key "\C-z" nil)

(defun convention-new-empty-buffer ()
  "Open a new empty buffer."
  (interactive)
  (let ((buf (generate-new-buffer "untitled")))
    (switch-to-buffer buf)
    (funcall (and initial-major-mode))
    (setq buffer-offer-save t)))

(defun copy-line-or-region ()
  "Copy current line, or current text selection."
  (interactive)
  (if (region-active-p)
      (kill-ring-save (region-beginning) (region-end))
    (kill-ring-save (line-beginning-position)
                    (line-beginning-position 2)) ) )

(defun cut-line-or-region ()
  "Cut the current line, or current text selection."
  (interactive)
  (if (region-active-p)
      (kill-region (region-beginning) (region-end))
    (kill-region (line-beginning-position)
                 (line-beginning-position 2)) ) )

(defun kill-line-leave-newline ()
  "A wrapper around prelude-kill-whole-line that leaves the newline"
  (interactive)
  (prelude-kill-whole-line 0))

(defun delete-local-region ()
  "Delete the contents of local delimited region."
  (interactive)
  (er/expand-region 1)
  (delete-active-region))

;;******* Keybindings **********
;; Keybinds

;; Emacsesque Keybindings
;; ;; C-c z x v q m c
;; ;; C-h z y x u o j
;; ;; C-x y x w t j c

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

;; (define-key minibuffer-local-map [M-backspace] 'backward-delete-char);
;; This is how you define for the minibuffer

;; (define-key helm-map (kbd "i") 'helm-semantic-or-imenu)
;; This is how you define for the helm minibuffer
;; More at helm wiki https://github.com/emacs-helm/helm/wiki

;; (key-chord-define-global "\\\\" ')
;; \\\\ is how to escape \\

;; Key Chords, Baish
;; Key order doesn't matter

;; Buffer Navigation
(key-chord-define-global "jk" 'next-line)
(key-chord-define-global "kk" 'prelude-smart-open-line)
(key-chord-define-global "jl" 'previous-line)
(key-chord-define-global "jj" 'prelude-smart-open-line-above)

(key-chord-define-global "hk" 'forward-word)
(key-chord-define-global "hj" 'backward-word)

(key-chord-define-global "fg" 'forward-char)
(key-chord-define-global "fb" 'backward-char)

(key-chord-define-global "hb" 'prelude-move-beginning-of-line) ; mwim maybe
(key-chord-define-global "hh" 'move-end-of-line) ; mwim maybe

(key-chord-define-global "0i" 'pager-page-up) ; go up-buffer
(key-chord-define-global "0j" 'pager-page-down) ; go down-buffer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Searching, Jumping, Selecting

(key-chord-define-global "2e" 'helm-swoop-back-to-last-point)
(key-chord-define-global "2f" 'helm-swoop)

(key-chord-define-global "3g" 'helm-multi-swoop)
(key-chord-define-global "3r" 'helm-multi-swoop-all)

(key-chord-define-global "vc" 'avy-goto-char)
(key-chord-define-global "xv" 'avy-goto-word-or-subword-1)

;;(key-chord-define-global "" 'avy-goto-line)

;;(key-chord-define-global "" 'avy-push-mark)
;;(key-chord-define-global "" 'avy-pop-mark)

(key-chord-define-global "zj" 'er/expand-region)
(key-chord-define-global "zn" 'er/contract-region)

;;(key-chord-define-global "" 'goto-last-change)
;;(key-chord-define-global "" 'ace-isearch) ; ace-jump-char-mode->isearch->helm-swoop

;; Editing

(key-chord-define-global "bg" 'newline)

(key-chord-define-global "dk" 'kill-word)
(key-chord-define-global "dj" 'backward-kill-word)

(key-chord-define-global "gk" 'delete-forward-char)
(key-chord-define-global "gj" 'delete-backward-char)

(key-chord-define-global "fj" 'delete-local-region)

(key-chord-define-global "vv" 'kill-line-leave-newline)
;;(key-chord-define-global "" 'kill-line-backward)

(key-chord-define-global "vj" 'copy-line-or-region)
(key-chord-define-global "vh" 'cut-line-or-region)

(key-chord-define-global "vk" 'yank)
(key-chord-define-global "vm" 'yank-pop)
(key-chord-define-global "vb" 'helm-show-kill-ring)

(key-chord-define-global "qw" 'undo-tree-undo)
(key-chord-define-global "qr" 'undo-tree-redo)
(key-chord-define-global "qp" 'undo-tree-visualize)

;; Meta

;; (key-chord-define-global "qq" 'delete-frame) ; not 'kill-emacs
(key-chord-define-global "qq" 'kill-emacs) 

(key-chord-define-global "xq" 'kill-buffer)

(key-chord-define-global "xh" 'ace-window)
(key-chord-define-global "zh" 'convention-new-empty-buffer)
(key-chord-define-global "xx" 'helm-M-x)
(key-chord-define-global "zg" 'helm-mini)

(key-chord-define-global "vf" 'find-alternate-file)
(key-chord-define-global "zx" 'save-buffer)

;; Right hand number chords (Smartparens)

;;(key-chord-define-global "j0" 'sp-down-sexp)
;;(key-chord-define-global "j9" 'sp-backward-down-sexp)
;;(key-chord-define-global "h0" 'sp-up-sexp)
;;(key-chord-define-global "h9" 'sp-backward-up-sexp)

(key-chord-define-global "u0" 'sp-next-sexp)
(key-chord-define-global "u9" 'sp-previous-sexp)

(key-chord-define-global "y9" 'sp-select-next-thing)
(key-chord-define-global "y8" 'sp-select-previous-thing) 

(key-chord-define-global "90" 'sp-backward-barf-sexp)
(key-chord-define-global "80" 'sp-slurp-hybrid-sexp) ; Forward slurp, good for line-based linguas
(key-chord-define-global "89" 'sp-forward-barf-sexp)
(key-chord-define-global "79" 'sp-backward-slurp-sexp)

(key-chord-define-global "u8" 'sp-unwrap-sexp)

;;(key-chord-define-global "o7" ')
;;(key-chord-define-global "o8" ')

;; Left-hand number chords

;; (key-chord-define-global "r2" ')
;; (key-chord-define-global "r3" ')
;; (key-chord-define-global "r4" ')

;; (key-chord-define-global "g2" ')
;; (key-chord-define-global "g3" ')
;; (key-chord-define-global "g4" ')

;; (key-chord-define-global "f2" ') !
;; (key-chord-define-global "f3" ')
;; (key-chord-define-global "f4" ')

;; (key-chord-define-global "23" ')
;; (key-chord-define-global "24" ')
;; (key-chord-define-global "34" ')

;; (key-chord-define-global "35" ')
;; (key-chord-define-global "45" ')

;; (key-chord-define-global "w4" ')
;; (key-chord-define-global "w5" ')

;; More Unused

;;(key-chord-define-global "xj" ')
;;(key-chord-define-global "xk" ')

;;(key-chord-define-global "xg" ')
;;(key-chord-define-global "xb" ')

;;(key-chord-define-global "fj" ')
;;(key-chord-define-global "qk" ')

;;(key-chord-define-global "jt" ')

;;(key-chord-define-global "yy" ')
;;(key-chord-define-global "uu" ')

;; Hydras

(defhydra hydra-zoom (global-map "<f2>")
  "zoom"
  ("g" text-scale-increase "in")
  ("l" text-scale-decrease "out"))
