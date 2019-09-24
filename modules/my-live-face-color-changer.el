;;; my-live-face-color-changer.el -*- lexical-binding: t; -*-

(provide 'my-live-face-color-changer)

(defun my-live-face-color-changer (face)
  (interactive (list (read-face-name "Select face"
                                     (or (face-at-point t) 'default)
                                     t)))
  (setq my-live-face (car face))
  (setq my-live-face-foreground t)
  (list-colors-display)
  (select-window (get-buffer-window "*Colors*"))
  (local-set-key "f" 'my-live-set-foreground)
  (local-set-key "b" 'my-live-set-background)
  (local-set-key "c" 'my-live-copy-colors)
  (add-hook 'post-command-hook 'my-live-face-color-set t t))


(defun my-live-face-color-set ()
  (when (looking-at ".+\\(#.+\\)")
    (funcall (if my-live-face-foreground
                 'set-face-foreground
               'set-face-background)
             my-live-face
             (match-string 1))))


(defun my-live-set-foreground ()
  (interactive)
  (setq my-live-face-foreground t)
  (message "Choosing foreground color."))


(defun my-live-set-background ()
  (interactive)
  (setq my-live-face-foreground nil)
  (message "Choosing background color."))


(defun my-live-copy-colors ()
  (interactive)
  (remove-hook 'post-command-hook 'my-live-face-color-set t)
  (let ((settings (format "(set-face-foreground '%s \"%s\")\n(set-face-background '%s \"%s\")"
                          my-live-face
                          (face-foreground my-live-face)
                          my-live-face
                          (face-background my-live-face))))
    (kill-new settings)
    (quit-window)
    (message "Copied settings to clipboard:\n\n%s" settings)))
