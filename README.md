
# Table of Contents

-   [Getting started](#orgd147947)
-   [Pretty](#org184023e)
    -   [Fonts](#orgaa47ad6)
    -   [Theme](#org1a4e1a2)
-   [Envrionment](#orgbb5fd9b)
    -   [User Settings](#org0a3c003)
    -   [Keys](#org6198bea)
-   [Behavior](#orge5fc5ed)
    -   [Popup Rules](#org5dda576)
    -   [Buffer Settings](#org5262e07)
-   [Module Settings](#orgc2e17e8)
    -   [Org Rifle](#org54bbbf0)
    -   [Org Roam](#org604086a)
    -   [Deft Mode](#org96bc417)
    -   [ORG MODE](#org107f121)
        -   [Agenda](#org095c00a)
            -   [Load all \*.org files to agenda](#org7cda0ec)
        -   [Captures](#orge9804b0)
            -   [Capture](#org37e70fc)
                -   [New Task](#org407a824)
                -   [Reference](#org3a787d2)
                -   [Notes](#org995e2d4)
                -   [Daily Tasks](#org8442fb7)
                -   [Time Tracking](#orgc47d58d)
            -   [Headline](#org6ded8ca)
                -   [Append current heading](#org0d60ed8)
                -   [Itemized Notes](#org72319d8)
                -   [Child Task](#org1ae00bf)
            -   [File](#orgfba7b71)
                -   [Notes](#orgd1d9f41)
                -   [Tasks](#org2552007)
            -   [Buffer Find](#org1fa22c0)
                -   [Child Task](#org9108b97)
                -   [Child Headline](#org1177a04)
                -   [Headline Item](#orge522f6c)
        -   [Directories](#orgdf9fb27)
        -   [Exports](#org3fb26a9)
        -   [Faces](#org7d39a9e)
        -   [Keywords](#orgf3acb0d)
        -   [Logging & Drawers](#orgeb3d939)
        -   [Prettify](#org0893d12)
        -   [Publishing](#orgaf759eb)
        -   [Refiling](#org54f2d09)
        -   [Startup](#org2fa2c75)
        -   [Tags](#orge43daf9)
    -   [Super Agenda](#org5337a8a)
-   [Custom Functions](#org470e76c)
    -   [+org/insert-item-below-w-timestamp](#orgf2c05c9)
    -   [my&#x2013;browse-url](#org6e70325)
    -   [my-agenda-prefix](#org623b017)
    -   [my/org-archive-task](#orgcd8724b)
    -   [org-archive-file](#orgc137a7c)
    -   [org-capture-file-selector](#org39e5da1)
    -   [org-capture-headline-finder](#orgba331e9)
    -   [org-capture-template-select](#org5ea7dfb)
    -   [org-find-task-headline](#orgfab2f00)
    -   [org-new-task](#orgc351e02)
    -   [org-update-cookies-after-save](#org644d116)
    -   [set-truncate-lines](#org0d21573)

My DOOM emacs private configuration:
![img](attachments/doom.png)

High focus on GTD process workflow: ([source](https://github.com/nmartin84/.references/blob/master/gtd-babel.org))

![img](./attachments/gtd.png)


<a id="orgd147947"></a>

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


<a id="org184023e"></a>

# Pretty


<a id="orgaa47ad6"></a>

## Fonts

For fonts please download [Input](https://input.fontbureau.com/download/) and [DejaVu](http://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-ttf-2.37.tar.bz2)

    (setq doom-font (font-spec :family "InputMono" :size 16)
          doom-variable-pitch-font (font-spec :family "InputMono" :height 120)
          doom-unicode-font (font-spec :family "DejaVu Sans")
          doom-big-font (font-spec :family "InputMono" :size 20))


<a id="org1a4e1a2"></a>

## Theme

    (setq doom-theme 'doom-snazzy)
    ;(setq org-emphasis-alist
    ;      '(("*" (bold :foreground "MediumPurple"))
    ;        ("/" (italic :foreground "VioletRed"))
    ;        ("_" underline)
    ;        ("=" (:foreground "PaleTurquoise"))
    ;        ("~" (:foreground "PaleTurquoise"))
    ;        ("+" (:strike-through t))))
    (custom-theme-set-faces
     'user
     '(org-ellipsis ((t (:foreground "SpringGreen")))))
    (if (equal doom-theme 'doom-snazzy)
        (custom-theme-set-faces
         'user
         '(org-block ((t (:background "#20222b"))))
         '(org-block-begin-line ((t (:background "#282A36"))))
         '(org-ellipsis ((t (:foreground "SpringGreen"))))
         '(org-headline-done ((t (:strike-through t))))))


<a id="orgbb5fd9b"></a>

# Envrionment


<a id="org0a3c003"></a>

## User Settings

    (setq user-full-name "Nicholas Martin"
          user-mail-address "nmartin84.com")


<a id="org6198bea"></a>

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


<a id="orge5fc5ed"></a>

# Behavior


<a id="org5dda576"></a>

## Popup Rules

    (after! org (set-popup-rule! "^Capture.*\\.org$" :side 'right :size .50 :select t :vslot 2 :ttl 3))
    (after! org (set-popup-rule! "Dictionary" :side 'bottom :size .30 :select t :vslot 3 :ttl 3))
    (after! org (set-popup-rule! "*helm*" :side 'bottom :size .30 :select t :vslot 5 :ttl 3))
    (after! org (set-popup-rule! "*eww*" :side 'right :size .30 :slect t :vslot 5 :ttl 3))
    (after! org (set-popup-rule! "*deadgrep" :side 'bottom :height .40 :select t :vslot 4 :ttl 3))
    (after! org (set-popup-rule! "\\Swiper" :side 'bottom :size .30 :select t :vslot 4 :ttl 3))
    (after! org (set-popup-rule! "*Ledger Report*" :side 'right :size .30 :select t :vslot 4 :ttl 3))
    (after! org (set-popup-rule! "*xwidget" :side 'right :size .50 :select t :vslot 5 :ttl 3))
    ;(after! org (set-popup-rule! "*Org Agenda*" :side 'right :size .40 :select t :vslot 2 :ttl 3))
    (after! org (set-popup-rule! "*Org ql" :side 'right :size .50 :select t :vslot 2 :ttl 3))


<a id="org5262e07"></a>

## Buffer Settings

    (global-auto-revert-mode t)


<a id="orgc2e17e8"></a>

# Module Settings


<a id="org54bbbf0"></a>

## Org Rifle

    (use-package helm-org-rifle
      :after (helm org)
      :preface
      (autoload 'helm-org-rifle-wiki "helm-org-rifle")
      :config
      ;; Define Helm actions to insert a link.
      ;; Note that these actions are effective only in org-mode and its
      ;; derived modes.
      (add-to-list 'helm-org-rifle-actions
                   '("Insert link"
                     . helm-org-rifle--insert-link)
                   t)
      (add-to-list 'helm-org-rifle-actions
                   '("Insert link with custom ID"
                     . helm-org-rifle--insert-link-with-custom-id)
                   t)
      (add-to-list 'helm-org-rifle-actions
                   '("Store link"
                     . helm-org-rifle--store-link)
                   t)
      (add-to-list 'helm-org-rifle-actions
                   '("Store link with custom ID"
                     . helm-org-rifle--store-link-with-custom-id)
                   t)
      (add-to-list 'helm-org-rifle-actions
                   '("Add org-edna dependency on this entry (with ID)"
                     . akirak/helm-org-rifle-add-edna-blocker-with-id)
                   t)
      (defun helm-org-rifle--store-link (candidate &optional use-custom-id)
        "Store a link to CANDIDATE."
        (-let (((buffer . pos) candidate))
          (with-current-buffer buffer
            (org-with-wide-buffer
             (goto-char pos)
             (when (and use-custom-id
                        (not (org-entry-get nil "CUSTOM_ID")))
               (org-set-property "CUSTOM_ID"
                                 (read-string (format "Set CUSTOM_ID for %s: "
                                                      (substring-no-properties
                                                       (org-format-outline-path
                                                        (org-get-outline-path t nil))))
                                              (helm-org-rifle--make-default-custom-id
                                               (nth 4 (org-heading-components))))))
             (call-interactively 'org-store-link)))))
      (defun helm-org-rifle--store-link-with-custom-id (candidate)
        "Store a link to CANDIDATE with a custom ID.."
        (helm-org-rifle--store-link candidate 'use-custom-id))
      (defun helm-org-rifle--insert-link (candidate &optional use-custom-id)
        "Insert a link to CANDIDATE."
        (unless (derived-mode-p 'org-mode)
          (user-error "Cannot insert a link into a non-org-mode"))
        (let ((orig-marker (point-marker)))
          (helm-org-rifle--store-link candidate use-custom-id)
          (-let (((dest label) (pop org-stored-links)))
            (org-goto-marker-or-bmk orig-marker)
            (org-insert-link nil dest label)
            (message "Inserted a link to %s" dest))))
      (defun helm-org-rifle--make-default-custom-id (title)
        (downcase (replace-regexp-in-string "[[:space:]]" "-" title)))
      (defun helm-org-rifle--insert-link-with-custom-id (candidate)
        "Insert a link to CANDIDATE with a custom ID."
        (helm-org-rifle--insert-link candidate t))
      ;; Based on the definition of helm-org-rifle-files in helm-org-rifle.el
      (helm-org-rifle-define-command
       "wiki" ()
       "Search in \"~/lib/notes/writing\" and `plain-org-wiki-directory' or create a new wiki entry"
       :sources `(,(helm-build-sync-source "Exact wiki entry"
                     :candidates (plain-org-wiki-files)
                     :action #'plain-org-wiki-find-file)
                  ,@(--map (helm-org-rifle-get-source-for-file it) files)
                  ,(helm-build-dummy-source "Wiki entry"
                     :action #'plain-org-wiki-find-file))
       :let ((files (let ((directories (list "~/lib/notes/writing"
                                             plain-org-wiki-directory
                                             "~/lib/notes")))
                      (-flatten (--map (f-files it
                                                (lambda (file)
                                                  (s-matches? helm-org-rifle-directories-filename-regexp
                                                              (f-filename file))))
                                       directories))))
             (helm-candidate-separator " ")
             (helm-cleanup-hook (lambda ()
                                  ;; Close new buffers if enabled
                                  (when helm-org-rifle-close-unopened-file-buffers
                                    (if (= 0 helm-exit-status)
                                        ;; Candidate selected; close other new buffers
                                        (let ((candidate-source (helm-attr 'name (helm-get-current-source))))
                                          (dolist (source helm-sources)
                                            (unless (or (equal (helm-attr 'name source)
                                                               candidate-source)
                                                        (not (helm-attr 'new-buffer source)))
                                              (kill-buffer (helm-attr 'buffer source)))))
                                      ;; No candidates; close all new buffers
                                      (dolist (source helm-sources)
                                        (when (helm-attr 'new-buffer source)
                                          (kill-buffer (helm-attr 'buffer source))))))))))
      :general
      (:keymaps 'org-mode-map
                "M-s r" #'helm-org-rifle-current-buffer)
      :custom
      (helm-org-rifle-directories-recursive nil)
      (helm-org-rifle-show-path t)
      (helm-org-rifle-test-against-path t))
    
    (provide 'setup-helm-org-rifle)


<a id="org604086a"></a>

## Org Roam

    (use-package! org-roam
      :commands (org-roam-insert org-roam-find-file org-roam)
      :init
      (setq org-roam-directory "~/.org/notes/")
      (setq org-roam-graph-viewer "/usr/bin/open")
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n b" . org-roam-switch-to-buffer)
               ("C-c n g" . org-roam-graph-show))
              :map org-mode-map
              (("C-c n i" . org-roam-insert)))
      :config
      (org-roam-mode +1))


<a id="org96bc417"></a>

## Deft Mode

    (setq deft-directory "~/.org/notes/")
    (setq deft-current-sort-method 'title)


<a id="org107f121"></a>

## ORG MODE


<a id="org095c00a"></a>

### Agenda

    (after! org (setq org-agenda-files '("~/.org/workload/tasks.org" "~/.org/workload/references.org")))
    ;(after! org (setq org-super-agenda-groups
    ;                  '((:auto-category t))))
    (after! org (setq org-agenda-diary-file "~/.org/diary.org"
                      org-agenda-dim-blocked-tasks t
                      org-agenda-use-time-grid t
                      org-agenda-hide-tags-regexp ":\w+:"
    ;                  org-agenda-prefix-format " %(my-agenda-prefix) "
                      org-agenda-skip-scheduled-if-done t
                      org-agenda-skip-deadline-if-done t
                      org-enforce-todo-checkbox-dependencies nil
                      org-habit-show-habits t))


<a id="org7cda0ec"></a>

#### Load all \*.org files to agenda

    (load-library "find-lisp")
    (after! org (setq org-agenda-files
                      (find-lisp-find-files "~/.org/" "\.org$")))


<a id="orge9804b0"></a>

### Captures

    (after! org (setq org-capture-templates
                      '(("h" "Headline")
                        ("b" "Buffer Find")
                        ("f" "File Find")
                        ("fn" "Notes")
                        ("ft" "Tasks")
                        ("c" "Captures"))))


<a id="org37e70fc"></a>

#### Capture


<a id="org407a824"></a>

##### New Task

    (after! org (add-to-list 'org-capture-templates
                 '("ct" "Task" entry (file+headline "~/.org/workload/tasks.org" "INBOX")
                   "* TODO %^{taskname} %^{CATEGORY}p
    :PROPERTIES:
    :CREATED: %U
    :END:
    ")))


<a id="org3a787d2"></a>

##### Reference

    (after! org (add-to-list 'org-capture-templates
                 '("cr" "Reference" entry (file "~/.org/workload/references.org")
    "* TODO %u %^{reference}
    %?")))


<a id="org995e2d4"></a>

##### Notes

    (setq my/org-note-categories '(("Topic: ") ("Account: ") ("Symptom: ")))
    (defun my/generate-org-note-categories ()
      "Select a category for Notes"
      (interactive (list (completing-read "Select a category: " my/org-note-categories))))
    (defun my/generate-org-note-name ()
      (setq my-org-note--category (read-string "Category: "))
      (setq my-org-note--name (read-string "Name: "))
      (expand-file-name (format "%s.org" my-org-note--name) "~/.org/notes/"))
    
    (after! org (add-to-list 'org-capture-templates
                             '("cn" "Note" plain (file my/generate-org-note-name)
                               "%(format \"#+TITLE: %s\n\" my-org-note--name)
    %?")))


<a id="org8442fb7"></a>

##### Daily Tasks

    (after! org (add-to-list 'org-capture-templates
                             '("cd" "Daily Task" plain (file+headline "~/.org/workload/tasks.org" "Daily Items")
                               "- [ ] %t %?")))


<a id="orgc47d58d"></a>

##### Time Tracking

    (after! org (add-to-list 'org-capture-templates
                 '("cx" "Time Tracker" entry (file+olp+datetree "~/.org/workload/timetracking.org")
                   "* [%\\1] %\\7 for %\\5
    :PROPERTIES:
    :CASENUMBER: %^{Case or SVCTAG}
    :ACCOUNT:  %^{account}
    :AUDIENCE: %^{audience}
    :SOURCE:   %^{source|Phone|Email|IM|Computer|Onsite|OOO|Meeting}
    :PERSON:   %^{Whose asking for help?}
    :TASK:     %^{task}
    :DESCRIPTION: %^{description}
    :CREATED:  %u
    :END:
    :LOGBOOK:
    :END:
    %?" :tree-type week :clock-in t :clock-resume t)))


<a id="org6ded8ca"></a>

#### Headline


<a id="org0d60ed8"></a>

##### Append current heading

    (after! org (add-to-list 'org-capture-templates
                 '("hh" "Append Headline" entry (file+function buffer-name org-end-of-subtree)
    "* %u %^{name}
    %?" :empty-lines 1)))


<a id="org72319d8"></a>

##### Itemized Notes

    (after! org (add-to-list 'org-capture-templates
                             '("hi" "Headline Item" plain (file+function buffer-name org-end-of-subtree)
                             "+ %u %?")))


<a id="org1ae00bf"></a>

##### Child Task

    (after! org (add-to-list 'org-capture-templates
                 '("hc" "Child Task" entry (file+function buffer-name org-back-to-heading-or-point-min)
    "* TODO %u %^{task}%? %^G")))


<a id="orgfba7b71"></a>

#### File


<a id="orgd1d9f41"></a>

##### Notes

-   +Entry to Note Headline

        (after! org (add-to-list 'org-capture-templates
                     '("fne" "Entry to Headline" entry (file+function org-capture-file-selector org-capture-headline-finder)
        "* %u %^{note}%? :%^G")))

-   +Entry to Note

        (defun org-capture-file-selector ()
          "test file selector"
          (interactive)
          (setq org-notes-directory "~/.org/notes/")
          (concat (read-file-name "Select file: " org-notes-directory)))
        (after! org (add-to-list 'org-capture-templates
                                 '("fnh" "New Headline to Note" entry (file org-capture-file-selector)
                                   "* %?")))

-   +Item to Note Headline

        (defun org-capture-file-selector ()
          "test file selector"
          (interactive)
          (setq org-notes-directory "~/.org/notes/")
          (concat (read-file-name "Select file: " org-notes-directory)))
        (after! org (add-to-list 'org-capture-templates
                                 '("fni" "New Item to Headline" plain (file+function org-capture-file-selector org-capture-headline-finder)
                                   "+ %u %?")))


<a id="org2552007"></a>

##### Tasks

-   +Item to Task

        (after! org (add-to-list 'org-capture-templates
                     '("fti" "+Task Item" plain (file+function "~/.org/workload/tasks.org" org-capture-headline-finder)
        "+ %u %?")))

-   +Child Task

        (after! org (add-to-list 'org-capture-templates
                     '("ftc" "Child Task" entry (file+function "~/.org/workload/tasks.org" org-find-task-headline)
        "* TODO %u %^{task}%? %^G")))


<a id="org1fa22c0"></a>

#### Buffer Find


<a id="org9108b97"></a>

##### Child Task

    (after! org (add-to-list 'org-capture-templates
                 '("bt" "Task" entry (file+function buffer-name org-find-task-headline)
    "* TODO %u %^{task} %^G
    %?")))


<a id="org1177a04"></a>

##### Child Headline

    (after! org (add-to-list 'org-capture-templates
                 '("bh" "Child Headline" entry (file+function buffer-name org-find-task-headline)
    "* %u %^{note}
    %?")))


<a id="orge522f6c"></a>

##### Headline Item

    (defun org-task-item-option ()
      "Simple function to select if you want a item or checklist inserted"
      (interactive)
      (let (choices ("Item" "Checklist")))
      (if (equal (choices "Item"))
          (concat "+ %u %?")
        (concat "+ [ ] %u %?")))
    (after! org (add-to-list 'org-capture-templates
                             '("bi" "Headline Item" plain (file+function buffer-name org-capture-headline-finder)
                             "+ %u %?")))


<a id="orgdf9fb27"></a>

### Directories

    (after! org (setq org-directory "~/.org/"
                      org-image-actual-width nil
                      +org-export-directory "~/.export/"
                      org-archive-location "~/.org/workload/archive.org::datetree/"
                      org-default-notes-file "~/.org/workload/inbox.org"
                      projectile-project-search-path '("~/.org/")))


<a id="org3fb26a9"></a>

### Exports

    (after! org (setq org-html-head-include-scripts t
                      org-export-with-toc t
                      org-export-with-author t
                      org-export-headline-levels 5
                      org-export-with-drawers nil
                      org-export-with-email t
                      org-export-with-footnotes t
                      org-export-with-sub-superscripts nil
                      org-export-with-latex t
                      org-export-with-section-numbers nil
                      org-export-with-properties t
                      org-export-with-smart-quotes t
                      org-export-backends '(pdf ascii html latex odt md pandoc)))


<a id="org7d39a9e"></a>

### Faces

Need to add condition to adjust faces based on theme select.

    (after! org (setq org-todo-keyword-faces
          '(("TODO" :foreground "OrangeRed" :weight bold)
            ("NEXT" :foreground "SteelBlue" :weight bold)
            ("SOMEDAY" :foreground "gold" :weight bold)
            ("ACTIVE" :foreground "DeepPink" :weight bold)
            ("NEXT" :foreground "spring green" :weight bold)
            ("DONE" :foreground "slategrey" :weight bold :strike-through t))))


<a id="orgf3acb0d"></a>

### Keywords

    (after! org (setq org-todo-keywords
          '((sequence "TODO(t)" "NEXT(n!)" "SOMEDAY(s!)" "HOLDING(h!)" "DELEGATED(e!)" "|" "DONE(d!)"))))


<a id="orgeb3d939"></a>

### Logging & Drawers

    (after! org (setq org-log-state-notes-insert-after-drawers nil
                      org-log-into-drawer t
                      org-log-done 'time
                      org-log-repeat 'time
                      org-log-redeadline 'note
                      org-log-reschedule 'note))


<a id="org0893d12"></a>

### Prettify

    ;(after! org (setq org-bullets-bullet-list '("•" "◦")
    (after! org (setq org-hide-emphasis-markers nil
                      org-bullets-bullet-list '("◉" "⚫" "○")
                      org-list-demote-modify-bullet '(("+" . "-") ("1." . "a.") ("-" . "+"))
                      org-ellipsis "▼"))


<a id="orgaf759eb"></a>

### Publishing

    (after! org (setq org-publish-project-alist
                      '(("attachments"
                         :base-directory "~/.org/notes/attachments/"
                         :base-extension "jpg\\|jpeg\\|png\\|pdf\\|css"
                         :publishing-directory "~/publish_html/images/"
                         :publishing-function org-publish-attachment)
                        ("notes"
                         :base-directory "~/.org/"
                         :publishing-directory "~/publish_html"
                         :base-extension "org"
                         :with-drawers t
                         :recursive t
                         :auto-sitemap t
                         :sitemap-filename "index.html"
                         :publishing-function org-html-publish-to-html
                         :section-numbers nil
                         :html-head "<link rel=\"stylesheet\"
                         href=\"http://dakrone.github.io/org.css\"
                         type=\"text/css\"/>"
                         :html-head-extra "<style type=text/css>body{ max-width:80%;  }</style>"
                         :with-email t
                         :html-link-up ".."
                         :auto-preamble t
                         :with-toc t)
                        ("myprojectweb" :components("attachments" "notes")))))


<a id="org54f2d09"></a>

### Refiling

    (after! org (setq org-refile-targets '((org-agenda-files . (:maxlevel . 6)))
                      org-outline-path-complete-in-steps nil
                      org-refile-allow-creating-parent-nodes 'confirm))


<a id="org2fa2c75"></a>

### Startup

    (after! org (setq org-startup-indented t
                      org-src-tab-acts-natively t))
    ;(add-hook 'org-mode-hook (lambda () (org-autolist-mode)))
    (add-hook 'org-mode-hook 'org-indent-mode)
    (add-hook 'org-mode-hook 'turn-off-auto-fill)


<a id="orge43daf9"></a>

### Tags

    (after! org (setq org-tags-column -80))


<a id="org5337a8a"></a>

## Super Agenda

    (org-super-agenda-mode t)
    
    (defun find-org-files (dir)
      "Simple function that'll scan a folder and return all ORG files"
      (interactive "p")
      (load-library "find-lisp")
      (setq org-agenda-files
            (find-lisp-find-files dir "\.org$")))
    
    (setq org-agenda-custom-commands
          '(("k" "Tasks"
             ((agenda ""
                      ((org-agenda-overriding-header "Agenda")
                       (org-agenda-span 'day)
                       (org-agenda-start-day (org-today))
                       (org-agenda-files '("~/.org/workload/tasks.org" "~/.org/workload/tickler.org"))))
              (todo ""
                    ((org-agenda-overriding-header "Priority Tasks")
                     (org-agenda-skip-function
                      '(or
                        (org-agenda-skip-if nil '(scheduled deadline))
                        (org-agenda-skip-entry-if 'notregexp "#[A-C]")
                        (org-agenda-skip-entry-if 'notregexp ":#\\w+")
                        (org-agenda-skip-entry-if 'todo '("SOMEDAY"))))
                     (org-agenda-files '("~/.org/workload/tasks.org"))
                     (org-super-agenda-groups
                      '((:auto-priority t)))))
              (todo ""
                    ((org-agenda-overriding-header "Tasks")
                     (org-agenda-skip-function
                      '(or
                        (org-agenda-skip-if nil '(scheduled deadline))
                        (org-agenda-skip-entry-if 'regexp "#[A-C]")
                        (org-agenda-skip-entry-if 'todo '("SOMEDAY"))
                        (org-agenda-skip-entry-if 'notregexp ":#\\w+")))
                     (org-agenda-files '("~/.org/workload/tasks.org"))
                     (org-super-agenda-groups
                      '((:auto-category t)))))
              (todo ""
                    ((org-agenda-overriding-header "Delegated Tasks")
                     (org-agenda-files '("~/.org/workload/tasks.org"))
                     (org-tags-match-list-sublevels t)
                     (org-agenda-skip-function
                      '(or
                        (org-agenda-skip-subtree-if 'nottodo '("DELEGATED"))))
                     (org-super-agenda-groups
                      '((:auto-property "WHO")))))))
            ("n" "Notes"
             ((todo ""
                    ((org-agenda-overriding-header "Note Actions")
                     (org-agenda-files '("~/.org/notes/"))
                     (org-super-agenda-groups
                      '((:auto-category t)))))))
            ("ii" "Inbox"
             ((todo ""
                    ((org-agenda-overriding-header "Inbox")
                     (org-agenda-skip-function
                      '(or
                        (org-agenda-skip-entry-if 'regexp ":#\\w+")
                        (org-agenda-skip-entry-if 'regexp "\[#[A-E]\]")
                        (org-agenda-skip-if 'nil '(scheduled deadline))
                        (org-agenda-skip-entry-if 'todo '("SOMEDAY"))
                        (org-agenda-skip-entry-if 'todo '("DELEGATED"))))
                     (org-agenda-files '("~/.org/workload/tasks.org"))
                     (org-super-agenda-groups
                      '((:auto-ts t)))))))
            ("is" "Someday"
             ((todo ""
                    ((org-agenda-overriding-header "Someday")
                     (org-agenda-skip-function
                      '(or
                        (org-agenda-skip-entry-if 'nottodo '("SOMEDAY"))))
                     (org-agenda-files '("~/.org/workload/tasks.org"))
                     (org-super-agenda-groups
                      '((:auto-outline-path t)))))))))


<a id="org470e76c"></a>

# Custom Functions


<a id="orgf2c05c9"></a>

## +org/insert-item-below-w-timestamp

    (defun +org/insert-item-below-w-timestamp (count)
      "Inserts a new item below with inactive timestamp asserted."
      (interactive "p")
      (dotimes (_ count) (+org--insert-item 'below) (org-end-of-line) (insert (org-format-time-string "[%Y-%m-%d %a]") " ")))
    (map! :n "S-<return>" #'+org/insert-item-below-w-timestamp)


<a id="org6e70325"></a>

## my&#x2013;browse-url

    (defun my--browse-url (url &optional _new-window)
      ;; new-window ignored
      "Opens link via powershell.exe"
      (interactive (browse-url-interactive-arg "URL: "))
      (let ((quotedUrl (format "start '%s'" url)))
        (apply 'call-process "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe" nil
               0 nil
               (list "-Command" quotedUrl))))
    (setq-default browse-url-browser-function 'my--browse-url)


<a id="org623b017"></a>

## my-agenda-prefix

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


<a id="orgcd8724b"></a>

## my/org-archive-task

    (defvar my-archive-dir "~/.org/archives/" "My Archive Directory")
    
    (defun my/org-archive-task ()
      "Moves the current buffer to the archived folder"
      (interactive)
      (let ((old (or (buffer-file-name) (user-error "Not visiting a file")))
            (dir (read-directory-name "Move to: " my-archive-dir)))
        (write-file (expand-file-name (file-name-nondirectory old) dir) t)
        (delete-file old)))


<a id="orgc137a7c"></a>

## org-archive-file

    (defvar org-archive-directory "~/.org/archives/")
    (defun org-archive-file ()
      "Moves the current buffer to the archived folder"
      (interactive)
      (let ((old (or (buffer-file-name) (user-error "Not visiting a file")))
            (dir (read-directory-name "Move to: " org-archive-directory)))
        (write-file (expand-file-name (file-name-nondirectory old) dir) t)
        (delete-file old)))
    (provide 'org-archive-file)


<a id="org39e5da1"></a>

## org-capture-file-selector

    (defun org-capture-file-selector ()
      "test file selector"
      (interactive)
      (setq org-notes-directory "~/.org/notes/")
      (concat (read-file-name "Select file: " org-notes-directory)))


<a id="orgba331e9"></a>

## org-capture-headline-finder

    CATEGORY: Test

    (defun org-capture-headline-finder (&optional arg)
      "Like `org-todo-list', but using only the current buffer's file."
      (interactive "P")
      (let ((org-agenda-files (list (buffer-file-name (current-buffer)))))
        (if (null (car org-agenda-files))
            (error "%s is not visiting a file" (buffer-name (current-buffer)))
          (counsel-org-agenda-headlines)))
      (goto-char (org-end-of-subtree)))


<a id="org5ea7dfb"></a>

## org-capture-template-select

    (defun org-capture-template-select (checkitem)
      "Concat results to function"
      (if (equal checkitem "Checklist")
          (concat "+ [ ] ")
        (concat (format-time-string "+ [%Y-%m-%d] "))))
    
    (defun org-capture-template-selector ()
      "Select your choice"
      (interactive)
      (let ((choice '("Checklist" "Unordered List")))
        (org-capture-template-select (org-completing-read "Pick option: " choice))))


<a id="orgfab2f00"></a>

## org-find-task-headline

    (defun org-find-task-headline ()
      "Find headline in Task Files"
      (interactive)
      (setq org-agenda-files '("~/.org/workload/tasks.org"))
      (counsel-org-agenda-headlines))


<a id="orgc351e02"></a>

## org-new-task

    (defun org-new-task ()
      "Creates a new task below current header"
      (interactive)
      (setq task-name (read-string "Task name: "))
      (setq task-category (read-string "Category: "))
      (setq task-case (read-string "Case Number: "))
      (+org--insert-item 'below) (org-end-of-subtree)
      (insert
       (format "TODO %s" task-name))
      (insert
       (format"\n:PROPERTIES:\n:CATEGORY: %s" task-category))
      (if task-case
          (insert (format "\n:CASENUMBER: %s" task-case)))
      (insert
       (format"\n:END:")))


<a id="org644d116"></a>

## org-update-cookies-after-save

    (defun org-update-cookies-after-save()
      (interactive)
      (let ((current-prefix-arg '(4)))
        (org-update-statistics-cookies "ALL")))
    
    (add-hook 'org-mode-hook
              (lambda ()
                (add-hook 'before-save-hook 'org-update-cookies-after-save nil 'make-it-local)))
    (provide 'org-update-cookies-after-save)


<a id="org0d21573"></a>

## set-truncate-lines

    (setq-default truncate-lines t)
    
    (defun jethro/truncate-lines-hook ()
      (setq truncate-lines nil))
    
    (add-hook 'text-mode-hook 'jethro/truncate-lines-hook)

