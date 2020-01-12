;;; ~/.doom.d/config-agenda.el -*- lexical-binding: t; -*-

(org-super-agenda-mode t)
(after! org-agenda (setq org-agenda-custom-commands
                         '(("t" "Tasks"
                             ((agenda ""
                                     ((org-agenda-files '("~/.org/gtd/tasks.org" "~/.org/gtd/habits.org" "~/.org/gtd/projects.org" "~/.org/gtd/recurring.org"))
                                      (org-agenda-overriding-header "What's on my calendar")
                                      (org-agenda-span 'day)
                                      (org-agenda-start-day (org-today))
                                      (org-agenda-current-span 'day)
                                      (org-super-agenda-groups
                                       '((:name "High Priority"
                                                :priority>= "B"
                                                :order 1)
                                         (:name "[[~/.org/gtd/recurring.org][Bills]]"
                                                :tag "@bills"
                                                :order 4)
                                         (:name "[[~/.org/gtd/habits.org][Habits]]"
                                                :habit t
                                                :order 5)
                                         (:name "Today's Schedule"
                                                :time-grid t
                                                :scheduled t
                                                :deadline t
                                                :order 13)))))
                             (todo "TODO|NEXT|DELEGATED|REVIEW|WAITING|IN-PROGRESS"
                                   ((org-agenda-overriding-header "[[~/.org/gtd/tasks.org][Task list]]")
                                    (org-agenda-files '("~/.org/gtd/tasks.org"))
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
                                       (:discard (:anything t))))))))
                           ("T" "Tasks by outline"
                            ((todo ""
                                   ((org-agenda-overriding-header "Tasks outline")
                                    (org-agenda-files '("~/.org/gtd/tasks.org"))
                                    (org-super-agenda-groups
                                     '((:auto-outline-path t)))))))
                           ("i" "Inbox"
                            ((todo ""
                                   ((org-agenda-files '("~/.org/gtd/inbox.org"))
                                    (org-agenda-overriding-header "Items in my inbox")
                                    (org-super-agenda-groups
                                     '((:auto-ts t)))))))
                           ("r" "Thankful reminders"
                            ((todo ""
                                   ((org-agenda-overriding-header "[[~/.org/gtd/reminders.org][Daily reminders]]")
                                    (org-agenda-files '("~/.org/gtd/reminders.org"))))))
                           ("x" "Get to someday"
                            ((tags-todo "-@computer-@email-@configure-@read-@watch-@personal"
                                   ((org-agenda-overriding-header "Projects marked Someday")
                                    (org-agenda-files '("~/.org/gtd/tasks.org"))
                                    (org-super-agenda-groups
                                     '((:auto-ts t))))))))))
