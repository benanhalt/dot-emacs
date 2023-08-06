(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(load "init-common")

(set-face-attribute 'default nil :height 160)
(set-frame-parameter nil 'fullscreen 'maximized)


(use-package dockerfile-mode
  :ensure t)

(use-package restclient
  :ensure t)
