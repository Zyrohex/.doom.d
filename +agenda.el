;;; ~/.doom.d/agenda.el -*- lexical-binding: t; -*-

(after! org-agenda (setq org-agenda-custom-commands
                         '(("t" "Tasks"
                            ((agenda ""
                                     ((org-agenda-overriding-header "My Agenda")
                                      (org-agenda-files '("~/.gtd/tasks/"))
                                      (org-super-agenda-groups
                                       '((:name "Habits"
                                                :habit t
                                                :order 5)
                                         (:name ""
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
                                    (org-agenda-prefix-format " %(my-agenda-prefix) ")
                                    (org-agenda-files '("~/.gtd/tasks/"))
                                    (org-tags-match-list-sublevels 'indented)
                                    (org-super-agenda-groups
                                     '((:name "Critical"
                                              :priority "A"
                                              :order 1)
                                       (:name "Medium Priority"
                                              :priority "B"
                                              :order 2)
                                       (:name "Low priority"
                                              :priority "C"
                                              :order 10)
                                       (:name "Tasks with deadlines"
                                              :deadline t
                                              :order 11)
                                       (:name "Scheduled Tasks"
                                              :scheduled t
                                              :order 12)
                                       (:name "Books to read"
                                              :category "Reading"
                                              :order 52)))))
                            (todo ""
                                  ((org-agenda-overriding-header "Projects")
                                   (org-agenda-files '("~/.gtd/projects/"))
                                   (org-super-agenda-groups
                                    '((:auto-category t)))))))
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
