;;; org-task-automation.el -*- lexical-binding: t; -*-

(add-hook! 'org-checkbox-statistics-hook #'nm/statistics-update-task)
;(add-hook 'before-save-hook #'nm/update-task-conditions)

(defvar org-tasks-properties-metadata "SOURCE" "List of property values used to clarify task items.")

(defun nm/statistics-update-task ()
  "Update task state when statistics checker runs"
  (when (and (bh/is-task-p) (nm/checkbox-active-exist-p)) (org-todo "NEXT"))
  (when (and (bh/is-task-p) (not (nm/checkbox-active-exist-p)) (nm/checkbox-done-exist-p)) (org-todo "DONE")))

; TODO Write interactive menu selection to ask user what value they want to update (tags, schedule, checkboxes).
(defun nm/update-task-tags ()
  "Update all child tasks in buffer that are missing a TAG value."
  (interactive)
  (org-map-entries (lambda ()
                     (message (nm/org-get-headline-title))
                     (when (and (bh/is-task-p) (null (org-get-tags)))
                       (org-set-tags-command))) t 'file))

(defun nm/update-task-conditions ()
  "Update task states depending on their conditions."
  (interactive)
  (org-map-entries (lambda ()
;                     (when (nm/task-has-next-condition) (org-todo "NEXT"))
;                     (when (nm/task-has-todo-condition) (org-todo "TODO"))
;                     (when (nm/task-has-wait-condition) (org-todo "WAIT"))
                     (when (nm/task-is-active-proj) (org-todo "PROJ"))) t))

(defun nm/task-is-active-proj ()
  "Checks if task is a Project with child subtask"
  (and (bh/is-project-p)
       (nm/has-subtask-active-p)))

(defun nm/task-has-next-condition ()
  "Checks task to see if it meets NEXT state critera and returns t."
  (interactive)
  (save-excursion
    (and (bh/is-task-p)
         (or (nm/checkbox-active-exist-p) (nm/is-scheduled-p) (nm/exist-context-tag-p))
         (and (not (member "WAIT" (org-get-tags))) (not (equal (org-get-todo-state) "DONE"))))))

(defun nm/task-has-todo-condition ()
  "Checks to see if task conditions meet TODO crtieria, and returns t if so."
  (interactive)
  (save-excursion
    (and (bh/is-task-p)
         (and (not (nm/checkbox-active-exist-p)) (not (nm/is-scheduled-p)) (not (nm/exist-context-tag-p)))
         (and (not (member "WAIT" (org-get-tags))) (not (equal (org-get-todo-state) "DONE"))))))

(defun nm/task-has-done-condition ()
  "Checks if task is considered DONE, and returns t."
  (interactive)
  (save-excursion
    (and (bh/is-task-p)
         (and (not (nm/checkbox-active-exist-p)) (not (nm/is-scheduled-p)) (not (nm/exist-context-tag-p)))
         (nm/checkbox-done-exist-p))))

(defun nm/task-has-wait-condition ()
  "Checks if task has conditions for WAIT state, retunrs t."
  (interactive)
  (and (bh/is-task-p)
       (member "WAIT" (org-get-tags))
       (not (equal (org-get-todo-state) "DONE"))
       (not (member "SOMEDAY" (org-get-tags)))))

(defun nm/checkbox-active-exist-p ()
  "Checks if a checkbox that's not marked DONE exist in the tree."
  (interactive)
  (save-excursion
    (org-back-to-heading)
    (let ((end (save-excursion (org-end-of-subtree t))))
      (search-forward-regexp "^[-+] \\[\\W].+\\|^[1-9].\\W\\[\\W]" end t))))

(defun nm/checkbox-done-exist-p ()
  "Checks if a checkbox that's not marked DONE exist in the tree."
  (interactive)
  (save-excursion
    (org-back-to-heading)
    (let ((end (save-excursion (org-end-of-subtree t))))
      (search-forward-regexp "^[-+] \\[X].+\\|^[1-9].\\W\\[X]" end t))))

(defun nm/has-subtask-done-p ()
  "Returns t for any heading that has a subtask is DONE state."
  (interactive)
  (org-back-to-heading t)
  (let ((end (save-excursion (org-end-of-subtree t))))
    (outline-end-of-heading)
    (save-excursion
      (re-search-forward (concat "^\*+ " "\\(DONE\\|KILL\\)") nil end))))

(defun nm/has-subtask-active-p ()
  "Returns t for any heading that has subtasks."
  (save-restriction
    (widen)
    (org-back-to-heading t)
    (let ((end (save-excursion (org-end-of-subtree t))))
      (outline-end-of-heading)
      (save-excursion
        (re-search-forward (concat "^\*+ " "\\(NEXT\\|WAIT\\|TODO\\)") end t)))))

(defun nm/exist-tag-p (arg)
  "If headline has ARG tag keyword assigned, return t."
  (interactive)
  (let ((end (save-excursion (end-of-line))))
    (save-excursion
      (member arg (org-get-tags)))))

(defconst nm/context-tags ".+\s:@\\w.+:\\|.+:@\\w.+:")

(defun nm/exist-context-tag-p (&optional arg)
  "If headline has context tag keyword assigned, return t."
  (interactive)
  (goto-char (org-entry-beginning-position))
  (let ((end (save-excursion (line-end-position))))
    (re-search-forward nm/context-tags end t)))

(defun nm/is-scheduled-p ()
  "Checks task for SCHEDULE and if found, return t."
  (save-excursion
    (org-back-to-heading)
    (let ((end (save-excursion (org-end-of-subtree t))))
      (re-search-forward org-scheduled-regexp end t))))

(defun nm/skip-project-tasks ()
  "Show non-project tasks.
Skip project and sub-project tasks, habits, and project related tasks."
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((bh/is-project-p) subtree-end)
       ((oh/is-scheduled-p) subtree-end)
       ((org-is-habit-p) subtree-end)
       ((bh/is-project-subtree-p) subtree-end)
       (t nil)))))

(defun nm/skip-projects-and-habits-and-single-tasks ()
  "Skip trees that are projects, tasks that are habits, single non-project tasks"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((org-is-habit-p) next-headline)
       ((nm/is-scheduled-p) next-headline)
       ((bh/is-project-p) next-headline)
       ((and (bh/is-task-p) (not (bh/is-project-subtree-p))) next-headline)
       (t nil)))))

(defun nm/skip-scheduled ()
  "Skip headlines that are scheduled."
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((nm/is-scheduled-p) next-headline)
       (t nil)))))
