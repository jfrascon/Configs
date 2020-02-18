
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
      (evil-leader/set-key "vs" 'split-window-right)
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

;; Don’t move back the cursor one position when exiting insert mode
(setq evil-move-cursor-back nil)

(define-key evil-ex-map "b " 'helm-mini)
(define-key evil-ex-map "e" 'helm-find-files)

(defun my-jump-to-tag ()
  "C* to jump to tags because C] does not work, at least now."
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

;;(eval-after-load 'evil
;; '(progn
;; (define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)
;; (define-key evil-insert-state-map (kbd "C-a") 'move-beginning-of-line)
;; (define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)
;; (define-key evil-insert-state-map (kbd "C-k") 'kill-line)
;; (define-key evil-insert-state-map (kbd "C-w") 'kill-region)
;; (define-key evil-visual-state-map (kbd "C-a") 'move-beginning-of-line)
;; (define-key evil-visual-state-map (kbd "C-e") 'move-end-of-line)
;; (define-key evil-normal-state-map (kbd "C-a") 'move-beginning-of-line)
;; (define-key evil-normal-state-map (kbd "C-e") 'move-end-of-line)
;; (define-key evil-normal-state-map (kbd "C-k") 'kill-line)
;; (define-key evil-normal-state-map (kbd "C-y") 'yank)
;; (define-key evil-insert-state-map (kbd "C-y") 'yank)
;; (define-key evil-insert-state-map (kbd "C-t") 'transpose-chars)
;; (define-key evil-normal-state-map (kbd "C-w") 'kill-region)
;; (define-key evil-visual-state-map (kbd "C-w") 'kill-region)
;; (define-key evil-visual-state-map (kbd "SPC") 'ace-jump-mode)))

(provide 'setup-evil)
