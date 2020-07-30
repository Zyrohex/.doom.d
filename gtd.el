;;; package --- Summary
;;; Commentary:
;;; Code:
(defvar org-gtd-folder (expand-file-name "gtd/" org-directory))
(defvar org-projects-folder (file-name-directory "~/.org/gtd/projects/"))
(defvar org-gtd-task-files '("next.org"))
(defvar org-gtd-someday-file (expand-file-name "someday.org" org-gtd-folder))
(defvar org-gtd-inbox-file (expand-file-name "inbox.org" org-gtd-folder))
(defvar org-gtd-references-file (expand-file-name "references.org" org-gtd-folder))
(defvar org-gtd-tickler-file (expand-file-name "tickler.org" org-gtd-folder))
(defvar org-gtd-refile-properties nil)
(defvar org-next-task-files nil)

;; Configure our next task file and map them to our folder directory
(setq org-next-task-files (mapcar (lambda (file) (expand-file-name file org-gtd-folder))
                                   org-gtd-task-files))

;; (mapcar (lambda (arg) (org-set-property arg (read-string (concat arg ": "))))
;;           org-gtd-properties)

;; Configure our key maps
(map! :after org
      :map org-mode-map
      :leader
      :prefix ("d" . "Getting Things Done")
      :desc "Capture" "!" #'org-gtd-quick-capture
      :desc "Check Inbox" "i" #'zyro/agenda-inbox
      :desc "Search references" "r" #'zyro/agenda-references
      :desc "Refile to next tasks" "R" #'zyro/refile
      :desc "Next Tasks" "n" #'zyro/agenda-next-tasks
      :desc "Find File" "f" #'org-gtd-find-file)

;;; Capture System for GTD
(defun zyro/capture-inbox ()
  "Function to locate file for capture template."
  (let ((name (file-name-nondirectory org-gtd-inbox-file))
        (dir (file-name-directory org-gtd-inbox-file)))
    (expand-file-name (format "%s%s" dir name))))

(defun org-gtd-quick-capture ()
  "Quick capture to inbox from KEY-BINDING."
  (interactive)
  (let* ((org-capture-templates
          '(("!" "Quick Capture" plain (file zyro/capture-inbox)
             "* TODO %^{task} %^g" :immediate-finish t))))
    (org-capture nil "!")))

;;; Refile System

(defun zyro/refile-set-properties ()
  "Set properties when refiling."
  (interactive)
  (when (and major-mode (= '"org-mode") (equal buffer-file-name (or (expand-file-name org-gtd-inbox-file) (expand-file-name org-gtd-someday-file))))
    (mapcar (lambda (arg) (org-set-property arg (read-string (concat arg ": "))))
          org-gtd-refile-properties)
;    (org-set-property "CATEGORY" (read-string "Category: "))
    (call-interactively #'org-schedule)
    (org-set-effort nil (ivy-completing-read "Estimate: " '("0:15" "0:30" "0:45" "1:00" "1:30" "2:00" "2:30" "3:00" "4:00")))
    (call-interactively #'counsel-org-tag)))

(defun zyro/refile ()
  "Refile current headline to NEXT tasks."
  (interactive)
  (let ((org-refile-targets '((org-next-task-files :maxlevel . 3))))
    (advice-add 'org-refile :before #'zyro/refile-set-properties)
    (org-refile)))

;;; Configure file finders
(defun org-gtd-find-file ()
  "Find default INBOX file."
  (interactive)
  (find-file (expand-file-name (ivy-completing-read "select: " (directory-files org-gtd-folder nil "[\\^.]org")) org-gtd-folder)))

;;; Configure Agenda Settings
(defun zyro/agenda-someday ()
  "Open next tasks in ORGMODE AGENDA."
  (interactive)
  (let ((org-agenda-files (list org-gtd-someday-file))
        (org-super-agenda-groups
                     '((:priority "A")
                       (:priority "B")
                       (:todo "PROJ")
                       (:effort> "0:16")
                       (:effort< "0:15"))))
    (org-agenda nil "t")))

(defun zyro/agenda-projects ()
  "Call agenda for GTD projects folder."
  (interactive)
  (let ((org-agenda-files (list org-projects-folder))
        (org-agenda-custom-commands
         '(("w" "Master List"
            ((agenda ""
                     ((org-agenda-start-day (org-today))
                      (org-agenda-span 3)))
             (todo ""
                   ((org-super-agenda-groups
                     '((:priority "A")
                       (:effort> "0:16")
                       (:priority "B"))))))))))
    (org-agenda nil "w")))

(defun zyro/agenda-references ()
  "Open next tasks in ORGMODE AGENDA."
  (interactive)
  (let ((org-agenda-files (list org-gtd-references-file))
        (org-super-agenda-groups
                     '((:auto-ts t))))
    (org-agenda nil "s")))

(defun zyro/agenda-inbox ()
  "Configure our Inbox agenda."
  (interactive)
  (let ((org-agenda-files (list org-gtd-inbox-file))
        (org-super-agenda-groups
         '((:auto-ts t))))
    (org-agenda nil "t")))

(defun zyro/agenda-next-tasks ()
  "Open next tasks in ORGMODE AGENDA."
  (interactive)
  (setq org-next-task-files (mapcar (lambda (file) (expand-file-name file org-gtd-folder))
                                    org-gtd-task-files))
  (let* ((org-agenda-files org-next-task-files)
         (org-super-agenda-groups
          '((:priority "A")
            (:priority "B")
            (:todo "PROJ")
            (:effort> "0:16")
            (:effort< "0:15"))))
    (org-agenda nil "t")))

;; Configure template picker
;;(find-file (expand-file-name (ivy-completing-read "select: " (directory-files "~/.doom.d/templates/" nil "[\\^.]org")) org-gtd-folder))

(defun org-gtd-templates ()
  "Template picker."
  (interactive)
  (let ((files (directory-files (expand-file-name "templates/" (doom-dir)) t "[\\^.]org")))
    (setq org-capture-templates nil)
    (mapcar (lambda (arg) (add-to-list 'org-capture-templates ((substring arg 20 21) arg plain (file zyro/capture-inbox)
                                                                (file arg)))) files)
    (call-interactively #'org-capture)))

(provide 'org-gtd)

;;; org-gtd.el ends here
