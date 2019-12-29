;;; ~/.doom.d/agenda.el -*- lexical-binding: t; -*-

(after! org-agenda (setq org-agenda-custom-commands
                         '(("t" "Tasks"
                            ((agenda ""
                                     ((org-agenda-files '("~/.gtd/habits.org" "~/.gtd/tasks.org" "~/.gtd/projects.org"))
                                      (org-agenda-overriding-header "What's on my calendar")
                                      (org-agenda-span 'day)
                                      (org-agenda-start-day (org-today))
                                      (org-agenda-current-span 'day)
                                      (org-super-agenda-groups
                                       '((:name "Habits"
                                                :habit t
                                                :order 1)
                                         (:name "Today's Schedule"
                                                :time-grid t
                                                :order 2)
                                         (:name "In future"
                                                :scheduled t
                                                :order 3)
                                         (:name "Deadline approaching"
                                                :deadline t
                                                :order 4)))))
                             (todo "TODO|NEXT|DELEGATED|REVIEW|WAITING|IN-PROGRESS"
                                   ((org-agenda-overriding-header "Task list")
                                    (org-agenda-files '("~/.gtd/tasks.org"))
                                    (org-super-agenda-groups
                                     '((:auto-property "Group-ID")))))
                             (todo "TODO|NEXT|DELEGATED|REVIEW|WAITING|IN-PROGRESS"
                                   ((org-agenda-overriding-header "Projects")
                                    (org-agenda-files '("~/.gtd/projects.org"))
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))))
                           ("n" "Notes"
                            ((todo ""
                                   ((org-agenda-files (f-files "~/.references/notes/" "~/.references/usage/"))
                                    (org-agenda-overriding-header "Note Tasks")
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))))
                           ("i" "Inbox"
                            ((todo ""
                                   ((org-agenda-files '("~/.gtd/inbox.org"))
                                    (org-agenda-overriding-header "Items in my inbox")
                                    (org-super-agenda-groups
                                     '((:name none
                                              :auto-ts t)))))))
                           ("x" "Get to someday"
                            ((todo "SOMEDAY"
                                   ((org-agenda-overriding-header "Things I need to get to someday")
                                    (org-agenda-files '("~/.gtd/"))
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))
                             (todo "SOMEDAY"
                                   ((org-agenda-overriding-header "Projects marked Someday")
                                    (org-agenda-files '("~/.gtd/"))
                                    (org-super-agenda-groups
                                     '((:auto-parent t))))))))))
