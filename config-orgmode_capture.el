;;; c:/Users/nmart/.doom.d/settings/config-orgmode_capture.el -*- lexical-binding: t; -*-

(setq org-capture-templates
      '(("g" "Getting things done")
        ("r" "References & Notes")
        ("d" "Data Tracker")))

(add-to-list 'org-capture-templates
             '("gx" "Recurring Task" entry (file "~/.gtd/recurring.org")
"* TODO %^{description}
:PROPERTIES:
:CREATED:    %U
:END:
** notes
%?"))
(add-to-list 'org-capture-templates
             '("gp" "Project" entry (file "~/.gtd/projects.org")
"* TODO %^{Description}
:PROPERTIES:
:END:
:RESOURCES:
- [[%^{link}][%^{description}]]
:END:

*Requirements*:
%^{requirements}

** TODO %^{task1}%?"))

(add-to-list 'org-capture-templates
             '("gt" "Task" entry (file"~/.gtd/inbox.org")
"** TODO %^{description}
:PROPERTIES:
:CREATED:    %U
:END:

*links*:
%^L

*next steps*:
- [ ] %^{next steps}

*** notes
%?"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                            References & Notes                                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'org-capture-templates
             '("rr" "Reference"  entry (file"~/.gtd/references.org")
               "* %^{description}\n\n*links*:\n%^L\n\n%?"))
(add-to-list 'org-capture-templates
             '("rs" "Reference with code block" entry (file"~/.gtd/references.org")
               "* %^{description}\n#+BEGIN_SRC %^{lang}\n%x\n#+END_SRC\n:END:\n%?"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                            Data Trackers                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'org-capture-templates
             '("db" "Big Purchases" table-line (file+headline"~/.gtd/data-tracker.org" "Big Purchases")
               "|  | %^{itemname} | %^{amount} | %^{why?} |" :table-line-pos "II-1" :immediate-finish t))

(add-to-list 'org-capture-templates
             '("ds" "Sugar Intake" table-line (file+headline"~/.gtd/data-tracker.org" "Sugar Intake")
               "|  | %u | %^{itemname} | %^{sugar} |" :table-line-pos "II-1" :immediate-finish t))

(add-to-list 'org-capture-templates
             '("dc" "Calories Burned" table-line (file+headline"~/.gtd/data-tracker.org" "Calories Burned")
               "|  | %u | %^{activity} | %^{calories} | %^{notes} |" :table-line-pos "II-1" :immediate-finish t))
