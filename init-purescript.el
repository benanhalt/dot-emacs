(use-package purescript-mode
  :ensure t
  :mode "\\.purs"
  :config
  (setq purty-command "purty")
  (reformatter-define purescript-format
    :program purty-command
    :args '("-"))

  :bind (("C-c C-f" . purescript-format-buffer)))

(use-package flycheck-purescript
  :ensure t)

(use-package psc-ide
  :ensure t
  :config
  (add-hook 'purescript-mode-hook
            (lambda () (psc-ide-mode)
              (company-mode)
              (flycheck-mode)
              (turn-on-purescript-indentation))))

