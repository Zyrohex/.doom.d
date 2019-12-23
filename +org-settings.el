;;; c:/Users/nmart/.doom.d/org-settings.el -*- lexical-binding: t; -*-

;; Agenda Custom Commands
(after! org-agenda (setq org-super-agenda-mode t))

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
      org-tag-persistent-alist '(("@email" . ?e) ("@write" . ?W) ("@phone" . ?p) ("@work" . ?w) ("@personal" . ?l) ("@read" . ?r) ("@emacs" . ?E) ("@watch" . ?W) ("@computer" . ?c) ("@purchase" . ?P)))

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
      '((sequence "TODO(t)" "REVIEW(R!)" "WAITING(w!)" "STARTED(s!)" "NEXT(n!)" "DELEGATED(e!)" "SOMEDAY(l!)" "|" "INVALID(I!)" "DONE(d!)"))
      org-todo-keyword-faces
      '(("TODO" :foreground "tomato" :weight bold)
        ("REVIEW" :foreground "royal blue" :weight bold)
        ("WAITING" :foreground "Green Yellow" :weight bold)
        ("STARTED" :foreground "snow" :weight bold)
        ("NEXT" :foreground "tomato" :weight bold)
        ("DELEGATED" :foreground "tomato" :weight bold)
        ("SOMEDAY" :foreground "yellow" :weight bold)
        ("DONE" :foreground "slategrey" :weight bold)))

(setq org-capture-templates
      '(("h" "Habit" entry (file"~/.gtd/habit.org") ; Habit tracking in org agenda
         "* TODO %?\nSCHEDULED: <%<%Y-%m-%d %a +1d>>\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: TODO\n:LOGGING: DONE(!)\n:END:") ; Default scheduled for daily reminders (+1d) [you can change to weekly (+1w) monthly (+1m) or yearly (+1y) and auto-sets style to "HABIT" with Repeat state to "TODO".
        ("g" "Get Shit Done" entry (file"~/.gtd/inbox.org") ; Sets all "Get Shit Done" captures to INBOX.ORG
         "* TODO %? %^{Group-ID}p\n:PROPERTIES:\n:CREATED: %U\n:END:")
        ("c" "Conversations" entry (file+olp+datetree "~/.gtd/conversations.org")
         "** %?%^{PERSON}p\n:PROPERTIES:\n:CREATED: <%<%Y-%m-%d>>\n:END:\n:LOGBOOK:\n:END:" :tree-type week)
        ("d" "Diary" entry (file+olp+datetree "~/.gtd/journey/diary.org")
         "** [%<%H:%M>] %? %^{SUBJECT}p" :tree-type week)
        ("j" "Journal" entry (file+olp+datetree "~/.gtd/journal.org")
         "** [%<%H:%M>] %?%^{ACCOUNT}p%^{SOURCE}p%^{AUDIENCE}p%^{TASK}p%^{TOPIC}p\n:PROPERTIES:\n:CREATED: <%<%Y-%m-%d>>\n:MONTH:    %<%b>\n:WEEK:     %<W%V>\n:DAY:      %<%a>\n:END:\n:LOGBOOK:\n:END:" :tree-type week :clock-in t :clock-resume t)))

(setq org-use-speed-commands t
      org-image-actual-width nil
      org-bullets-bullet-list '("✖" "✚")
      +org-export-directory "~/.export/")

(setq org-export-backends
      '((pandoc md html latex odt)))

(setq org-html-head "<link rel=\"stylesheet\" href=\"https://fniessen.github.io/org-html-themes/styles/readtheorg/css/htmlize.css\" type=\"text/css\"/>"
      org-html-head "<link rel=\"stylesheet\" href=\"https://fniessen.github.io/org-html-themes/styles/readtheorg/css/readtheorg.css\" type=\"text/css\"/>"
      org-html-head "<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js\"></script>"
      org-html-head "<script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js\"></script>"
      org-html-head "<script type=\"text/javascript\" src=\"https://fniessen.github.io/org-html-themes/styles/lib/js/jquery.stickytableheaders.min.js\"></script>"
      org-html-head-include-scripts t
      org-export-with-toc t
      org-export-with-author t
      org-export-headline-levels 5
      org-export-with-drawers t
      org-export-with-email t
      org-export-with-footnotes t
      org-export-with-latex t
      org-export-with-section-numbers nil
      org-export-with-properties t
      org-export-with-smart-quotes t)

(setq org-plantuml-jar-path "~/.emacs.d/bin/plantuml.jar")

(setq org-archive-location "~/.gtd/archive.org::datetree/"
      org-default-notes-file "~/.gtd/inbox.org"
      projectile-project-search-path '("~/"))

(setq org-directory (expand-file-name "~/.gtd/")
      org-archive-location "~/.gtd/archive.org::datetree/"
      org-default-notes-file "~/.gtd/inbox.org"
      projectile-project-search-path '("~/"))

(setq org-agenda-files '("~/.gtd/tasks/thelist.org" "~/.gtd/inbox/someday.org")
      org-agenda-diary-file '("~/.org/diary.org")
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t)

(setq org-habit-show-habits t)

(add-to-list 'org-babel-load-languages '(dot . t))
(add-to-list 'org-babel-load-languages '(plantuml . t))
(add-to-list 'org-babel-load-languages '(sql .t))
(org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)

(setq org-latex-tables-centered t
      org-latex-default-class "koma-article")
