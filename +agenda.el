;;; ~/.doom.d/agenda.el -*- lexical-binding: t; -*-

(after! org-agenda (setq org-agenda-custom-commands
                         '(("p" "Tasks by Parent"
                             ((todo "TODO|DOING|NEXT|DELEGATED|REMINDERS"
                                   ((org-agenda-overriding-header "Tasks on my action list")
                                    (org-agenda-prefix-format " %(my-agenda-prefix) ")
                                    (org-agenda-files '("~/.gtd/tasks/"))
                                    (org-tags-match-list-sublevels 'indented)
                                    (org-super-agenda-groups
                                     '((:name "Critical"
                                              :priority "A"
                                              :order 2)
                                       (:name "Low priority"
                                              :priority "C"
                                              :order 10)
                                       (:name "Tasks due"
                                              :deadline t
                                              :order 11)
                                       (:name "Scheduled Tasks"
                                              :scheduled t
                                              :order 12)
                                       (:name "Tasks"
                                              :category "Tasks I need to complete"
                                              :order 50)
                                       (:name "Items on my list for studying"
                                              :category "Learning"
                                              :order 51)
                                       (:name "Books to read"
                                              :category "Reading"
                                              :order 52)
                                       (:name "Form into habits"
                                              :habit t
                                              :order 1)))))
                             (todo "TODO|NEXT|DOING"
                                   ((org-agenda-overriding-header "My projects")
                                    (org-agenda-prefix-format " %(my-agenda-prefix) ")
                                    (org-tags-match-list-sublevels 'indented)
                                    (org-agenda-files '("~/.gtd/projects/"))
                                    (org-super-agenda-groups
                                     '((:auto-category t)))))))
                           ("r" "References"
                            ((todo ""
                                   ((org-agenda-prefix-format " %(my-agenda-prefix) ")
                                    (org-agenda-files '("~/.references/"))
                                    (org-agenda-overriding-header "TODO Items for References")
                                    (org-tags-match-list-sublevels 'indented)
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))))
                           ("i" "Inbox"
                            ((todo "REFILE"
                                   ((org-agenda-files '("~/.gtd/tasks/"))
                                    (org-agenda-overriding-header "What's in my inbox by date created")
                                    (org-super-agenda-groups
                                     '((:name none
                                              :auto-ts t)))))))
                           ("x" "Get to someday"
                            ((todo "SOMEDAY"
                                   ((org-agenda-overriding-header "Things I need to get to someday")
                                    (org-agenda-files '("~/.gtd/tasks/"))
                                    (org-super-agenda-groups
                                     '((:auto-parent t))))))))))
