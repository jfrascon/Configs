(use-package helm
  :ensure t
  :init
  (progn
    (require 'helm-config)
    (require 'helm-grep)
    ;; To fix error at compile:
    ;; Error (bytecomp): Forgot to expand macro with-helm-buffer in
    ;; (with-helm-buffer helm-echo-input-in-header-line)
    (if (version< "26.0.50" emacs-version)
        (eval-when-compile (require 'helm-lib)))

    ;; (defun helm-hide-minibuffer-maybe ()
    ;;   (when (with-helm-buffer helm-echo-input-in-header-line)
    ;;     (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
    ;;       (overlay-put ov 'window (selected-window))
    ;;       (overlay-put ov 'face (let ((bg-color (face-background 'default nil)))
    ;;                               `(:background ,bg-color :foreground ,bg-color)))
    ;;       (setq-local cursor-type nil))))
    ;;(add-hook 'helm-minibuffer-set-up-hook 'helm-hide-minibuffer-maybe)

    ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
    ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
    ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
    (global-set-key (kbd "C-c h") 'helm-command-prefix)
    (global-unset-key (kbd "C-x c"))
    ;; Let's use TAB to "execute persistent actions", which changes depending on what type of helm buffer is open. For example, with helm-find-files it shows the file, for helm-buffers it shows the buffer.
    ;; For helm-apropos it shows the *help* buffer for a symbol.
    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
    ;; Make TAB works in terminal, C-i is the same as TAB
    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
    ;; When a helm buffer is open, we can see what we can actually do with the thing using C-z
    (define-key helm-map (kbd "C-z")  'helm-select-action)

    (define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
    (define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
    (define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)

    (when (executable-find "curl")
      (setq helm-google-suggest-use-curl-p t))

    (setq helm-google-suggest-use-curl-p t
          helm-scroll-amount 4 ; scroll 4 lines other window using M-<next>/M-<prior>
          ;; helm-quick-update t ; do not display invisible candidates
          helm-ff-search-library-in-sexp t ; search for library in `require' and `declare-function' sexp.

          ;; you can customize helm-do-grep to execute ack-grep
          ;; helm-grep-default-command "ack-grep -Hn --smart-case --no-group --no-color %e %p %f"
          ;; helm-grep-default-recurse-command "ack-grep -H --smart-case --no-group --no-color %e %p %f"
          helm-split-window-in-side-p t ;; open helm buffer inside current window, not occupy whole other window

          helm-echo-input-in-header-line t

          ;; helm-candidate-number-limit 500 ; limit the number of displayed canidates
          helm-ff-file-name-history-use-recentf t
          helm-move-to-line-cycle-in-source t ; move to end or beginning of source when reaching top or bottom of source.
          helm-buffer-skip-remote-checking t

          helm-mode-fuzzy-match t

          helm-buffers-fuzzy-matching t ; fuzzy matching buffer names when non-nil
                                        ; useful in helm-mini that lists buffers
          helm-org-headings-fontify t
          ;; helm-find-files-sort-directories t
          ;; ido-use-virtual-buffers t
          helm-semantic-fuzzy-match t
          helm-M-x-fuzzy-match t ;; optional fuzzy matching for helm-M-x
          helm-imenu-fuzzy-match t
          helm-recentf-fuzzy-match t
          helm-lisp-fuzzy-completion t
          ;; helm-apropos-fuzzy-match t
          helm-buffer-skip-remote-checking t
          helm-locate-fuzzy-match nil
          ;;helm-autoresize-max-height 40
          ;;helm-autoresize-min-height 20
          ;;helm-autoresize-mode t
          helm-display-header-line nil)

    ;; Quickly jump to any man entry using the Helm interface
    (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

    ;; I also recommend you set up "helm-resume", which resumes your last helm session (great for searching)
    ;;(global-set-key (kbd "C-M-z") 'helm-resume)
    (global-set-key (kbd "M-x") 'helm-M-x) ;; C-c h M-x
    (global-set-key (kbd "M-y") 'helm-show-kill-ring) ;; C-c h M-y
    (global-set-key (kbd "C-x b") 'helm-buffers-list) ;; C-c h C-x b
    (setq helm-mini-default-sources '(helm-source-buffers-list helm-source-recentf helm-source-bookmarks helm-source-buffer-not-found))
    (global-set-key (kbd "C-x C-f") 'helm-find-files) ;; C-c h C-x C-f
    (global-set-key (kbd "C-x f") 'helm-projectile) ;; C-c h C-x f
    (global-set-key (kbd "C-c r") 'helm-regexp) ;; C-c h r
    (global-set-key (kbd "C-c C-r") 'helm-recentf) ;; C-c h C-r
    (global-set-key (kbd "C-c l") 'helm-locate) ;; C-c h l

    (global-set-key (kbd "C-c SPC") 'helm-all-mark-rings);; C-c h SPC
    (global-set-key (kbd "C-c o") 'helm-occur) ;; C-c h o
    (global-set-key (kbd "C-c w") 'helm-wikipedia-suggest) ;; C-c h w
    (global-set-key (kbd "C-c g") 'helm-google-suggest) ;; C-c h g
    (global-set-key (kbd "C-c x") 'helm-register) ;; C-c h x
    ;; (global-set-key (kbd "C-x r j") 'jump-to-register)

    (define-key 'help-command (kbd "C-r") 'helm-apropos)
    (define-key 'help-command (kbd "r") 'helm-info-emacs)
    (define-key 'help-command (kbd "C-l") 'helm-locate-library)

    ;; C-c h C-x C-b -> helm-buffers-list
    ;; C-c h m --> helm-man-woman

    ;; use helm to list eshell history
    (add-hook 'eshell-mode-hook
              #'(lambda ()
                  (define-key eshell-mode-map (kbd "M-l")  'helm-eshell-history)))

    ;; Save current position to mark ring
    (add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)

    (add-hook 'helm-after-initialize-hook
              #'(lambda ()
                  "Hide the cursor in helm buffers."
                  (with-helm-buffer
                    (setq cursor-in-non-selected-windows nil))))

    ;; show minibuffer history with Helm
    (define-key minibuffer-local-map (kbd "M-p") 'helm-minibuffer-history)
    (define-key minibuffer-local-map (kbd "M-n") 'helm-minibuffer-history)

    (define-key global-map [remap find-tag] 'helm-etags-select)

    (define-key global-map [remap list-buffers] 'helm-buffers-list)

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; PACKAGE: helm-swoop                ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Locate the helm-swoop folder to your path
    ;; https://github.com/ShingoFukuyama/helm-swoop
    ;; https://writequit.org/denver-emacs/presentations/2016-03-01-helm.html
    ;; https://github.com/tuhdo/emacs-c-ide-demo/blob/master/custom/setup-helm.el
    (use-package helm-swoop
      :bind (("C-c s" . helm-swoop) ;; C-c h s
             ;;("M-i" . helm-swoop)
             ;;("C-M-i" . helm-swoop-back-to-last-point)
             ("C-c M-i" . helm-multi-swoop) ;; C-c h M-i
             ("C-c C-x M-i" . helm-multi-swoop-all) ;; C-c h C-x M-i
             :map  isearch-mode-map
             ("M-i" . helm-swoop-from-isearch) ;; When doing isearch, hand the word over to helm-swoop
             :map helm-swoop-map
             ("M-i" . helm-multi-swoop-all-from-helm-swoop) ;; From helm-swoop to helm-multi-swoop-all
             ("M-m" . helm-multi-swoop-current-mode-from-helm-swoop) ;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
             ;;("C-r" . helm-previous-line) ;; Move up and down like isearch
             ;;("C-s" . helm-next-line)
             :map evil-motion-state-map
             ;;("C-r" . helm-previous-line)
             ;;("C-s" . helm-next-line)
             ("M-i" . helm-swoop-from-evil-search)) ;; When doing evil-search, hand the word over to helm-swoop
      :config
      ;; Save buffer when helm-multi-swoop-edit complete
      (setq helm-multi-swoop-edit-save t)

      ;; If this value is t, split window inside the current window
      (setq helm-swoop-split-with-multiple-windows t)

      ;; Split direcion. 'split-window-vertically or 'split-window-horizontally
      (setq helm-swoop-split-direction 'split-window-vertically)

      ;; If nil, you can slightly boost invoke speed in exchange for text color
      (setq helm-swoop-speed-or-color t);;

      ;; Go to the opposite side of line from the end or beginning of line
      (setq helm-swoop-move-to-line-cycle t)

      ;; Optional face for line numbers
      ;; Face name is `helm-swoop-line-number-face`
      (setq helm-swoop-use-line-number-face t)

      ;; If you prefer fuzzy matching
      (setq helm-swoop-use-fuzzy-match nil)

      ;; Use search query at the cursor  (default)
      (setq helm-swoop-pre-input-function
            (lambda () (thing-at-point 'symbol)))

      ;; Disable pre-input
      (setq helm-swoop-pre-input-function
            (lambda () ""))
      ;; Or, just use M-x helm-swoop-without-pre-input

      ;; Match only for symbol
      (setq helm-swoop-pre-input-function
            (lambda () (format "\\_<%s\\_> " (thing-at-point 'symbol))))

      ;; Always use the previous search for helm. Remember C-<backspace> will delete entire line
      (setq helm-swoop-pre-input-function
            (lambda () (if (boundp 'helm-swoop-pattern)
                           helm-swoop-pattern "")))

      ;; If there is no symbol at the cursor, use the last used words instead.
      ;;(setq helm-swoop-pre-input-function
      ;;      (lambda ()
      ;;        (let (($pre-input (thing-at-point 'symbol)))
      ;;          (if (eq (length $pre-input) 0)
      ;;              helm-swoop-pattern ;; this variable keeps the last used words
      ;;            $pre-input))))

      )

    (helm-mode 1)

    (use-package helm-projectile
      :init
      (helm-projectile-on)
      (setq projectile-completion-system 'helm)
      (setq projectile-indexing-method 'alien))))

(provide 'setup-helm)
