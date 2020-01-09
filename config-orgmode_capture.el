;;; c:/Users/nmart/.doom.d/settings/config-orgmode_capture.el -*- lexical-binding: t; -*-

(setq org-capture-templates
      '(("g" "Getting things done")
        ("r" "References & Notes")
        ("d" "Diary")
        ("p" "Graph Data")
        ("t" "Data Tracker")))

(add-to-list 'org-capture-templates
             '("gx" "Recurring Task" entry (file "~/.gtd/recurring.org")
"* TODO %^{description}
:PROPERTIES:
:CREATED:    %U
:WHO:     %^{who}
:WHAT:    %^{what}
:WHERE:   %^{where}
:WHY:     %^{why}
:END:
:RESOURCES:
%^{url}
:END:

** notes
%?
"))
(add-to-list 'org-capture-templates
             '("gp" "Project" entry (file "~/.gtd/projects.org")
"* TODO %^{Description}
:PROPERTIES:
:SUBJECT: %^{subject}
:GOAL:    %^{goal}
:END:
:RESOURCES:
[[%^{url}]]
:END:

*requirements*:
%^{requirements}

*notes*:
%?

** TODO %^{task1}
"))

(add-to-list 'org-capture-templates
             '("gt" "Task" entry (file"~/.gtd/inbox.org")
"** TODO %^{description}
:PROPERTIES:
:CREATED:    %U
:GOAL:    %^{goal}
:WHO:     %^{who}
:WHAT:    %^{what}
:WHY:     %^{why}
:WHERE:   %^{where}
:END:
:RESOURCES:
[[%^{url}]]
:END:

*next steps*:
- [ ] %^{next steps}

*** notes
%?"))

(add-to-list 'org-capture-templates
             '("gr" "Reminders/Thanksful" entry (file"~/.gtd/reminders.org")
               "* [-] %^{reminder}" :immediate-finish t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                            References & Notes                                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'org-capture-templates
             '("rr" "Reference"  entry (file"~/.gtd/references.org")
"* %^{description}
:RESOURCES:
[[%^{url}]]
:END:

%?"))
(add-to-list 'org-capture-templates
             '("rs" "Reference + dump clipboard to srcblock" entry (file"~/.gtd/references.org")
"* %^{description}

#+BEGIN_SRC %^{lang}
%x
#+END_SRC

%?"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                            Data Trackers                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'org-capture-templates
             '("dt" "Journal Thoughs" entry (file+datetree"~/.gtd/journal.org")
"* %^{description}
:PROPERTIES:
:MOOD:    %^{mood}
:END:
%?"))

(add-to-list 'org-capture-templates
             '("dd" "Journal with Data" plain (file+olp"~/.gtd/diary.org" "Data Tracker")
"%<%Y-%m-%d> %<%H:%M> %^{activity|walking|sugar|calories|bicycle|running|eating out|drinks cost|food cost} %^{value}" :immediate-finish t))
