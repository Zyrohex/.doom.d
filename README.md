
# Table of Contents

-   [Getting started with this REPO](#org68a438b)
-   [General Settings](#org2063e72)
    -   [Fonts](#org7ab36d5)
    -   [Lines](#org3b5da7f)
    -   [Keys](#orgde4e192)
    -   [General settings](#orga27adc2)
    -   [Popup Rules](#orgea5a61d)
-   [Doom Settings](#org5cab2b2)
    -   [Theme](#org3a4b5f4)
-   [Org Mode Settings](#orgbbcf0de)
    -   [Agenda](#org4149c32)
    -   [Load all \*.org files to agenda](#orgd26162d)
    -   [Captures](#org01a6062)
        -   [Getting Things Done](#org2f8b631)
            -   [Recurring Tasks](#orge48d8ab)
            -   [Project](#orgfc6fd2a)
            -   [New Capture](#org8b49f8b)
        -   [Reference - Yank Example](#org623a6b0)
        -   [Reference - New Entry](#org10de9ac)
        -   [Diary - Daily Log](#org53608ab)
    -   [Directories](#org7e29940)
    -   [Exports](#org0dbf6b5)
    -   [Faces](#org186da27)
    -   [Keywords](#org6a8e5fb)
    -   [Latex Exports](#org856be38)
    -   [Link Abbreviations](#org99bb26c)
    -   [Logging & Drawers](#org851a22d)
    -   [Prettify](#org604dc25)
    -   [Publishing](#orgc9a2ce9)
    -   [Refiling](#org6fdc79b)
    -   [Tags](#org3902073)
-   [Extra Modules](#org6204f45)
    -   [Plantuml](#org923eaf0)
    -   [Org-Mind-Map](#orgaf2032f)
    -   [Gnuplot](#orgc0f39f9)
    -   [Deft](#org6669c3e)
    -   [Elfeed](#org004e822)
    -   [Org-Clock-Switch](#org26fb965)
    -   [Org-Rifle](#org2948f85)
    -   [Update Tickboxes](#org3d7fbeb)
    -   [Zyrohex/org-tasks-refile](#org61f9fac)
    -   [Zyrohex/org-reference-refile](#org32d6fef)
    -   [Zyrohex/org-notes-refile](#org9d97d14)
    -   [WSL Browser](#org49e783c)
-   [Super Agenda Groups](#org8a9c02d)

My DOOM emacs private configuration:
![img](https://i.imgur.com/EBp5TxA.png)

High focus on GTD process workflow:

![img](./attachments/gtd.png)


<a id="org68a438b"></a>

# Getting started with this REPO

If you are starting with a fresh DOOM Emacs Installation, you can follow the following steps:

    git clone https://github.com/nmartin84/.doom.d.git ~/.doom.d
    git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
    sed -i 's/;;literate/literate/' ~/.doom.d/init.el
    ~/.emacs.d/bin/doom install

Otherwise, backup your existing DOOM private config and run:

    mv ~/.doom.d ~/.doom.d_backup
    git clone https://github.com/nmartin84/.doom.d.git ~/.doom.d
    sed -i 's/;;literate/literate/' ~/.doom.d/init.el
    ~/.emacs.d/bin/doom refresh

This repo uses a literate configuration, with basic settings in `./init.el`, `./packags.el`, the content of `./config.el` will be generated
from the Emacs Lisp code blocks in `config.org`.


<a id="org2063e72"></a>

# General Settings


<a id="org7ab36d5"></a>

## Fonts

For fonts please download [Input](https://input.fontbureau.com/download/) and [DejaVu](http://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-ttf-2.37.tar.bz2)

    (setq doom-font (font-spec :family "InputMono" :size 18)
          doom-variable-pitch-font (font-spec :family "InputMono")
          doom-unicode-font (font-spec :family "DejaVu Sans")
          doom-big-font (font-spec :family "InputMono" :size 20))


<a id="org3b5da7f"></a>

## Lines

For this we just make small tweaks to line numbers.

    (setq display-line-numbers t)


<a id="orgde4e192"></a>

## Keys

    
    (map!
     :nvime "<f5> d" #'helm-org-rifle-directories
     :nvime "<f5> b" #'helm-org-rifle-current-buffer
     :nvime "<f5> o" #'helm-org-rifle-org-directory
     :nvime "<f5> a" #'helm-org-rifle-agenda-files)
    
    (map! :leader
          :n "e" #'ace-window
          :n "!" #'swiper
          :n "@" #'swiper-all
          :n "#" #'deadgrep
          :n "$" #'helm-org-rifle-directories
          :n "X" #'org-capture
          (:prefix "o"
            :n "e" #'elfeed
            :n "g" #'metrics-tracker-graph
            :n "o" #'org-open-at-point
            :n "u" #'elfeed-update
            :n "w" #'deft)
          (:prefix "f"
            :n "o" #'plain-org-wiki-helm)
          (:prefix "n"
            :n "D" #'dictionary-lookup-definition
            :n "T" #'powerthesaurus-lookup-word)
          (:prefix "s"
            :n "d" #'deadgrep
            :n "q" #'org-ql-search
            :n "b" #'helm-org-rifle-current-buffer
            :n "o" #'helm-org-rifle-org-directory
            :n "." #'helm-org-rifle-directories)
          (:prefix "b"
            :n "c" #'org-board-new
            :n "e" #'org-board-open)
          (:prefix "t"
            :n "s" #'org-narrow-to-subtree
            :n "w" #'widen)
          (:prefix "/"
            :n "j" #'org-journal-search))


<a id="orga27adc2"></a>

## General settings

    (setq-default fill-column 140)
    (setq diary-file "~/.org/gtd/diary.org")
    (global-auto-revert-mode t)


<a id="orgea5a61d"></a>

## Popup Rules

    (after! org (set-popup-rule! "^Capture.*\\.org$" :side 'right :size .40 :select t :vslot 2 :ttl 3))
    (after! org (set-popup-rule! "Dictionary" :side 'bottom :height .40 :width 20 :select t :vslot 3 :ttl 3))
    (after! org (set-popup-rule! "*helm*" :side 'bottom :height .40 :select t :vslot 5 :ttl 3))
    (after! org (set-popup-rule! "*deadgrep" :side 'bottom :height .40 :select t :vslot 4 :ttl 3))
    (after! org (set-popup-rule! "*xwidget" :side 'right :size .40 :select t :vslot 5 :ttl 3))
    (after! org (set-popup-rule! "*org agenda*" :side 'right :size .40 :select t :vslot 2 :ttl 3))


<a id="org5cab2b2"></a>

# Doom Settings


<a id="org3a4b5f4"></a>

## Theme

    (setq doom-theme 'doom-city-lights)


<a id="orgbbcf0de"></a>

# Org Mode Settings


<a id="org4149c32"></a>

## Agenda

    (setq org-agenda-diary-file "~/.org/diary.org"
          org-agenda-use-time-grid nil
          org-agenda-skip-scheduled-if-done t
          org-agenda-skip-deadline-if-done t
          org-habit-show-habits t)


<a id="orgd26162d"></a>

## Load all \*.org files to agenda

    (load-library "find-lisp")
    (after! org (setq org-agenda-files
                      (find-lisp-find-files "~/.org/" "\.org$")))


<a id="org01a6062"></a>

## Captures

    (after! org (setq org-capture-templates
                      '(("g" "Getting things done")
                        ("r" "References")
                        ("d" "Diary")
                        ("p" "Graph Data")
                        ("t" "Data Tracker"))))


<a id="org2f8b631"></a>

### Getting Things Done


<a id="orge48d8ab"></a>

#### Recurring Tasks

    (after! org (add-to-list 'org-capture-templates
                             '("gr" "Recurring Task" entry (file "~/.org/gtd/recurring.org")
                               "* TODO %^{description}
    :PROPERTIES:
    :CREATED:    %U
    :END:
    :RESOURCES:
    :END:
    
    + NOTES:
      %?")))


<a id="orgfc6fd2a"></a>

#### Project

    (after! org (add-to-list 'org-capture-templates
                 '("gp" "Project" entry (file+headline"~/.org/gtd/tasks.org" "Projects")
    "* TODO %^{Description}
    :PROPERTIES:
    :SUBJECT: %^{subject}
    :GOAL:    %^{goal}
    :END:
    :RESOURCES:
    :END:
    
    + REQUIREMENTS:
      %^{requirements}
    
    + NOTES:
      %?
    
    \** TODO %^{task1}")))


<a id="org8b49f8b"></a>

#### New Capture

    (after! org (add-to-list 'org-capture-templates
                 '("gt" "Capture Task" entry (file"~/.org/gtd/inbox.org")
    "** TODO %^{description}
    :PROPERTIES:
    :CREATED:    %U
    :END:
    :RESOURCES:
    [[%^{url}]]
    :END:
    
    + NEXT STEPS:
      - [ ] %^{next steps}
    
    + NOTES:
      %?")))


<a id="org623a6b0"></a>

### Reference - Yank Example

    (after! org (add-to-list 'org-capture-templates
                 '("re" "Yank new Example" entry(file+headline"~/.org/notes/examples.org" "INBOX")
    "* %^{example}
    :PROPERTIES:
    :SOURCE:  %^{source|Command|Script|Code|Usage}
    :SUBJECT: %^{subject}
    :END:
    
    \#+BEGIN_SRC
    %x
    \#+END_SRC
    %?")))


<a id="org10de9ac"></a>

### Reference - New Entry

    (after! org (add-to-list 'org-capture-templates
                 '("rn" "Yank new Example" entry(file+headline"~/.org/notes/references.org" "INBOX")
    "* %^{example}
    :PROPERTIES:
    :CATEGORY: %^{category}
    :SUBJECT:  %^{subject}
    :END:
    :RESOURCES:
    :END:
    
    %?")))


<a id="org53608ab"></a>

### Diary - Daily Log

    (after! org (add-to-list 'org-capture-templates
                 '("dn" "New Diary Entry" entry(file+olp+datetree"~/.org/diary.org" "Dailies")
    "* %^{example}
    :PROPERTIES:
    :CATEGORY: %^{category}
    :SUBJECT:  %^{subject}
    :MOOD:     %^{mood}
    :END:
    :RESOURCES:
    :END:
    
    \*What was one good thing you learned today?*:
    - %^{whatilearnedtoday}
    
    \*List one thing you could have done better*:
    - %^{onethingdobetter}
    
    \*Describe in your own words how your day was*:
    - %?")))


<a id="org7e29940"></a>

## Directories

    (setq org-directory "~/.org/"
          org-image-actual-width nil
          +org-export-directory "~/.export/"
          org-archive-location "~/.org/gtd/archive.org::datetree/"
          org-default-notes-file "~/.org/gtd/inbox.org"
          projectile-project-search-path '("~/"))


<a id="org0dbf6b5"></a>

## Exports

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
    
    ;(after! org (add-to-list 'org-export-backends 'pandoc))
    (after! org (add-to-list 'org-export-backends 'pdf))


<a id="org186da27"></a>

## TODO Faces

Need to add condition to adjust faces based on theme select.

    (after! org (setq org-todo-keyword-faces
          '(("TODO" :foreground "tomato" :weight bold)
            ("WAITING" :foreground "light sea green" :weight bold)
            ("STARTED" :foreground "DodgerBlue" :weight bold)
            ("DELEGATED" :foreground "Gold" :weight bold)
            ("NEXT" :foreground "violet red" :weight bold)
            ("DONE" :foreground "slategrey" :weight bold))))


<a id="org6a8e5fb"></a>

## Keywords

    (after! org (setq org-todo-keywords
          '((sequence "TODO(t)" "WAITING(w!)" "STARTED(s!)" "NEXT(n!)" "DELEGATED(d!)" "|" "INVALID(I!)" "DONE(d!)"))))


<a id="org856be38"></a>

## TODO Latex Exports

Getting errors on start up for this one. Will need to look into it.

    (add-to-list 'org-latex-classes
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


<a id="org99bb26c"></a>

## Link Abbreviations

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
            ("attachments" . "~/.org/.attachments/")))


<a id="org851a22d"></a>

## Logging & Drawers

    (setq org-log-state-notes-insert-after-drawers nil
          org-log-into-drawer t
          org-log-done 'time
          org-log-repeat 'time
          org-log-redeadline 'note
          org-log-reschedule 'note)


<a id="org604dc25"></a>

## Prettify

    (setq org-bullets-bullet-list '("✖" "✚")
          org-ellipsis "▼")


<a id="orgc9a2ce9"></a>

## Publishing

    (setq org-publish-project-alist
          '(("references-attachments"
             :base-directory "~/.org/notes/images/"
             :base-extension "jpg\\|jpeg\\|png\\|pdf\\|css"
             :publishing-directory "~/publish_html/references/images"
             :publishing-function org-publish-attachment)
            ("references-md"
             :base-directory "~/.org/notes/"
             :publishing-directory "~/publish_md"
             :base-extension "org"
             :recursive t
             :headline-levels 5
             :publishing-function org-html-publish-to-html
             :section-numbers nil
             :html-head "<link rel=\"stylesheet\" href=\"http://thomasf.github.io/solarized-css/solarized-light.min.css\" type=\"text/css\"/>"
             :infojs-opt "view:t toc:t ltoc:t mouse:underline buttons:0 path:http://thomas.github.io/solarized-css/org-info.min.js"
             :with-email t
             :with-toc t)
            ("tasks"
             :base-directory "~/.org/gtd/"
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
             :base-directory "~/.org/gtd/references/"
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


<a id="org6fdc79b"></a>

## Refiling

    (setq org-refile-targets '((org-agenda-files . (:maxlevel . 6)))
          org-hide-emphasis-markers nil
          org-outline-path-complete-in-steps nil
          org-refile-allow-creating-parent-nodes 'confirm)


<a id="org3902073"></a>

## Tags

    (setq org-tags-column -80
          org-tag-persistent-alist '(("@email" . ?e) ("@write" . ?W) ("@phone" . ?p) ("@configure" . ?C) ("@work" . ?w) ("@personal" . ?l) ("@read" . ?r) ("@watch" . ?W) ("@computer" . ?c) ("@bills" . ?b) ("@purchase" . ?P)))


<a id="org6204f45"></a>

# Extra Modules


<a id="org923eaf0"></a>

## Plantuml

    (use-package ob-plantuml
      :ensure nil
      :commands
      (org-babel-execute:plantuml)
      :config
      (setq org-plantuml-jar-path (expand-file-name "~/.tools/plantuml.jar")))


<a id="orgaf2032f"></a>

## Org-Mind-Map

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


<a id="orgc0f39f9"></a>

## Gnuplot

    (use-package gnuplot
      :config
      (setq gnuplot-program "gnuplot"))


<a id="org6669c3e"></a>

## Deft

    (defun my-deft/strip-quotes (str)
      (cond ((string-match "\"\\(.+\\)\"" str) (match-string 1 str))
            ((string-match "'\\(.+\\)'" str) (match-string 1 str))
            (t str)))
    
    (defun my-deft/parse-title-from-front-matter-data (str)
      (if (string-match "^title: \\(.+\\)" str)
          (let* ((title-text (my-deft/strip-quotes (match-string 1 str)))
                 (is-draft (string-match "^draft: true" str)))
            (concat (if is-draft "[DRAFT] " "") title-text))))
    
    (defun my-deft/deft-file-relative-directory (filename)
      (file-name-directory (file-relative-name filename deft-directory)))
    
    (defun my-deft/title-prefix-from-file-name (filename)
      (let ((reldir (my-deft/deft-file-relative-directory filename)))
        (if reldir
            (concat (directory-file-name reldir) " > "))))
    
    (defun my-deft/parse-title-with-directory-prepended (orig &rest args)
      (let ((str (nth 1 args))
            (filename (car args)))
        (concat
          (my-deft/title-prefix-from-file-name filename)
          (let ((nondir (file-name-nondirectory filename)))
            (if (or (string-prefix-p "README" nondir)
                    (string-suffix-p ".txt" filename))
                nondir
              (if (string-prefix-p "---\n" str)
                  (my-deft/parse-title-from-front-matter-data
                   (car (split-string (substring str 4) "\n---\n")))
                (apply orig args)))))))
    
    (provide 'my-deft-title)

    (use-package deft
      :bind (("<f8>" . deft))
      :commands (deft deft-open-file deft-new-file-named)
      :config
      (setq deft-directory "~/.org/"
            deft-auto-save-interval 0
            deft-use-filename-as-title nil
            deft-current-sort-method 'title
            deft-recursive t
            deft-extensions '("md" "txt" "org")
            deft-markdown-mode-title-level 1
            deft-file-naming-rules '((noslash . "-")
                                     (nospace . "-")
                                     (case-fn . downcase))))
    (require 'my-deft-title)
    (advice-add 'deft-parse-title :around #'my-deft/parse-title-with-directory-prepended)


<a id="org004e822"></a>

## Elfeed

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


<a id="org26fb965"></a>

## Org-Clock-Switch

    (defun org-clock-switch ()
      "Switch task and go-to that task"
      (interactive)
      (setq current-prefix-arg '(12)) ; C-u
      (call-interactively 'org-clock-goto)
      (org-clock-in)
      (org-clock-goto))
    (provide 'org-clock-switch)


<a id="org2948f85"></a>

## TODO Org-Rifle

    ID: 3256ce1c-aa68-4b99-823c-4c8fd6545c0b

I&rsquo;ll want to add some of my own custom rifle actions here.


<a id="org3d7fbeb"></a>

## Update Tickboxes

    (defun org-update-cookies-after-save()
      (interactive)
      (let ((current-prefix-arg '(4)))
        (org-update-statistics-cookies "ALL")))
    
    (add-hook 'org-mode-hook
              (lambda ()
                (add-hook 'before-save-hook 'org-update-cookies-after-save nil 'make-it-local)))
    (provide 'org-update-cookies-after-save)


<a id="org61f9fac"></a>

## Zyrohex/org-tasks-refile

    (defun zyrohex/org-tasks-refile ()
      "Process a single TODO task item."
      (interactive)
      (call-interactively 'org-agenda-schedule)
      (org-agenda-set-tags)
      (org-agenda-priority)
      (let ((org-refile-targets '((helm-read-file-name :maxlevel .6)))
            (call-interactively #'org-refile))))
    (provide 'zyrohex/org-tasks-refile)


<a id="org32d6fef"></a>

## Zyrohex/org-reference-refile

    (defun zyrohex/org-reference-refile (arg)
      "Process an item to the reference bucket"
      (interactive "P")
      (let ((org-refile-targets '(("~/.gtd/references.org" :maxlevel . 6))))
        (call-interactively #'org-refile)))
    (provide 'zyrohex/org-reference-refile)


<a id="org9d97d14"></a>

## Zyrohex/org-notes-refile

    (defun zyrohex/org-notes-refile ()
      "Process an item to the references bucket"
      (interactive)
      (let ((org-refile-targets '(("~/.gtd/references.org" :maxlevel . 6)))
            (org-refile-allow-creating-parent-nodes 'confirm))
        (call-interactively #'org-refile)))
    (provide 'zyrohex/org-notes-refile)


<a id="org49e783c"></a>

## WSL Browser

    (defun my--browse-url (url &optional _new-window)
      ;; new-window ignored
      "Opens link via powershell.exe"
      (interactive (browse-url-interactive-arg "URL: "))
      (let ((quotedUrl (format "start '%s'" url)))
        (apply 'call-process "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe" nil
               0 nil
               (list "-Command" quotedUrl))))
    
    (setq-default browse-url-browser-function 'my--browse-url)


<a id="org8a9c02d"></a>

# Super Agenda Groups

    (org-super-agenda-mode t)
    (after! org-agenda (setq org-agenda-custom-commands
                             '(("t" "Tasks"
                                ((agenda ""
                                         ((org-agenda-files '("~/.org/gtd/tasks.org" "~/.org/gtd/tickler.org" "~/.org/gtd/projects.org"))
                                          (org-agenda-overriding-header "What's on my calendar")
                                          (org-agenda-span 'day)
                                          (org-agenda-start-day (org-today))
                                          (org-agenda-current-span 'day)
                                          (org-super-agenda-groups
                                           '((:name "[[~/.org/gtd/habits.org][Habits]]"
                                                    :habit t
                                                    :order 1)
                                             (:name "[[~/.org/gtd/recurring.org][Bills]]"
                                                    :tag "@bills"
                                                    :order 4)
                                             (:name "Today's Schedule"
                                                    :time-grid t
                                                    :scheduled t
                                                    :deadline t
                                                    :order 13)))))
                                 (todo "TODO|NEXT|REVIEW|WAITING|IN-PROGRESS"
                                       ((org-agenda-overriding-header "[[~/.org/gtd/tasks.org][Task list]]")
                                        (org-agenda-files '("~/.org/gtd/tasks.org"))
                                        (org-super-agenda-groups
                                         '((:name "CRITICAL"
                                                  :priority "A"
                                                  :order 1)
                                           (:name "NEXT UP"
                                                  :todo "NEXT"
                                                  :order 2)
                                           (:name "Emacs Reading"
                                                  :and (:category "Emacs" :tag "@read")
                                                  :order 3)
                                           (:name "Emacs Config"
                                                  :and (:category "Emacs" :tag "@configure")
                                                  :order 4)
                                           (:name "Emacs Misc"
                                                  :category "Emacs"
                                                  :order 5)
                                           (:name "Task Reading"
                                                  :and (:category "Tasks" :tag "@read")
                                                  :order 6)
                                           (:name "Task Other"
                                                  :category "Tasks"
                                                  :order 7)
                                           (:name "Projects"
                                                  :category "Projects"
                                                  :order 8)))))
                                 (todo "DELEGATED"
                                       ((org-agenda-overriding-header "Delegated Tasks by WHO")
                                        (org-agenda-files '("~/.org/gtd/tasks.org"))
                                        (org-super-agenda-groups
                                         '((:auto-property "WHO")))))))
                               ("i" "Inbox"
                                ((todo ""
                                       ((org-agenda-files '("~/.org/gtd/inbox.org"))
                                        (org-agenda-overriding-header "Items in my inbox")
                                        (org-super-agenda-groups
                                         '((:auto-ts t)))))))
                               ("x" "Get to someday"
                                ((todo ""
                                            ((org-agenda-overriding-header "Projects marked Someday")
                                             (org-agenda-files '("~/.org/gtd/someday.org"))
                                             (org-super-agenda-groups
                                              '((:auto-ts t))))))))))

