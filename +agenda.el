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
                                     '((:name "High Priority"
                                              :priority "A"
                                              :order 1)
                                       (:name "Medium Priority"
                                              :priority "B"
                                              :order 2)
                                       (:name "Deadline Due"
                                              :deadline t
                                              :order 3)
                                       (:name "Scheduled"
                                              :scheduled t
                                              :order 4)
                                       (:name "To read"
                                              :tag "@read"
                                              :order 5)
                                       (:name "To watch"
                                              :tag "@watch"
                                              :order 6)
                                       (:name "Call or Message"
                                              :tag "@phone"
                                              :order 7)
                                       (:name "Email"
                                              :tag "@email"
                                              :order 8)
                                       (:name "Stuff to work on"
                                              :tag "@computer"
                                              :order 9)
                                       (:name "Personal Items"
                                              :tag "@personal"
                                              :order 10)
                                       (:name "Play"
                                              :tag "@play"
                                              :order 11)
                                       (:name "Bills"
                                              :tag "@bills"
                                              :order 12)
                                       (:name "Things to purchase"
                                              :tag "@purchase"
                                              :order 20)
                                       (:name "Emacs Stuff"
                                              :tag "@emacs"
                                              :order 100)
                                       (:discard (:scheduled t))))))))
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
