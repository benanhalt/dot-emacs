
(defun fix-markdown-paragraph-fill ()
  "Make paragraph filling work with text under headers."
  (make-local-variable 'paragraph-separate)
  (make-local-variable 'paragraph-start)
  (setq paragraph-start
        (concatenate 'string "#+.*$\\|" paragraph-start))
  (setq paragraph-separate
        (concatenate 'string "#+.*$\\|" paragraph-separate)))

(add-hook 'markdown-mode-hook 'fix-markdown-paragraph-fill)

(provide 'setup-markdown)
