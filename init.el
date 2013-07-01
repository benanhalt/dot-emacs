;;; -*- lexical-binding: t -*-

;; turn off screen real estate theives
(dolist (mode '(tool-bar-mode menu-bar-mode scroll-bar-mode))
  (if (fboundp mode) (funcall mode -1)))

(setq inhibit-startup-message t)

;; Go ahead and load cl since ace-jump-mode is broken and depends on it.
(require 'cl)

(let* ((dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))
       (site-lisp-dir (expand-file-name "site-lisp" dotfiles-dir)))

  (add-to-list 'load-path dotfiles-dir)
  (add-to-list 'load-path site-lisp-dir)

  ;; Keep emacs Custom-settings in separate file
  (setq custom-file (expand-file-name "custom.el" dotfiles-dir))
  (load custom-file)

  ;; Add external projects to load path
  (dolist (project (directory-files site-lisp-dir t "\\w+"))
    (when (file-directory-p project)
      (add-to-list 'load-path project)))

  ;; Functions (load all files in defuns-dir)
  (setq defuns-dir (expand-file-name "defuns" dotfiles-dir))
  (dolist (file (directory-files defuns-dir t "\\w+"))
    (when (file-regular-p file)
      (load file))))

(setq frame-title-format
      '((buffer-file-name "%f" (dired-directory dired-directory "%b")) " - "
        invocation-name "@" system-name))

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; (when (require 'geiser-install nil t)
;;   (setq geiser-repl-startup-time 20000))

;; disabling prompts
(fset 'yes-or-no-p 'y-or-n-p)

(setq confirm-nonexistent-file-or-buffer nil)

(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))

(require 'setup-hippie)
(require 'setup-package)

(eval-after-load 'magit '(require 'setup-magit))
(eval-after-load 'flymake '(require 'setup-flymake))

(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'emacs-lisp-mode-hook (lambda () (elisp-slime-nav-mode 1)))

;; slime
(setq inferior-lisp-program "sbcl") ; your Lisp system
(slime-setup '(slime-fancy))

(require 'key-bindings)
(put 'narrow-to-region 'disabled nil)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

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
(global-rainbow-delimiters-mode)

(setq mouse-yank-at-point t)
(setq isearch-allow-scroll t)
(setq compilation-scroll-output 'first-error)
(setq split-height-threshold nil)

(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)

(require 'undo-tree)
(global-undo-tree-mode)

(require 'server)
(unless (server-running-p)
  (server-start))

(load-theme 'zenburn t)
