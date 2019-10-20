;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;(load! "+ui") ; Load custom theme for DOOM
(load! "+keys") ; Load custom keymaps
(load! "+ui2")

;; Default Settings
(setq doom-font (font-spec :family "Fira Code" :size 20)) ; Configure Default font
(setq doom-big-font (font-spec :family "Fira Code" :size 26))
;(setq org-bullets-bullet-list '("#"))
(setq +org-export-directory "~/.org/.export/")
(display-time-mode 1) ;; Display time and System Load on modeline
(global-auto-revert-mode t) ;; Auto revert files when file changes detected on disk
;(add-to-list 'org-modules 'org-habit t) ; Enable Emacs to track habits

;; Load Org Wiki
(add-to-list 'load-path  "~/.doom.d/modules/") ; Load plain-org-wiki .el module
(require 'plain-org-wiki)
(setq plain-org-wiki-directory "~/.notes/")

;; Load Org GTD
(add-to-list 'load-path  "~/.doom.d/modules/") ; Load plain-org-gtd .el module
(require 'plain-org-gtd)
(setq plain-org-gtd-directory "~/.gtd/")

;; Journal
(setq org-journal-dir "~/.gtd/journal"
      org-journal-enable-agenda-integration t
      org-journal-find-file 'find-file
      org-journal-file-format "%b-%Y.org"
      org-journal-file-type 'monthly)

;; Load Clock Switch
(require 'org-clock-switch) ; Allows hot swapping to previous tasks that are stored in the clock history

;; Capture Templates
(setq org-capture-templates
                  '(("h" "Habit" entry (file+olp"~/.gtd/tickler.org" "Habits") ; Habit tracking in org agenda
                     "* TODO %?\nSCHEDULED: <%<%Y-%m-%d %a +1d>>\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: TODO\n:LOGGING: DONE(!)\n:END:") ; Default scheduled for daily reminders (+1d) [you can change to weekly (+1w) monthly (+1m) or yearly (+1y) and auto-sets style to "HABIT" with Repeat state to "TODO".
                    ("g" "Get Shit Done" entry (file+olp"~/.gtd/inbox.org" "Inbox") ; Sets all "Get Shit Done" captures to INBOX.ORG
                     "* TODO %? %^g %^{CATEGORY}p\n:PROPERTIES:\n:CREATED: %U\n:END:")
                    ("r" "Reference" entry (file+olp"~/.gtd/reference.org" "INBOX")
                     "** %?")
                    ("e" "Elfeed" entry (file+olp"~/.org/elfeed.org" "Dump")
                     "* [[%x]]")
                    ("d" "Diary" entry (file+olp+datetree "~/.gtd/diary.org")
                     "** [%<%H:%M>] %?" :tree-type week)
                    ("j" "Journal" entry (file+olp+datetree "~/.gtd/journal.org")
                     "** [%<%H:%M>] %?%^{ACCOUNT}p%^{SOURCE}p%^{AUDIENCE}p%^{TASK}p%^{TOPIC}p\n:PROPERTIES:\n:CREATED: <%<%Y-%m-%d>>\n:MONTH:    %<%b>\n:WEEK:     %<W%V>\n:DAY:      %<%a>\n:END:\n:LOGBOOK:\n:END:" :tree-type week :clock-in t :clock-resume t)))
(add-hook 'org-capture-mode-hook 'delete-other-windows)

;; TODO Keywords
(after! org (setq org-todo-keywords
                  '((sequence "TODO(t)" "NEXT(n!)" "DELEGATED(e!)" "SOMEDAY(l!)" "|" "INVALID(I!)" "DONE(d!)")))
        org-todo-keyword-faces
        '(("TODO" :foreground "#f5ff36" :weight bold)
          ("NEXT" :foreground "#ff3d47" :weight bold)
          ("SOMEDAY" :foreground "#29edff" :weight bold)
          ("DONE" :foreground "#50a14f" :weight normal)))

;; Agenda Custom Commands
(after! org-agenda (setq org-super-agenda-mode t))
(after! org-agenda (setq org-agenda-custom-commands
      '(("h" "by Hierarchy"
         ((agenda "" ((org-agenda-span 'day)
                      (org-agenda-start-day (org-today))
                      (org-agenda-overriding-header "Items on your Calendar")
                      (org-super-agenda-groups
                       '((:name "Appointments"
                                :time-grid t)
                         (:name "Scheduled"
                                :scheduled t)))))
          (todo "TODO|NEXT"
                ((org-agenda-overriding-header "by Parent Tasks")
                 (org-agenda-files '("~/.gtd/thelist.org"))
                 (org-agenda-prefix-format " %(my-agenda-prefix) ")
                 (org-tags-match-list-sublevels 'indented)
                 (org-super-agenda-groups
                  '((:auto-parent t)))))
          (todo "DELEGATED"
                ((org-agenda-overriding-header "Delegated Tasks")
                 (org-agenda-files '("~/.gtd/thelist.org"))
                 (org-agenda-prefix-format " %(my-agenda-prefix) ")
                 (org-tags-match-list-sublevels 'indented)
                 (org-super-agenda-groups
                  '((:auto-parent t)))))))
        ("l" "by Organized List"
         ((agenda "" ((org-agenda-span 'day)
                      (org-agenda-start-day (org-today))
                      (org-agenda-overriding-header "Scheduled Items")
                      (org-super-agenda-groups
                       '((:name "Today"
                                :time-grid t
                                :order 1)
                         (:name "Scheduled"
                                :scheduled t
                                :order 2)))))
          (todo "TODO|NEXT"
                ((org-agenda-prefix-format " %(my-agenda-prefix) ")
                 (org-agenda-files '("~/.gtd/thelist.org"))
                 (org-agenda-overriding-header "Priotized List")
                 (org-tags-match-list-sublevels 'indented)
                 (org-super-agenda-groups
                  '((:name "Important Items"
                           :priority>= "B"
                           :order 1)
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

;; Super Agenda
(setq org-super-agenda-groups
      '((:name "by top heading"
               :auto-parent t)
        (:discard (:anything t))))

;; Default Folders
(setq org-directory (expand-file-name "~/.org/")
      org-archive-location "~/.gtd/archive.org::datetree/"
      org-default-notes-file "~/.gtd/inbox.org"
      projectile-project-search-path '("~/"))

;; Elfeed
(require 'elfeed)
(require 'elfeed-org)
(elfeed-org)
(after! org (setq rmh-elfeed-org-files (list "~/.elfeed/elfeed.org")
                  elfeed-db-directory "~/.elfeed/"))

;; Deft
(require 'deft)
(setq deft-extension
      '("org" "md" "txt") ; Extensions for deft files
      deft-recursive t ; Nil = Recursive in directories
      deft-directory "~/.notes/" ; Directory where your DEFT notes are saved
      deft-use-filename-as-title t ; Configure DEFT to use file name as your in-buffer title
      deft-auto-save-interval 0) ; Auto save file after x minutes

;; Popup Rules
;(set-popup-rule! "^\\*Org Agenda" :side 'right :size 80 :select t :ttl 3)
(set-popup-rule! "^CAPTURE.*\\.org$" :side 'right :size 0.50 :select t :ttl nil)
;(set-popup-rule! "^\\*org-brain" :side 'bottom :size 1.00 :select t :ttl nil)
(set-popup-rule! "^\\*Deft*" :side 'right :size 1.00 :select t :ttl nil)
(set-popup-rule! "^\\*Deadgrep*" :side 'right :size 1.00 :select t :ttl nil)
(set-popup-rule! "^\\*Info*" :side 'right :size 1.00 :select t :ttl nil)
;(set-popup-rule! "^\\*Helm*" :side 'bottom :size 0.30 :select t :ttl nil)
;(set-popup-rule! "^\\*Docker*" :side 'bottom :size 0.30 :select t :ttl nil)
;(set-popup-rule! "^\\*Calc*" :side 'bottom :size 0.20 :select t :ttl nil)
;(set-popup-rule! "^\\*Eww*" :side 'right :size 1.00 :select t :ttl nil)

;; Logging
(setq org-log-state-notes-insert-after-drawers nil
      org-log-into-drawer t
      org-log-done 'note ; Requires notes when task is set to DONE
      org-log-repeat 'time ; Time is logged when repeat tasks are set to DONE
      org-log-redeadline 'time ; Time is logged when task is redeadlined
      org-log-reschedule 'time) ; Time is logged when task is rescheduled

;; Agenda
(setq org-agenda-files '("~/.gtd")
      org-agenda-diary-file '("~/.org/diary.org")
      org-agenda-skip-scheduled-if-done t ; Nil = Show scheduled items in agenda when they are done
      org-agenda-skip-deadline-if-done t) ; Nil = Show deadlines when the corresponding item is done

;; Tags
(setq org-tags-column -80 ; Sets tags so many characters away from headings
      org-tag-persistent-alist '(("@email" . ?e) ("@phone" . ?p) ("@work" . ?w) ("@personal" . ?l) ("@read" . ?r) ("@emacs" . ?E) ("@watch" . ?W) ("@computer" . ?c) ("@purchase" . ?P)))

;; Refile
(setq org-refile-targets '((org-agenda-files . (:maxlevel . 6)))
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
  
(defun org-update-cookies-after-save()
  (interactive)
  (let ((current-prefix-arg '(4)))
    (org-update-statistics-cookies "ALL")))

(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'org-update-cookies-after-save nil 'make-it-local)))

(defun my-agenda-prefix ()
  (format "%s" (my-agenda-indent-string (org-current-level))))

(defun my-agenda-indent-string (level)
  (if (= level 1)
      ""
    (let ((str ""))
      (while (> level 2)
        (setq level (1- level)
              str (concat str "──")))
      (concat str "►"))))
