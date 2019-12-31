;;; c:/Users/nmart/.doom.d/settings/config-orgmode_capture.el -*- lexical-binding: t; -*-

(setq org-capture-templates
      '(("g" "Getting things done")
        ("d" "Data Tracker")))

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

*next steps*:
- [ ] %^{next steps}

*** notes
%?"))

(add-to-list 'org-capture-templates
             '("gu" "Task with URL" entry (file"~/.gtd/inbox.org")
"** TODO %^{Description}
:PROPERTIES:
:CREATED:    %U
:END:
:RESOURCES:
- %^L
:END:

*next steps*:
- [ ] %^{next steps}

*** notes
%?"))

(add-to-list 'org-capture-templates
             '("gr" "Task with resources" entry (file"~/.gtd/inbox.org")
"** TODO %^{Description}
:PROPERTIES:
:CREATED:    %U
:END:
:RESOURCES:
- %^L
:END:

*next steps*:
- [ ] %^{next steps}

*** notes
%?"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               Data Trackers                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'org-capture-templates
             '("db" "Big Purchases" table-line (file+headline"~/.gtd/data-tracker.org" "Big Purchases")
               "|  | %^{itemname} | %^{amount} | %^{why?} |" :table-line-pos "II-1" :immediate-finish t))

(add-to-list 'org-capture-templates
             '("ds" "Sugar Intake" table-line (file+headline"~/.gtd/data-tracker.org" "Sugar Intake")
               "|  | %u | %^{itemname} | %^{sugar} |" :table-line-pos "II-1" :immediate-finish t))

(add-to-list 'org-capture-templates
             '("dc" "Calories Burned" table-line (file+headline"~/.gtd/data-tracker.org" "Calories Burned")
               "|  | %u | %^{activity} | %^{calories} | %^{notes} |" :table-line-pos "II-1" :immediate-finish t))
