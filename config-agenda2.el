;;; c:/Users/nmart/.doom.d/config-agenda2.el -*- lexical-binding: t; -*-

(after! org-agenda (setq org-agenda-custom-commands
                         '(("t" "Tasks"
                             ((agenda ""
                                     ((org-agenda-files '("~/.gtd/tasks.org" "~/.gtd/habits.org" "~/.gtd/projects.org" "~/.gtd/recurring.org"))
                                      (org-agenda-overriding-header "What's on my calendar")
                                      (org-agenda-span 'day)
                                      (org-agenda-start-day (org-today))
                                      (org-agenda-current-span 'day)
                                      (org-super-agenda-groups
                                       '((:name "High Priority"
                                                :priority>= "B"
                                                :order 1)
                                         (:name "[[~/.gtd/recurring.org][Bills]]"
                                                :tag "@bills"
                                                :order 4)
                                         (:name "[[~/.gtd/habits.org][Habits]]"
                                                :habit t
                                                :order 5)
                                         (:name "Today's Schedule"
                                                :time-grid t
                                                :scheduled t
                                                :deadline t
                                                :order 13)))))
                             (todo "TODO|NEXT|DELEGATED|REVIEW|WAITING|IN-PROGRESS"
                                   ((org-agenda-overriding-header "[[~/.gtd/tasks.org][Task list]]")
                                    (org-agenda-files '("~/.gtd/tasks.org"))
                                    (org-super-agenda-groups
                                     '((:name "Urgent"
                                              :priority "A"
                                              :order 1)
                                       (:name "High Priority"
                                              :priority "B"
                                              :order 2)
                                       (:name "On Computer"
                                              :tag ("@computer" "@email")
                                              :order 3)
                                       (:name "Stuff to read"
                                              :tag ("@read" "@study")
                                              :order 4)
                                       (:name "Write"
                                              :tag ("@write")
                                              :order 5)
                                       (:name "Call or message"
                                              :tag ("@phone")
                                              :order 6)
                                       (:name "Configure or Code"
                                              :tag ("@configure")
                                              :order 7)
                                       (:name "Personal items"
                                              :tag ("@personal")
                                              :order 8)
                                       (:name "Watch this"
                                              :tag ("@watch")
                                              :order 9)
                                       (:discard (:anything t))))))
                             (todo "TODO|NEXT|DELEGATED|REVIEW|WAITING|IN-PROGRESS"
                                   ((org-agenda-overriding-header "[[~/.gtd/projects.org][Projects]]")
                                    (org-agenda-files '("~/.gtd/projects.org"))
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))))
                           ("n" "Notes"
                            ((todo ""
                                   ((org-agenda-files (f-files "~/.notes/notes/" "~/.notes/usage/"))
                                    (org-agenda-overriding-header "Note Tasks")
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))))
                           ("i" "Inbox"
                            ((todo ""
                                   ((org-agenda-files '("~/.gtd/inbox.org"))
                                    (org-agenda-overriding-header "Items in my inbox")
                                    (tags-todo "-@computer")
                                    (org-super-agenda-groups
                                     '((:name none
                                              :auto-ts t)))))))
                           ("r" "Thankful reminders"
                            ((todo ""
                                   ((org-agenda-overriding-header "[[~/.gtd/reminders.org][Daily reminders]]")
                                    (org-agenda-files '("~/.gtd/reminders.org"))))))
                           ("x" "Get to someday"
                            ((tags-todo "-@computer-@email-@configure-@read-@watch-@personal"
                                   ((org-agenda-overriding-header "Projects marked Someday")
                                    (org-agenda-files '("~/.gtd/tasks.org"))
                                    (tags-todo)
                                    (org-super-agenda-groups
                                     '((:auto-ts t))))))))))
