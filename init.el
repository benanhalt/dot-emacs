(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(tab-width 4)
 '(tool-bar-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "#221f1e" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 122 :width normal :foundry "unknown" :family "Droid Sans Mono")))))

(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

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

(require 'restclient)

(require 'typing)
(autoload 'typing-of-emacs "Typing of Emacs" t)

(require 'coffee-mode)

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; use javascript mode for .json
(setq auto-mode-alist
      (append '(("\\.json$" . javascript-mode)) auto-mode-alist))

(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

