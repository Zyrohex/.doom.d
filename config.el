;; Place your private configuration here
(load! "+keys") ; Load custom keymaps
(load! "+agenda")
(load! "+publish")

;; Default Settings
(setq doom-font (font-spec :family "Source Code Pro" :size 22)
      doom-big-font (font-spec :family "Source Code Pro" :size 30)
      org-use-speed-commands t
      org-bullets-bullet-list '("✖" "✱")
      +org-export-directory "~/.export/"

      org-super-agenda-groups
      '((:name "by top heading"
               :auto-parent t)
        (:discard (:anything t)))

      org-archive-location "~/.gtd/archive.org::datetree/"
      org-default-notes-file "~/.gtd/inbox.org"
      projectile-project-search-path '("~/")

      org-directory (expand-file-name "~/.org/")
      org-archive-location "~/.gtd/archive.org::datetree/"
      org-default-notes-file "~/.gtd/inbox.org"
      projectile-project-search-path '("~/")

      org-agenda-files '("~/.gtd/thelist.org" "~/.gtd/someday.org")
      org-agenda-diary-file '("~/.org/diary.org")
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t

      org-refile-targets '((org-agenda-files . (:maxlevel . 6)))
      org-outline-path-complete-in-steps nil
      org-refile-allow-creating-parent-nodes 'confirm

      org-log-state-notes-insert-after-drawers nil
      org-log-into-drawer t
      org-log-done 'note
      org-log-repeat 'time
      org-log-redeadline 'time
      org-log-reschedule 'time

      org-tags-column -80
      org-tag-persistent-alist '(("@email" . ?e) ("@phone" . ?p) ("@work" . ?w) ("@personal" . ?l) ("@read" . ?r) ("@emacs" . ?E) ("@watch" . ?W) ("@computer" . ?c) ("@purchase" . ?P))

      org-todo-keywords
      '((sequence "TODO(t)" "DOING(x!)" "NEXT(n!)" "DELEGATED(e!)" "SOMEDAY(l!)" "|" "INVALID(I!)" "DONE(d!)"))
      org-todo-keyword-faces
      '(("TODO" :foreground "tomato" :weight bold)
        ("DOING" :foreground "tomato" :weight bold)
        ("NEXT" :foreground "tomato" :weight bold)
        ("DELEGATED" :foreground "tomato" :weight bold)
        ("SOMEDAY" :foreground "tomato" :weight bold)
        ("DONE" :foreground "slategrey" :weight bold))

      org-capture-templates
      '(("h" "Habit" entry (file+olp"~/.gtd/tickler.org" "Habits") ; Habit tracking in org agenda
         "* TODO %?\nSCHEDULED: <%<%Y-%m-%d %a +1d>>\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: TODO\n:LOGGING: DONE(!)\n:END:") ; Default scheduled for daily reminders (+1d) [you can change to weekly (+1w) monthly (+1m) or yearly (+1y) and auto-sets style to "HABIT" with Repeat state to "TODO".
        ("g" "Get Shit Done" entry (file+olp"~/.gtd/inbox.org" "Inbox") ; Sets all "Get Shit Done" captures to INBOX.ORG
         "* TODO %? %^g %^{CATEGORY}p\n:PROPERTIES:\n:CREATED: %U\n:END:")
        ("r" "Reference" entry (file"~/.gtd/reference.org")
         "** %?")
        ("e" "Elfeed" entry (file+olp"~/.org/elfeed.org" "Dump")
         "* [[%x]]")
        ("d" "Diary" entry (file+olp+datetree "~/.gtd/diary.org")
         "** [%<%H:%M>] %?" :tree-type week)
        ("j" "Journal" entry (file+olp+datetree "~/.gtd/journal.org")
         "** [%<%H:%M>] %?%^{ACCOUNT}p%^{SOURCE}p%^{AUDIENCE}p%^{TASK}p%^{TOPIC}p\n:PROPERTIES:\n:CREATED: <%<%Y-%m-%d>>\n:MONTH:    %<%b>\n:WEEK:     %<W%V>\n:DAY:      %<%a>\n:END:\n:LOGBOOK:\n:END:" :tree-type week :clock-in t :clock-resume t))


      deft-extensions
      '("org" "md" "txt")
      deft-recursive t
      deft-directory "~/.notes"
      deft-use-filename-as-title t
      deft-auto-save-interval 0)

(display-time-mode 1) ;; Display time and System Load on modeline
(global-auto-revert-mode t) ;; Auto revert files when file changes detected on disk
(add-to-list 'load-path  "~/.doom.d/modules/") ; Load plain-org-wiki .el module
(require 'org-clock-switch)

;; Agenda Custom Commands
(after! org-agenda (setq org-super-agenda-mode t))

;; Elfeed
;(require 'elfeed)
;(require 'elfeed-org)
;(elfeed-org)
;(after! org (setq rmh-elfeed-org-files (list "~/.elfeed/elfeed.org")
;                  elfeed-db-directory "~/.elfeed/"))

;; Popup Rules
;(set-popup-rule! "^\\*Org Agenda" :side 'right :size 80 :select t :ttl 3)
;(set-popup-rule! "^CAPTURE.*\\.org$" :side 'bottom :size 0.50 :select t :ttl nil)
;(set-popup-rule! "^\\*org-brain" :side 'bottom :size 1.00 :select t :ttl nil)
;(set-popup-rule! "^\\*Org-QL" :side 'right :size 1.00 :select t :ttl nil)
;(set-popup-rule! "^\\*Deft*" :side 'right :size 1.00 :select t :ttl nil)
;(set-popup-rule! "^\\*Deadgrep*" :side 'right :size 1.00 :select t :ttl nil)
;(set-popup-rule! "^\\*Info*" :side 'right :size 1.00 :select t :ttl nil)
;(set-popup-rule! "^\\*Helm*" :side 'bottom :size 0.30 :select t :ttl nil)
;(set-popup-rule! "^\\*Docker*" :side 'bottom :size 0.30 :select t :ttl nil)
;(set-popup-rule! "^\\*Calc*" :side 'bottom :size 0.20 :select t :ttl nil)
;(set-popup-rule! "^\\*Eww*" :side 'right :size 1.00 :select t :ttl nil)

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
