;; Place your private configuration here
(load! "+keys") ; Load custom keymaps
(load! "+agenda")
(load! "+publish")
(require 'tiny-menu)


;; Default Settings
(setq doom-font (font-spec :family "Source Code Pro" :size 22)
      doom-big-font (font-spec :family "Source Code Pro" :size 30)
      org-use-speed-commands t
      org-image-actual-width nil
      org-bullets-bullet-list '("✖" "✱")
      +org-export-directory "~/.export/")

(setq org-super-agenda-groups
      '((:name "by top heading"
               :auto-parent t)
        (:discard (:anything t))))

(setq org-archive-location "~/.gtd/archive.org::datetree/"
      org-default-notes-file "~/.gtd/inbox.org"
      projectile-project-search-path '("~/"))

(setq org-directory (expand-file-name "~/.org/")
      org-archive-location "~/.gtd/archive.org::datetree/"
      org-default-notes-file "~/.gtd/inbox.org"
      projectile-project-search-path '("~/"))

(setq org-agenda-files '("~/.gtd/thelist.org" "~/.gtd/someday.org")
      org-agenda-diary-file '("~/.org/diary.org")
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t)

(setq org-refile-targets '((org-agenda-files . (:maxlevel . 6)))
      org-outline-path-complete-in-steps nil
      org-refile-allow-creating-parent-nodes 'confirm)

(setq org-log-state-notes-insert-after-drawers nil
      org-log-into-drawer t
      org-log-done 'note
      org-log-repeat 'time
      org-log-redeadline 'time
      org-log-reschedule 'time)

(setq org-tags-column -80
      org-tag-persistent-alist '(("@email" . ?e) ("@phone" . ?p) ("@work" . ?w) ("@personal" . ?l) ("@read" . ?r) ("@emacs" . ?E) ("@watch" . ?W) ("@computer" . ?c) ("@purchase" . ?P)))

(setq org-link-abbrev-alist
      '(("doom-repo" . "https://github.com/hlissner/doom-emacs/%s")
        ("wolfram" . "https://wolframalpha.com/input/?i=%s")
        ("duckduckgo" . "https://duckduckgo.com/?q=%s")
        ("gmap" . "https://maps.google.com/maps?q=%s")
        ("gimages" . "https://google.com/images?q=%s")
        ("google" . "https://google.com/search?q=")
        ("youtube" . "https://youtube.com/watch?v=%s")
        ("youtu" . "https://youtube.com/results?search_query=%s")
        ("github" . "https://github.com/%s")
        ("attach" . "~/org/.attach/")))

(setq org-todo-keywords
      '((sequence "TODO(t)" "DOING(x!)" "NEXT(n!)" "REFILE(r!)" "DELEGATED(e!)" "SOMEDAY(l!)" "|" "INVALID(I!)" "DONE(d!)"))
      org-todo-keyword-faces
      '(("TODO" :foreground "Dark Orange" :weight bold)
        ("DOING" :foreground "tomato" :weight bold)
        ("NEXT" :foreground "tomato" :weight bold)
        ("DELEGATED" :foreground "tomato" :weight bold)
        ("SOMEDAY" :foreground "yellow" :weight bold)
        ("DONE" :foreground "slategrey" :weight bold)))

(setq org-capture-templates
      '(("h" "Habit" entry (file+olp"~/.gtd/tickler.org" "Habits") ; Habit tracking in org agenda
         "* TODO %?\nSCHEDULED: <%<%Y-%m-%d %a +1d>>\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: TODO\n:LOGGING: DONE(!)\n:END:") ; Default scheduled for daily reminders (+1d) [you can change to weekly (+1w) monthly (+1m) or yearly (+1y) and auto-sets style to "HABIT" with Repeat state to "TODO".
        ("g" "Get Shit Done" entry (file+olp"~/.gtd/tasks/inbox.org" "Inbox") ; Sets all "Get Shit Done" captures to INBOX.ORG
         "* REFILE %? %^g %^{CATEGORY}p\n:PROPERTIES:\n:CREATED: %U\n:END:")
        ("r" "Reference" entry (file"~/.gtd/reference.org")
         "** %?")
        ("e" "Events" entry (file+olp+datetree"~/.gtd/events.org")
         "* %?" :tree-type month)
        ("d" "Diary" entry (file+olp+datetree "~/.gtd/diary.org")
         "** [%<%H:%M>] %?" :tree-type week)
        ("j" "Journal" entry (file+olp+datetree "~/.gtd/journal.org")
         "** [%<%H:%M>] %?%^{ACCOUNT}p%^{SOURCE}p%^{AUDIENCE}p%^{TASK}p%^{TOPIC}p\n:PROPERTIES:\n:CREATED: <%<%Y-%m-%d>>\n:MONTH:    %<%b>\n:WEEK:     %<W%V>\n:DAY:      %<%a>\n:END:\n:LOGBOOK:\n:END:" :tree-type week :clock-in t :clock-resume t)))

(use-package deft
  :bind (("<f8>" . deft))
  :commands (deft deft-open-file deft-new-file-named)
  :config
  (setq deft-directory "~/.references/"
        deft-auto-save-interval 0
        deft-recursive t
        deft-extensions '("md" "txt" "org" "org.txt" "tex")
        deft-use-filter-string-for-filename nil
        deft-use-filename-as-title nil
        deft-markdown-mode-title-level 1
        deft-file-naming-rules '((noslash . "-")
                                 (nospace . "-")
                                 (case-fn . downcase))))

(global-auto-revert-mode t) ;; Auto revert files when file changes detected on disk
(add-to-list 'load-path  "~/.doom.d/modules/") ; Load plain-org-wiki .el module

;; Agenda Custom Commands
(after! org-agenda (setq org-super-agenda-mode t))

;; Elfeed
;(require 'elfeed)
;(require 'elfeed-org)
;(elfeed-org)
;(after! org (setq rmh-elfeed-org-files (list "~/.elfeed/elfeed.org")
;                  elfeed-db-directory "~/.elfeed/"))

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
