;;; ~/.doom.d/agenda.el -*- lexical-binding: t; -*-

(after! org-agenda (setq org-agenda-custom-commands
                         '(("t" "Tasks"
                            ((agenda ""
                                     ((org-agenda-overriding-header "My Agenda")
                                      (org-agenda-span 'day)
                                      (org-agenda-start-day (org-today))
                                      (org-agenda-current-span 'day)
                                      (org-agenda-files '("~/.gtd/tasks/" "~/.gtd/projects/"))
                                      (org-super-agenda-groups
                                       '((:name "Habits"
                                                :habit t
                                                :order 5)
                                         (:name "On Calendar"
                                                :time-grid t
                                                :order 1)
                                         (:name "Deadline Approaching"
                                                :deadline t
                                                :order 2)
                                         (:name "Upcoming"
                                                :scheduled t
                                                :order 3)))))
                             (todo ""
                                   ((org-agenda-overriding-header "Tasks on my action list")
;                                    (org-agenda-prefix-format " %(my-agenda-prefix) ")
                                    (org-agenda-files '("~/.gtd/tasks/"))
;                                    (org-tags-match-list-sublevels 'indented)
                                    (org-super-agenda-groups
                                     '((:name "Keep an eye"
                                              :todo "NOTE"
                                              :order 1)
                                       (:name "Critical"
                                              :priority "A"
                                              :order 2)
                                       (:name "Medium Priority"
                                              :priority "B"
                                              :order 3)
                                       (:name "Low priority"
                                              :priority "C"
                                              :order 4)
                                       (:name "Personal Items"
                                              :tag "@personal"
                                              :order 21)
                                       (:name "Email"
                                              :tag "@email"
                                              :order 22)
                                       (:name "Call"
                                              :tag "@phone"
                                              :order 23)
                                       (:name "Work Related"
                                              :tag "@work"
                                              :order 24)
                                       (:name "Read"
                                              :tag "@read"
                                              :order 25)
                                       (:name "Watch"
                                              :tag "@watch"
                                              :order 26)
                                       (:name "Computer"
                                              :tag "@computer"
                                              :order 27)
                                       (:name "Purchase"
                                              :tag "@purchase"
                                              :order 28)
                                       (:name "Emacs"
                                              :tag "@emacs"
                                              :order 29)))))
                            (todo ""
                                  ((org-agenda-overriding-header "Projects")
                                   (org-agenda-files '("~/.gtd/projects/"))
                                   (org-super-agenda-groups
                                    '((:auto-category t)))))
                            (todo ""
                                  ((org-agenda-overriding-header "Things to remember")
                                   (org-agenda-files '("~/.gtd/remember.org"))
                                   (org-super-agenda-groups
                                    '((:auto-parent t)))))))
                           ("h" "Habit Tracker"
                            ((agenda ""
                                     ((org-agenda-overriding-header "My Habits tracker")
                                      (org-agenda-files '("~/.gtd/habits/"))
                                      (org-super-agenda-groups
                                       '((:auto-parent t)))))))
                           ("r" "References"
                            ((todo ""
                                   ((org-agenda-files '("~/.references/"))
                                    (org-agenda-overriding-header "TODO Items for References")
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))))
                           ("i" "Inbox"
                            ((todo ""
                                   ((org-agenda-files '("~/.gtd/inbox/inbox.org"))
                                    (org-agenda-overriding-header "What's in my inbox by date created")
                                    (org-super-agenda-groups
                                     '((:name none
                                              :auto-ts t)))))))
                           ("x" "Get to someday"
                            ((todo ""
                                   ((org-agenda-overriding-header "Things I need to get to someday")
                                    (org-agenda-files '("~/.gtd/inbox/someday.org"))
                                    (org-super-agenda-groups
                                     '((:auto-parent t))))))))))
