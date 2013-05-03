
;; -*- lexical-binding: t -*-

(require 'package)
(require 'cl-lib)

(let ((archives
       '(("marmalade" . "http://marmalade-repo.org/packages/")
         ("melpa" . "http://melpa.milkbox.net/packages/")))

      (packages
       '(magit fill-column-indicator undo-tree visual-regexp flymake-cursor
               ace-jump-mode coffee-mode jump-char restclient expand-region
               mark-multiple markdown-mode js2-mode slime)))

  (dolist (archive archives)
    (add-to-list 'package-archives archive))

  (package-initialize)

  (unless (cl-every 'package-installed-p packages)
    (package-refresh-contents)
    (dolist (package packages)
      (unless (package-installed-p package)
        (package-install package))))
)

(provide 'setup-package)

