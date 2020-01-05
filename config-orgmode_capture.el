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
             '("tb" "Big Purchases" table-line (file+headline"~/.gtd/data-tracker.org" "Big Purchases")
               "|  | %^{itemname} | %^{amount} | %^{why?} |" :table-line-pos "II-1" :immediate-finish t))

(add-to-list 'org-capture-templates
             '("ts" "Sugar Intake" table-line (file+headline"~/.gtd/data-tracker.org" "Sugar Intake")
               "|  | %u | %^{itemname} | %^{sugar} |" :table-line-pos "II-1" :immediate-finish t))

(add-to-list 'org-capture-templates
             '("tc" "Calories Burned" entry (file+headline"~/.gtd/data-tracker.org" "Calories Burned")
"* [%u] [%\\2] [%\\3] [%\\4]
:PROPERTIES:
:ACTIVITY: %^{activity}
:CALORIES: %^{calories}
:DISTANCE: %^{distance}
:END" :immediate-finish t))

(add-to-list 'org-capture-templates
             '("dt" "Journal Thoughs" entry (file+datetree"~/.gtd/journal.org")
"* %^{description}
:PROPERTIES:
:MOOD:    %^{mood}
:END:
%?"))

(add-to-list 'org-capture-templates
             '("dd" "Journal with Data" plain (file+olp"~/.gtd/diary.org" "Data Tracker")
"%<%Y-%m-%d> %<%H:%M> %^{activity|walking|sugar|calories|bicycle|running|att dps miss|eating out|drinks cost|food cost} %^{value}" :immediate-finish t))
