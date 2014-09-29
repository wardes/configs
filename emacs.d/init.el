;; packages
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(defun require-package (package)
  (setq-default highlight-tabs t)
  "Install given PACKAGE."
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))

;; something asked for this (Helm probably)
;;(require 'async-bytecomp)

;; only one dired buffer
    (require-package 'dired-single)
;; scratch buffer empty
    (setq initial-scratch-message nil)
;;
    (setq redisplay-dont-pause t)

;; auto-refresh dired
    (setq global-auto-revert-non-file-buffers t)
    (setq auto-revert-verbose nil)
;; some more interface-related settings
    (setq
          read-file-name-completion-ignore-case t
          frame-title-format '("Emacs @ : %b %+%+ %f")  
          inhibit-splash-screen t
          inhibit-startup-echo-area-message t
          inhibit-startup-message t
    )

;; colours
;; rainbox-delimiters
    (require-package 'diminish)
    (require-package 'rainbow-delimiters)
    (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; highlight current line
    (global-hl-line-mode)



;; create backup files on a directory inside dotemacs
    (setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Remember last edit positions
    (require-package 'saveplace)
    (setq save-place-file "~/.emacs.d/saveplace")
    (setq-default save-place t)

;; minibuffer history
    (require-package 'savehist)
    (setq savehist-file "~/.emacs.d/savehist"
          savehist-additional-variables '(search ring regexp-search-ring)
          savehist-autosave-interval 60)
    (setq-default history-length 1000)
    (savehist-mode +1)

;; bookmarks
    (setq bookmark-default-file "~/.emacs.d/bookmarks"
          bookmark-save-flag 1) ;; save after every change


;; lots of recent files
    (require 'recentf)
    (setq recentf-save-file "~/.emacs.d/recentf"
          recentf-max-saved-items 1000
          recentf-max-menu-items 500)
    (add-to-list 'recentf-exclude "COMMIT_EDITMSG\\'")
    (recentf-mode +1)
    (run-with-timer 1800 1800 'recentf-save-list)


;; auto-refresh dired
    (setq global-auto-revert-non-file-buffers t)
    (setq auto-revert-verbose nil)

;; ediff: side-by-side diffs
    (setq ediff-split-window-function 'split-window-horizontally
          ediff-window-setup-function 'ediff-setup-windows-plain) ;; no extra frames

;; dont clutter the modeline bar with minor modes indicators
    (require-package 'diminish)
    (diminish 'visual-line-mode)



;; Auto indent lines after pressing return so I don't have to press TAB
    (define-key global-map (kbd "RET") 'newline-and-indent)

;; show matching parens
    (show-paren-mode t)

;; helm settings (TAB in helm window for actions over selected items,
;; C-SPC to select items)
(require-package 'helm)

(require-package 'projectile)
(require-package 'project-explorer)
(setq pe/cache-directory "~/.emacs.d/cache/project_explorer")
;;(setq pe/omit-regex (concat pe/omit-regex "\\|single_emails"))

(require 'helm-config)
(require 'helm-misc)
(require 'helm-projectile)
(require 'helm-locate)
(setq helm-quick-update t
      helm-bookmark-show-location t
      helm-buffers-fuzzy-matching t)

(require-package 'helm-projectile)
(global-set-key (kbd "M-x") 'helm-M-x)

(defun helm-my-buffers ()
  (interactive)
  (helm-other-buffer '(helm-c-source-buffers-list
                       helm-c-source-elscreen
                       helm-c-source-occur
                       ;;                        helm-c-source-projectile-files-list
                       helm-c-source-ctags
                       helm-c-source-recentf
                       helm-c-source-locate)
                     "*helm-my-buffers*"))


;; evil mode!
(require-package 'evil)
(require-package 'elscreen)

(require-package 'evil-tabs)
(require-package 'evil-leader)
(evil-mode t)
;;(global-evil-tabs-mode t) ; tabs (requires evil-tabs)
(require-package 'evil-jumper) ; c-i / c-o
(require-package 'evil-visualstar)
(require-package 'evil-indent-textobject)
(require-package 'evil-surround)
(require-package 'evil-matchit) ; matchit (show matching parenthesis)
(require-package 'evil-search-highlight-persist)

(global-evil-matchit-mode t)
(global-evil-surround-mode t)
(global-evil-search-highlight-persist t)
(global-evil-leader-mode t)
(setq evil-leader/in-all-states t) ;; leader
;; evil settings
(setq evil-emacs-state-cursor '("red" box)
      evil-normal-state-cursor '("green" box)
      evil-visual-state-cursor '("orange" box)
      evil-insert-state-cursor '("red" bar)
      evil-replace-state-cursor '("red" bar)
      evil-operator-state-cursor '("red" hollow))

;; window move
(define-key evil-normal-state-map (kbd "C-w <up>") 'windmove-up)
(define-key evil-normal-state-map (kbd "C-w <down>") 'windmove-down)
(define-key evil-normal-state-map (kbd "C-w <right>") 'windmove-right)
(define-key evil-normal-state-map (kbd "C-w <left>") 'windmove-left)

;; other shortcuts (prefixed by leader, which is comma here)
(evil-leader/set-leader ",")
(evil-leader/set-key "SPC" 'lazy-highlight-cleanup)
(evil-leader/set-key "SPC" 'evil-search-highlight-persist-remove-all)
(evil-leader/set-key "v" (lambda () (interactive)
                           (split-window-horizontally)
                           (evil-window-right 1)))
                                        ; shortcuts for jumping to a tab
(evil-leader/set-key "0" (lambda() (interactive) (elscreen-goto 0)))
(evil-leader/set-key "1" (lambda() (interactive) (elscreen-goto 1)))
(evil-leader/set-key "2" (lambda() (interactive) (elscreen-goto 2)))
(evil-leader/set-key "3" (lambda() (interactive) (elscreen-goto 3)))
(evil-leader/set-key "4" (lambda() (interactive) (elscreen-goto 4)))
(evil-leader/set-key "5" (lambda() (interactive) (elscreen-goto 5)))
(evil-leader/set-key "6" (lambda() (interactive) (elscreen-goto 6)))
(evil-leader/set-key "7" (lambda() (interactive) (elscreen-goto 7)))
(evil-leader/set-key "8" (lambda() (interactive) (elscreen-goto 8)))
(evil-leader/set-key "9" (lambda() (interactive) (elscreen-goto 9)))







;; C-x (arrow) to move between windows
(global-set-key (kbd "C-x <up>")    'windmove-up)
(global-set-key (kbd "C-x <down>")  'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>")  'windmove-left)
