(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)

(define-key global-map (kbd "C-'") 'ace-jump-mode)

(global-set-key (kbd "C-=") 'er/expand-region)

(global-set-key (kbd "C-x r t") 'inline-string-rectangle)
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)
(global-set-key (kbd "C-M-m") 'mark-more-like-this)
(global-set-key (kbd "C-*") 'mark-all-like-this)

(global-set-key (kbd "M-m") 'jump-char-forward)
(global-set-key (kbd "M-M") 'jump-char-backward)

(global-set-key (kbd "C-w") 'kill-region-or-backward-word)

(global-set-key (kbd "C-x m") 'magit-status)

(provide 'key-bindings)
