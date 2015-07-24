
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-from-kill
        try-expand-dabbrev-all-buffers
        try-expand-all-abbrevs
        try-complete-file-name-partially
        try-complete-file-name))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (make-local-variable 'hippie-expand-try-functions-list)
            (setq hippie-expand-try-functions-list
                  (cons 'try-complete-lisp-symbol-partially
                        (cons 'try-complete-lisp-symbol
                              hippie-expand-try-functions-list)))))



(add-hook 'slime-mode-hook 'set-up-slime-hippie-expand)
(add-hook 'slime-repl-mode-hook 'set-up-slime-hippie-expand)

(provide 'benanhalt-hippie)
