
# Table of Contents

-   [Getting started](#org72eb1eb)
-   [General Settings](#orgf597f67)
    -   [Lines](#org982d542)
    -   [Keys](#orgc1a5cdb)
    -   [General settings](#org4a2619f)
    -   [Popup Rules](#org3b45d8c)
    -   [User Settings](#org4fdfaaf)
-   [Doom Settings](#org278910b)
    -   [Fonts](#orgbfff60b)
    -   [Mode line](#orgcef691f)
    -   [Theme](#org1c8d2d5)
-   [Org Mode Settings](#orgff60a84)
    -   [Agenda](#orge579b65)
    -   [Load all \*.org files to agenda](#org6158ef3)
    -   [Captures](#org7dd0e25)
        -   [Append sub-heading to current](#org282d1f7)
        -   [Capture](#org53434c0)
        -   [New parent with child task](#org12f1ab4)
        -   [New Project](#org8e9beaf)
        -   [New Task in heading](#org4efe99b)
        -   [Recurring Tasks](#orge0e026e)
        -   [Reference - New Entry](#org0c3cfd6)
        -   [Reference - Yank Example](#org6eaca12)
        -   [Workouts](#org47f006f)
        -   [Food](#org9bf8dab)
        -   [Diary](#org43bd035)
    -   [Directories](#org5c3801e)
    -   [Exports](#org60e22fe)
    -   [Faces](#org503bf31)
    -   [Keywords](#org78549b8)
    -   [Latex Exports](#org526d04b)
    -   [Link Abbreviations](#orgd740136)
    -   [Logging & Drawers](#org0498187)
    -   [Pitch Settings](#orgde6d0a1)
    -   [Prettify](#org3db2263)
    -   [Publishing](#orga60333d)
    -   [Refiling](#orgaf6b3f7)
    -   [Startup](#org36179ea)
    -   [Tags](#org8b6cc79)
-   [Extra Modules](#orga33be55)
    -   [Deft](#orga0f78f1)
    -   [Elfeed](#org345a610)
    -   [Gnuplot](#orgc38ba5c)
    -   [Grip Mode](#org3c1e237)
    -   [Org Agenda Prefix](#orgcc5a0e9)
    -   [Org Agenda Property](#orgbbedf07)
    -   [Org Outlook](#orgceb4060)
    -   [Org Clock Switch](#org1671a70)
    -   [Org Clock MRU](#orgf691b94)
    -   [Org Mind Map](#orgf591aed)
    -   [Org Rifle](#org5e8ab51)
    -   [Plantuml](#org8e99024)
    -   [Update Tickboxes](#org0a11efe)
    -   [WSL Browser](#orgf61c9d7)
    -   [Zyrohex/org-notes-refile](#org60cc6f9)
    -   [Zyrohex/org-reference-refile](#orgc633532)
    -   [Zyrohex/org-tasks-refile](#org760e394)
    -   [Move capture](#orgbe2bafd)
    -   [Prompt filename](#org0ec40e6)
-   [Super Agenda Groups](#orgbe0e9ab)

My DOOM emacs private configuration:
![img](https://i.imgur.com/0NBUc3c.png)

High focus on GTD process workflow: ([source](https://github.com/nmartin84/.references/blob/master/gtd-babel.org))

![img](./attachments/gtd.png)


<a id="org72eb1eb"></a>

# Getting started

If you have not installed DOOM Emacs but would like to:

    git clone https://github.com/nmartin84/.doom.d.git ~/.doom.d
    git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install

Otherwise, backup your existing DOOM private config and run:

    mv ~/.doom.d ~/.doom.d_backup
    git clone https://github.com/nmartin84/.doom.d.git ~/.doom.d
    ~/.emacs.d/bin/doom refresh

This repo uses a literate configuration, with basic settings in `./init.el`, `./packags.el`, the content of `./config.el` will be generated
from the Emacs Lisp code blocks in `config.org`. This readme file gets created when exporting `config.org` to markdown.


<a id="orgf597f67"></a>

# General Settings


<a id="org982d542"></a>

## Lines

For this we just make small tweaks to line numbers.

    (setq display-line-numbers t)


<a id="orgc1a5cdb"></a>

## Keys

    (global-set-key (kbd "C-c C-x i") #'org-mru-clock-in)
    (global-set-key (kbd "C-c C-x C-j") #'org-mru-clock-select-recent-task)
    (bind-key "C-<down>" #'+org/insert-item-below)
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


<a id="org4a2619f"></a>

## General settings

    (setq-default fill-column 80)
    (global-auto-revert-mode t)


<a id="org3b45d8c"></a>

## Popup Rules

    (after! org (set-popup-rule! "^Capture.*\\.org$" :side 'right :size .40 :select t :vslot 2 :ttl 3))
    (after! org (set-popup-rule! "Dictionary" :side 'bottom :height .40 :width 20 :select t :vslot 3 :ttl 3))
    (after! org (set-popup-rule! "*helm*" :side 'bottom :height .40 :select t :vslot 5 :ttl 3))
    (after! org (set-popup-rule! "*eww*" :side 'right :size .40 :slect t :vslot 5 :ttl 3))
    (after! org (set-popup-rule! "*deadgrep" :side 'bottom :height .40 :select t :vslot 4 :ttl 3))
    (after! org (set-popup-rule! "*org-roam" :side 'right :size .40 :select t :vslot 4 :ttl 3))
    (after! org (set-popup-rule! "\\Swiper" :side 'bottom :size .30 :select t :vslot 4 :ttl 3))
    (after! org (set-popup-rule! "*xwidget" :side 'right :size .40 :select t :vslot 5 :ttl 3))
    (after! org (set-popup-rule! "*org agenda*" :side 'right :size .40 :select t :vslot 2 :ttl 3))
    (after! org (set-popup-rule! "*Org ql" :side 'right :size .40 :select t :vslot 2 :ttl 3))


<a id="org4fdfaaf"></a>

## User Settings

    (setq user-full-name "Nicholas Martin"
          user-mail-address "nmartin84.com")


<a id="org278910b"></a>

# Doom Settings


<a id="orgbfff60b"></a>

## Fonts

For fonts please download [Input](https://input.fontbureau.com/download/) and [DejaVu](http://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-ttf-2.37.tar.bz2)

    (setq doom-font (font-spec :family "InputMono" :size 20)
          doom-variable-pitch-font (font-spec :family "InputMono" :height 120)
          doom-unicode-font (font-spec :family "InputMono")
          doom-big-font (font-spec :family "InputMono" :size 20))
    (prefer-coding-system       'utf-8)
    (set-default-coding-systems 'utf-8)
    (set-terminal-coding-system 'utf-8)
    (set-keyboard-coding-system 'utf-8)
    (setq default-buffer-file-coding-system 'utf-8)


<a id="orgcef691f"></a>

## Mode line

    (setq doom-modeline-gnus t
          doom-modeline-gnus-timer 'nil)


<a id="org1c8d2d5"></a>

## Theme

    (setq doom-theme 'doom-gruvbox)


<a id="orgff60a84"></a>

# Org Mode Settings


<a id="orge579b65"></a>

## Agenda

    (after! org (setq org-agenda-use-time-grid nil
                      org-agenda-skip-scheduled-if-done t
                      org-agenda-skip-deadline-if-done t
                      org-habit-show-habits t))
    (after! org (setq org-super-agenda-groups
                      '((:auto-category t))))


<a id="org6158ef3"></a>

## Load all \*.org files to agenda

    (load-library "find-lisp")
    (after! org (setq org-agenda-files
    (find-lisp-find-files "~/.org/" "\.org$")))


<a id="org7dd0e25"></a>

## Captures

    (after! org (setq org-capture-templates
                      '(("t" "Tasks")
                        ("p" "Projects")
                        ("r" "References"))))


<a id="org282d1f7"></a>

### Append sub-heading to current

    (after! org (add-to-list 'org-capture-templates
                 '("ta" "Append new entry to existing header" entry (file+function buffer-name org-back-to-heading-or-point-min)
    "* %^{topic}
    :PROPERTIES:
    :CREATED:    %U
    :END:
    :LOGBOOK:
    :END:
    
    %?" :clock-in t :clock-resume t)))


<a id="org53434c0"></a>

### Capture

    (after! org (add-to-list 'org-capture-templates
                 '("c" "Capture [GTD]" entry (file "~/.org/gtd/inbox.org")
    "* TODO %^{taskname}%?
    :PROPERTIES:
    :CREATED:    %U
    :END:
    " :immediate-finish t)))


<a id="org12f1ab4"></a>

### New parent with child task

    (after! org (add-to-list 'org-capture-templates
                 '("tp" "Add Parent w/child to Current" entry (file+function buffer-name org-back-to-heading-or-point-min)
    "* TODO %^{taskname}
    :PROPERTIES:
    :CREATED:    %U
    :END:
    :LOGBOOK:
    :END:
    
    %?
    
    \** TODO %^{child task}" :clock-in t :clock-resume t)))


<a id="org8e9beaf"></a>

### New Project

    ID: bed0315c-b641-4a08-97ac-570a741181fb

    (after! org (add-to-list 'org-capture-templates
                 '("pn" "New Project" entry (file+function my/generate-org-note-name org-back-to-heading-or-point-min)
    "* TODO %^{projectname}
    :PROPERTIES:
    :GOAL:    %^{goal}
    :END:
    :RESOURCES:
    :END:
    
    + REQUIREMENTS:
      %^{requirements}
    
    \** TODO %^{task1}")))


<a id="org4efe99b"></a>

### New Task in heading

    (after! org (add-to-list 'org-capture-templates
                 '("tc" "Add Task to Current" entry (file+function buffer-name org-back-to-heading-or-point-min)
    "* TODO %^{taskname}
    :PROPERTIES:
    :CREATED:    %U
    :END:
    :LOGBOOK:
    :END:
    
    %?" :clock-in t :clock-resume t)))


<a id="orge0e026e"></a>

### Recurring Tasks

    (after! org (add-to-list 'org-capture-templates
                             '("tr" "Recurring Task" entry (file "~/.org/gtd/recurring.org")
                               "* TODO %^{description} %?
    :SCHEDULED: %^{schedule}t
    :PROPERTIES:
    :CREATED:    %U
    :END:
    :RESOURCES:
    :END:
    ")))


<a id="org0c3cfd6"></a>

### Reference - New Entry

    ID: 872e98d3-c9bf-42ca-9e91-d62a5b61bf34

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


<a id="org6eaca12"></a>

### Reference - Yank Example

    ID: a92854f8-81a0-48cc-923d-0ae0eeddf49d

    (after! org (add-to-list 'org-capture-templates
                 '("re" "Yank new Example" entry(file+headline"~/.org/notes/examples.org" "INBOX")
    "* %^{example}
    :PROPERTIES:
    :SOURCE:  %^{source|Command|Script|Code|Usage}
    :SUBJECT: %^{subject}
    :END:
    
    \#+BEGIN_SRC %^{lang}
    %x
    \#+END_SRC
    %?")))


<a id="org47f006f"></a>

### Workouts

    (after! org (add-to-list 'org-capture-templates
                 '("w" "Workout Log" entry(file+olp+datetree"~/.org/journal/workout.org")
                   "** %\\1 (%\\2 calories) :: %\\3 (reps)
    :PROPERTIES:
    :ACTIVITY: %^{ACTIVITY}
    :CALORIES: %^{CALORIES}
    :REPS:     %^{REPS}
    :COMMENT:  %^{COMMENT}
    ")))


<a id="org9bf8dab"></a>

### Food

    (after! org (add-to-list 'org-capture-templates
                 '("F" "Food Log" entry(file+olp+datetree"~/.org/journal/food.org")
    "** %\\1 [%\\2]
    :PROPERTIES:
    :FOOD:     %^{FOOD}
    :CALORIES: %^{CALORIES}
    :COMMENT:  %^{COMMENT}
    :END:")))


<a id="org43bd035"></a>

### Diary

    (after! org (add-to-list 'org-capture-templates
                 '("d" "Diary Log" entry(file+datetree"~/.org/journal/diary.org")
                   "** <%<%I:%M:%S>> %^{diary entry}
    %?")))


<a id="org5c3801e"></a>

## Directories

    (after! org (setq org-directory "~/.org/"
                      org-image-actual-width nil
                      +org-export-directory "~/.export/"
                      org-archive-location "~/.org/gtd/archive.org::datetree/"
                      org-default-notes-file "~/.org/gtd/inbox.org"
                      projectile-project-search-path '("~/")))


<a id="org60e22fe"></a>

## Exports

    (after! org (setq org-html-head-include-scripts t
                      org-export-with-toc t
                      org-export-with-author t
                      org-export-headline-levels 5
                      org-export-with-drawers t
                      org-export-with-email t
                      org-export-with-footnotes t
                      org-export-with-latex t
                      org-export-with-section-numbers nil
                      org-export-with-properties t
                      org-export-with-smart-quotes t
                      org-export-backends '(pdf ascii html latex odt pandoc)))


<a id="org503bf31"></a>

## TODO Faces

Need to add condition to adjust faces based on theme select.

    (after! org (setq org-todo-keyword-faces
          '(("TODO" :foreground "tomato" :weight bold)
            ("WAITING" :foreground "light sea green" :weight bold)
            ("STARTED" :foreground "DodgerBlue" :weight bold)
            ("DELEGATED" :foreground "Gold" :weight bold)
            ("NEXT" :foreground "violet red" :weight bold)
            ("DONE" :foreground "slategrey" :weight bold))))


<a id="org78549b8"></a>

## Keywords

    (after! org (setq org-todo-keywords
          '((sequence "TODO(t)" "WAITING(w!)" "STARTED(s!)" "NEXT(n!)" "DELEGATED(e!)" "|" "INVALID(I!)" "DONE(d!)"))))


<a id="org526d04b"></a>

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


<a id="orgd740136"></a>

## Link Abbreviations

    (after! org (setq org-link-abbrev-alist
                      '(("doom-repo" . "https://github.com/hlissner/doom-emacs/%s")
                        ("wolfram" . "https://wolframalpha.com/input/?i=%s")
                        ("duckduckgo" . "https://duckduckgo.com/?q=%s")
                        ("gmap" . "https://maps.google.com/maps?q=%s")
                        ("gimages" . "https://google.com/images?q=%s")
                        ("google" . "https://google.com/search?q=")
                        ("youtube" . "https://youtube.com/watch?v=%s")
                        ("youtu" . "https://youtube.com/results?search_query=%s")
                        ("github" . "https://github.com/%s")
                        ("attachments" . "~/.org/.attachments/"))))


<a id="org0498187"></a>

## Logging & Drawers

    (after! org (setq org-log-state-notes-insert-after-drawers nil
                      org-log-into-drawer t
                      org-log-done 'time
                      org-log-repeat 'time
                      org-log-redeadline 'note
                      org-log-reschedule 'note))


<a id="orgde6d0a1"></a>

## Pitch Settings


<a id="org3db2263"></a>

## Prettify

    (after! org (setq org-bullets-bullet-list '("◉" "○")
                      org-hide-emphasis-markers nil
                      org-list-demote-modify-bullet '(("+" . "-") ("1." . "a.") ("-" . "+"))
                      org-ellipsis "▼"))
    (setq org-emphasis-alist
      '(("*" (bold :foreground "Orange" ))
        ("/" italic)
        ("_" underline)
        ("=" (:foreground "maroon"))
        ("~" (:foreground "deep sky blue"))
        ("+" (:strike-through t))))


<a id="orga60333d"></a>

## Publishing

    (after! org (setq org-publish-project-alist
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
                         ;:html-head "<link rel=\"stylesheet\"
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
                        ("myprojectweb" :components("references-attachments" "pdf" "references-md" "tasks")))))


<a id="orgaf6b3f7"></a>

## Refiling

    (after! org (setq org-refile-targets '((org-agenda-files . (:maxlevel . 6)))
                      org-outline-path-complete-in-steps nil
                      org-refile-allow-creating-parent-nodes 'confirm))


<a id="org36179ea"></a>

## Startup

    (after! org (setq org-startup-indented t
                      org-src-tab-acts-natively t))
    (add-hook 'org-mode-hook 'variable-pitch-mode)
    (add-hook 'org-mode-hook 'visual-line-mode)
    (add-hook 'org-mode-hook (lambda () (org-autolist-mode)))
    (add-hook 'org-agenda-finalize-hook 'org-timeline-insert-timeline :append)
    
    ;(add-hook 'org-mode-hook 'org-num-mode)


<a id="org8b6cc79"></a>

## Tags

    (after! org (setq org-tags-column -80))
    (after! org (setq org-tag-alist '((:startgrouptag)
                                      ("GTD")
                                      (:grouptags)
                                      ("Control")
                                      ("Persp")
                                      (:endgrouptag)
                                      (:startgrouptag)
                                      ("Control")
                                      (:grouptags)
                                      ("Context")
                                      ("Task")
                                      (:endgrouptag))))


<a id="orga33be55"></a>

# Extra Modules


<a id="orga0f78f1"></a>

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
      (setq deft-directory "~/.org/notes/"
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


<a id="org345a610"></a>

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


<a id="orgc38ba5c"></a>

## Gnuplot

    ;(use-package gnuplot
    ;  :config
    ;  (setq gnuplot-program "gnuplot"))


<a id="org3c1e237"></a>

## Grip Mode


<a id="orgcc5a0e9"></a>

## Org Agenda Prefix

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


<a id="orgbbedf07"></a>

## Org Agenda Property

    ;(after! org (setq org-agenda-property-list '("WHO" "NEXTACT")
    ;                  org-agenda-property-position 'where-it-fits))


<a id="orgceb4060"></a>

## Org Outlook

    (require 'org)
    
    (org-add-link-type "outlook" 'org-outlook-open)
    
    (defun org-outlook-open (id)
       "Open the Outlook item identified by ID.  ID should be an Outlook GUID."
       (w32-shell-execute "open" (concat "outlook:" id)))
    
    (provide 'org-outlook)
    (require 'org-outlook)


<a id="org1671a70"></a>

## Org Clock Switch

    (defun org-clock-switch ()
      "Switch task and go-to that task"
      (interactive)
      (setq current-prefix-arg '(12)) ; C-u
      (call-interactively 'org-clock-goto)
      (org-clock-in)
      (org-clock-goto))
    (provide 'org-clock-switch)


<a id="orgf691b94"></a>

## Org Clock MRU

    (setq org-mru-clock-how-many 10)
    (setq org-mru-clock-completing-read #'ivy-completing-read)
    (setq org-mru-clock-keep-formatting t)
    (setq org-mru-clock-files #'org-agenda-files)


<a id="orgf591aed"></a>

## Org Mind Map

    ;(use-package org-mind-map
    ;  :init
    ;  (require 'ox-org)
    ;  ;; Uncomment the below if 'ensure-system-packages` is installed
    ;  ;;:ensure-system-package (gvgen . graphviz)
    ;  :config
    ;  (setq org-mind-map-engine "dot")       ; Default. Directed Graph
    ;  ;; (setq org-mind-map-engine "neato")  ; Undirected Spring Graph
    ;  ;; (setq org-mind-map-engine "twopi")  ; Radial Layout
    ;  ;; (setq org-mind-map-engine "fdp")    ; Undirected Spring Force-Directed
    ;  ;; (setq org-mind-map-engine "sfdp")   ; Multiscale version of fdp for the layout of large graphs
    ;  ;; (setq org-mind-map-engine "twopi")  ; Radial layouts
    ;  ;; (setq org-mind-map-engine "circo")  ; Circular Layout
    ;  )


<a id="org5e8ab51"></a>

## Org Rifle

    ID: 3256ce1c-aa68-4b99-823c-4c8fd6545c0b

I&rsquo;ll want to add some of my own custom rifle actions here.


<a id="org8e99024"></a>

## Plantuml

    (use-package ob-plantuml
      :ensure nil
      :commands
      (org-babel-execute:plantuml)
      :config
      (setq org-plantuml-jar-path (expand-file-name "~/.tools/plantuml.jar")))


<a id="org0a11efe"></a>

## Update Tickboxes

    (defun org-update-cookies-after-save()
      (interactive)
      (let ((current-prefix-arg '(4)))
        (org-update-statistics-cookies "ALL")))
    
    (add-hook 'org-mode-hook
              (lambda ()
                (add-hook 'before-save-hook 'org-update-cookies-after-save nil 'make-it-local)))
    (provide 'org-update-cookies-after-save)


<a id="orgf61c9d7"></a>

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


<a id="org60cc6f9"></a>

## Zyrohex/org-notes-refile

    (defun zyrohex/org-notes-refile ()
      "Process an item to the references bucket"
      (interactive)
      (let ((org-refile-targets '(("~/.gtd/references.org" :maxlevel . 6)))
            (org-refile-allow-creating-parent-nodes 'confirm))
        (call-interactively #'org-refile)))
    (provide 'zyrohex/org-notes-refile)


<a id="orgc633532"></a>

## Zyrohex/org-reference-refile

    (defun zyrohex/org-reference-refile (arg)
      "Process an item to the reference bucket"
      (interactive "P")
      (let ((org-refile-targets '(("~/.gtd/references.org" :maxlevel . 6))))
        (call-interactively #'org-refile)))
    (provide 'zyrohex/org-reference-refile)


<a id="org760e394"></a>

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


<a id="orgbe2bafd"></a>

## Move capture

    ID: d687b67d-0ca2-44c1-8acf-c1c807d1906e

    (defun my/last-captured-org-note ()
      "Move to the last line of the last org capture note."
      (interactive)
      (goto-char (point-max)))


<a id="org0ec40e6"></a>

## Prompt filename

    ID: fa8ee6b6-aefd-4dd2-94b5-592bff088b6d

    (defun my/generate-org-note-name ()
      (setq my-org-note--name (read-string "Name: "))
      (expand-file-name (format "%s.org"my-org-note--name) "~/.org/gtd/projects/"))


<a id="orgbe0e9ab"></a>

# Super Agenda Groups

    (org-super-agenda-mode t)
    (after! org-agenda (setq org-agenda-custom-commands
                             '(("k" "Tasks"
                                ((agenda ""
                                         ((org-agenda-files '("~/.org/gtd/tasks.org" "~/.org/gtd/tickler.org" "~/.org/gtd/projects.org"))
                                          (org-agenda-overriding-header "What's on my calendar")
                                          (org-agenda-span 'day)
                                          (org-agenda-start-day (org-today))
                                          (org-agenda-current-span 'day)
                                          (org-time-budgets-for-agenda)
                                          (org-super-agenda-groups
                                           '((:name "Today's Schedule"
                                                    :scheduled t
                                                    :time-grid t
                                                    :deadline t
                                                    :order 13)))))
                                 (todo ""
                                       ((org-agenda-overriding-header "[[~/.org/gtd/tasks.org][Task list]]")
                                        (org-agenda-prefix-format " %(my-agenda-prefix) ")
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
                                         '((:auto-property "WHO")))))
                                 (todo ""
                                       ((org-agenda-overriding-header "References")
                                        (org-agenda-files '("~/.org/gtd/references.org"))
                                        (org-super-agenda-groups
                                         '((:auto-ts t)))))))
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

