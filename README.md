
# Table of Contents

-   [Getting started](#org8b79860)
-   [General Settings](#org8aa98e9)
    -   [Lines](#org1e6aee7)
    -   [Keys](#org3310df8)
    -   [General settings](#org3b9668e)
    -   [Popup Rules](#org5d16d1d)
    -   [User Settings](#org2663e9d)
-   [Doom Settings](#org8e67b3f)
    -   [Fonts](#orgba338c0)
    -   [Mode line](#org0937d6b)
    -   [Theme](#org271bdc5)
-   [Org Mode Settings](#orgebb6ce8)
    -   [Agenda](#orgba37490)
    -   [Load all \*.org files to agenda](#orgae7c2fb)
    -   [Captures](#org9a01507)
        -   [Getting Things Done](#org2e6843d)
            -   [Capture](#orgee00835)
        -   [Tasks](#org5ea9230)
            -   [Recurring Tasks](#orgc934c6e)
            -   [New parent with child task](#org5cc62de)
            -   [New Task in heading](#org24ce17b)
            -   [Append sub-heading to current](#org6851688)
        -   [Projects](#org9057e7d)
            -   [New Project](#org6ed3ccb)
        -   [References](#org32f00cb)
            -   [Reference - Yank Example](#orgb07d76b)
            -   [Reference - New Entry](#orge135736)
    -   [Directories](#orge2db85d)
    -   [Exports](#orge8e10de)
    -   [Faces](#org81d04d1)
    -   [Keywords](#orga137f38)
    -   [Latex Exports](#org7e9c3c5)
    -   [Link Abbreviations](#orge67ada8)
    -   [Logging & Drawers](#org4d3ad79)
    -   [Pitch Settings](#orgf139b20)
    -   [Prettify](#org9d39ebc)
    -   [Publishing](#org51c51f7)
    -   [Refiling](#org827a11d)
    -   [Startup](#org7430789)
    -   [Tags](#orgfdaedb8)
-   [Extra Modules](#org7e8f5ce)
    -   [Alert](#orgb956a9b)
    -   [Deft](#org41aba1a)
    -   [Elfeed](#orgf18294a)
    -   [Gnuplot](#orgb9db794)
    -   [Grip Mode](#org7e6919d)
    -   [Org Agenda Prefix](#org863aeea)
    -   [Org Agenda Property](#org65f55a3)
    -   [Org Outlook](#orgdac374c)
    -   [Org Clock Switch](#org1141eee)
    -   [Org Clock MRU](#orgc7d1ab9)
    -   [Org Mind Map](#org4eb9e7f)
    -   [Org Rifle](#org4321d7c)
    -   [Plantuml](#org1bb4aad)
    -   [Update Tickboxes](#org3ab8b8c)
    -   [WSL Browser](#org841eb1b)
    -   [Zyrohex/org-notes-refile](#org259b3e0)
    -   [Zyrohex/org-reference-refile](#org66b2654)
    -   [Zyrohex/org-tasks-refile](#orgac0e6bc)
    -   [Move capture](#orgcb997b3)
    -   [Prompt filename](#org9fa1c70)
-   [Super Agenda Groups](#org105af59)

My DOOM emacs private configuration:
![img](https://i.imgur.com/0NBUc3c.png)

High focus on GTD process workflow: ([source](https://github.com/nmartin84/.references/blob/master/gtd-babel.org))

![img](./attachments/gtd.png)


<a id="org8b79860"></a>

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


<a id="org8aa98e9"></a>

# General Settings


<a id="org1e6aee7"></a>

## Lines

For this we just make small tweaks to line numbers.

    (setq display-line-numbers t)


<a id="org3310df8"></a>

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


<a id="org3b9668e"></a>

## General settings

    (setq-default fill-column 80)
    (global-auto-revert-mode t)


<a id="org5d16d1d"></a>

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


<a id="org2663e9d"></a>

## User Settings

    (setq user-full-name "Nicholas Martin"
          user-mail-address "nmartin84.com")


<a id="org8e67b3f"></a>

# Doom Settings


<a id="orgba338c0"></a>

## Fonts

For fonts please download [Input](https://input.fontbureau.com/download/) and [DejaVu](http://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-ttf-2.37.tar.bz2)

    (setq doom-font (font-spec :family "InputMono" :size 20)
          doom-variable-pitch-font (font-spec :family "InputMono" :height 120)
          doom-unicode-font (font-spec :family "DejaVu Sans")
          doom-big-font (font-spec :family "InputMono" :size 18))
    (prefer-coding-system       'utf-8)
    (set-default-coding-systems 'utf-8)
    (set-terminal-coding-system 'utf-8)
    (set-keyboard-coding-system 'utf-8)
    (setq default-buffer-file-coding-system 'utf-8)


<a id="org0937d6b"></a>

## Mode line

    (setq doom-modeline-gnus t
          doom-modeline-gnus-timer 'nil)


<a id="org271bdc5"></a>

## Theme

    (setq doom-theme 'doom-gruvbox)


<a id="orgebb6ce8"></a>

# Org Mode Settings


<a id="orgba37490"></a>

## Agenda

    (after! org (setq org-agenda-use-time-grid nil
                      org-agenda-skip-scheduled-if-done t
                      org-agenda-skip-deadline-if-done t
                      org-habit-show-habits t))
    (after! org (setq org-super-agenda-groups
                      '((:auto-category t))))


<a id="orgae7c2fb"></a>

## Load all \*.org files to agenda

    (load-library "find-lisp")
    (after! org (setq org-agenda-files
    (find-lisp-find-files "~/.org/" "\.org$")))


<a id="org9a01507"></a>

## Captures

    (after! org (setq org-capture-templates
                      '(("t" "Tasks")
                        ("p" "Projects")
                        ("r" "References"))))


<a id="org2e6843d"></a>

### Getting Things Done


<a id="orgee00835"></a>

#### Capture

    (after! org (add-to-list 'org-capture-templates
                 '("c" "Capture [GTD]" entry (file "~/.org/gtd/inbox.org")
    "* TODO %^{taskname}%?
    :PROPERTIES:
    :CREATED:    %U
    :END:
    " :immediate-finish t)))


<a id="org5ea9230"></a>

### Tasks


<a id="orgc934c6e"></a>

#### Recurring Tasks

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


<a id="org5cc62de"></a>

#### New parent with child task

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


<a id="org24ce17b"></a>

#### New Task in heading

    (after! org (add-to-list 'org-capture-templates
                 '("tc" "Add Task to Current" entry (file+function buffer-name org-back-to-heading-or-point-min)
    "* TODO %^{taskname}
    :PROPERTIES:
    :CREATED:    %U
    :END:
    :LOGBOOK:
    :END:
    
    %?" :clock-in t :clock-resume t)))


<a id="org6851688"></a>

#### Append sub-heading to current

    (after! org (add-to-list 'org-capture-templates
                 '("ta" "Append new entry to existing header" entry (file+function buffer-name org-back-to-heading-or-point-min)
    "* %^{topic}
    :PROPERTIES:
    :CREATED:    %U
    :END:
    :LOGBOOK:
    :END:
    
    %?" :clock-in t :clock-resume t)))


<a id="org9057e7d"></a>

### Projects


<a id="org6ed3ccb"></a>

#### New Project

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


<a id="org32f00cb"></a>

### References


<a id="orgb07d76b"></a>

#### Reference - Yank Example

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


<a id="orge135736"></a>

#### Reference - New Entry

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


<a id="orge2db85d"></a>

## Directories

    (after! org (setq org-directory "~/.org/"
                      org-image-actual-width nil
                      +org-export-directory "~/.export/"
                      org-archive-location "~/.org/gtd/archive.org::datetree/"
                      org-default-notes-file "~/.org/gtd/inbox.org"
                      projectile-project-search-path '("~/")))


<a id="orge8e10de"></a>

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


<a id="org81d04d1"></a>

## TODO Faces

Need to add condition to adjust faces based on theme select.

    (after! org (setq org-todo-keyword-faces
          '(("TODO" :foreground "tomato" :weight bold)
            ("WAITING" :foreground "light sea green" :weight bold)
            ("STARTED" :foreground "DodgerBlue" :weight bold)
            ("DELEGATED" :foreground "Gold" :weight bold)
            ("NEXT" :foreground "violet red" :weight bold)
            ("DONE" :foreground "slategrey" :weight bold))))


<a id="orga137f38"></a>

## Keywords

    (after! org (setq org-todo-keywords
          '((sequence "TODO(t)" "WAITING(w!)" "STARTED(s!)" "NEXT(n!)" "DELEGATED(e!)" "|" "INVALID(I!)" "DONE(d!)"))))


<a id="org7e9c3c5"></a>

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


<a id="orge67ada8"></a>

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


<a id="org4d3ad79"></a>

## Logging & Drawers

    (after! org (setq org-log-state-notes-insert-after-drawers nil
                      org-log-into-drawer t
                      org-log-done 'time
                      org-log-repeat 'time
                      org-log-redeadline 'note
                      org-log-reschedule 'note))


<a id="orgf139b20"></a>

## Pitch Settings


<a id="org9d39ebc"></a>

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


<a id="org51c51f7"></a>

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


<a id="org827a11d"></a>

## Refiling

    (after! org (setq org-refile-targets '((org-agenda-files . (:maxlevel . 6)))
                      org-outline-path-complete-in-steps nil
                      org-refile-allow-creating-parent-nodes 'confirm))


<a id="org7430789"></a>

## Startup

    (after! org (setq org-startup-indented t
                      org-src-tab-acts-natively t))
    (add-hook 'org-mode-hook 'variable-pitch-mode)
    (add-hook 'org-mode-hook 'visual-line-mode)
    (add-hook 'org-mode-hook (lambda () (org-autolist-mode)))
    (add-hook 'org-agenda-finalize-hook 'org-timeline-insert-timeline :append)
    
    ;(add-hook 'org-mode-hook 'org-num-mode)


<a id="orgfdaedb8"></a>

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


<a id="org7e8f5ce"></a>

# Extra Modules


<a id="orgb956a9b"></a>

## Alert

    (setq alert-default-style 'mode-line)


<a id="org41aba1a"></a>

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


<a id="orgf18294a"></a>

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


<a id="orgb9db794"></a>

## Gnuplot

    ;(use-package gnuplot
    ;  :config
    ;  (setq gnuplot-program "gnuplot"))


<a id="org7e6919d"></a>

## Grip Mode


<a id="org863aeea"></a>

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


<a id="org65f55a3"></a>

## Org Agenda Property

    ;(after! org (setq org-agenda-property-list '("WHO" "NEXTACT")
    ;                  org-agenda-property-position 'where-it-fits))


<a id="orgdac374c"></a>

## Org Outlook

    (require 'org)
    
    (org-add-link-type "outlook" 'org-outlook-open)
    
    (defun org-outlook-open (id)
       "Open the Outlook item identified by ID.  ID should be an Outlook GUID."
       (w32-shell-execute "open" (concat "outlook:" id)))
    
    (provide 'org-outlook)
    (require 'org-outlook)


<a id="org1141eee"></a>

## Org Clock Switch

    (defun org-clock-switch ()
      "Switch task and go-to that task"
      (interactive)
      (setq current-prefix-arg '(12)) ; C-u
      (call-interactively 'org-clock-goto)
      (org-clock-in)
      (org-clock-goto))
    (provide 'org-clock-switch)


<a id="orgc7d1ab9"></a>

## Org Clock MRU

    (setq org-mru-clock-how-many 10)
    (setq org-mru-clock-completing-read #'ivy-completing-read)
    (setq org-mru-clock-keep-formatting t)
    (setq org-mru-clock-files #'org-agenda-files)


<a id="org4eb9e7f"></a>

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


<a id="org4321d7c"></a>

## Org Rifle

    ID: 3256ce1c-aa68-4b99-823c-4c8fd6545c0b

I&rsquo;ll want to add some of my own custom rifle actions here.


<a id="org1bb4aad"></a>

## Plantuml

    (use-package ob-plantuml
      :ensure nil
      :commands
      (org-babel-execute:plantuml)
      :config
      (setq org-plantuml-jar-path (expand-file-name "~/.tools/plantuml.jar")))


<a id="org3ab8b8c"></a>

## Update Tickboxes

    (defun org-update-cookies-after-save()
      (interactive)
      (let ((current-prefix-arg '(4)))
        (org-update-statistics-cookies "ALL")))
    
    (add-hook 'org-mode-hook
              (lambda ()
                (add-hook 'before-save-hook 'org-update-cookies-after-save nil 'make-it-local)))
    (provide 'org-update-cookies-after-save)


<a id="org841eb1b"></a>

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


<a id="org259b3e0"></a>

## Zyrohex/org-notes-refile

    (defun zyrohex/org-notes-refile ()
      "Process an item to the references bucket"
      (interactive)
      (let ((org-refile-targets '(("~/.gtd/references.org" :maxlevel . 6)))
            (org-refile-allow-creating-parent-nodes 'confirm))
        (call-interactively #'org-refile)))
    (provide 'zyrohex/org-notes-refile)


<a id="org66b2654"></a>

## Zyrohex/org-reference-refile

    (defun zyrohex/org-reference-refile (arg)
      "Process an item to the reference bucket"
      (interactive "P")
      (let ((org-refile-targets '(("~/.gtd/references.org" :maxlevel . 6))))
        (call-interactively #'org-refile)))
    (provide 'zyrohex/org-reference-refile)


<a id="orgac0e6bc"></a>

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


<a id="orgcb997b3"></a>

## Move capture

    ID: d687b67d-0ca2-44c1-8acf-c1c807d1906e

    (defun my/last-captured-org-note ()
      "Move to the last line of the last org capture note."
      (interactive)
      (goto-char (point-max)))


<a id="org9fa1c70"></a>

## Prompt filename

    ID: fa8ee6b6-aefd-4dd2-94b5-592bff088b6d

    (defun my/generate-org-note-name ()
      (setq my-org-note--name (read-string "Name: "))
      (expand-file-name (format "%s.org"my-org-note--name) "~/.org/gtd/projects/"))


<a id="org105af59"></a>

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

