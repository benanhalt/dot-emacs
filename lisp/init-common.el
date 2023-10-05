;;; -*- lexical-binding: t -*-

;; more screen real estate.
(dolist (mode '(tool-bar-mode menu-bar-mode scroll-bar-mode))
  (if (fboundp mode) (funcall mode -1)))

(setq inhibit-startup-message t)

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-install-verbose t)

(eval-when-compile
  (require 'use-package))

(use-package diminish
  :ensure t)

(use-package nix-mode :ensure t)

(use-package reformatter :ensure t)

(use-package string-inflection
  :ensure t)

(use-package benanhalt-editing
  :load-path "lisp/"
  :bind (("C-a" . back-to-indentation-or-beginning)
         ("C-t" . yank-and-indent)
         ("C-w" . kill-region-or-backward-word)
         ("C-c a" . align-on-equal-sign)
         ("<C-return>" . open-line-below)
         ("<C-S-return>" . open-line-above)))

;; (use-package undo-tree
;;   :ensure t
;;   :diminish undo-tree-mode
;;   :config
;;   (global-undo-tree-mode)
;;   (setq undo-tree-visualizer-timestamps t)
;;   (setq undo-tree-visualizer-diff t))

(use-package avy
  :ensure t
  :bind (("C-'" . avy-goto-char)
         ("C-o" . avy-goto-word-1)))

(use-package helm
  :ensure t
  :diminish helm-mode
  :init
  ;; (require 'helm-config)
  (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
        helm-buffers-fuzzy-matching           t ; fuzzy matching buffer names when non--nil
        helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
        helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
        helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
        helm-ff-file-name-history-use-recentf t)
  (helm-mode)

  :bind (("C-c h" . helm-command-prefix)
         ("M-x" . helm-M-x)
         ("M-y" . helm-show-kill-ring)
         ("C-x C-b" . helm-mini)
         ("C-x b" . helm-mini)
         ("C-x C-f" . helm-find-files)
         ("C-x f" . helm-find-files))

  :config
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action)) ; list actions using C-z

(use-package helm-descbinds
  :ensure t
  :bind (("C-h b" . helm-descbinds)
         ("C-h w" . helm-descbinds))
  :init (fset 'describe-bindings 'helm-descbinds)
  :config
  (setq helm-descbinds-window-style 'split-window)
  (helm-descbinds-mode))

(use-package nyan-mode
  :ensure t
  :config (nyan-mode t))

;; (use-package smartparens
;;   :ensure t
;;   :config
;;   (require 'smartparens-config)
;;   (sp-use-smartparens-bindings)
;;   (add-hook 'emacs-lisp-mode-hook 'turn-on-smartparens-mode))

(use-package markdown-mode
  :ensure t
  :mode "\\.md"
  :config
  (defun my/fix-markdown-paragraph-fill ()
    "Make paragraph filling work with text under headers."
    (make-local-variable 'paragraph-separate)
    (make-local-variable 'paragraph-start)
    (setq paragraph-start
          (concatenate 'string "#+.*$\\|=+$\\|" paragraph-start))
    (setq paragraph-separate
          (concatenate 'string "#+.*$\\|=+$\\|" paragraph-separate)))

  (add-hook 'markdown-mode-hook 'my/fix-markdown-paragraph-fill))

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

(use-package elisp-slime-nav
  :ensure t
  :config
  (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
    (add-hook hook 'turn-on-elisp-slime-nav-mode)))

(use-package which-key :ensure t)

(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :config
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (go-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)


(use-package rectangle-utils
  :ensure t
  :bind (("C-x r e" . rectangle-utils-extend-rectangle-to-end)))

(use-package company
  :ensure t
  :bind (:map company-search-map
              ("C-t" . company-search-toggle-filtering)
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous)
              ("<tab>" . company-complete-selection)
              :map company-active-map
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous)
              ("<tab>" . company-complete-selection)))

(use-package zenburn-theme
  :ensure t
  :config
  (when (display-graphic-p)
    (load-theme 'zenburn t)))

(use-package magit
  :ensure t
  :bind (("C-x m" . magit-status)
         ("C-x C-m" . magit-status))
  :config
  (defadvice magit-status (around magit-fullscreen activate)
    (window-configuration-to-register :magit-fullscreen)
    ad-do-it
    (delete-other-windows))

  (defun magit-quit-session ()
    "Restores the previous window configurations and kills the magit buffer"
    (interactive)
    (kill-buffer)
    (jump-to-register :magit-fullscreen))

  (bind-key "q" 'magit-quit-session magit-status-mode-map)
  (setq magit-log-margin '(t "%m/%d/%Y %H:%M " magit-log-margin-width nil 18))

  :init (setq magit-last-seen-setup-instructions "1.4.0"))

(use-package uniquify
  :config (setq uniquify-buffer-name-style 'forward))

(use-package multiple-cursors
  :ensure t
  :bind (("C-c C->" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

(use-package benanhalt-hippie
  :load-path "lisp/")

(add-to-list 'auto-mode-alist '("\\.json$" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)

(put 'narrow-to-region 'disabled nil)

(bind-key "M-SPC" 'cycle-spacing)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files even when they're in version control
(setq vc-make-backup-files t)

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(winner-mode 1)
(column-number-mode 1)
(show-paren-mode 1)
(recentf-mode 1)

(setq mouse-yank-at-point t)
(setq isearch-allow-scroll t)
(setq compilation-scroll-output 'first-error)
(setq split-height-threshold nil)

(setq-default indent-tabs-mode nil)

;; disabling prompts
(fset 'yes-or-no-p 'y-or-n-p)

(setq confirm-nonexistent-file-or-buffer nil)

(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))

(setq frame-title-format
      '((buffer-file-name "%f" (dired-directory dired-directory "%b")) " - "
        invocation-name "@" system-name))


(let ((stw '(lambda () (setq show-trailing-whitespace t))))
  (dolist (hook '(prog-mode-hook python-mode-hook))
    (add-hook hook stw)))

(setq confirm-kill-emacs 'y-or-n-p)

(require 'ansi-color)
(defun my/colorize-compilation ()
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region
     compilation-filter-start (point))))

(add-hook 'compilation-filter-hook
          #'my/colorize-compilation)

(require 'server)
(unless (server-running-p)
  (server-start))


(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
