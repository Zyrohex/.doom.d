
# Table of Contents

-   [Getting started](#orgec53c98)
-   [General Settings](#org33dd801)
    -   [Keys](#orgea8a9f1)
    -   [General settings](#orgdf2d056)
    -   [Popup Rules](#orgeedd900)
    -   [User Settings](#org55684d6)
-   [Doom Settings](#org83b2f40)
    -   [Fonts](#orga28b1e5)
    -   [Mode line](#org8097d29)
    -   [Theme](#org30e51af)
-   [Org Mode Settings](#org694634b)
    -   [Agenda](#orga1d5901)
    -   [Load all \*.org files to agenda](#org4f40527)
    -   [Captures](#orgb907deb)
        -   [Diary](#org7a63d59)
        -   [New Task File](#org4ee9dc6)
        -   [Child Task](#org3e88c7b)
        -   [Notes](#org52a27c3)
        -   [Capture](#orge9b895b)
        -   [Workouts](#orgda2ef53)
        -   [Food](#orgef026de)
        -   [Weigh In](#org68deba3)
        -   [Ledger Expense](#orgef10c39)
        -   [Ledger Expense Date](#orgd4f4d24)
        -   [Ledger Income](#orgd4b8032)
    -   [Directories](#org03cb6a4)
    -   [Exports](#org821bfa2)
    -   [Faces](#org4566256)
    -   [Keywords](#org874ac2d)
    -   [Ledger](#orgb4557c8)
    -   [Link Abbreviations](#org7c7dd6d)
    -   [Logging & Drawers](#org577e6eb)
    -   [Prettify](#org3516e8d)
    -   [Publishing](#orgb8d8702)
    -   [Refiling](#org5ad1c0b)
    -   [Startup](#orgf1e497b)
    -   [Tags](#orgb96d568)
-   [Extra Modules](#org8fe1965)
    -   [Deft](#org2fc40fa)
    -   [Elfeed](#orgc0127dd)
    -   [Gnuplot](#orgc3df476)
    -   [Org Agenda Property](#orgb751444)
    -   [Org Clock MRU](#org2d193ac)
    -   [Org Clock Switch](#org0d81015)
    -   [Org Mind Map](#org87ec7a8)
    -   [Org Outlook](#org749d619)
    -   [Plantuml](#orgdfe0328)
    -   [Truncate](#orgd643370)
    -   [WSL Browser](#orgadd8d5d)
-   [Super Agenda Groups](#orgb89013c)
-   [Custom Functions](#org9e94458)
    -   [Archive File](#org2279c68)
    -   [Insert Item Below w/timestamp](#org1b3871e)
    -   [Move capture](#org6cfe386)
    -   [Org Agenda Prefix](#org60deafd)
    -   [Prompt filename](#org7491bab)
    -   [Update Tickboxes](#org619d557)
    -   [Zyrohex/org-notes-refile](#org66bbe5e)
    -   [Zyrohex/org-reference-refile](#org5dd70b6)
    -   [Zyrohex/org-tasks-refile](#org6be0e28)

My DOOM emacs private configuration:
![img](https://i.imgur.com/0NBUc3c.png)

High focus on GTD process workflow: ([source](https://github.com/nmartin84/.references/blob/master/gtd-babel.org))

![img](./attachments/gtd.png)


<a id="orgec53c98"></a>

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


<a id="org33dd801"></a>

# General Settings


<a id="orgea8a9f1"></a>

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
          :desc "Search buffer" :n "!" #'swiper
          :desc "Search all" :n "@" #'swiper-all
          :desc "Deadgrep search" :n "#" #'deadgrep
          :desc "Rifle directories" :n "$" #'helm-org-rifle-directories
          :desc "Capture" :n "X" #'org-capture
          (:prefix "o"
            :desc "Open Elfeed" :n "e" #'elfeed
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


<a id="orgdf2d056"></a>

## General settings

    (global-auto-revert-mode t)


<a id="orgeedd900"></a>

## Popup Rules

    (after! org (set-popup-rule! "^Capture.*\\.org$" :side 'right :size .50 :select t :vslot 2 :ttl 3))
    (after! org (set-popup-rule! "Dictionary" :side 'bottom :size .30 :select t :vslot 3 :ttl 3))
    (after! org (set-popup-rule! "*helm*" :side 'bottom :size .30 :select t :vslot 5 :ttl 3))
    (after! org (set-popup-rule! "*eww*" :side 'right :size .30 :slect t :vslot 5 :ttl 3))
    (after! org (set-popup-rule! "*deadgrep" :side 'bottom :height .40 :select t :vslot 4 :ttl 3))
    (after! org (set-popup-rule! "*org-roam" :side 'right :size .40 :select t :vslot 4 :ttl 3))
    (after! org (set-popup-rule! "\\Swiper" :side 'bottom :size .30 :select t :vslot 4 :ttl 3))
    (after! org (set-popup-rule! "*Ledger Report*" :side 'right :size .30 :select t :vslot 4 :ttl 3))
    (after! org (set-popup-rule! "*xwidget" :side 'right :size .50 :select t :vslot 5 :ttl 3))
    ;(after! org (set-popup-rule! "*org agenda*" :side 'right :size .50 :select t :vslot 2 :ttl 3))
    (after! org (set-popup-rule! "*Org ql" :side 'right :size .50 :select t :vslot 2 :ttl 3))


<a id="org55684d6"></a>

## User Settings

    (setq user-full-name "Nicholas Martin"
          user-mail-address "nmartin84.com")


<a id="org83b2f40"></a>

# Doom Settings


<a id="orga28b1e5"></a>

## Fonts

For fonts please download [Input](https://input.fontbureau.com/download/) and [DejaVu](http://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-ttf-2.37.tar.bz2)

    (setq doom-font (font-spec :family "InputMono" :size 18)
          doom-variable-pitch-font (font-spec :family "InputMono" :height 120)
          doom-unicode-font (font-spec :family "InputMono")
          doom-big-font (font-spec :family "InputMono" :size 20))
    (prefer-coding-system       'utf-8)
    (set-default-coding-systems 'utf-8)
    (set-terminal-coding-system 'utf-8)
    (set-keyboard-coding-system 'utf-8)


<a id="org8097d29"></a>

## Mode line

    (setq doom-modeline-gnus t
          doom-modeline-gnus-timer 'nil)


<a id="org30e51af"></a>

## Theme

    (setq doom-theme 'doom-city-lights)
    (if (equal doom-theme 'doom-snazzy)
        (custom-theme-set-faces
         'user
         '(org-block ((t (:background "#20222b"))))
         '(org-block-begin-line ((t (:background "#282A36"))))))
    (if (equal doom-theme 'doom-city-lights)
        (setq org-emphasis-alist
              '(("*" (bold :foreground "MediumPurple"))
                ("/" (italic :foreground "VioletRed"))
                ("_" underline)
                ("=" (:foreground "PaleTurquoise"))
                ("~" (:foreground "PaleTurquoise"))
                ("+" (:strike-through t))))
        (custom-theme-set-faces
         'user))


<a id="org694634b"></a>

# Org Mode Settings


<a id="orga1d5901"></a>

## Agenda

    (after! org (setq org-agenda-use-time-grid nil
                      org-agenda-skip-scheduled-if-done t
                      org-agenda-skip-deadline-if-done t
                      org-habit-show-habits t))
    (after! org (setq org-super-agenda-groups
                      '((:auto-category t))))


<a id="org4f40527"></a>

## Load all \*.org files to agenda

    (load-library "find-lisp")
    (after! org (setq org-agenda-files
    (find-lisp-find-files "~/.org/tasks/" "\.org$")))


<a id="orgb907deb"></a>

## Captures


<a id="org7a63d59"></a>

### Diary

    (defun my/generate-org-diary-name ()
      (setq my-org-note--name (read-string "Name: "))
      (setq my-org-note--time (format-time-string "%Y-%m-%d"))
      (expand-file-name (format "%s %s.org" my-org-note--time my-org-note--name) "~/.org/diary/"))
    
    (after! org (setq org-capture-templates
                      '(("d" "Diary" plain (file my/generate-org-diary-name)
                         "%(format \"#+TITLE: %s\n\" my-org-note--name my-org-note--time)
    %u %?")
                        ("l" "Ledger"))))


<a id="org4ee9dc6"></a>

### New Task File

    (defun my/generate-org-task-name ()
      (setq my-org-note--name (read-string "Name: "))
      (setq my-org-note--time (format-time-string "%Y-%m-%d"))
      (expand-file-name (format "%s %s.org" my-org-note--time my-org-note--name) "~/.org/tasks/"))
    
    (after! org (add-to-list 'org-capture-templates
                 '("t" "Task File" plain (file my/generate-org-task-name)
                   "%(format \"#+TITLE: %s\n\" my-org-note--name)
    \* INBOX %(format my-org-note--name) %?
    :PROPERTIES:
    :CREATED: %U
    :END:
    ")))


<a id="org3e88c7b"></a>

### Child Task

    (after! org (add-to-list 'org-capture-templates
                 '("c" "Child Task" entry (file+function buffer-name org-back-to-heading-or-point-min)
    "* %^{keyword|TODO|INBOX} %u %^{task}
    %?" :empty-lines 1)))


<a id="org52a27c3"></a>

### Notes

    (setq my/org-note-categories '(("Topic: ") ("Account: ") ("Symptom: ")))
    (defun my/generate-org-note-categories ()
      "Select a category for Notes"
      (interactive (list (completing-read "Select a category: " my/org-note-categories))))
    (defun my/generate-org-note-name ()
      (setq my-org-note--category (read-string "Category: "))
      (setq my-org-note--name (read-string "Name: "))
      (expand-file-name (format "%s.org" my-org-note--name) "~/.org/notes/"))
    
    (after! org (add-to-list 'org-capture-templates
                             '("n" "Note" plain (file my/generate-org-note-name)
                               "%(format \"#+TITLE: %s: %s\n\" my-org-note--category my-org-note--name)
    %?")))


<a id="orge9b895b"></a>

### Capture

    (after! org (add-to-list 'org-capture-templates
                 '("x" "Capture [WORKLOAD]" entry (file "~/.org/workload/inbox.org")
    "* INBOX %^{taskname}%?
    :PROPERTIES:
    :CREATED:    %U
    :END:
    " :immediate-finish t)))


<a id="orgda2ef53"></a>

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


<a id="orgef026de"></a>

### Food

    (after! org (add-to-list 'org-capture-templates
                 '("F" "Food Log" entry(file+olp+datetree"~/.org/journal/food.org")
    "** %\\1 [%\\2]
    :PROPERTIES:
    :FOOD:     %^{FOOD}
    :CALORIES: %^{CALORIES}
    :COMMENT:  %^{COMMENT}
    :END:")))


<a id="org68deba3"></a>

### Weigh In

    (after! org (add-to-list 'org-capture-templates
                 '("W" "Weigh In" entry(file+olp+datetree"~/.org/journal/food.org")
    "** %\\1 [%\\2]
    :PROPERTIES:
    :WEIGHT: %^{WEIGHT}
    :COMMENT:  %^{COMMENT}
    :END:")))


<a id="orgef10c39"></a>

### Ledger Expense

    (after! org (add-to-list 'org-capture-templates
                 '("le" "Ledger Expense" plain(file"~/.org/journal/finance.dat")
                   "%<%Y/%m/%d> * %^{Creditor}
        Expenses:%^{category|Snacks|Eating Out|Drinks|Movies|Games|Clothes|Shopping|Electronics}   %^{Dollar ammount}
        Assets:%^{account|Checking|CreditCard}" :empty-lines 1)))


<a id="orgd4f4d24"></a>

### Ledger Expense Date

    (after! org (add-to-list 'org-capture-templates
                 '("ld" "Ledger Expense Date" plain(file"~/.org/journal/finance.dat")
                   "2020/%^{month}/%^{date} * %^{Creditor}
        Expenses:%^{category}   %^{Dollar ammount}
        Income:%^{account}" :empty-lines 1)))


<a id="orgd4b8032"></a>

### Ledger Income

    (after! org (add-to-list 'org-capture-templates
                 '("li" "Ledger Income" plain(file"~/.org/journal/finance.dat")
                   "%<%Y/%m/%d> * %^{Payee}
        Income:%^{account}   %^{Dollar ammount}
        Payee:%^{who}" :empty-lines 1)))


<a id="org03cb6a4"></a>

## Directories

    (after! org (setq org-directory "~/.org/"
                      org-image-actual-width nil
                      +org-export-directory "~/.export/"
                      org-archive-location "~/.org/gtd/archive.org::datetree/"
                      org-default-notes-file "~/.org/gtd/inbox.org"
                      projectile-project-search-path '("~/.org/")))


<a id="org821bfa2"></a>

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
                      org-export-backends '(pdf ascii html md latex odt pandoc)))


<a id="org4566256"></a>

## Faces

Need to add condition to adjust faces based on theme select.

    (after! org (setq org-todo-keyword-faces
          '(("TODO" :foreground "tomato" :weight bold)
            ("WAITING" :foreground "light sea green" :weight bold)
            ("STARTED" :foreground "DodgerBlue" :weight bold)
            ("SOMEDAY" :foreground "sky blue" :weight bold)
            ("INBOX" :foreground "spring green" :weight bold)
            ("DELEGATED" :foreground "Gold" :weight bold)
            ("NEXT" :foreground "violet red" :weight bold)
            ("DONE" :foreground "slategrey" :weight bold))))


<a id="org874ac2d"></a>

## Keywords

    (after! org (setq org-todo-keywords
          '((sequence "TODO(t!)" "ACTIVE(a!)" "HOLDING(h!)" "NEXT(n!)" "DELEGATED(e!)" "INBOX(i!)" "SOMEDAY(s!)" "|" "INVALID(I!)" "DONE(d!)"))))


<a id="orgb4557c8"></a>

## Ledger

    (use-package ledger-mode
      :mode ("\\.dat\\'"
             "\\.ledger\\'")
      :custom (ledger-clear-whole-transactions t))
    
    (use-package flycheck-ledger :after ledger-mode)


<a id="org7c7dd6d"></a>

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


<a id="org577e6eb"></a>

## Logging & Drawers

    (after! org (setq org-log-state-notes-insert-after-drawers nil
                      org-log-into-drawer t
                      org-log-done 'time
                      org-log-repeat 'time
                      org-log-redeadline 'note
                      org-log-reschedule 'note))


<a id="org3516e8d"></a>

## Prettify

    (after! org (setq org-bullets-bullet-list '("◉" "○")
                      org-hide-emphasis-markers nil
                      org-list-demote-modify-bullet '(("+" . "-") ("1." . "a.") ("-" . "+"))
                      org-ellipsis "▼"))


<a id="orgb8d8702"></a>

## Publishing

    (after! org (setq org-publish-project-alist
                      '(("references-attachments"
                         :base-directory "~/.org/attachments/"
                         :base-extension "jpg\\|jpeg\\|png\\|pdf\\|css"
                         :publishing-directory "~/publish_html/attachments"
                         :publishing-function org-publish-attachment)
                        ("references-md"
                         :base-directory "~/.org/brain/"
                         :publishing-directory "~/publish"
                         :base-extension "org"
                         :auto-sitemap t
                         :sitemap-filename "index.html"
                         :recursive t
                         :headline-levels 5
                         :publishing-function org-html-publish-to-html
                         :section-numbers nil
                         :html-head "<link rel=\"stylesheet\" href=\"http://thomasf.github.io/solarized-css/solarized-light.min.css\" type=\"text/css\"/>"
                         :infojs-opt "view:t toc:t ltoc:t mouse:underline buttons:0 path:http://thomas.github.io/solarized-css/org-info.min.js"
                         :with-email t
                         :with-toc t)
                        ("myprojectweb" :components("references-attachments" "references-md")))))


<a id="org5ad1c0b"></a>

## Refiling

    (after! org (setq org-refile-targets '((org-agenda-files . (:maxlevel . 3)))
                      org-outline-path-complete-in-steps nil
                      org-refile-allow-creating-parent-nodes 'confirm))


<a id="orgf1e497b"></a>

## Startup

    (after! org (setq org-startup-indented t
                      org-src-tab-acts-natively t))
    (add-hook 'org-mode-hook (lambda () (org-autolist-mode)))
    ;(add-hook 'org-mode-hook 'org-num-mode)


<a id="orgb96d568"></a>

## Tags

    (after! org (setq org-tags-column -80))
    (after! org (setq org-tag-alist '((:startgrouptag)
                                      ("GTD")
                                      (:grouptags)
                                      ("Control" . ?c)
                                      ("Persp")
                                      (:endgrouptag)
                                      (:startgrouptag)
                                      ("Control")
                                      (:grouptags)
                                      ("Context")
                                      ("Task")
                                      (:endgrouptag))))


<a id="org8fe1965"></a>

# Extra Modules


<a id="org2fc40fa"></a>

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


<a id="orgc0127dd"></a>

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


<a id="orgc3df476"></a>

## Gnuplot

    ;(use-package gnuplot
    ;  :config
    ;  (setq gnuplot-program "gnuplot"))


<a id="orgb751444"></a>

## Org Agenda Property

    ;(after! org (setq org-agenda-property-list '("WHO" "NEXTACT")
    ;                  org-agenda-property-position 'where-it-fits))


<a id="org2d193ac"></a>

## Org Clock MRU

    (setq org-mru-clock-how-many 10)
    (setq org-mru-clock-completing-read #'ivy-completing-read)
    (setq org-mru-clock-keep-formatting t)
    (setq org-mru-clock-files #'org-agenda-files)


<a id="org0d81015"></a>

## Org Clock Switch

    ;(defun org-clock-switch ()
    ;  "Switch task and go-to that task"
    ;  (interactive)
    ;  (setq current-prefix-arg '(12)) ; C-u
    ;  (call-interactively 'org-clock-goto)
    ;  (org-clock-in)
    ;  (org-clock-goto))
    ;(provide 'org-clock-switch)


<a id="org87ec7a8"></a>

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


<a id="org749d619"></a>

## Org Outlook

    ;(require 'org)
    
    ;(org-add-link-type "outlook" 'org-outlook-open)
    
    ;(defun org-outlook-open (id)
    ;   "Open the Outlook item identified by ID.  ID should be an Outlook GUID."
    ;   (w32-shell-execute "open" (concat "outlook:" id)))
    
    ;(provide 'org-outlook)
    ;(require 'org-outlook)


<a id="orgdfe0328"></a>

## Plantuml

    (use-package ob-plantuml
      :ensure nil
      :commands
      (org-babel-execute:plantuml)
      :config
      (setq org-plantuml-jar-path (expand-file-name "~/.tools/plantuml.jar")))


<a id="orgd643370"></a>

## Truncate

    (setq-default truncate-lines t)
    
    (defun jethro/truncate-lines-hook ()
      (setq truncate-lines nil))
    
    (add-hook 'text-mode-hook 'jethro/truncate-lines-hook)


<a id="orgadd8d5d"></a>

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


<a id="orgb89013c"></a>

# Super Agenda Groups

    (org-super-agenda-mode t)
    (after! org-agenda (setq org-agenda-custom-commands
                             '(("k" "Tasks"
                                ((agenda "TODO|ACTIVE|HOLDING|NEXT"
                                         ((org-agenda-files '("~/.org/gtd/"))
                                          (org-agenda-overriding-header "What's on my calendar")
                                          (org-agenda-span 'day)
                                          (org-agenda-start-day (org-today))
                                          (org-agenda-current-span 'day)
                                          (org-time-budgets-for-agenda)
                                          (org-super-agenda-groups
                                           '((:name "Today's Schedule"
                                                    :scheduled t
                                                    :time-grid t
                                                    :deadline t)))))
                                 (todo "TODO|ACTIVE|HOLDING|NEXT"
                                       ((org-agenda-overriding-header "[[~/.org/gtd/tasks.org][Task list]]")
                                        (org-agenda-prefix-format " %(my-agenda-prefix) ")
                                        (org-agenda-files '("~/.org/gtd/"))
                                        (org-super-agenda-groups
                                         '((:auto-category t)))))))
                               ("i" "Inbox"
                                ((todo "INBOX|REFILE"
                                       ((org-agenda-files '("~/.org/gtd/"))
                                        (org-agenda-overriding-header "Items in my inbox")
                                        (org-super-agenda-groups
                                         '((:auto-ts t)))))))
                               ("x" "Get to someday"
                                ((todo "SOMEDAY"
                                       ((org-agenda-overriding-header "Projects marked Someday")
                                        (org-agenda-prefix-format " %(my-agenda-prefix) ")
                                        (org-agenda-files '("~/.org/gtd/"))
                                        (org-super-agenda-groups
                                         '((:auto-outline-path t))))))))))


<a id="org9e94458"></a>

# Custom Functions


<a id="org2279c68"></a>

## Archive File

    (defvar org-archive-directory "~/.org/archives/")
    (defun org-archive-file ()
      "Moves the current buffer to the archived folder"
      (interactive)
      (let ((old (or (buffer-file-name) (user-error "Not visiting a file")))
            (dir (read-directory-name "Move to: " org-archive-directory)))
        (write-file (expand-file-name (file-name-nondirectory old) dir) t)
        (delete-file old)))
    (provide 'org-archive-file)


<a id="org1b3871e"></a>

## Insert Item Below w/timestamp

Because i&rsquo;m always inserting inactive timestamps into new header items, so save
my fingers the abuse.

    (defun +org/insert-item-below-w-timestamp (count)
      "Inserts a new item below with inactive timestamp asserted."
      (interactive "p")
      (dotimes (_ count) (+org--insert-item 'below) (org-end-of-line) (insert (org-format-time-string "[%Y-%m-%d %a]") " ")))
    (map! :n "S-<return>" #'+org/insert-item-below-w-timestamp)


<a id="org6cfe386"></a>

## Move capture

    (defun my/last-captured-org-note ()
      "Move to the last line of the last org capture note."
      (interactive)
      (goto-char (point-max)))


<a id="org60deafd"></a>

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


<a id="org7491bab"></a>

## Prompt filename

    (defun my/generate-org-note-name ()
      (setq my-org-note--name (read-string "Name: "))
      (expand-file-name (format "%s.org"my-org-note--name) "~/.org/gtd/projects/"))


<a id="org619d557"></a>

## Update Tickboxes

    (defun org-update-cookies-after-save()
      (interactive)
      (let ((current-prefix-arg '(4)))
        (org-update-statistics-cookies "ALL")))
    
    (add-hook 'org-mode-hook
              (lambda ()
                (add-hook 'before-save-hook 'org-update-cookies-after-save nil 'make-it-local)))
    (provide 'org-update-cookies-after-save)


<a id="org66bbe5e"></a>

## Zyrohex/org-notes-refile

    (defun zyrohex/org-notes-refile ()
      "Process an item to the references bucket"
      (interactive)
      (let ((org-refile-targets '(("~/.gtd/references.org" :maxlevel . 6)))
            (org-refile-allow-creating-parent-nodes 'confirm))
        (call-interactively #'org-refile)))
    (provide 'zyrohex/org-notes-refile)


<a id="org5dd70b6"></a>

## Zyrohex/org-reference-refile

    (defun zyrohex/org-reference-refile (arg)
      "Process an item to the reference bucket"
      (interactive "P")
      (let ((org-refile-targets '(("~/.gtd/references.org" :maxlevel . 6))))
        (call-interactively #'org-refile)))
    (provide 'zyrohex/org-reference-refile)


<a id="org6be0e28"></a>

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

