(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(load "init-common")
(load (concat "init-host-" (system-name)))

(use-package envrc
  :ensure t
  :hook (after-init . envrc-global-mode))
