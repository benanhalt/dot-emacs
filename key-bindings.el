(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)

(define-key global-map (kbd "C-'") 'ace-jump-mode)

(global-set-key (kbd "M-m") 'jump-char-forward)
(global-set-key (kbd "M-M") 'jump-char-backward)

(global-set-key (kbd "C-x m") 'magit-status)

(provide 'key-bindings)
