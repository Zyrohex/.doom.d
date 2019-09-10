(provide 'org-clock-switch)

(defun org-clock-switch ()
  "Switch task and go-to that task"
  (interactive)
  (setq current-prefix-arg '(12)) ; C-u
  (call-interactively 'org-clock-goto)
  (org-clock-in)
  (org-clock-goto))
