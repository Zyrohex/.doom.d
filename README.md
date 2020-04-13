
# Table of Contents

-   [Getting started](#orgb08ca8c)
-   [Pretty](#org99bfc59)
    -   [Fonts](#org366ca00)
    -   [Theme](#org464416a)
-   [Environment](#org4eb395d)
    -   [User Settings](#org637c216)
    -   [Default Files](#orge04b49c)
    -   [Keys](#orgd26f4c4)
    -   [Extra Files](#org49a6c99)
-   [Behavior](#org865b4c0)
    -   [Popup Rules](#org6fc701d)
    -   [Buffer Settings](#org5d4cb24)
    -   [Other things](#orgfe93552)
-   [Module Settings](#orgd6d7b8f)
    -   [Bookmark+](#org006cff0)
    -   [Deft Mode](#org81617a9)
    -   [Elfeed](#orgdae30c9)
    -   [OrgMode](#org896564c)
        -   [Agenda](#orgfd3d8bc)
            -   [Load all \*.org files to agenda](#org842b4fb)
        -   [Captures](#org55e367f)
                -   [Capture](#orgf6fb61c)
        -   [Directories](#org0746b48)
        -   [Exports](#org241b2a7)
        -   [Faces](#org4762e6d)
        -   [Keywords](#org2a101bc)
        -   [Logging & Drawers](#org935f448)
        -   [Prettify](#org5d0d387)
        -   [Properties](#org7bd99ed)
        -   [Publishing](#org2779af2)
        -   [Refiling](#orgebe7238)
        -   [Startup](#org6100357)
        -   [Tags](#org871b580)
    -   [Org Rifle](#org4eaa4e3)
    -   [Org Roam](#orgd6ecd4f)
    -   [Super Agenda](#org99c74c7)
-   [Custom Functions](#orgab9f7bb)
    -   [my&#x2013;browse-url](#org046ac23)
    -   [my-agenda-prefix](#org2ceb290)
    -   [my/goto](#orgc334c5d)
    -   [org-archive-file](#orgc47a9f6)
    -   [org-capture-templates-dynamic-headline](#orgc2941ec)
    -   [org-capture-templates-dynamic-notes](#org26c6eae)
    -   [org-capture-file-selector](#org546ab09)
    -   [org-capture-headline-finder](#orgb1ac2be)
    -   [org-update-cookies-after-save](#org2d58090)
    -   [set-truncate-lines](#org0593670)

My DOOM emacs private configuration:
![img](attachments/doom.png)

High focus on GTD process workflow: ([source](https://github.com/nmartin84/.references/blob/master/gtd-babel.org))

![img](./attachments/gtd.png)


<a id="orgb08ca8c"></a>

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


<a id="org99bfc59"></a>

# Pretty


<a id="org366ca00"></a>

## Fonts

For fonts please download [Input](https://input.fontbureau.com/download/) and [DejaVu](http://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-ttf-2.37.tar.bz2)

    (setq doom-font (font-spec :family "InputMono" :size 18)
          doom-variable-pitch-font (font-spec :family "InputMono" :height 120)
          doom-unicode-font (font-spec :family "all-the-icons")
          doom-big-font (font-spec :family "InputMono" :size 20))


<a id="org464416a"></a>

## Theme

    (setq doom-theme 'chocolate)
    (custom-theme-set-faces
     'user
     '(org-ellipsis ((t (:foreground "SpringGreen")))))
    (if (equal doom-theme 'chocolate)
         (custom-theme-set-faces
          'user
          '(org-list-dt ((t (:foreground "cadet blue"))))
          '(org-ellipsis ((t (:foreground "gold"))))))
    (if (equal doom-theme 'chocolate)
         (setq org-emphasis-alist
               '(("*" (bold :foreground "MediumPurple"))
                 ("/" (italic :foreground "VioletRed"))
                 ("_" underline)
                 ("=" (:foreground "cadet blue"))
                 ("~" (:foreground "cadet blue"))
                 ("+" (:foreground "slate grey" :strike-through t)))))
         (if (equal doom-theme 'doom-snazzy)
             (custom-theme-set-faces
              'user
              '(org-block ((t (:background "#20222b"))))
              '(org-block-begin-line ((t (:background "#282A36"))))
              '(org-ellipsis ((t (:foreground "SpringGreen"))))
              '(org-headline-done ((t (:strike-through t))))))


<a id="org4eb395d"></a>

# Environment


<a id="org637c216"></a>

## User Settings

    (setq user-full-name "Nicholas Martin"
          user-mail-address "nmartin84.com")
    (display-time-mode 1)
    (setq display-time-day-and-date t)


<a id="orge04b49c"></a>

## Default Files

    (load-library "find-lisp")
    (defvar org-gtd-tasks-file "~/.org/workload/tasks.org")
    (defvar org-gtd-archive-file "~/.org/workload/archive.org")
    (defvar org-gtd-files (find-lisp-find-files "~/.org/" "\.org$"))
    (defvar org-gtd-notes-files (find-lisp-find-files "~/.org/notes/" "\.org$"))


<a id="orgd26f4c4"></a>

## Keys

    (map! :after org
          :map org-mode-map
          :localleader
          :desc "Toggle Narrowing" "!" #'org-toggle-narrow-to-subtree
          :prefix ("R" . "Rifle")
          "b" #'helm-org-rifle-current-buffer
          "a" #'helm-org-rifle-agenda-files
          "o" #'helm-org-rifle-org-directory
          "d" #'helm-org-rifle-directories
          :prefix ("l" . "+links")
          "o" #'org-open-at-point
          :prefix ("g" . "+goto")
          "q" #'orgql-search)
    
    (map! :leader
          :desc "Set Bookmark" "!" #'my/goto-bookmark-location
          :prefix ("s" . "search")
          :desc "Deadgrep Directory" "d" #'deadgrep
          :desc "Swiper All" "@" #'swiper-all
          :prefix ("o" . "open")
          :desc "Elfeed" "e" #'elfeed
          :desc "Deft" "w" #'deft)


<a id="org49a6c99"></a>

## Extra Files


<a id="org865b4c0"></a>

# Behavior


<a id="org6fc701d"></a>

## Popup Rules

    (after! org (set-popup-rule! "^Capture.*\\.org$" :side 'right :size .50 :select t :vslot 2 :ttl 3))
    (after! org (set-popup-rule! "Dictionary" :side 'bottom :size .30 :select t :vslot 3 :ttl 3))
    (after! org (set-popup-rule! "*helm*" :side 'bottom :size .30 :select t :vslot 5 :ttl 3))
    (after! org (set-popup-rule! "*eww*" :side 'right :size .30 :slect t :vslot 5 :ttl 3))
    (after! org (set-popup-rule! "*deadgrep" :side 'bottom :height .40 :select t :vslot 4 :ttl 3))
    (after! org (set-popup-rule! "\\Swiper" :side 'bottom :size .30 :select t :vslot 4 :ttl 3))
    (after! org (set-popup-rule! "*Ledger Report*" :side 'right :size .30 :select t :vslot 4 :ttl 3))
    (after! org (set-popup-rule! "*xwidget" :side 'right :size .50 :select t :vslot 5 :ttl 3))
    (after! org (set-popup-rule! "*Org Agenda*" :side 'right :size .40 :select t :vslot 2 :ttl 3))
    (after! org (set-popup-rule! "*Org ql" :side 'right :size .50 :select t :vslot 2 :ttl 3))


<a id="org5d4cb24"></a>

## Buffer Settings

    (global-auto-revert-mode t)


<a id="orgfe93552"></a>

## Other things

Set line numbers to relative:

    (setq display-line-numbers-type 'relative)

    (custom-set-faces! '(doom-modeline-evil-insert-state :weight bold :foreground "#339CDB"))


<a id="orgd6d7b8f"></a>

# Module Settings


<a id="org006cff0"></a>

## Bookmark+

    (require 'bookmark+)


<a id="org81617a9"></a>

## Deft Mode

    (setq deft-directory "~/.org/notes/")
    (setq deft-current-sort-method 'title)


<a id="orgdae30c9"></a>

## Elfeed

    (setq rmh-elfeed-org-files "~/.elfeed/elfeed.org")


<a id="org896564c"></a>

## OrgMode


<a id="orgfd3d8bc"></a>

### Agenda

    (after! org (setq org-agenda-files '("~/.org/workload/tasks.org" "~/.org/workload/references.org")))
    (after! org (setq org-agenda-diary-file "~/.org/diary.org"
                      org-agenda-dim-blocked-tasks t
                      org-agenda-use-time-grid t
                      org-agenda-hide-tags-regexp ":\\w+:"
                      org-agenda-compact-blocks t
                      org-agenda-block-separator nil
    ;                  org-agenda-prefix-format " %(my-agenda-prefix) "
                      org-agenda-skip-scheduled-if-done t
                      org-agenda-skip-deadline-if-done t
                      org-enforce-todo-checkbox-dependencies nil
                      org-habit-show-habits t))


<a id="org842b4fb"></a>

#### Load all \*.org files to agenda

    (load-library "find-lisp")
    (after! org (setq org-agenda-files
                      (find-lisp-find-files "~/.org/" "\.org$")))


<a id="org55e367f"></a>

### Captures

    ;(after! org (setq org-capture-templates
    ;                  '(("a" "Append")
    ;                    ("c" "Captures"))))


<a id="orgf6fb61c"></a>

##### Capture

-   Append Headline

        (after! org (add-to-list 'org-capture-templates
                                 '("h" "Append Headline" entry (file+function org-capture-file-selector org-capture-templates-append-headline)
                                   "%(format \"%s\" org-capture-templates-dynamic-opt1)%?")))

-   Append Notes

        (after! org (add-to-list 'org-capture-templates
                                 '("l" "Append List" plain (file+function org-capture-file-selector org-capture-templates-append-notes)
                                   "%(format \"%s\" org-capture-templates-dynamic-opt2)%?")))

-   New Task

        (after! org (add-to-list 'org-capture-templates
                     '("t" "Task" entry (file+headline org-gtd-tasks-file "INBOX")
                       "* TODO %^{taskname}%? %^{CATEGORY}p
        :PROPERTIES:
        :CREATED: %U
        :END:
        ")))

-   Reference

        (after! org (add-to-list 'org-capture-templates
                     '("r" "Reference" entry (file "~/.org/workload/references.org")
        "* TODO %u %^{reference}%?")))

-   Notes

        (defun my/generate-org-note-name ()
          (setq my-org-note--name (read-string "Name: "))
          (expand-file-name (format "%s.org" my-org-note--name) "~/.org/notes/"))
        
        (after! org (add-to-list 'org-capture-templates
                                 '("n" "New Note" plain (file my/generate-org-note-name)
                                   "%(format \"#+TITLE: %s\n\" my-org-note--name)
        %?")))
    
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
    
    -   +Item to Task
    
            (after! org (add-to-list 'org-capture-templates
                         '("fti" "+Task Item" plain (file+function "~/.org/workload/tasks.org" org-capture-headline-finder)
            "+ %u %?")))
    
    -   +Child Task
    
            (after! org (add-to-list 'org-capture-templates
                         '("ftc" "Child Task" entry (file+function "~/.org/workload/tasks.org" org-find-task-headline)
            "* TODO %u %^{task}%? %^G")))
    
    -   Child Task
    
            (after! org (add-to-list 'org-capture-templates
                         '("bt" "Task" entry (file+function buffer-name org-find-task-headline)
            "* TODO %u %^{task} %^G
            %?")))

-   Daily Task

        (after! org (add-to-list 'org-capture-templates
                                 '("d" "Daily Task" plain (file+headline "~/.org/workload/tasks.org" "Daily Items")
                                   "- [ ] %t %?")))

-   Time Tracking

        (after! org (add-to-list 'org-capture-templates
                     '("x" "Time Tracker" entry (file+olp+datetree "~/.org/workload/timetracking.org")
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


<a id="org0746b48"></a>

### Directories

    (after! org (setq org-directory "~/.org/"
                      org-image-actual-width nil
                      +org-export-directory "~/.export/"
                      org-archive-location "~/.org/workload/archive.org::datetree/"
                      org-default-notes-file "~/.org/workload/inbox.org"
                      projectile-project-search-path '("~/.org/")))


<a id="org241b2a7"></a>

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


<a id="org4762e6d"></a>

### Faces

Need to add condition to adjust faces based on theme select.

    (after! org (setq org-todo-keyword-faces
          '(("TODO" :foreground "OrangeRed" :weight bold)
            ("NEXT" :foreground "SteelBlue" :weight bold)
            ("SOMEDAY" :foreground "gold" :weight bold)
            ("ACTIVE" :foreground "DeepPink" :weight bold)
            ("NEXT" :foreground "spring green" :weight bold)
            ("DONE" :foreground "slategrey" :weight bold :strike-through t))))


<a id="org2a101bc"></a>

### Keywords

    (after! org (setq org-todo-keywords
          '((sequence "TODO(t)" "NEXT(n!)" "SOMEDAY(s!)" "HOLDING(h!)" "DELEGATED(e!)" "|" "DONE(d!)"))))


<a id="org935f448"></a>

### Logging & Drawers

    (after! org (setq org-log-state-notes-insert-after-drawers nil
                      org-log-into-drawer t
                      org-log-done 'time
                      org-log-repeat 'time
                      org-log-redeadline 'note
                      org-log-reschedule 'note))


<a id="org5d0d387"></a>

### Prettify

    ;(after! org (setq org-bullets-bullet-list '("•" "◦")
    (after! org (setq org-hide-emphasis-markers nil
                      org-bullets-bullet-list '("◉" "⚫" "○")
                      org-list-demote-modify-bullet '(("+" . "-") ("1." . "a.") ("-" . "+"))
                      org-ellipsis "▼"))


<a id="org7bd99ed"></a>

### Properties

    (setq org-use-property-inheritance t ; We like to inhert properties from their parents
          org-catch-invisible-edits 'smart) ; Catch invisible edits


<a id="org2779af2"></a>

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


<a id="orgebe7238"></a>

### Refiling

    (after! org (setq org-refile-targets '((org-agenda-files . (:maxlevel . 6)))
                      org-outline-path-complete-in-steps nil
                      org-refile-allow-creating-parent-nodes 'confirm))


<a id="org6100357"></a>

### Startup

    (after! org (setq org-startup-indented t
                      org-src-tab-acts-natively t))
    ;(add-hook 'org-mode-hook (lambda () (org-autolist-mode)))
    (add-hook 'org-mode-hook 'org-indent-mode)
    (add-hook 'org-mode-hook 'turn-off-auto-fill)


<a id="org871b580"></a>

### Tags

    (after! org (setq org-tags-column -80))


<a id="org4eaa4e3"></a>

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


<a id="orgd6ecd4f"></a>

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
    (require 'company-org-roam)
    (push 'company-org-roam company-backends)


<a id="org99c74c7"></a>

## Super Agenda

    (org-super-agenda-mode t)
    (setq org-agenda-custom-commands
          '(("k" "Tasks"
             ((agenda ""
                      ((org-agenda-overriding-header "Agenda")
                       (org-agenda-span 'day)
                       (org-agenda-start-day (org-today))
                       (org-agenda-files '("~/.org/workload/tasks.org" "~/.org/workload/tickler.org"))))
              (todo ""
                    ((org-agenda-overriding-header "Tasks")
                     (org-agenda-skip-function
                      '(or
                        (and
                         (org-agenda-skip-entry-if 'notregexp "#[A-C]")
                         (org-agenda-skip-entry-if 'notregexp ":@\\w+"))
                        (org-agenda-skip-if nil '(scheduled deadline))
                        (org-agenda-skip-if 'todo '("SOMEDAY"))))
                     (org-agenda-files '("~/.org/workload/tasks.org"))
                     (org-super-agenda-groups
                      '((:name "Priority Items"
                               :priority>= "B")
                        (:auto-parent t)))))
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
            ("i" "Inbox"
             ((todo ""
                    ((org-agenda-overriding-header "Inbox")
                     (org-agenda-skip-function
                      '(or
                        (org-agenda-skip-entry-if 'regexp ":@\\w+")
                        (org-agenda-skip-entry-if 'regexp "\[#[A-E]\]")
                        (org-agenda-skip-if 'nil '(scheduled deadline))
                        (org-agenda-skip-entry-if 'todo '("SOMEDAY"))
                        (org-agenda-skip-entry-if 'todo '("DELEGATED"))))
                     (org-agenda-files '("~/.org/workload/tasks.org"))
                     (org-super-agenda-groups
                      '((:auto-ts t)))))))
            ("s" "Someday"
             ((todo ""
                    ((org-agenda-overriding-header "Someday")
                     (org-agenda-skip-function
                      '(or
                        (org-agenda-skip-entry-if 'nottodo '("SOMEDAY"))))
                     (org-agenda-files '("~/.org/workload/tasks.org"))
                     (org-super-agenda-groups
                      '((:auto-parent t)))))))))
    (defun my/org-capture-note-file ()
      "Select a capture note file."
      (interactive)
      (let ((file (read-file-name "Note file: "
                                  (expand-file-name "notes/" org-directory))))
        (if (or (file-exists-p file)
                (string-suffix-p ".org" file))
            file
          (concat file ".org"))))


<a id="orgab9f7bb"></a>

# Custom Functions


<a id="org046ac23"></a>

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


<a id="org2ceb290"></a>

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


<a id="orgc334c5d"></a>

## my/goto

    ;;; my-goto.el --- go to things quickly -*- lexical-binding: t; -*-
    
    ;; This is free and unencumbered software released into the public domain.
    
    ;; Author: Bas Alberts <bas@anti.computer>
    ;; URL: https://github.com/anticomputer/my-goto.el
    
    ;; Version: 0.1
    ;; Package-Requires: ((emacs "25") (cl-lib "0.5"))
    
    ;; Keywords: bookmark
    
    ;;; Commentary:
    
    ;;; This lets you define custom dispatch bookmarks
    ;;; You can think of it as a lightweight `bookmark+'
    
    ;;; Code:
    (require 'bookmark)
    (require 'cl-lib)
    
    ;; add any custom classes to this list
    (defvar my/goto-classes '(:uri :file))
    
    ;; define a generic (xristos-fu)
    (cl-defgeneric my/goto-dispatch (class goto)
      "Visit GOTO based on CLASS.")
    
    ;; specialize the generic for the cases we want to handle
    (cl-defmethod my/goto-dispatch ((class (eql :uri)) goto)
      "Visit GOTO based on CLASS."
      (browse-url goto))
    
    (cl-defmethod my/goto-dispatch ((class (eql :file)) goto)
      "Visit GOTO based on CLASS."
      (find-file goto))
    
    ;; fall-through method
    (cl-defmethod my/goto-dispatch (class goto)
      "Visit GOTO based on CLASS."
      (message "goto: no handler for %s" class))
    
    (defun my/goto-bookmark-handler (bookmark)
      "Handle goto BOOKMARK through goto dispatchers."
      (let* ((v (read (cdr (assq 'filename bookmark))))
             (class (car v))
             (goto (cadr v)))
        (my/goto-dispatch class goto)))
    
    ;;;###autoload
    (defun my/goto-bookmark-location (class location &optional label)
      "Bookmark LOCATION of CLASS under optional LABEL."
      (interactive
       (let* ((class (read (completing-read "class: " my/goto-classes)))
              (location (if (eq class :file)
                            (read-file-name "location: ")
                          (read-string "location: ")))
              (label (read-string "label: " nil nil location)))
         (list class location label)))
      (unless (equal label "")
        (let ((label (or label location)))
          (bookmark-store
           label
           `((filename . ,(format "%S" `(,class ,location)))
             (handler . my/goto-bookmark-handler))
           nil))))
    
    (provide 'my-goto)
    ;;; my-goto.el ends here


<a id="orgc47a9f6"></a>

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


<a id="orgc2941ec"></a>

## org-capture-templates-dynamic-headline

    (defun org-capture-templates-append-headline ()
      "A guided walk-through to capturing"
      (interactive)
      (let ((org-agenda-files (list (buffer-file-name (current-buffer)))))
        (if (null (car org-agenda-files))
            (error "%s is not visiting a faile" (buffer-name (current-buffer)))
          (counsel-org-agenda-headlines)))
      (org-back-to-heading-or-point-min)
      (if (eq (count-lines (point-min) (point-max)) (count-lines (point-min) (point)))
          (newline-and-indent))
      (let ((var1 '("TODO" "Headline"))
            (var2 '("None" "Active" "In-Active")))
        (let ((selection (ivy-completing-read "Choose an option: " option1))
              (date1 (ivy-completing-read "Choose 2nd option: " option2)))
          (setq org-capture-templates-dynamic-opt1 (concat
                                                    (or
                                                     (if (equal selection (nth 0 var11))
                                                         (concat "* TODO "))
                                                     (if (equal selection (nth 1 var1))
                                                         (concat "* ")))
                                                    (or
                                                     (if (equal date1 (nth 0 var2))
                                                         (concat ""))
                                                     (if (equal date1 (nth 1 var2))
                                                         (concat (format-time-string "<%Y-%m-%d %a>")))
                                                     (if (equal date1 (nth 2 var2))
                                                         (concat (format-time-string "[%Y-%m-%d %a]")))))))))


<a id="org26c6eae"></a>

## org-capture-templates-dynamic-notes

    (defun org-capture-templates-append-notes ()
      "A guided walk-through to capturing"
      (interactive)
      (let ((org-agenda-files (list (buffer-file-name (current-buffer)))))
        (if (null (car org-agenda-files))
            (error "%s is not visiting a faile" (buffer-name (current-buffer)))
          (counsel-org-agenda-headlines)))
      (next-line)
      (org-end-of-subtree)
      (if (eq (count-lines (point-min) (point-max)) (count-lines (point-min) (point)))
          (newline-and-indent))
      (let ((var1 '("Checklist" "List" "None"))
            (var2 '("None" "Inactive" "Active")))
        (let
            ((selection (ivy-completing-read "Choose Line: " var1))
             (date1 (ivy-completing-read "Choose timestamp: " var2)))
          (setq org-capture-templates-dynamic-opt2 (concat
                                                    (or
                                                     (if (equal selection (nth 0 var1))
                                                         (concat "- [ ] "))
                                                     (if (equal selection (nth 1 var1))
                                                         (concat "- "))
                                                     (if (equal selection (nth 2 var1))
                                                         (concat "")))
                                                    (or
                                                     (if (equal date1 (nth 0 var2))
                                                         (concat ""))
                                                     (if (equal date1 (nth 1 var2))
                                                         (concat (format-time-string "[%Y-%m-%d %a]")))
                                                     (if (equal date1 (nth 2 var2))
                                                         (concat (format-time-string "<%Y-%m-%d %a>")))))))))


<a id="org546ab09"></a>

## org-capture-file-selector

    (defun org-capture-file-selector ()
      "test file selector"
      (interactive)
      (concat (read-file-name "Select file: " org-directory)))


<a id="orgb1ac2be"></a>

## org-capture-headline-finder

    (defun org-capture-headline-finder (&optional arg)
      "Like `org-todo-list', but using only the current buffer's file."
      (interactive "P")
      (let ((org-agenda-files (list (buffer-file-name (current-buffer)))))
        (if (null (car org-agenda-files))
            (error "%s is not visiting a file" (buffer-name (current-buffer)))
          (counsel-org-agenda-headlines)))
      (goto-char (org-end-of-subtree)))


<a id="org2d58090"></a>

## org-update-cookies-after-save

    (defun org-update-cookies-after-save()
      (interactive)
      (let ((current-prefix-arg '(4)))
        (org-update-statistics-cookies "ALL")))
    
    (add-hook 'org-mode-hook
              (lambda ()
                (add-hook 'before-save-hook 'org-update-cookies-after-save nil 'make-it-local)))
    (provide 'org-update-cookies-after-save)


<a id="org0593670"></a>

## set-truncate-lines

    (setq-default truncate-lines t)
    
    (defun jethro/truncate-lines-hook ()
      (setq truncate-lines nil))
    
    (add-hook 'text-mode-hook 'jethro/truncate-lines-hook)

