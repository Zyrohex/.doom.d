;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;(load! "+ui") ; Load custom theme for DOOM
(load! "+keys") ; Load custom keymaps


;; Default Settings
(setq doom-font (font-spec :family "Source Code Pro" :size 22)) ; Configure Default font
(setq org-bullets-bullet-list '("#"))
(setq +org-export-directory "~/Google Drive/org/.export/")
(display-time-mode 1) ;; Display time and System Load on modeline
(global-auto-revert-mode t) ;; Auto revert files when file changes detected on disk
(add-to-list 'org-modules 'org-habit t) ; Enable Emacs to track habits


;; Load custom modules
(add-to-list 'load-path  "~/.doom.d/modules/") ; Load plain-org-wiki .el module

;; Load Wiki Module
(require 'plain-org-wiki)
(setq plain-org-wiki-directory "~/Google Drive/org/wiki")

;; Load Clock Switch
(require 'org-clock-switch) ; Allows hot swapping to previous tasks that are stored in the clock history

;; Capture Templates
(after! org (setq org-capture-templates
                  '(("h" "Habit" entry (file+olp"~/Google Drive/org/gtd/tickler.org" "Habit Tracker") ; Habit tracking in org agenda
                     "* TODO %?\nSCHEDULED: <%<%Y-%m-%d %a +1d>>\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: TODO\n:LOGGING: DONE(!)\n:END:") ; Default scheduled for daily reminders (+1d) [you can change to weekly (+1w) monthly (+1m) or yearly (+1y) and auto-sets style to "HABIT" with Repeat state to "TODO".
                    ("g" "Get Shit Done" entry (file+olp"~/Google Drive/org/gtd/inbox.org" "Inbox") ; Sets all "Get Shit Done" captures to INBOX.ORG
                     "* TODO %? %^g %^{CATEGORY}p")
                    ("r" "Resources" entry (file+olp"~/Google Drive/org/gtd/Resources.org" "Resources")
                     "* [[%^{URL}][%^{DESCRIPTION}]] %^{CATEGORY}p %^{SUBJECT}p")
                    ("e" "Elfeed" entry (file+olp"~/.doom.d/setup/elfeed.org" "Dump")
                     "* [[%x]]")
                    ("J" "Journal" entry (file+olp+datetree "~/Google Drive/org/gtd/journal.org")
                     "** [%<%H:%M>] %? %^g %^{ACCOUNT}p %^{TOPIC}p %^{WHO}p\n:LOGBOOK:\n:END:" :tree-type week :clock-in t :clock-resume t))))

;; TODO Keywords
(after! org (setq org-todo-keywords
                  '((sequence "TODO(t)" "WORKING(W!)" "NEXT(n!)" "DELEGATED(e!)" "LATER(l!)" "|" "INVALID(I!)" "DONE(d!)")))
        org-todo-keyword-faces
        '(("TODO" :foreground "#f5ff36" :weight bold)
          ("WAITING" :foreground "#ffff29" :weight normal :underline t)
          ("WORKING" :foreground "#a8d7ff" :weight normal :underline t)
          ("NEXT" :foreground "#ff3d47" :weight bold)
          ("LATER" :foreground "#29edff" :weight normal)
          ("DONE" :foreground "#50a14f" :weight normal)))

;; Agenda Custom Commands
(after! org-agenda (setq org-super-agenda-mode t))
(after! org-agenda (setq org-agenda-custom-commands
      '(("u" "Start of day review"
         ((agenda ""
                  ((org-agenda-start-day (org-today)))
                  ((org-super-agenda-groups
                    '((:name "Today"
                             :time-grid t)
                      (:name "Soon/Missed"
                             :scheduled past
                             :scheduled future
                             :deadline past
                             :deadline future)
                      (:name "Tasks"
                             :category "Tasks")
                      (:name "Collaboration"
                             :category "Collaborate")
                      (:discard (:anything t))))))))
        ("p" "by Top Headline"
         ((todo ""
                ((org-super-agenda-groups
                  '((:auto-parent t)))))))
        ("?" "by Timestamp"
         ((todo ""
                ((org-super-agenda-groups
                  '((:auto-ts t)))))))
        ("C" "by Category"
         ((todo ""
                ((org-super-agenda-groups
                  '((:auto-category t)))))))
        ("r" "Review"
         ((todo ""
                ((org-agenda-overriding-header "Inbox Review")
                 (org-super-agenda-groups
                  '((:name "Refile"
                           :category "Refile")
                    (:name "Someday"
                           :category "Someday")
                    (:discard (:anything t)))))))))))

;; Super Agenda
(setq org-super-agenda-groups
      '((:name "Due Today"
               :deadline today
               :scheduled today
               :order 2)
        (:name "Overdue or Future"
               :deadline future
               :deadline past
               :scheduled future
               :scheduled past
               :order 3)
        (:name "Tasks"
               :category "Tasks"
               :order 10)
        (:name "Collaborate"
               :category "Collaborate"
               :order 11)
        (:discard (:anything t))))

;; Default Folders
(setq org-directory (expand-file-name "~/Google Drive/org/")
      org-archive-location "~/Google Drive/org/gtd/archive.org::datetree/"
      org-default-notes-file "~/Google Drive/org/gtd/agenda/inbox.org"
      projectile-project-search-path '("~/Google Drive/org/"))

;; Elfeed
(require 'elfeed)
(require 'elfeed-org)
(elfeed-org)
(after! org (setq rmh-elfeed-org-files (list "~/Google Drive/org/elfeed.org")
                  elfeed-db-directory "~/Google Drive/elfeed/"))

;; Deft
(require 'deft)
(setq deft-extension
      '("org" "md" "txt") ; Extensions for deft files
      deft-recursive t ; Nil = Recursive in directories
      deft-directory "~/Google Drive/org/notes/" ; Directory where your DEFT notes are saved
      deft-use-filename-as-title t ; Configure DEFT to use file name as your in-buffer title
      deft-auto-save-interval 0) ; Auto save file after x minutes

;; Popup Rules
(set-popup-rule! "^\\*Org Agenda" :side 'right :size 80 :select t :ttl 3)
(set-popup-rule! "^CAPTURE.*\\.org$" :side 'bottom :size 0.50 :select t :ttl nil)
;(set-popup-rule! "^\\*org-brain" :side 'bottom :size 1.00 :select t :ttl nil)
;(set-popup-rule! "^\\*Deft*" :side 'right :size 1.00 :select t :ttl nil)
;(set-popup-rule! "^\\*Deadgrep*" :side 'right :size 1.00 :select t :ttl nil)
;(set-popup-rule! "^\\*Info*" :side 'right :size 1.00 :select t :ttl nil)
;(set-popup-rule! "^\\*Helm*" :side 'bottom :size 0.30 :select t :ttl nil)
;(set-popup-rule! "^\\*Docker*" :side 'bottom :size 0.30 :select t :ttl nil)
;(set-popup-rule! "^\\*Calc*" :side 'bottom :size 0.20 :select t :ttl nil)
;(set-popup-rule! "^\\*Eww*" :side 'right :size 1.00 :select t :ttl nil)

;; Logging
(setq org-log-state-notes-insert-after-drawers nil
      org-log-done 'note ; Requires notes when task is set to DONE
      org-log-repeat 'time ; Time is logged when repeat tasks are set to DONE
      org-log-redeadline 'time ; Time is logged when task is redeadlined
      org-log-reschedule 'time) ; Time is logged when task is rescheduled

;; Agenda
(setq org-agenda-files (list "~/Google Drive/org/gtd/tasks.org" "~/Google Drive/org/gtd/inbox.org")
      org-agenda-skip-scheduled-if-done t ; Nil = Show scheduled items in agenda when they are done
      org-agenda-skip-deadline-if-done t) ; Nil = Show deadlines when the corresponding item is done

;; Tags
(setq org-tags-column -80 ; Sets tags so many characters away from headings
      org-tag-persistent-alist '(("@email" . ?e) ("@phone" . ?p) ("@work" . ?w) ("@personal" . ?l) ))

;; Refile
(setq org-refile-targets '((org-agenda-files . (:maxlevel . 2)))
      org-refile-use-cache t
      org-refile-history 3
      org-outline-path-complete-in-steps nil ; Nil = Show path outline in one step
      org-refile-allow-creating-parent-nodes 'confirm) ; Create now headings with "\NAME"

;; Org-Board
(setq org-attach-directory "~/.attach"
      +org-export-directory "~/.export")

;; Mind Map
(def-package! org-mind-map
  :init
  (require 'ox-org)
  :config
  (setq org-mind-map-engine "dot")       ; Default. Directed Graph
  ;; (setq org-mind-map-engine "neato")  ; Undirected Spring Graph
  ;; (setq org-mind-map-engine "twopi")  ; Radial Layout
  ;; (setq org-mind-map-engine "fdp")    ; Undirected Spring Force-Directed
  ;; (setq org-mind-map-engine "sfdp")   ; Multiscale version of fdp for the layout of large graphs
  ;; (setq org-mind-map-engine "twopi")  ; Radial layouts
  ;; (setq org-mind-map-engine "circo")  ; Circular Layout
  )
