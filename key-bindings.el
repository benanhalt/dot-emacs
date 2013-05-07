(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)
(global-set-key (kbd "C-x r t") 'inline-string-rectangle)

(global-set-key (kbd "C-x m") 'magit-status)
(global-set-key (kbd "C-x w") 'webjump)

(global-set-key (kbd "C-x C-j") 'dired-jump)

(global-set-key (kbd "M-/") 'hippie-expand)

(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map (kbd "C-'") 'ace-jump-mode)

(define-key my-keys-minor-mode-map (kbd "C-=") 'er/expand-region)

(define-key my-keys-minor-mode-map (kbd "C-<") 'mark-previous-like-this)
(define-key my-keys-minor-mode-map (kbd "C->") 'mark-next-like-this)
(define-key my-keys-minor-mode-map (kbd "C-M-m") 'mark-more-like-this-extended)
(define-key my-keys-minor-mode-map (kbd "C-*") 'mark-all-like-this)

(define-key my-keys-minor-mode-map (kbd "M-m") 'jump-char-forward)
(define-key my-keys-minor-mode-map (kbd "M-M") 'jump-char-backward)

(define-key my-keys-minor-mode-map (kbd "C-w") 'kill-region-or-backward-word)

(define-key my-keys-minor-mode-map (kbd "<C-return>") 'open-line-below)
(define-key my-keys-minor-mode-map (kbd "<C-S-return>") 'open-line-above)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(my-keys-minor-mode 1)

(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

(provide 'key-bindings)
