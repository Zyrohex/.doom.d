;;; ~/.doom.d/agenda.el -*- lexical-binding: t; -*-

(after! org-agenda (setq org-agenda-custom-commands
                         '(("t" "Tasks"
                            ((todo "TODO|NEXT|DELEGATED"
                                   ((org-agenda-overriding-header "Task list")
                                    (org-agenda-files '("~/.gtd/tasks/"))
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))
                             (todo "TODO|NEXT|NOTE|DELEGATED"
                                   ((org-agenda-overriding-header "Projects")
                                    (org-agenda-files '("~/.gtd/projects/"))
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))
                             (todo "NOTE"
                                   ((org-agenda-files '("~/.gtd/tasks/"))
                                    (org-agenda-overriding-header "Remember")
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))
                             (todo "REVIEW"
                                   ((org-agenda-overriding-header "Items to review")
                                    (org-agenda-files '("~/.gtd/tasks/"))))
                             (todo ""
                                   ((org-agenda-overriding-header "Emacs Items")
                                    (org-agenda-files '("~/.doom.d/readme.org"))
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))))
                           ("c" "On Calendar"
                            ((agenda ""
                                     ((org-agenda-files '("~/.gtd/habits.org" "~/.gtd/tasks/" "~/.gtd/projects/"))
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
                                                :order 4)))))))
                           ("n" "Notes"
                            ((todo ""
                                   ((org-agenda-files '("~/.gtd/notes.org"))
                                    (org-agenda-overriding-header "Note Tasks")
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))))
                           ("i" "Inbox/Someday"
                            ((todo ""
                                   ((org-agenda-files '("~/.gtd/inbox.org"))
                                    (org-agenda-overriding-header "Items in my inbox")
                                    (org-super-agenda-groups
                                     '((:name none
                                              :auto-ts t)))))))
                           ("x" "Get to someday"
                            ((todo "SOMEDAY"
                                   ((org-agenda-overriding-header "Things I need to get to someday")
                                    (org-agenda-files '("~/.gtd/tasks/"))
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))
                             (todo "SOMEDAY"
                                   ((org-agenda-overriding-header "Projects marked Someday")
                                    (org-agenda-files '("~/.gtd/projects/"))
                                    (org-super-agenda-groups
                                     '((:auto-parent t))))))))))
