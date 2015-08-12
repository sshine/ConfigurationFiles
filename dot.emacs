;;; Package --- Simon Shine <shine@diku.dk> Emacs Configuration
;;; Commentary:
;;;
;;; This is my Emacs Configuration.  There are many like it, but this one is
;;; mine.  My Emacs Configuration is my best friend.  It is my life.  I must
;;; master it as I must master my life.  My Emacs Configuration, without me,
;;; is useless.  Without my Emacs Configuration, I am useless.  I must init
;;; my Emacs Configuration true.  I must code straighter than my enemy who
;;; is trying to kill me.
;;;
;;; Code:
(setq inhibit-splash-screen t) ; Don't show the Emacs welcome screen

(ido-mode t)                   ; Improved file hinting when opening/saving files
(electric-pair-mode 1)         ; Write parentheses in pairs
(show-paren-mode 1)            ; Show matching parentheses
(delete-selection-mode 1)      ; Delete selected text when typing
(global-font-lock-mode 1)      ; Syntax coloring by default
(column-number-mode 1)         ; Show cursor's column number
(setq-default fill-column 76)  ; Word-wrap at 76 characters
(setq tab-width 4)             ;
(setq-default indent-tabs-mode nil) ; Indent with spaces, not tabs

(defalias 'yes-or-no-p 'y-or-n-p) ; Answer yes/no questions with y/n keys

; Disable backup files
(setq make-backup-files nil)
(setq auto-save-default nil)

; Remove menubar, toolbar and scrollbar
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

; Ubuntu once broke dead keys in Emacs, so export XMODIFIERS='' in .zshrc.

;; Removes *Messages* buffer
(setq-default message-log-max nil)
(if (get-buffer "*Messages*")
    (kill-buffer "*Messages*"))

;; Removes *Completions* from buffer after you've opened a file.
(add-hook 'minibuffer-exit-hook
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
                (kill-buffer buffer)))))

;; Don't show *Buffer list* when opening multiple files at the same time.
(setq inhibit-startup-buffer-menu t)

;; Custom keybindings
(dolist (pair
  '(("C-k" kill-whole-line)      ; including the end-of-line character(s)
    ("M-c" comment-region)       ; comment out the selected region
    ("M-u" uncomment-region)     ; uncomment the selected region
    ("C-n" dabbrev-expand)       ; auto-completion
    ("C-x C-g" goto-line)
    ("C-z" undo)
    ("C-<tab>" next-multiframe-window)
    ("C--" text-scale-decrease)
    ("C-+" text-scale-increase)
    ))
  (global-set-key (kbd (car pair)) (cadr pair)))

;; Package system
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

;; Automatically install the following packages
(setq auto-install-packages
      '(solarized-theme bar-cursor htmlize flycheck flycheck-haskell
	haskell-mode markdown-mode sml-mode rust-mode fsharp-mode
	go-mode))
(dolist (pkg auto-install-packages)
  (unless (package-installed-p pkg)
          (package-install pkg)))

;; Font -- make sure it's installed
(set-frame-font "Inconsolata-13")

;; Use a vertical bar as cursor instead of a block
(require 'bar-cursor)
(bar-cursor-mode 1)

;; Solarized theme
(require 'solarized-light-theme)

;; Flycheck
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(custom-set-variables
 '(flycheck-check-syntax-automatically '(save mode-enabled)))

;; Haskell
(require 'haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))

;; Markdown
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))

;; Rust
;(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;; ElDoc -- show function hints in the echo area below
(require 'eldoc)
(add-hook 'haskell-mode-hook 'turn-on-eldoc-mode)
