;;; ~/.doom.d/additional.el -*- lexical-binding: t; -*-

(add-to-list '+lookup-provider-url-alist '("Wikibooks" . "https://en.wikibooks.org/w/index.php?sort=relevance&search=%s"))
(defun psachin/create-notes-file ()
  "Create an org file in ~/Google Drive/org/personal/."
  (interactive)
  (let ((name (read-string "Filename: ")))
    (expand-file-name (format "%s.org" name) "~/Google Drive/org/personal/notebook/")))
;; Journal file locator
(defun org-journal-find-location ()
  (org-journal-new-entry t)
  (goto-char (point-min)))
;; Configure auto check-boxes on sub-tasks
(defun org-update-cookies-after-save()
(interactive)
(let ((current-prefix-arg '(4)))
(org-update-statistics-cookies "ALL")))
(add-hook 'org-mode-hook
        (lambda ()
            (add-hook 'before-save-hook 'org-update-cookies-after-save nil 'make-it-local)))
;; Configure pandoc support
(custom-set-variables
 '(markdown-command "pandoc"))

;; Unknown what this does and I need to look into it more
(add-to-list 'org-modules 'org-habit t)

;; Show lot of clocking history so it's easy to pick items off the C-F11 list
;(setq org-clock-history-length 23)
;; Resume clocking task on clock-in if the clock is open
;(setq org-clock-in-resume t)
;; Change tasks to NEXT when clocking in
;(setq org-clock-in-switch-to-state 'bh/clock-in-to-next)
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)
;; Do not prompt to resume an active clock
;(setq org-clock-persist-query-resume nil)
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)
