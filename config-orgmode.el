;;; c:/Users/nmart/.doom.d/org-settings.el -*- lexical-binding: t; -*-

;; Agenda Custom Commands
(after! org-agenda (setq org-super-agenda-mode t))

(setq org-refile-targets '((org-agenda-files . (:maxlevel . 6)))
      org-outline-path-complete-in-steps nil
      org-refile-allow-creating-parent-nodes 'confirm)

(add-to-list 'org-emphasis-alist
             '("_" (:foreground "red")))

(setq org-scheduled-delay-days 0
      org-scheduled-past-days 10)

(setq org-log-state-notes-insert-after-drawers nil
      org-log-into-drawer t
      org-log-done 'note
      org-log-repeat 'time
      org-log-redeadline 'time
      org-log-reschedule 'time)

(setq org-tags-column -80
      org-tag-persistent-alist '(("@email" . ?e) ("@write" . ?W) ("@phone" . ?p) ("@configure" . ?C) ("@work" . ?w) ("@personal" . ?l) ("@read" . ?r) ("@watch" . ?W) ("@computer" . ?c) ("@bills" . ?b) ("@purchase" . ?P)))

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
      '((sequence "TODO(t)" "REVIEW(R!)" "[-](-!)" "WAITING(w!)" "IN-PROGRESS(s!)" "NEXT(n!)" "DELEGATED(e!)" "SOMEDAY(l!)" "|" "INVALID(I!)" "DONE(d!)")))

(setq org-todo-keyword-faces
      '(("TODO" :foreground "tomato" :background "GhostWhite" :weight bold)
        ("REVIEW" :foreground "royal blue" :background "GhostWhite" :weight bold)
        ("WAITING" :foreground "light sea green" :background "GhostWhite" :weight bold)
        ("IN-PROGRESS" :foreground "Turquoise" :background "GhostWhite" :weight bold)
        ("NEXT" :foreground "violet red" :background "GhostWhite" :weight bold)
        ("[-]" :foreground "violet red" :background "GhostWhite" :weight bold)
        ("DELEGATED" :foreground "sky blue" :background "GhostWhite" :weight bold)
        ("SOMEDAY" :foreground "yellow" :background "GhostWhite" :weight bold)
        ("DONE" :foreground "slategrey" :background "GhostWhite" :weight bold)))

(setq org-use-speed-commands t
      org-directory "~/.notes"
      org-image-actual-width nil
      org-bullets-bullet-list '("✖" "✚")
      +org-export-directory "~/.export/")

(add-to-list 'org-export-backends 'pandoc)
(add-to-list 'org-export-backends 'pdf)

;      '((ascii md pandoc markdown html latex)))

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

;(setq org-latex-tables-centered t
;      org-latex-default-class "koma-article")
