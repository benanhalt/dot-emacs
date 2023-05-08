(use-package quelpa :ensure t)
(use-package quelpa-use-package :ensure t)

(use-package copilot
  :quelpa (copilot :fetcher github
                   :repo "zerolfx/copilot.el"
                   :commit "7cb7beda89145ccb86a4324860584545ec016552"
                   :files ("dist" "*.el")
                   :upgrade t)
  :bind ("<tab>" . copilot-accept-completion))

