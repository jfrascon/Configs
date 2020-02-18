(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

; If use-package is not installed, install it.
(unless
  (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

; How to enter special symbols with Alt
(setq ns-alternate-modifier 'meta)
(setq ns-right-alternate-modifier 'none)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(add-to-list 'exec-path "/usr/local/bin")

; I don't want the error bell.
(setq ring-bell-function 'ignore)

;Make the yes or no prompts shorter.
(defalias 'yes-or-no-p 'y-or-n-p)

; A common frustration with new Emacs users is the filename# files created.
;This centralises the backup files created as you edit.
(setq backup-directory-alist '(("." . "~/.emacs.d/backups"))
    backup-by-copying t    ; Don't delink hardlinks
    version-control t      ; Use version numbers on backups
    delete-old-versions t  ; Automatically delete excess backups
    kept-new-versions 20   ; how many of the newest versions to keep
    kept-old-versions 5    ; and how many of the old
    )
(setq auto-saves-dir "~/.emacs.d/backups")

; Display line numbers always
(global-linum-mode 1)

;; Highlight current line
(global-hl-line-mode +1)

; TAB completion?
(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

; Theme folder
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula t)

;I prefer lines to wrap.
(global-visual-line-mode t)

(add-to-list 'auto-mode-alist '("\\.pgc" . c-mode))

;; How to get back to an active minibuffer prompt in emacs without the mouse
;; https://trey-jackson.blogspot.com.es/2010/04/emacs-tip-36-abort-minibuffer-when.html
(defun switch-to-minibuffer-window ()
  "switch to minibuffer window (if active)"
  (interactive)
  (when (active-minibuffer-window)
    (select-frame-set-input-focus (window-frame (active-minibuffer-window)))
    (select-window (active-minibuffer-window))))

(global-set-key (kbd "<f7>") 'switch-to-minibuffer-window)

; I never want whitespace at the end of lines. Remove it on save.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; turn on highlight matching brackets when cursor is on one
(show-paren-mode t)

(setq show-paren-style 'parenthesis) ;; highlight brackets
;(setq show-paren-style 'expression) ;; highlight entire expression
;(setq show-paren-style 'mixed)      ;; highlight brackets if visible, else entire expression

(add-hook 'eshell-mode-hook (lambda () (setq pcomplete-cycle-completions nil)))

(setq inhibit-startup-message t)

;Let's turn off unwanted window decoration.
(tool-bar-mode -1)
(scroll-bar-mode +1)

(setq column-number-mode t)

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(global-set-key [C-f1] 'show-file-name) ; Or any other key you want

;; Smooth scrolling
(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)

;; ---------------------------------------------------------------------
;; HELM
;; https://writequit.org/denver-emacs/presentations/2016-03-01-helm.html
;; ---------------------------------------------------------------------
;;(require 'helm-config)
;;(require 'helm-swoop)

(use-package helm
  :ensure t)

(use-package helm-swoop
  :ensure t
  :bind
    (("C-S-s" . helm-swoop)
    ("M-i" . helm-swoop)
    ("M-s s" . helm-swoop)
    ("M-s M-s" . helm-swoop)
    ("M-I" . helm-swoop-back-to-last-point)
    ("C-c M-i" . helm-multi-swoop)
    ("C-x M-i" . helm-multi-swoop-all)
    :map  isearch-mode-map
    ("M-i" . helm-swoop-from-isearch)
    :map helm-swoop-map
    ("M-i" . helm-multi-swoop-all-from-helm-swoop)))

(require 'helm-config)
;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(helm-mode 1)
; Let's use TAB to "execute persistent actions", which changes depending on what type of helm buffer is open.
; For example, with helm-find-files it shows the file, for helm-buffers it shows the buffer.
; For helm-apropos it shows the *help* buffer for a symbol.
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
;; make TAB works in terminal, C-i is the same as TAB
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
; When a helm buffer is open, we can see what we can actually do with the thing using C-z
(define-key helm-map (kbd "C-z") 'helm-select-action)

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)
(setq helm-autoresize-max-height 40)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode t)
; I also recommend you set up "helm-resume", which resumes your last helm session (great for searching)
(global-set-key (kbd "C-M-z") 'helm-resume)
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
(setq helm-mini-default-sources '(helm-source-buffers-list
                                  helm-source-recentf
                                  helm-source-bookmarks
                                  helm-source-buffer-not-found))
(global-set-key (kbd "C-x b") 'helm-mini)
;; Enable fuzzy matching
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)
(global-set-key (kbd "C-h a") 'helm-apropos)
(global-set-key (kbd "C-c o") 'helm-occur)
(global-set-key (kbd "C-c s") 'helm-swoop)
(global-set-key (kbd "C-c l") 'helm-locate)
(global-set-key (kbd "C-h r") 'helm-info-emacs)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
(global-set-key (kbd "C-x f") 'helm-projectile)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
; C-c h C-x C-b -> helm-buffers-list
; C-c h m --> helm-man-woman

;; Quickly jump to any man entry using the Helm interfaceI
(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

(defun spacemacs//hide-cursor-in-helm-buffer ()
  "Hide the cursor in helm buffers."
  (with-helm-buffer
    (setq cursor-in-non-selected-windows nil)))
(add-hook 'helm-after-initialize-hook
          'spacemacs//hide-cursor-in-helm-buffer)


;; -------------------------------------------------------------------
;; https://github.com/zamansky/using-emacs/blob/master/myinit.org#swiper--ivy--counsel
;; SWIPER (+IVY) AND COUNSEL
;; -------------------------------------------------------------------
;; Swiper gives us a really efficient incremental search with regular expressions and
;; Ivy / Counsel replace a lot of ido or helms completion functionality
;; (use-package counsel
;;  :ensure t
;;   :bind
;;   (("M-y" . counsel-yank-pop)
;;    :map ivy-minibuffer-map ("M-y" . ivy-next-line)))

;; (use-package swiper
;;   :ensure t
;;   :init
;;   (setq ivy-use-virtual-buffers t)
;;   (setq ivy-display-style 'fancy)
;;   (setq ivy-count-format "(%d/%d) ")  ;; changes the format of the number of results
;;   (ivy-mode 1)
;;   :config
;;   :bind
;;   ("M-x" . counsel-M-x)
;;   ("\C-s" . swiper)
;;   ("C-x C-f" . counsel-find-file)
;;   ("C-c C-r" . ivy-resume)
;;   ("C-c C-r" . ivy-resume)
;;   ("<f6>" . ivy-resume)
;;   ("<f1> f" . counsel-describe-function)
;;   ("<f1> v" . counsel-describe-variable)
;;   ("<f1> l" . counsel-load-library)
;;   ("<f2> i" . counsel-info-lookup-symbol)
;;   ("<f2> u" . counsel-unicode-char)
;;   ("C-c g" . counsel-git)
;;   ("C-c j" . counsel-git-grep)
;;   ("C-c k" . counsel-ag)
;;   ("C-c l" . counsel-locate)
;;   ("C-c r" . counsel-recentf)
;;   ("C-S-o" . counsel-rhythmbox)
;;   ("C-r"   . counsel-expression-history)
;;   (:map read-expression-map
;; 	("C-r" . counsel-expression-history)))

;; C-x b - ivy switch buffer
;; C-x d - dired

;; ;;https://truthseekers.io/lessons/how-to-use-ivy-swiper-counsel-in-emacs-for-noobs/
;; ;;set action options during execution of counsel-find-file
;; ;; replace "frame" with window to open in new window
;; (ivy-set-actions
;;  'counsel-find-file
;;  '(("j" find-file-other-frame "other frame")
;;    ("b" counsel-find-file-cd-bookmark-action "cd bookmark")
;;    ("x" counsel-find-file-extern "open externally")
;;    ("d" delete-file "delete")
;;    ("r" counsel-find-file-as-root "open as root")))

;; ;; set actions when running C-x b
;; ;; replace "frame" with window to open in new window
;; (ivy-set-actions
;;  'ivy-switch-buffer
;;  '(("j" switch-to-buffer-other-frame "other frame")
;;    ("k" kill-buffer "kill")
;;    ("r" ivy--rename-buffer-action "rename")))

;; https://sam217pa.github.io/2016/09/13/from-helm-to-ivy/
;; Helm	                       Ivy	                       What ?
;; helm-mini	         ivy-switch-buffer	search for currently opened buffers
;; helm-recentf	         counsel-recentf	search for recently edited files
;; helm-find-files	 counsel-find-files	search files starting from ./
;; helm-ag	         counsel-ag	        search regexp occurence in current project
;; helm-grep-do-git-grep counsel-git-grep	search regexp in current project
;; helm-swoop	         swiper	                search string interactively in current buffer
;; helm-show-kill-ring	 counsel-yank-pop	search copy-paste history
;; helm-projectile	 counsel-projectile	search project and file in it
;; helm-ls-git-ls	 counsel-git	        search file in current git project
;; helm-themes	         counsel-load-theme	switch themes
;; helm-descbinds	 counsel-descbinds	describe keybindings and associated functions
;; helm-M-x	         counsel-M-x	        enhanced M-x command

(use-package smex ;; sort things out in minibuffer
:ensure t)

;; -------------------------------------------------------------------
;; EVIL
;; -------------------------------------------------------------------

(use-package evil
  :ensure t
  :init
  (setq evil-search-module 'evil-search
      evil-want-C-u-scroll t
      evil-want-C-w-in-emacs-state t)
   ;(when evil-want-C-u-scroll
   ;(define-key evil-insert-state-map (kbd "C-u") 'evil-scroll-up)
   ;(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
   ;(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
   ;(define-key evil-motion-state-map (kbd "C-u") 'evil-scroll-up))
  :config
  (use-package evil-leader
    :ensure t
    :config
    (setq evil-leader/in-all-states t) ; leader-key now works in all modes
    (global-evil-leader-mode)
    (progn
      (evil-leader/set-leader ",")
      (evil-leader/set-key "w" 'save-buffer)
      (evil-leader/set-key "q" 'kill-buffer)
      (evil-leader/set-key "d" 'dired-jump)
      (evil-leader/set-key "" 'split-window-right)
      ;(evil-leader/set-key "e" 'pp-eval-last-sexp)
      (evil-leader/set-key "," 'other-window)
      (evil-leader/set-key "b" 'helm-mini)
      (evil-leader/set-key "x" 'helm-M-x)
      (evil-leader/set-key "s" 'helm-swoop)
      (evil-leader/set-key "l" 'helm-locate)
      (evil-leader/set-key "o" 'helm-occur)
      (evil-leader/set-key "f" 'helm-find-files)
      ))
  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))
  (use-package evil-indent-textobject
    :ensure t)
  (use-package evil-tabs
    :ensure t
    :config (global-evil-tabs-mode t))
  (evil-mode t))

(dolist (mode '(ag-mode flycheck-error-list-mode git-rebase-mode eshell-mode))
(add-to-list 'evil-emacs-state-modes mode))

(evil-add-hjkl-bindings occur-mode-map 'emacs
  (kbd "/")       'evil-search-forward
  (kbd "n")       'evil-search-next
  (kbd "N")       'evil-search-previous
  (kbd "C-d")     'evil-scroll-down
  (kbd "C-u")     'evil-scroll-up
  (kbd "C-w C-w") 'other-window)

(define-key evil-normal-state-map (kbd "C-w <left>") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-w h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-w <down>") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-w j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-w <up>") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-w k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-w <right>") 'evil-window-right)
(define-key evil-normal-state-map (kbd "C-w l") 'evil-window-right)

;; Change the cursor/point color depending on mode
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("yellow" bar))
(setq evil-operator-state-cursor '("pink" hollow))

; Don’t move back the cursor one position when exiting insert mode
(setq evil-move-cursor-back nil)

(define-key evil-ex-map "b " 'helm-mini)
(define-key evil-ex-map "e" 'helm-find-files)

(defun my-jump-to-tag ()
  (interactive)
  (evil-emacs-state)
  (call-interactively (key-binding (kbd "M-.")))
  (evil-change-to-previous-state (other-buffer))
  (evil-change-to-previous-state (current-buffer)))

(define-key evil-normal-state-map (kbd "C-*") 'my-jump-to-tag)

;; Treat wrapped line scrolling as single lines
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

;; esc quits pretty much anything (like pending prompts in the minibuffer)
;; (define-key evil-normal-state-map [escape] 'keyboard-quit)
;; (define-key evil-visual-state-map [escape] 'keyboard-quit)
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

;; (use-package ivy
;;   :ensure t
;;   :config
;;   (ivy-mode t)
;;   (setq ivy-use-virtual-buffers t)
;;   (setq ivy-count-format "(%d/%d) "))

;By default ivy starts filters with ^.
; I don't normally want that and can easily type it manually when I do.
;(setq ivy-initial-inputs-alist nil)

; Counsel is a collection of ivy enhanced versions of common Emacs commands.
; I haven't bound much as ivy-mode takes care of most things.
;; (use-package counsel
;;   :ensure t
;;   :bind (("M-x" . counsel-M-x))
;;   :chords (("yy" . counsel-yank-pop)))

; swiper is an ivy enhanced version of isearch.
;; (use-package swiper
;;   :ensure t
;;   :bind ("M-s" . swiper))

; hydra presents menus for ivy commands.
;; (use-package ivy-hydra
;;   :ensure t)



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
  :chords (("uu" . undo-tree-visualize))
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
