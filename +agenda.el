;;; ~/.doom.d/agenda.el -*- lexical-binding: t; -*-

(after! org-agenda (setq org-agenda-custom-commands
                         '(("t" "Tasks"
                            ((agenda ""
                                     ((org-agenda-overriding-header "My Agenda")
                                      (org-agenda-span 'day)
                                      (org-agenda-start-day (org-today))
                                      (org-agenda-current-span 'day)
                                      (org-agenda-files '("~/.gtd/tasks/" "~/.gtd/habit.org" "~/.gtd/projects/"))
                                      (org-super-agenda-groups
                                       '((:name "Habits"
                                                :habit t
                                                :order 1)
                                         (:name "On Calendar"
                                                :time-grid t
                                                :order 2)
                                         (:name "Deadline Approaching"
                                                :deadline t
                                                :order 3)
                                         (:name "Upcoming"
                                                :scheduled t
                                                :order 4)))))
                             (todo "NOTE"
                                   ((org-agenda-files '("~/.gtd/tasks/"))
                                    (org-agenda-overriding-header "Remember")
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))
                             (todo "REVIEW"
                                   ((org-agenda-overriding-header "Items to review")
                                    (org-agenda-files '("~/.gtd/tasks/"))))
                             (todo "TODO|NEXT|DELEGATED"
                                   ((org-agenda-overriding-header "Task list")
                                    (org-agenda-files '("~/.gtd/tasks/"))
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))
                            (todo "TODO|NEXT|NOTE|DELEGATED"
                                  ((org-agenda-overriding-header "Projects")
                                   (org-agenda-files '("~/.gtd/projects/"))
                                   (org-super-agenda-groups
                                    '((:auto-parent t)))))
                            (todo ""
                                  ((org-agenda-overriding-header "Tasks for contacts")
                                   (org-agenda-files '("~/.gtd/conversations.org"))))
                            (todo ""
                                  ((org-agenda-overriding-header "Emacs Items")
                                   (org-agenda-files '("~/.doom.d/readme.org"))
                                   (org-super-agenda-groups
                                    '((:auto-parent t)))))))
                            ("n" "Notes"
                             ((todo ""
                                    ((org-agenda-files '("~/.gtd/notes.org"))
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
                                     (org-agenda-files '("~/.gtd/tasks/"))
                                     (org-super-agenda-groups
                                      '((:auto-parent t)))))
                              (todo "SOMEDAY"
                                    ((org-agenda-overriding-header "Projects marked Someday")
                                     (org-agenda-files '("~/.gtd/projects/"))
                                     (org-super-agenda-groups
                                      '((:auto-parent t))))))))))
