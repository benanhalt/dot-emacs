(use-package go-mode
  :ensure t
  :config
  ;; go install golang.org/x/tools/cmd/goimports@latest
  (setq gofmt-command "~/go/bin/goimports")
  ;; go install golang.org/x/tools/gopls@latest
  (setq lsp-go-gopls-server-path "~/go/bin/gopls")
  :hook ((before-save . gofmt-before-save)
         (go-mode . (lambda () (setq tab-width 4)))))

