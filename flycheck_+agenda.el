;;; ~/.doom.d/agenda.el -*- lexical-binding: t; -*-

(after! org-agenda (setq org-agenda-custom-commands
                         '(("h" "by Hierarchy"
                            ((todo "TODO|NEXT|DOING"
                                   ((org-agenda-overriding-header "Next up or TODO Tasks")
                                    (org-agenda-files '("~/.gtd/thelist.org" "~/.gtd/projects.org"))
                                    (org-agenda-prefix-format " %(my-agenda-prefix) ")
                                    (org-tags-match-list-sublevels 'indented)
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))
                             (agenda "" ((org-agenda-span 'day)
                                         (org-agenda-start-day (org-today))
                                         (org-super-agenda-groups
                                          '((:name "Habits"
                                                   :habit t)
                                            (:name "Deadline"
                                                   :deadline t)
                                            (:name "Scheduled"
                                                   :scheduled t)))))))
                           ("r" "References Tasks"
                            ((todo ""
                                   ((org-agenda-prefix-format " %(my-agenda-prefix) ")
                                    (org-agenda-files '("~/.gtd/reference.org"))
                                    (org-agenda-overriding-header "TODO Items for References")
                                    (org-tags-match-list-sublevels 'indented)
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))))
                           ("q" "Notes Tasks"
                            ((todo ""
                                   ((org-agenda-prefix-format " %(my-agenda-prefix) ")
                                    (org-agenda-files (list "~/.notes"))
                                    (org-agenda-overriding-header "TODO Items in Notes")
                                    (org-tags-match-list-sublevels 'indented)
                                    (org-super-agenda-groups
                                     '((:auto-dir-name t)))))))
                           ("i" "Inbox"
                            ((todo ""
                                   ((org-agenda-files '("~/.gtd/inbox.org"))
                                    (org-agenda-overriding-header "What's in my inbox by date created")
                                    (org-super-agenda-groups
                                     '((:name none
                                              :auto-ts t)))))))
                           ("x" "Get to someday"
                            ((todo ""
                                   ((org-agenda-overriding-header "Things I need to get to someday")
                                    (org-agenda-files '("~/.gtd/someday.org"))
                                    (org-super-agenda-groups
                                     '((:name none
                                              :auto-parent t)
                                       (:discard (:anything t)))))))))))
