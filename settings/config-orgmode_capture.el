;;; c:/Users/nmart/.doom.d/settings/config-orgmode_capture.el -*- lexical-binding: t; -*-

;(setq org-capture-templates
;      '(("h" "Habit" entry (file"~/.gtd/habit.org") ; Habit tracking in org agenda
;         "* TODO %?\nSCHEDULED: <%<%Y-%m-%d %a +1d>>\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: TODO\n:LOGGING: DONE(!)\n:END:") ; Default scheduled for daily reminders (+1d) [you can change to weekly (+1w) monthly (+1m) or yearly (+1y) and auto-sets style to "HABIT" with Repeat state to "TODO".
;        ("g" "Get Shit Done" entry (file"~/.gtd/inbox.org") ; Sets all "Get Shit Done" captures to INBOX.ORG
;         "* TODO %? %^{Group-ID}p\n:PROPERTIES:\n:CREATED: %U\n:END:")
;        ("c" "Conversations" entry (file+olp+datetree "~/.gtd/conversations.org")
;         "** %?%^{PERSON}p\n:PROPERTIES:\n:CREATED: <%<%Y-%m-%d>>\n:END:\n:LOGBOOK:\n:END:" :tree-type week)
;        ("d" "Diary" entry (file+olp+datetree "~/.gtd/journey/diary.org")
;         "** [%<%H:%M>] %? %^{SUBJECT}p" :tree-type week)
;        ("j" "Journal" entry (file+olp+datetree "~/.gtd/journal.org")
;         "** [%<%H:%M>] %?%^{ACCOUNT}p%^{SOURCE}p%^{AUDIENCE}p%^{TASK}p%^{TOPIC}p\n:PROPERTIES:\n:CREATED: <%<%Y-%m-%d>>\n:MONTH:    %<%b>\n:WEEK:     %<W%V>\n:DAY:      %<%a>\n:END:\n:LOGBOOK:\n:END:" :tree-type week :clock-in t :clock-resume t)))

(setq org-capture-templates
      '(("g" "Getting things done")
        ("d" "Data Tracker")))

(add-to-list 'org-capture-templates
             '("gp" "Project" entry (file "~/.gtd/projects.org")
"* TODO %^{Description}
:PROPERTIES:
:PROJECT-ID:  %^{id}
:CATEGORY:    %^{category}
:END:
:RESOURCES:
- [[%^{link}][%^{description}]]
** Requirements
%^{requirements}
** TODO %^{task1}%?"))

(add-to-list 'org-capture-templates
             '("gt" "Task" entry (file"~/.gtd/inbox.org")
"** TODO %^{Description}
:PROPERTIES:
:PROJ-ID:    %^{proj-id}
:CATEGORY:   %^{category}
:CREATED:    %U
:END:"))

(add-to-list 'org-capture-templates
             '("gu" "Task with URL" entry (file"~/.gtd/inbox.org")
"** TODO %^{Description}
:PROPERTIES:
:PROJ-ID:    %^{proj-id}
:CATEGORY:   %^{category}
:CREATED:    %U
:END:
:RESOURCES:
- %^L
:END:"))

(add-to-list 'org-capture-templates
             '("gr" "Task with resources" entry (file"~/.gtd/inbox.org")
"** TODO %^{Description}
:PROPERTIES:
:PROJ-ID:    %^{proj-id}
:CATEGORY:   %^{category}
:CREATED:    %U
:END:
:RESOURCES:
- Notes:
  %?
:END:"))


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
