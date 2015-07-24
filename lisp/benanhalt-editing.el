(defun untabify-buffer ()
  "untabify buffer or narrowed portion of buffer"
  (interactive)
  (untabify (point-min) (point-max)))

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

(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline)
  (indent-for-tab-command))

(defun open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))

(provide 'benanhalt-editing)
