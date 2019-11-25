;;; ~/.doom.d/agenda.el -*- lexical-binding: t; -*-

(after! org-agenda (setq org-agenda-custom-commands
                         '(("p" "Tasks by Parent"
                            ((todo "TODO|NEXT|DOING"
                                   ((org-agenda-overriding-header "Tasks")
                                    (org-agenda-prefix-format " %(my-agenda-prefix) ")
                                    (org-tags-match-list-sublevels 'indented)
                                    (org-super-agenda-groups
                                     '((:auto-parent t)))))))
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
