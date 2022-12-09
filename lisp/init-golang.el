(use-package go-mode
  :ensure t
  :config
  (setq gofmt-command "/Users/benanhalt/go/bin/goimports")
  :hook ((before-save . gofmt-before-save)
         (go-mode . (lambda () (setq tab-width 4)))))

