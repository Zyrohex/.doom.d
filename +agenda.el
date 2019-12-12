;;; ~/.doom.d/agenda.el -*- lexical-binding: t; -*-

(after! org-agenda (setq org-agenda-custom-commands
                         '(("t" "Tasks"
                            ((agenda ""
                                     ((org-agenda-overriding-header "My Agenda")
                                      (org-agenda-span 'day)
                                      (org-agenda-start-day (org-today))
                                      (org-agenda-current-span 'day)
                                      (org-agenda-files '("~/.gtd/tasks/"))
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
                             (todo "NOTE"
                                   ((org-agenda-files '("~/.gtd/tasks/"))
                                    (org-agenda-overriding-header "Keep tabs on")
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))
                             (todo "TODO|NEXT|REVIEW|PROJ|DELEGATED"
                                   ((org-agenda-overriding-header "Task list")
                                    (org-agenda-files '("~/.gtd/tasks/"))
                                    (org-super-agenda-groups
                                     '((:name "Critical"
                                              :priority "A"
                                              :order 2)
                                       (:name "Medium Priority"
                                              :priority "B"
                                              :order 3)
                                       (:name "Low priority"
                                              :priority "C"
                                              :order 4)
                                       (:name "Automation"
                                              :regexp "Automation"
                                              :order 5)
                                       (:name "Programming"
                                              :regexp ("Programming" "Python" "Lisp")
                                              :order 6)
                                       (:name "Health Related"
                                              :regexp ("Health" "Running" "run" "Biking" "vitamins")
                                              :order 7)
                                       (:name "Orgmode or Emacs"
                                              :regexp ("emacs" "orgmode" "org-mode" "org mode")
                                              :order 8)
                                       (:name "Emacs"
                                              :tag "@emacs"
                                              :order 29)))))
                            (todo "TODO|NEXT|REVIEW|PROJ|NOTE|DELEGATED"
                                  ((org-agenda-overriding-header "Projects")
                                   (org-agenda-files '("~/.gtd/projects/"))
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
                                    ((org-agenda-files '("~/.gtd/inbox/"))
                                     (org-agenda-overriding-header "What's in my inbox by date created")
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
