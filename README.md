

# Doom Settings

    ;;; c:/Users/nmart/.doom.d/settings/config-doom.el -*- lexical-binding: t; -*-
    
    (setq doom-theme 'doom-city-lights)
    
    (setq doom-font (font-spec :family "Source Code Pro" :size 26)
          doom-big-font (font-spec :family "Source Code Pro" :size 32)
          doom-variable-pitch-font (font-spec :family "Fira Code"))


# Orgmode

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
          '((sequence "TODO(t)" "REVIEW(R!)" "WAITING(w!)" "IN-PROGRESS(s!)" "NEXT(n!)" "DELEGATED(e!)" "SOMEDAY(l!)" "|" "INVALID(I!)" "DONE(d!)")))
    
    (setq org-todo-keyword-faces
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
          '((pandoc md html latex)))
    
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


# Agenda Settings

Agenda needs to focus on 4 areas:

1.  Tasks
2.  Projects
3.  Someday
4.  Inbox

    ;;; ~/.doom.d/agenda.el -*- lexical-binding: t; -*-
    
    (after! org-agenda (setq org-agenda-custom-commands
                             '(("t" "Tasks"
                                ((agenda ""
                                         ((org-agenda-files '("~/.gtd/habits.org" "~/.gtd/tasks.org" "~/.gtd/projects.org"))
                                          (org-agenda-overriding-header "What's on my calendar")
                                          (org-agenda-span 'day)
                                          (org-agenda-start-day (org-today))
                                          (org-agenda-current-span 'day)
                                          (org-super-agenda-groups
                                           '((:name "Habits"
                                                    :habit t
                                                    :order 1)
                                             (:name "Today's Schedule"
                                                    :time-grid t
                                                    :order 2)
                                             (:name "In future"
                                                    :scheduled t
                                                    :order 3)
                                             (:name "Deadline approaching"
                                                    :deadline t
                                                    :order 4)))))
                                 (todo "TODO|NEXT|DELEGATED|REVIEW|WAITING|IN-PROGRESS"
                                       ((org-agenda-overriding-header "Task list")
                                        (org-agenda-files '("~/.gtd/tasks.org"))
                                        (org-super-agenda-groups
                                         '((:auto-property "Group-ID")))))
                                 (todo "TODO|NEXT|DELEGATED|REVIEW|WAITING|IN-PROGRESS"
                                       ((org-agenda-overriding-header "Projects")
                                        (org-agenda-files '("~/.gtd/projects.org"))
                                        (org-super-agenda-groups
                                         '((:auto-parent t)))))))
                               ("n" "Notes"
                                ((todo ""
                                       ((org-agenda-files (f-files "~/.references/notes/" "~/.references/usage/"))
                                        (org-agenda-overriding-header "Note Tasks")
                                        (org-super-agenda-groups
                                         '((:auto-parent t)))))))
                               ("i" "Inbox"
                                ((todo ""
                                       ((org-agenda-files '("~/.gtd/inbox.org"))
                                        (org-agenda-overriding-header "Items in my inbox")
                                        (org-super-agenda-groups
                                         '((:name none
                                                  :auto-ts t)))))))
                               ("x" "Get to someday"
                                ((todo "SOMEDAY"
                                       ((org-agenda-overriding-header "Things I need to get to someday")
                                        (org-agenda-files '("~/.gtd/"))
                                        (org-super-agenda-groups
                                         '((:auto-parent t)))))
                                 (todo "SOMEDAY"
                                       ((org-agenda-overriding-header "Projects marked Someday")
                                        (org-agenda-files '("~/.gtd/"))
                                        (org-super-agenda-groups
                                         '((:auto-parent t))))))))))


# Deft

    ;;; c:/Users/nmart/.doom.d/my-deft-title.el -*- lexical-binding: t; -*-
    
    (use-package deft
      :bind (("<f8>" . deft))
      :commands (deft deft-open-file deft-new-file-named)
      :config
      (setq deft-directory "~/.references"
            deft-auto-save-interval 0
            deft-use-filename-as-title nil
            deft-current-sort-method 'title
            deft-recursive t
            deft-extensions '("md" "txt" "org")
            deft-markdown-mode-title-level 1
            deft-file-naming-rules '((noslash . "-")
                                     (nospace . "-")
                                     (case-fn . downcase))))


# Bind Keys

Minor tweaks to add additional keybindings

    ;;; c:/Users/nmart/.doom.d/+keys.el -*- lexical-binding: t; -*-
    
    (map! :leader
          :n "e" #'ace-window
          :n "!" #'swiper
          :n "@" #'swiper-all
          :n "X" #'helm-org-capture-templates
          (:prefix "o"
            :n "e" #'elfeed
            :n "u" #'elfeed-update
            :n "v" #'org-brain-visualize
            :n "w" #'deft
            :n "n" #'plain-org-wiki
            :n "g" #'plain-org-gtd)
          (:prefix "n"
            :n "D" #'dictionary-lookup-definition
            :n "T" #'powerthesaurus-lookup-word)
          (:prefix "f"
            :n "w" #'deft
            :n "g" #'plain-org-gtd
            :n "n" #'plain-org-wiki
            :n "d" #'org-journal-new-entry)
          (:prefix "b"
            :n "c" #'org-board-new
            :n "e" #'org-board-open)
          (:prefix "t"
            :n "s" #'org-narrow-to-subtree
            :n "w" #'widen)
          (:prefix "/"
            :n "j" #'org-journal-search))


# Publish Settings

    ;;; ~/.doom.d/publish.el -*- lexical-binding: t; -*-
    
    (setq org-publish-project-alist
          '(("references-attachments"
             :base-directory "~/.references/images/"
             :base-extension "jpg\\|jpeg\\|png\\|pdf\\|css"
             :publishing-directory "~/publish_html/references/images"
             :publishing-function org-publish-attachment)
            ("references-md"
             :base-directory "~/.references/"
             :publishing-directory "~/publish_md"
             :base-extension "org"
             :recursive t
             :html-link-home "../readme.md"
             :sitemap-filename "index"
             :sitemap-title "Nick's Site generated by Emacs"
             :headline-levels 5
             :publishing-function org-html-publish-to-html
             :section-numbers nil
    ;         :html-head "<link rel=\"stylesheet\"
    ;href=\"https://codepen.io/nmartin84/pen/ExaWKqy.css\"
    ;type=\"text/css\"/>"
             :with-email t
             :html-link-up "."
             :auto-preamble t
             :with-toc t)
            ("tasks"
             :base-directory "~/.gtd/"
             :publishing-directory "~/publish_tasks"
             :base-extension "org"
             :recursive t
             :auto-sitemap t
             :sitemap-filename "index"
             :html-link-home "../index.html"
             :publishing-function org-html-publish-to-html
             :section-numbers nil
    ;         :html-head "<link rel=\"stylesheet\"
    ;href=\"https://codepen.io/nmartin84/pen/MWWdwbm.css\"
    ;type=\"text/css\"/>"
             :with-email t
             :html-link-up ".."
             :auto-preamble t
             :with-toc t)
            ("pdf"
             :base-directory "~/.gtd/references/"
             :base-extension "org"
             :publishing-directory "~/publish"
             :preparation-function somepreparationfunction
             :completion-function  somecompletionfunction
             :publishing-function org-latex-publish-to-pdf
             :recursive t
             :latex-class "koma-article"
             :headline-levels 5
             :with-toc t)
             ("myprojectweb" :components("references-attachments" "pdf" "references-md" "tasks"))))


# Mindmap

Create mindmaps from org files, no requirements.

    ;;; ~/.doom.d/graphviz.el -*- lexical-binding: t; -*-
    
    (use-package org-mind-map
      :init
      (require 'ox-org)
      ;; Uncomment the below if 'ensure-system-packages` is installed
      ;;:ensure-system-package (gvgen . graphviz)
      :config
      (setq org-mind-map-engine "dot")       ; Default. Directed Graph
      ;; (setq org-mind-map-engine "neato")  ; Undirected Spring Graph
      ;; (setq org-mind-map-engine "twopi")  ; Radial Layout
      ;; (setq org-mind-map-engine "fdp")    ; Undirected Spring Force-Directed
      ;; (setq org-mind-map-engine "sfdp")   ; Multiscale version of fdp for the layout of large graphs
      ;; (setq org-mind-map-engine "twopi")  ; Radial layouts
      ;; (setq org-mind-map-engine "circo")  ; Circular Layout
      )


# Elfeed

    ;;; c:/Users/nmart/.doom.d/settings/config-elfeed.el -*- lexical-binding: t; -*-
    
    (use-package elfeed
      :config
      (setq elfeed-db-directory "~/.elfeed/"))
    
    (use-package elfeed-org
      :config
      (setq rhm-elfeed-org-files (list "~/.elfeed/elfeed.org")))
    
    (require 'elfeed)
    (require 'elfeed-org)
    (elfeed-org)
    (after! org (setq rmh-elfeed-org-files (list "~/.elfeed/elfeed.org")
                      elfeed-db-directory "~/.elfeed/"))


# Plantuml

Requires Graphviz to be installed on your system.

    (use-package ob-plantuml
      :ensure nil
      :commands
      (org-babel-execute:plantuml)
      :config
      (setq org-plantuml-jar-path (expand-file-name "~/.tools/plantuml.jar")))


# Dictionary

Basics for dictionary

    ;;; c:/Users/nmart/.doom.d/settings/config-dictionary.el -*- lexical-binding: t; -*-
    
    (use-package dictionary
      :config
      (setq dictionary-tooltip-mode t))


# Popups

Configuring popup rules

    ;;; c:/Users/nmart/.doom.d/settings/config-popups.el -*- lexical-binding: t; -*-
    
    (set-popup-rule! "^Capture.*\\.org$" :side 'right :height .30 :width 60 :select t :vslot 2 :ttl 3)
    (set-popup-rule! "Dictionary" :side 'bottom :height .40 :width 20 :select t :vslot 3 :ttl 3)
    (set-popup-rule! "*eww pdf*" :side 'right :width 60 :select t :vslot 3 :ttl 3)


# Latex

    ;;; c:/Users/nmart/.doom.d/latex-classes.el -*- lexical-binding: t; -*-
    
    (setq org-latex-to-pdf-process
      '("xelatex -interaction nonstopmode %f"
         "xelatex -interaction nonstopmode %f"))
    
    (setq org-latex-classes
                 '("koma-article"
                   "\\documentclass{scrartcl}
    \\usepackage[T1]{fontenc}
    \\usepackage[bitstream-charter]{mathdesign}
    \\usepackage[scaled=.9]{helvet}
    \\usepackage{courier} % tt
    \\usepackage{geometry}
    \\usepackage{booktabs}
    \\usepackage{multicol}
    \\usepackage{paralist}
    \\geometry{letter, textwidth=6.5in, textheight=10in,
                marginparsep=7pt, marginparwidth=.6in}"
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                   ("\\paragraph{%s}" . "\\paragraph*{%s}")
                   ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

