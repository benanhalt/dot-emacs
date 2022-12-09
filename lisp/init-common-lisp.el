(use-package slime
  :ensure t
  :init (setq inferior-lisp-program "sbcl")
  :config (slime-setup '(slime-fancy)))

