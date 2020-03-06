;;; ~/.doom.d/task.el -*- lexical-binding: t; -*-

(defun org-new-task ()
  "Creates a new task below current header"
  (interactive)
  (setq task-name (read-string "Task name: "))
  (setq task-category (read-string "Category: "))
  (setq task-case (read-string "Case Number: "))
  (+org--insert-item 'below) (org-end-of-line)
  (insert
   (format "TODO %s" task-name))
  (insert
   (format"\n:PROPERTIES:\n:CATEGORY: %s" task-category))
  (if task-case
      (insert (format "\n:CASENUMBER: %s" task-case)))
  (insert
   (format"\n:END:")))
