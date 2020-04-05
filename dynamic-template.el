;;; ~/.doom.d/agenda.el -*- lexical-binding: t; -*-

(defun org-capture-templates-file-select (checklist)
  "Concat results to function"
  (interactive)
  (if (equal checklist "Buffer")
      (concat (buffer-name))
    (org-capture-file-selector)))

(org-capture-templates-file-selector)

(defun org-capture-templates-file-selector ()
  "Select your choice"
  (interactive)
  (let ((choice '("Buffer" "File")))
    (org-capture-templates-file-select (org-completing-read "Pick option: " choice))))

(defun org-capture-headline-finder (&optional arg)
  "Like `org-todo-list', but using only the current buffer's file."
  (interactive "P")
  (let ((org-agenda-files (list (buffer-file-name (current-buffer)))))
    (if (null (car org-agenda-files))
        (error "%s is not visiting a file" (buffer-name (current-buffer)))
      (counsel-org-agenda-headlines)))
  (goto-char (org-end-of-subtree)))

(defun org-capture-headline-finder2 (&optional arg)
  "Like `org-todo-list', but using only the current buffer's file."
  (interactive "P")
  (let ((org-agenda-files (list (buffer-file-name (current-buffer)))))
    (if (null (car org-agenda-files))
        (error "%s is not visiting a file" (buffer-name (current-buffer)))
      (org-refile))))

(setq org-capture-templates
      '(("x" "Test Item" plain (file+function org-capture-templates-file-selector org-capture-headline-finder)
         "%(format \"%s\" (org-capture-template-selector))%?")))
