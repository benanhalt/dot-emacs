
;; Set path to .emacs.d
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" dotfiles-dir))
(load custom-file)

;; Set path to dependencies
(setq site-lisp-dir (expand-file-name "site-lisp" dotfiles-dir))

;; Set up load path
(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path site-lisp-dir)

;; Add external projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

(require 'scala-mode-auto)

;; Load the ensime lisp code...
;;(add-to-list 'load-path "~/ensime/elisp/")
;;(require 'ensime)

;; This step causes the ensime-mode to be started whenever
;; scala-mode is started for a buffer. You may have to customize this step
;; if you're not using the standard scala mode.
;;(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; MINI HOWTO: 
;; Open .scala file. M-x ensime (once per project)

(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)

;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" dotfiles-dir))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

(toggle-fullscreen)

(setq frame-title-format
      '((buffer-file-name "%f" (dired-directory dired-directory "%b")) " - "
        invocation-name "@" system-name))

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(when (require 'geiser-install nil t)
  (setq geiser-repl-startup-time 20000))

(when (require 'quack nil t)
  (quack-install))

;; disabling prompts
(fset 'yes-or-no-p 'y-or-n-p)

(setq confirm-nonexistent-file-or-buffer nil)

(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))

;; csharp mode
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist
      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

(require 'setup-package)
(packages-install
 (cons 'magit melpa))

(eval-after-load 'magit '(require 'setup-magit))

(require 'restclient)

(require 'typing)
(autoload 'typing-of-emacs "Typing of Emacs" t)

(require 'coffee-mode)

(require 'ace-jump-mode)

(require 'jump-char)

;; use javascript mode for .json
(setq auto-mode-alist
      (append '(("\\.json$" . javascript-mode)) auto-mode-alist))

;; slime
(setq inferior-lisp-program "sbcl") ; your Lisp system
(require 'slime-autoloads)
(slime-setup)

;; google chrome emacs edit server
(require 'setup-edit-server)

(require 'key-bindings)
