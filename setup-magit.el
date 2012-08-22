(set-face-foreground 'magit-diff-add "green3")
(set-face-foreground 'magit-diff-del "red3")
(when (not window-system)
  (set-face-background 'magit-item-highlight "black"))

(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window conigurations and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)

(provide 'setup-magit)
