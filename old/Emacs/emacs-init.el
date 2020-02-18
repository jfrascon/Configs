(require 'package)

(setq package-enable-at-startup nil)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))


(when (not package-archive-contents)
  (package-refresh-contents))

; If use-package is not installed, install it.
(unless
    (package-installed-p 'use-package)
    (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-general)

(use-package company
  :init
  (global-company-mode 1)
  (delete 'company-semantic company-backends))
;; (define-key c-mode-map  [(control tab)] 'company-complete)
;; (define-key c++-mode-map  [(control tab)] 'company-complete)

(use-package projectile
  :init
  (projectile-global-mode)
  (setq projectile-enable-caching t))

(use-package zygospore
  :bind (("C-x 1" . zygospore-toggle-delete-other-windows)
         ("RET" .   newline-and-indent)))

(require 'setup-ivy-counsel)
(require 'setup-helm)
(require 'setup-helm-gtags)
(require 'setup-evil)
(require 'setup-cedet)
(require 'setup-editing)

(use-package smex ;; sort things out in minibuffer
:ensure t)

;; (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;; Key chords
;; Key chords let us bind functions to sequential key presses like jj.
;; It makes evil mode being turned off much more palatable.
(use-package use-package-chords
  :ensure t
  :config
  (key-chord-mode t))
; We bind individual mode chords via use-package but some globals are useful
; like JJ to jump to the previous buffer.
;(defun jf/switch-to-previous-buffer ()
;  "Switch to previously open buffer.
;  Repeated invocations toggle between the two most recently open buffers."
;  (interactive)
;  (switch-to-buffer (other-buffer (current-buffer) 1)))
;(key-chord-define-global "JJ" 'jf/switch-to-previous-buffer)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)


;(progn
;(use-package elisp-slime-nav
;  :ensure t)
;(defun my-lisp-hook ()
;  (elisp-slime-nav-mode)
;  (turn-on-eldoc-mode))
;(add-hook 'emacs-lisp-mode-hook 'my-lisp-hook)
;)


; crux has useful functions extracted from Emacs Prelude. Set C-a to move to the
;first non-whitespace character on a line, and then to toggle between that and the beginning of the line.
(use-package crux
  :ensure t
  :bind (("C-a" . crux-move-beginning-of-line)))


; undo-tree v
;isualises undo history as a tree for easy navigation.
(use-package undo-tree
  :ensure t
  :chords (("uuu" . undo-tree-visualize))
  :diminish undo-tree-mode:
  :config
  (global-undo-tree-mode 1))

; Jump to source
; Individual language packages often support IDE features like jump to source, but dumb-jump attempts to support
; many languages by simple searching. It's quite effective even with dynamic libraries like JS and Python.
;; (use-package dumb-jump
;;   :ensure t
;;   :diminish dumb-jump-mode
;;   :bind (("C-M-g" . dumb-jump-go)
;;      ("C-M-p" . dumb-jump-back)
;;      ("C-M-q" . dumb-jump-quick-look)))

;; On the fly syntax checking
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

;; -------------------------------------------------------------------
;; WEB DEVELOPMENT
;; -------------------------------------------------------------------
(use-package treemacs
  :ensure t)
(use-package php-mode
  :ensure t)
(use-package ac-php
  :ensure t)
(use-package ac-html
  :ensure t)
(use-package flymake-php
  :ensure t)
(use-package flymake-phpcs
  :ensure t)

;; -------------------------------------------------------------------
;; MARKDOWN
;; -------------------------------------------------------------------
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown")
  :config
  (use-package edit-indirect
:ensure t))

;; -------------------------------------------------------------------
;; GIT GUTTER
;; -------------------------------------------------------------------
(use-package git-gutter
  :ensure t
  :init
  (global-git-gutter-mode +1))

; Up and down arrow now works in eshell
(define-key comint-mode-map (kbd "<up>") 'comint-previous-input)
(define-key comint-mode-map (kbd "<down>") 'comint-next-input)
