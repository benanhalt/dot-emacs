(require 'edit-server)
(setq edit-server-new-frame nil)
(edit-server-start)

(defadvice edit-server-create-edit-buffer (after edit-server-fullscreen activate)
  (delete-other-windows))

(provide 'setup-edit-server)
