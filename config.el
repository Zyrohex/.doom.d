;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;(load! "+ui") ; Load custom theme for DOOM
(load! "+keys") ; Load custom keymaps

;; Default Settings
(setq tool-bar-mode 1)
(setq doom-font (font-spec :family "Source Code Pro" :size 18)) ; Configure Default font
(setq org-bullets-bullet-list '("#"))
(setq +org-export-directory "~/.org/.export/")
(display-time-mode 1) ;; Display time and System Load on modeline
(global-auto-revert-mode t) ;; Auto revert files when file changes detected on disk
(add-to-list 'org-modules 'org-habit t) ; Enable Emacs to track habits

;; Load custom modules
(add-to-list 'load-path  "~/.doom.d/modules/") ; Load plain-org-wiki .el module

;; Load Wiki Module
(require 'plain-org-wiki)
(setq plain-org-wiki-directory "~/.org/wiki")

; Live Color
(require 'my-live-face-color-changer)

;; Load Clock Switch
(require 'org-clock-switch) ; Allows hot swapping to previous tasks that are stored in the clock history

;; Capture Templates
(setq org-capture-templates
                  '(("h" "Habit" entry (file+olp"~/.org/tickler.org" "Habits") ; Habit tracking in org agenda
                     "* TODO %?\nSCHEDULED: <%<%Y-%m-%d %a +1d>>\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: TODO\n:LOGGING: DONE(!)\n:END:") ; Default scheduled for daily reminders (+1d) [you can change to weekly (+1w) monthly (+1m) or yearly (+1y) and auto-sets style to "HABIT" with Repeat state to "TODO".
                    ("g" "Get Shit Done" entry (file+olp"~/.org/inbox.org" "Inbox") ; Sets all "Get Shit Done" captures to INBOX.ORG
                     "* SOMEDAY %? %^g %^{CATEGORY}p\n:PROPERTIES:\n:CREATED: %U\n:END:")
                    ("r" "Resources" entry (file+olp"~/.org/Resources.org" "Resources")
                     "* [[%^{URL}][%^{DESCRIPTION}]] %^{CATEGORY}p %^{SUBJECT}p")
                    ("e" "Elfeed" entry (file+olp"~/.org/elfeed.org" "Dump")
                     "* [[%x]]")
                    ("j" "Journal" entry (file+olp+datetree "~/.org/journal.org")
                     "** [%<%H:%M>] %? %^g %^{TOPIC}p %^{CATEGORY}p\n:LOGBOOK:\n:END:" :tree-type week :clock-in t :clock-resume t)))

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
      '(("n" "Next Actions"
         ((agenda "" ((org-agenda-span 'day)
                      (org-agenda-start-day (org-today))
                      (org-super-agenda-groups
                       '((:name "Today"
                                :time-grid t
                                :order 1)
                         (:name "Habits"
                                :habit t
                                :order 2)
                         (:name "Scheduled"
;                                :deadline future
;                                :deadline past
;                                :scheduled future
;                                :scheduled past
                                :date t
                                :order 3)
                         (:discard (:anything t))))))
          (todo "TODO|NEXT|"
                ((org-agenda-overriding-header "Next Actions")
                 (org-agenda-files '("~/.org/thelist.org"))
                 (org-super-agenda-groups
                  '((:auto-parent t)))))))
        ("p" "All Tasks by Parents"
         ((todo "TODO"
                ((org-agenda-overriding-header "Projects by Parent Header")
                 (org-super-agenda-groups
                  '((:auto-category t)))))))
        ("r" "Inbox Review"
         ((todo ""
                ((org-agenda-files '("~/.org/inbox.org"))
                 (org-agenda-overriding-header "What's in my inbox by date created")
                 (org-super-agenda-groups
                  '((:name none
                           :auto-ts t)))))))
        ("x" "Get to someday"
         ((todo "SOMEDAY"
                ((org-agenda-overriding-header "Things I need to get to someday")
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
      org-archive-location "~/.org/archive.org::datetree/"
      org-default-notes-file "~/.org/inbox.org"
      projectile-project-search-path '("~/.org/"))

;; Elfeed
(require 'elfeed)
(require 'elfeed-org)
(elfeed-org)
(after! org (setq rmh-elfeed-org-files (list "~/.org/elfeed.org")
                  elfeed-db-directory "~/.elfeed/"))

;; Deft
(require 'deft)
(setq deft-extension
      '("org" "md" "txt") ; Extensions for deft files
      deft-recursive t ; Nil = Recursive in directories
      deft-directory "~/.org/notes/" ; Directory where your DEFT notes are saved
      deft-use-filename-as-title t ; Configure DEFT to use file name as your in-buffer title
      deft-auto-save-interval 0) ; Auto save file after x minutes

;; Popup Rules
(set-popup-rule! "^\\*Org Agenda" :side 'right :size 80 :select t :ttl 3)
(set-popup-rule! "^CAPTURE.*\\.org$" :side 'bottom :size 0.50 :select t :ttl nil)
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
(setq org-agenda-files (list "~/.org/")
      org-agenda-skip-scheduled-if-done t ; Nil = Show scheduled items in agenda when they are done
      org-agenda-skip-deadline-if-done t) ; Nil = Show deadlines when the corresponding item is done

;; Tags
(setq org-tags-column -80 ; Sets tags so many characters away from headings
      org-tag-persistent-alist '(("@email" . ?e) ("@phone" . ?p) ("@work" . ?w) ("@personal" . ?l) ("@config" . ?c) ("@elfeed" . ?f) ("@read" . ?r) ("@emacs" . ?E) ("@watch" . ?W)))

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
