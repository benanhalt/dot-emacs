(defun kill-region-or-backward-word ()
  "kill region if active, otherwise kill backward word"
  (interactive)
  (if (region-active-p)
      (kill-region (region-beginning) (region-end))
    (backward-kill-word 1)))

(defun back-to-indentation-or-beginning ()
   (interactive)
   (if (and (looking-back "^\s+")
           (eq last-command 'back-to-indentation-or-beginning))
       (beginning-of-line)
     (back-to-indentation)))
