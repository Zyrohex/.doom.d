;;; c:/Users/nmart/.doom.d/config-orgmode.el -*- lexical-binding: t; -*-

;(setq org-use-speed-commands t
(setq org-directory "~/.org/"
      org-image-actual-width nil
      ;org-bullets-bullet-list '("✖" "✚")
      +org-export-directory "~/.export/")

(setq org-refile-targets '((org-agenda-files . (:maxlevel . 6)))
      org-hide-emphasis-markers nil
      org-outline-path-complete-in-steps nil
      org-refile-allow-creating-parent-nodes 'confirm)

(setq org-log-state-notes-insert-after-drawers nil
      org-log-into-drawer t
      org-log-done 'note
      org-log-repeat 'time
      org-log-redeadline 'time
      org-log-reschedule 'time)

;(setq org-tags-column -80
;      org-tag-groups-alist
;      org-tag-persistent-alist '(("@email" . ?e) ("@write" . ?W) ("@phone" . ?p) ("@configure" . ?C) ("@work" . ?w) ("@personal" . ?l) ("@read" . ?r) ("@watch" . ?W) ("@computer" . ?c) ("@bills" . ?b) ("@purchase" . ?P)))

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

(after! org (setq org-todo-keywords
      '((sequence "TODO(t)" "WAITING(w!)" "IN-PROGRESS(s!)" "NEXT(n!)" "|" "INVALID(I!)" "DONE(d!)"))))

(after! org (setq org-todo-keyword-faces
      '(("TODO" :foreground "tomato" :weight bold)
        ("REVIEW" :foreground "royal blue" :weight bold)
        ("WAITING" :foreground "light sea green" :weight bold)
        ("IN-PROGRESS" :foreground "Turquoise" :weight bold)
        ("NEXT" :foreground "violet red" :weight bold)
        ("[-]" :foreground "violet red" :weight bold)
        ("DELEGATED" :foreground "sky blue" :weight bold)
        ("SOMEDAY" :foreground "yellow" :weight bold)
        ("DONE" :foreground "slategrey" :weight bold))))

(after! org (add-to-list 'org-export-backends 'pandoc))
(after! org (add-to-list 'org-export-backends 'pdf))

(setq org-html-head-include-scripts t
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

(setq org-archive-location "~/.org/gtd/archive.org::datetree/"
      org-default-notes-file "~/.org/gtd/inbox.org"
      projectile-project-search-path '("~/"))

(setq org-agenda-files '("~/.org/gtd/" "~/.org/notes/")
      org-agenda-diary-file "~/.org/diary.org"
      org-agenda-use-time-grid nil
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-habit-show-habits t)
