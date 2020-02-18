


;; -------------------------------------------------------------------
;; https://github.com/zamansky/using-emacs/blob/master/myinit.org#swiper--ivy--counsel
;; SWIPER (+IVY) AND COUNSEL
;; -------------------------------------------------------------------

; Counsel is a collection of ivy enhanced versions of common Emacs commands.
; I haven't bound much as ivy-mode takes care of most things.
 (use-package counsel
  :ensure t
   :bind
   (("C-c M-y" . counsel-yank-pop) ;; C-c c M-y
    :map ivy-minibuffer-map
    ("C-c M-y" . ivy-next-line))) ;; C-c c M-y


(use-package counsel-projectile
  :init
  (counsel-projectile-mode))

;; Swiper gives us a really efficient incremental search with regular expressions and
;; Ivy / Counsel replace a lot of ido or helms completion functionality
(use-package swiper
  :ensure t
  :init
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy)
  (setq ivy-count-format "(%d/%d) ")  ;; changes the format of the number of results
  (ivy-mode 1)
  :config
  :bind
  ("C-c c M-x" . counsel-M-x) ;; C-c c M-x
  ("C-c c C-x b" . ivy-switch-buffer) ;; C-c c C-x b
  ("C-c c C-x C-f" . counsel-find-file) ;; C-c c C-x C-f
  ("C-c c C-r" . counsel-recentf) ;; C-c c C-r
  ("C-c c l" . counsel-locate) ;; C-c c l

  ("C-c c r" . ivy-resume)
  ("<f6>" . ivy-resume)
  ("<f1> f" . counsel-describe-function)
  ("C-h f" . counsel-describe-function)
  ("<f1> v" . counsel-describe-variable)
  ("C-h v" . counsel-describe-variable)
  ("<f1> l" . counsel-load-library)
  ("C-h l" . counsel-load-library)
  ("<f2> u" . counsel-info-lookup-symbol)
  ("<f2> u" . counsel-unicode-char)
  ("C-c c i" . counsel-git)
  ("C-c c e" . counsel-git-grep)
  ("C-c c a" . counsel-ag)
  ;;("C-c c o" . counsel-rhythmbox)
  ("C-c c h"   . counsel-expression-history)
  ("C-c c s" . swiper) ;; C-c c s
  (:map read-expression-map
        ("C-c c h" . counsel-expression-history)))

;; C-c h C-x d - dired

;; hydra presents menus for ivy commands.
; (use-package ivy-hydra
;   :ensure t)

;; By default ivy starts filters with ^.
;; I don't normally want that and can easily type it manually when I do.
; (setq ivy-initial-inputs-alist nil)

;; https://truthseekers.io/lessons/how-to-use-ivy-swiper-counsel-in-emacs-for-noobs/
;; set action options during execution of counsel-find-file
;; replace "frame" with window to open in new window
(ivy-set-actions
 'counsel-find-file
 '(("j" find-file-other-frame "other frame")
   ("b" counsel-find-file-cd-bookmark-action "cd bookmark")
   ("x" counsel-find-file-extern "open externally")
   ("d" delete-file "delete")
   ("r" counsel-find-file-as-root "open as root")))

;; ;; set actions when running C-x b
;; ;; replace "frame" with window to open in new window
(ivy-set-actions
 'ivy-switch-buffer
 '(("j" switch-to-buffer-other-frame "other frame")
   ("k" kill-buffer "kill")
   ("r" ivy--rename-buffer-action "rename")))

;; https://sam217pa.github.io/2016/09/13/from-helm-to-ivy/
;; Helm	                       Ivy	                       What ?
;; helm-mini	         ivy-switch-buffer	  search for currently opened buffers
;; helm-recentf	         counsel-recentf	  search for recently edited files
;; helm-find-files	     counsel-find-files	  search files starting from ./
;; helm-ag	             counsel-ag	          search regexp occurence in current project
;; helm-grep-do-git-grep counsel-git-grep	  search regexp in current project
;; helm-swoop	         swiper	              search string interactively in current buffer
;; helm-show-kill-ring	 counsel-yank-pop	  search copy-paste history
;; helm-projectile	     counsel-projectile	  search project and file in it
;; helm-ls-git-ls	     counsel-git	      search file in current git project
;; helm-themes	         counsel-load-theme	  switch themes
;; helm-descbinds	     counsel-descbinds	  describe keybindings and associated functions
;; helm-M-x	             counsel-M-x	      enhanced M-x command

(provide 'setup-ivy-counsel)
