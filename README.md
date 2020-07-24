
# Table of Contents

-   [Getting started](#orgc591bdc)
    -   [New Changes](#org7d1dba7)
        -   [<span class="timestamp-wrapper"><span class="timestamp">[2020-07-22 Wed]</span></span>](#orgaa5c450)
        -   [<span class="timestamp-wrapper"><span class="timestamp">[2020-06-21 Sun]</span></span>](#org85b92fe)
        -   [<span class="timestamp-wrapper"><span class="timestamp">[2020-06-02 Tue]</span></span>](#orgfa84393)
    -   [Some Requirements](#org06075ea)
-   [Initial Settings](#org6ec4265)
    -   [Setting up our initial look to Emacs and Orgmode](#org0a5c372)
        -   [Configure Function to profile monitor setup](#org51a43c2)
        -   [We first setup our font settings](#org86bf78a)
        -   [Prettify ORGMODE and other aspects of Emacs](#org742fc31)
        -   [Configure Category Icons for ORGMODE-AGENDA](#org1a45af5)
    -   [Configure Default Templates](#org4ff279a)
    -   [Setup Default Directory and Files](#org8b47bd4)
-   [GTD Setup](#org2c9a0f8)
    -   [Setup our intial defaults for GTD](#orgf20fef1)
    -   [Capture System](#org01c8c11)
    -   [Configuring `someday.org`](#org4c1f8db)
    -   [Configuring `inbox.org`](#org7098341)
        -   [Refiling to `next.org`](#org22746f7)
        -   [Refiling to `someday.org`](#orgcaf8443)
    -   [Configuring `next.org`](#org588d3ce)
    -   [Setting up `references.org`](#orgd234dc3)
    -   [Setting up Refile Settings](#org3f6401f)
    -   [Configure PROJECTS](#orgcb0d08b)
    -   [Configure our KEYWORDS](#org12e51cf)
-   [Org-Roam with GTD](#org96fc7f5)
    -   [Setting up TASKS to integrate with our REFERENCES](#orgf0a2169)
-   [ORGMODE](#orge29638d)
    -   [Initial startup settings](#org5580b02)
    -   [Making things pretty](#orgc50736e)
    -   [Setting up property drawers](#org6c434cc)
    -   [Configuring TAGS](#org811d848)
    -   [How we want to publish projects](#org69cfdfc)
    -   [Configuring how refiling will work](#org5fb1444)
    -   [Configuring initial defaults](#org8abb5fb)
    -   [Keeping track of our logs and history](#org71818d0)
    -   [Setting up Export Settings](#org62ffcf6)
    -   [Telling Emacs how to treat links](#orgd325df7)
    -   [Setting up diary captures with ROAM integration](#org2d0d4b0)
    -   [Setting up agenda-files on first load](#orgb2cb02d)
    -   [Keeping our work safe](#org3be50cd)
-   [Environment](#orgb205ce2)
    -   [User Information](#org84a5e63)
    -   [Default folder(s) and file(s)](#org955f407)
    -   [Misc Settings](#org43fc706)
    -   [Key Bindings](#orgc2785d6)
    -   [Terminal Mode](#org1913a4a)
-   [Behavior](#org6a52324)
    -   [Popup Rules](#orga209bbc)
    -   [Buffer Settings](#orgb07d321)
    -   [Misc Settings](#org748b11b)
-   [Module Settings](#org3194a8b)
    -   [company mode](#org250af43)
    -   [Misc Modules [Bookmarks, PDF Tools]](#org19d0849)
    -   [Graphs and Chart Modules](#orgf109b8b)
    -   [Elfeed](#orga1ff12b)
    -   [DEFT](#orgc8659ca)
    -   [Org-Rifle](#org7f34f7a)
    -   [ROAM](#orgfe2b591)
    -   [ROAM Server](#orga26ee03)
    -   [ROAM Export Backlinks + Content](#org9a7c021)
    -   [Reveal [HTML Presentations]](#orgf36a248)
    -   [Super Agenda Settings](#org6508472)
-   [Load Extras](#org1ed24f2)
    -   [Theme Settings](#orgcdf2e50)
-   [Ideas to Consider](#orgb3eb910)
    -   [GANTT Chart](#org873a5f9)



<a id="orgc591bdc"></a>

# Getting started


<a id="org7d1dba7"></a>

## New Changes


<a id="orgaa5c450"></a>

### <span class="timestamp-wrapper"><span class="timestamp">[2020-07-22 Wed]</span></span>

1.  Added new functions specifically for GTD workflow, this will require some changes to fit your needs:
    1.  Configure your variable settings in [Setup our intial defaults for GTD](#orgf20fef1)


<a id="org85b92fe"></a>

### <span class="timestamp-wrapper"><span class="timestamp">[2020-06-21 Sun]</span></span>

1.  metrics-tracker + capture-template for habit tracker (see ~/.doom.d/templates/habitstracker.org)
2.  new templates for captures, breakfix, meeting-notes, diary and more&#x2026; (check the ~/.doom.d/templates/.. directory)
3.  added org-roam-server


<a id="orgfa84393"></a>

### <span class="timestamp-wrapper"><span class="timestamp">[2020-06-02 Tue]</span></span>

1.  Added `org-roam`
2.  Added agenda schdules faces (thanks to )
3.  Search and narrow&#x2026; Bound to `SPC ^`, this provides a function to pick a headline from the current buffer and narrow to it.
4.  Agenda-Hook to narrow on current subtree
5.  Deft mode with custom title maker (thanks to [jingsi&rsquo;s space](https://jingsi.space/post/2017/04/05/organizing-a-complex-directory-for-emacs-org-mode-and-deft/))
6.  GTD Inbox Processing &#x2026; Credit to Jethro for his function. Function is bound to `jethro/org-inbox-process`
7.  [Org-Web-Tools](https://github.com/alphapapa/org-web-tools), thanks Alphapapa for the awesome package.


<a id="org06075ea"></a>

## Some Requirements

These are some items that are required outside of the normal DOOM EMACS installation, before you can use this config. The idea here is to keep this minimum so as much of this is close to regular DOOM EMACS.

1.  **SQLITE3 Installation**: You will need to install sqlite3, typicalled installed via your package manager as `sudo apt install sqlite3`
2.  For fonts please download [Input](https://input.fontbureau.com/download/) and [DejaVu](http://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-ttf-2.37.tar.bz2)


<a id="org6ec4265"></a>

# Initial Settings

These are things that we absolutely must load before anything else


<a id="org0a5c372"></a>

## Setting up our initial look to Emacs and Orgmode


<a id="org51a43c2"></a>

### Configure Function to profile monitor setup

    (defun zyro/calculate-profile-width ()
      "Run calcuation to determine width of display"
      (when (and (> (* (/ (float (display-pixel-height)) (float (display-pixel-width))) 10) 3.5)
                (< (* (/ (float (display-pixel-height)) (float (display-pixel-width))) 10) 4.2))
        (setq zyro/monitor-profile-width '"ultra-wide"))
      (when (and (> (* (/ (float (display-pixel-height)) (float (display-pixel-width))) 10) 1.5)
                (< (* (/ (float (display-pixel-height)) (float (display-pixel-width))) 10) 2.9))
        (setq zyro/monitor-profile-width '"super-wide")))
    (zyro/calculate-profile-width)
    
    (setq zyro/monitor-profile-size (/ (* (float (display-pixel-width)) (float (display-pixel-height))) 100))


<a id="org86bf78a"></a>

### We first setup our font settings

    (setq doom-unicode-font doom-font)
    (when (> (display-pixel-height) 1200)
      (setq doom-font (font-spec :family "Input Mono" :size 18)
            doom-big-font (font-spec :family "Input Mono" :size 24)))
    
    (when (< (display-pixel-height) 1200)
      (setq doom-font (font-spec :family "Input Mono" :size 14)
            doom-big-font (font-spec :family "Input Mono" :size 18)))


<a id="org742fc31"></a>

### Prettify ORGMODE and other aspects of Emacs

    ;(font-lock-add-keywords 'org-mode
    ;                        '(("^ *\\([-]\\) "
    ;                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
    ;(font-lock-add-keywords 'org-mode
    ;                        '(("^ *\\([+]\\) "
    ;                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "▪"))))))
    
    ; "✖"
    (setq org-superstar-headline-bullets-list '("●" "○"))
    (setq org-ellipsis "▼")
    (add-hook 'org-mode-hook #'+org-pretty-mode)


<a id="org1a45af5"></a>

### Configure Category Icons for ORGMODE-AGENDA

    ;(customize-set-value
    ;    'org-agenda-category-icon-alist
    ;    `(
    ;      ("Breakfix" "~/.icons/repair.svg" nil nil :ascent center)
    ;      ("Escalation" "~/.dotfiles/icons/loop.svg" nil nil :ascent center)
    ;      ("Inquiry" "~/.dotfiles/icons/calendar.svg" nil nil :ascent center)
    ;      ("Deployment" "~/.icons/deployment.svg" nil nil :ascent center)
    ;      ("Project" "~/.icons/project-management.svg" nil nil :ascent center)
    ;      ("Improvement" "~/.icons/improvement.svg" nil nil :ascent center)
    ;      ("Sustaining" "~/.icons/chemistry.svg" nil nil :ascent center)))


<a id="org4ff279a"></a>

## Configure Default Templates

    (after! org (setq org-capture-templates
          '(("d" "Diary" plain (file zyro/capture-file-name)
             (file "~/.doom.d/templates/diary.org"))
            ("m" "Metrics Tracker" plain (file+olp+datetree diary-file "Metrics Tracker")
             (file "~/.doom.d/templates/metrics.org") :immediate-finish t)
            ("h" "Habits Tracker" entry (file+olp+datetree diary-file "Metrics Tracker")
             (file "~/.doom.d/templates/habitstracker.org") :immediate-finish t)
            ("a" "Article" plain (file+headline (concat (doom-project-root) "articles.org") "Inbox")
             "%(call-interactively #'org-cliplink-capture)")
            ("x" "Time Tracker" entry (file+headline "~/.org/timetracking.org" "Time Tracker")
    ;         "* %^{TITLE} %^{CUSTOMER}p %^{TAG}p" :clock-in t :clock-resume t)))
             (file "~/.doom.d/templates/timetracker.org") :clock-in t :clock-resume t))))


<a id="org8b47bd4"></a>

## Setup Default Directory and Files

    (setq org-directory "~/.org/")


<a id="org2c9a0f8"></a>

# GTD Setup


<a id="orgf20fef1"></a>

## TODO Setup our intial defaults for GTD

    
    ;; Configure ORG Directory
    (defvar org-directory "~/.org/")
    
    ;; Configure Folders
    (defvar org-gtd-tasks-folder "~/.org/tasks/")
    (defvar org-projects-folder "~/.org/tasks/projects/")
    
    ;; Configure files
    (defvar org-someday-file (file-truename (concat org-gtd-tasks-folder "someday.org")))
    (defvar org-inbox-file (file-truename (concat org-gtd-tasks-folder "inbox.org")))
    (defvar org-references-file (file-truename (concat org-gtd-tasks-folder "references.org")))
    (defvar org-tickler-file (file-truename (concat org-gtd-tasks-folder"tickler.org")))
    (defvar org-next-tasks-file (file-truename (concat org-gtd-tasks-folder "next.org")))


<a id="org01c8c11"></a>

## TODO Capture System

    (defun zyro/capture-system ()
      "Capture"
      (interactive)
      (let* ((org-capture-templates
             '(("!" "Quick Capture" plain (function zyro/capture-inbox)
                (file "~/.doom.d/templates/capture.org")))))
        (org-capture)))
    
    (defun zyro/capture-inbox ()
      "Function to locate file for capture template"
      (expand-file-name (format "%s" (file-name-nondirectory (car org-inbox-file))) org-gtd-tasks-folder))


<a id="org4c1f8db"></a>

## TODO Configuring `someday.org`

Configure our someday file finder

    (defun zyro/agenda-someday ()
      "Open next tasks in ORGMODE AGENDA"
      (interactive)
      (let ((org-agenda-files (list (car org-someday-file)))
            (org-super-agenda-groups
                         '((:priority "A")
                           (:priority "B")
                           (:todo "PROJ")
                           (:effort> "0:16")
                           (:effort< "0:15"))))
        (org-agenda nil "t")))

Configure Keybindings

    (map! :after org
          :map org-mode-map
          :leader
          :prefix ("e" . "Getting Things Done")
          :desc "SOMEDAY" "s" #'zyro/agenda-someday
          :prefix ("eg" . "goto")
          :desc "Someday Items" "s" #'org-find-someday-file)

Configuring file-finder

    (defun org-find-someday-file ()
      "Find default INBOX file"
      (interactive)
      (if (f-file-p (format "%s"(car org-someday-file)))
          (find-file (car org-someday-file))
        (error (format "'%s' does not exist, please check and make sure the file exist."))))


<a id="org7098341"></a>

## TODO Configuring `inbox.org`

Because GTD focuses on capturing information quick, we want the capture template to be callable with a single key-stroke. Here we also configure our capture template. The **KEY THING** here, is we want this process to be <span class="underline">QUICK AND EASY</span>. Do not prompt and ask for anything more than we need for the capture. Capture the name of the TASK, and leave a small blurb section to jot a quick note.

    (after! org (add-to-list 'org-capture-templates
                             '("!" "Capture" entry (file+headline "~/.org/inbox.org" "INBOX")
                               (file "~/.doom.d/templates/capture.org") :immediate-finish t)))
    
    (defun zyro/quick-capture ()
      "Quick capture to inbox from KEY-BINDING"
      (interactive)
      (org-capture nil "!"))
    
    (map! :after org
          :map org-mode-map
          :leader
          :prefix ("e" . "Getting Things Done")
          :desc "New Capture" "!" #'zyro/quick-capture)

For the Agenda, we can focus simply by `:auto-ts t` to see when our tasks was created

    (defun zyro/agenda-inbox ()
      "Configure our Inbox agenda"
      (interactive)
      (let ((org-agenda-files (list org-inbox-file))
            (org-super-agenda-groups
             '((:auto-ts t))))
        (org-agenda nil "t")))

Now configure default key bindings

    (map! :after org
          :map org-mode-map
          :leader
          :prefix ("e" . "Getting Things Done")
          :desc "Check Inbox" "i" #'zyro/agenda-inbox
          :prefix ("eg" . "goto")
          :desc "Inbox" "i" #'org-find-inbox-file)

Configure file finder

    (defun org-find-inbox-file ()
      "Find default INBOX file"
      (interactive)
      (if (f-file-p (format "%s"(car org-inbox-file)))
          (find-file (car org-inbox-file))
        (error (format "'%s' does not exist, please check and make sure the file exist."))))


<a id="org22746f7"></a>

### TODO Refiling to `next.org`

We use Jethro&rsquo;s function to process bulk agenda items&#x2026;

-   [ ] Write a new function to process bulk agenda items

    (defun jethro/org-process-inbox ()
      "Called in org-agenda-mode, processes all inbox items."
      (interactive)
      (org-agenda-bulk-mark-regexp "inbox:")
      (jethro/bulk-process-entries))

Configuring default effort value

    (defvar jethro/org-current-effort "1:00"
      "Current effort for agenda items.")

Set our effort to &ldquo;&#x2026;&rdquo;

    (defun jethro/my-org-agenda-set-effort (effort)
      "Set the effort property for the current headline."
      (interactive
       (list (read-string (format "Effort [%s]: " jethro/org-current-effort) nil nil jethro/org-current-effort)))
      (setq jethro/org-current-effort effort)
      (org-agenda-check-no-diary)
      (let* ((hdmarker (or (org-get-at-bol 'org-hd-marker)
                           (org-agenda-error)))
             (buffer (marker-buffer hdmarker))
             (pos (marker-position hdmarker))
             (inhibit-read-only t)
             newhead)
        (org-with-remote-undo buffer
          (with-current-buffer buffer
            (widen)
            (goto-char pos)
            (org-show-context 'agenda)
            (funcall-interactively 'org-set-effort nil jethro/org-current-effort)
            (end-of-line 1)
            (setq newhead (org-get-heading)))
          (org-agenda-change-all-lines newhead hdmarker))))

Function to process a single item in our inbox

    (defun jethro/org-agenda-process-inbox-item ()
      "Process a single item in the org-agenda."
      (org-with-wide-buffer
       (org-agenda-set-tags)
       (org-agenda-set-property)
       (org-agenda-priority)
       (call-interactively 'org-agenda-schedule)
       (call-interactively 'jethro/my-org-agenda-set-effort)
       (org-agenda-refile nil nil t)))

Bulk process entries

    (defun jethro/bulk-process-entries ()
      (if (not (null org-agenda-bulk-marked-entries))
          (let ((entries (reverse org-agenda-bulk-marked-entries))
                (processed 0)
                (skipped 0))
            (dolist (e entries)
              (let ((pos (text-property-any (point-min) (point-max) 'org-hd-marker e)))
                (if (not pos)
                    (progn (message "Skipping removed entry at %s" e)
                           (cl-incf skipped))
                  (goto-char pos)
                  (let (org-loop-over-headlines-in-active-region) (funcall 'jethro/org-agenda-process-inbox-item))
                  ;; `post-command-hook' is not run yet.  We make sure any
                  ;; pending log note is processed.
                  (when (or (memq 'org-add-log-note (default-value 'post-command-hook))
                            (memq 'org-add-log-note post-command-hook))
                    (org-add-log-note))
                  (cl-incf processed))))
            (org-agenda-redo)
            (unless org-agenda-persistent-marks (org-agenda-bulk-unmark-all))
            (message "Acted on %d entries%s%s"
                     processed
                     (if (= skipped 0)
                         ""
                       (format ", skipped %d (disappeared before their turn)"
                               skipped))
                     (if (not org-agenda-persistent-marks) "" " (kept marked)")))))

Initiate capture from agenda

    (defun jethro/org-inbox-capture ()
      (interactive)
      "Capture a task in agenda mode."
      (org-capture nil "i"))


<a id="orgcaf8443"></a>

### TODO Refiling to `someday.org`

    (defvar org-someday-file "~/.org/someday.org")
    (defun zyro/refile-someday ()
      "Refile TASK to SOMEDAY file"
      (interactive)
      (let ((org-refile-targets '((org-someday-file :maxlevel . 3))))
        (org-refile)))
    (bind-key "<f5>R" #'zyro/refile-someday)


<a id="org588d3ce"></a>

## TODO Configuring `next.org`

    (defun zyro/agenda-next-tasks ()
      "Open next tasks in ORGMODE AGENDA"
      (interactive)
      (let ((org-agenda-files (list org-next-tasks-file))
            (org-super-agenda-groups
                         '((:priority "A")
                           (:priority "B")
                           (:todo "PROJ")
                           (:effort> "0:16")
                           (:effort< "0:15"))))
        (org-agenda nil "t")))

Configure key bindings

    (map! :after org
          :map org-mode-map
          :leader
          :prefix ("e" . "Getting Things Done")
          :desc "Check Next Tasks" "n" #'zyro/agenda-next-tasks
          :prefix ("eg" . "goto")
          :desc "Next Tasks" "n" #'org-find-next-tasks-file)

Configure file finder

    (defun org-find-next-tasks-file ()
      "Default next task file"
      (interactive)
      (if (f-file-p (format "%s" (car org-next-tasks-file)))
          (find-file (car org-next-tasks-file))
          (goto-char (point-min))
        (error (format "'%s', does not exist. Please create the file before continuing." org-next-tasks-file))))


<a id="orgd234dc3"></a>

## TODO Setting up `references.org`

    (defun zyro/agenda-references ()
      "Open next tasks in ORGMODE AGENDA"
      (interactive)
      (let ((org-agenda-files (list (car org-references-file)))
            (org-super-agenda-groups
                         '((:auto-ts t))))
        (org-agenda nil "s")))
    
    (map! :after org
          :map org-mode-map
          :leader
          :prefix ("e" . "Getting Things Done")
          :desc "Search references" "r" #'zyro/agenda-references)
    
    (defun org-find-references-file ()
      "Find default INBOX file"
      (interactive)
      (if (f-file-p (format "%s"(car org-someday-file)))
          (find-file (car org-someday-file))
        (error (format "'%s' does not exist, please check and make sure the file exist."))))


<a id="org3f6401f"></a>

## STRT Setting up Refile Settings

I want ORGMODE to handle refiling a little different for GTD, such as when it comes from the `inbox.org` or `someday.org` file, it&rsquo;ll run a hook and require additional details to be added to the task file such as:

1.  effort estimate
2.  tags
3.  scheduling/deadline

    ;(defun zyro/refile-conditions ()
    ;  "Condition checker when refiling from target"
    ;  (when t (equal (buffer-file-name) '(or (org-inbox-file) (org-someday-file)))
    ;        (org-refile-targets)))


<a id="orgcb0d08b"></a>

## TODO Configure PROJECTS

Then we setup `ORGMODE AGENDA` to monitor the health of our projects

    (defun zyro/agenda-projects ()
      (interactive)
      (let ((org-agenda-files (list org-projects-folder))
            (org-agenda-custom-commands
             '(("w" "Master List"
                ((agenda ""
                         ((org-agenda-start-day (org-today))
                          (org-agenda-span 3)))
                 (todo ""
                       ((org-super-agenda-groups
                         '((:priority "A")
                           (:effort> "0:16")
                           (:priority "B"))))))))))
        (org-agenda nil "w")))


<a id="org12e51cf"></a>

## TODO Configure our KEYWORDS


<a id="org96fc7f5"></a>

# Org-Roam with GTD


<a id="orgf0a2169"></a>

## TODO Setting up TASKS to integrate with our REFERENCES


<a id="orge29638d"></a>

# ORGMODE


<a id="org5580b02"></a>

## Initial startup settings


<a id="orgc50736e"></a>

## Making things pretty


<a id="org6c434cc"></a>

## Setting up property drawers


<a id="org811d848"></a>

## Configuring TAGS

    (setq org-tags-column 0)


<a id="org69cfdfc"></a>

## How we want to publish projects


<a id="org5fb1444"></a>

## Configuring how refiling will work


<a id="org8abb5fb"></a>

## Configuring initial defaults


<a id="org71818d0"></a>

## Keeping track of our logs and history


<a id="org62ffcf6"></a>

## Setting up Export Settings

    (after! org (setq org-html-head-include-scripts t
                      org-export-with-toc t
                      org-export-with-author t
                      org-export-headline-levels 4
                      org-export-with-drawers nil
                      org-export-with-email t
                      org-export-with-footnotes t
                      org-export-with-sub-superscripts nil
                      org-export-with-latex t
                      org-export-with-section-numbers nil
                      org-export-with-properties nil
                      org-export-with-smart-quotes t
                      org-export-backends '(pdf ascii html latex odt md pandoc)))


<a id="orgd325df7"></a>

## Telling Emacs how to treat links


<a id="org2d0d4b0"></a>

## TODO Setting up diary captures with ROAM integration


<a id="orgb2cb02d"></a>

## Setting up agenda-files on first load

    (setq org-agenda-files (append (file-expand-wildcards (concat org-gtd-tasks-folder "*.org"))))


<a id="org3be50cd"></a>

## Keeping our work safe


<a id="orgb205ce2"></a>

# Environment


<a id="org84a5e63"></a>

## User Information

Load ORG Files
Environment settings, which are specific to the user and system. First up are user settings.

    (setq user-full-name "Nick Martin"
          user-mail-address "nmartin84@gmail.com")


<a id="org955f407"></a>

## Default folder(s) and file(s)

Then we will define some default files. I&rsquo;m probably going to use default task files for inbox/someday/todo at some point so expect this to change. Also note, all customer functions will start with a `+` to distinguish from major symbols.

    (setq diary-file "~/.org/diary.org")


<a id="org43fc706"></a>

## Misc Settings

Now we load some default settings for EMACS.

    (display-time-mode 1)
    (setq display-time-day-and-date t)
    (add-to-list 'default-frame-alist '(fullscreen . maximized))


<a id="orgc2785d6"></a>

## Key Bindings

From here we load some extra key bindings that I use often

    (bind-key "<f6>" #'link-hint-copy-link)
    (bind-key "C-M-<up>" #'evil-window-up)
    (bind-key "C-M-<down>" #'evil-window-down)
    (bind-key "C-M-<left>" #'evil-window-left)
    (bind-key "C-M-<right>" #'evil-window-right)
    (map! :after org
          :map org-mode-map
          :leader
          :desc "Move up window" "<up>" #'evil-window-up
          :desc "Move down window" "<down>" #'evil-window-down
          :desc "Move left window" "<left>" #'evil-window-left
          :desc "Move right window" "<right>" #'evil-window-right
          :desc "Toggle Narrowing" "!" #'org-toggle-narrow-to-subtree
          :desc "Find and Narrow" "^" #'+org-find-headline-narrow
          :desc "Rifle Project Files" "P" #'helm-org-rifle-project-files
          :prefix ("s" . "+search")
          :desc "Counsel Narrow" "n" #'counsel-narrow
          :desc "Rifle Buffer" "b" #'helm-org-rifle-current-buffer
          :desc "Rifle Agenda Files" "a" #'helm-org-rifle-agenda-files
          :desc "Deadgrep" "d" #'deadgrep
          :desc "Rifle Project Files" "#" #'helm-org-rifle-project-files
          :desc "Rifle Other Project(s)" "$" #'helm-org-rifle-other-files
          :prefix ("l" . "+links")
          "o" #'org-open-at-point
          "g" #'eos/org-add-ids-to-headlines-in-file
          :prefix ("e" . "Getting Things Done")
          :desc "Project Tasks [Agenda]" "P" #'zyro/agenda-projects
          :localleader
          :prefix ("s" . "Tree/Subtree")
          :desc "Refile to Someday" "R" #'zyro/refile-someday
          :prefix ("r" . "Refile")
          :desc "Refile to Someday" "R" #'zyro/refile-someday)
    
    (map! :leader
          :desc "Set Bookmark" "`" #'my/goto-bookmark-location
          :prefix ("s" . "search")
          :desc "Deadgrep Directory" "d" #'deadgrep
          :desc "Swiper All" "@" #'swiper-all
          :prefix ("o" . "open")
          :desc "Elfeed" "e" #'elfeed
          :desc "Deft" "w" #'deft
          :desc "Next Tasks" "n" #'org-find-next-tasks-file)


<a id="org1913a4a"></a>

## Terminal Mode

Set a few settings if we detect terminal mode

    (when (equal (window-system) nil)
      (and
       (bind-key "C-<down>" #'+org/insert-item-below)
       (setq doom-theme 'doom-monokai-pro)
       (setq doom-font (font-spec :family "Input Mono" :size 20))))


<a id="org6a52324"></a>

# Behavior


<a id="orga209bbc"></a>

## Popup Rules

    (set-popup-rule! "^\\*lsp-help" :side 'left :size .40 :select t :slot 1 :ttl 3)
    ;(when (> (display-pixel-width) '3000)
    ;(after! org (set-popup-rule! "*Org Agenda*" :side 'left :size .25 :height 0.5 :select t :slot 1 :ttl 3))
    ;(after! org (set-popup-rule! "*Capture*" :side 'left :size .25 :height 0.5 :select t :slot 1 :ttl 3))
    ;  (set-popup-rule! "*helm*" :side 'left :size .30 :select t :vslot 5 :ttl 3))
    ;(when (< (display-pixel-width) '2000)
    ;  (set-popup-rule! "*Org Agenda*" :side 'bottom :size .30 :select t :vslot 2 :ttl 3)
    ;  (set-popup-rule! "*Capture*" :side 'bottom :size .30 :select t :vslot 2 :ttl 3)
    ;  (set-popup-rule! "*helm*" :side 'bottom :size .30 :select t :vslot 5 :ttl 3))
                                            ;(after! org (set-popup-rule! "*Deft*" :side 'right :size .50 :select t :vslot 2 :ttl 3))
                                            ;(after! org (set-popup-rule! "*Select Link*" :side 'bottom :size .40 :select t :vslot 3 :ttl 3))
                                            ;(after! org (set-popup-rule! "*deadgrep" :side 'bottom :height .40 :select t :vslot 4 :ttl 3))
                                            ;(after! org (set-popup-rule! "\\Swiper" :side 'bottom :size .30 :select t :vslot 4 :ttl 3))


<a id="orgb07d321"></a>

## Buffer Settings

    (global-auto-revert-mode 1)
    (setq undo-limit 80000000
          evil-want-fine-undo t
          auto-save-default t
          inhibit-compacting-font-caches t)
    (whitespace-mode -1)


<a id="org748b11b"></a>

## Misc Settings

    (setq display-line-numbers-type t)
    (setq-default
     delete-by-moving-to-trash t
     tab-width 4
     uniquify-buffer-name-style 'forward
     window-combination-resize t
     x-stretch-cursor t)


<a id="org3194a8b"></a>

# Module Settings


<a id="org250af43"></a>

## company mode

    (setq company-idle-delay 0.5)


<a id="org19d0849"></a>

## Misc Modules [Bookmarks, PDF Tools]

Configuring PDF support and ORG-NOTER for note taking

    ;(use-package org-pdftools
    ;  :hook (org-load . org-pdftools-setup-link))


<a id="orgf109b8b"></a>

## Graphs and Chart Modules

Eventually I would like to have org-mind-map generating charts like Sacha&rsquo;s [evil-plans](https://pages.sachachua.com/evil-plans/).

    (after! org (setq org-ditaa-jar-path "~/.emacs.d/.local/straight/repos/org-mode/contrib/scripts/ditaa.jar"))
    
    ; GNUPLOT
    (use-package gnuplot
      :config
      (setq gnuplot-program "gnuplot"))
    
    ; MERMAID
    (setq mermaid-mmdc-location "~/node_modules/.bin/mmdc"
          ob-mermaid-cli-path "~/node_modules/.bin/mmdc")
    
    ; PLANTUML
    (use-package ob-plantuml
      :ensure nil
      :commands
      (org-babel-execute:plantuml)
      :config
      (setq plantuml-jar-path (expand-file-name "~/.doom.d/plantuml.jar")))


<a id="orga1ff12b"></a>

## Elfeed

    (require 'elfeed-org)
    (elfeed-org)
    (setq elfeed-db-directory "~/.elfeed/")
    (setq rmh-elfeed-org-files (list "~/google-drive/.elfeed/elfeed.org"))


<a id="orgc8659ca"></a>

## DEFT

    (load! "my-deft-title.el")
    (use-package deft
      :bind (("<f8>" . deft))
      :commands (deft deft-open-file deft-new-file-named)
      :config
      (setq deft-directory "~/.org/"
            deft-auto-save-interval 0
            deft-recursive t
            deft-current-sort-method 'title
            deft-extensions '("md" "txt" "org")
            deft-use-filter-string-for-filename t
            deft-use-filename-as-title nil
            deft-markdown-mode-title-level 1
            deft-file-naming-rules '((nospace . "-"))))
    (require 'my-deft-title)
    (advice-add 'deft-parse-title :around #'my-deft/parse-title-with-directory-prepended)


<a id="org7f34f7a"></a>

## Org-Rifle

    (use-package helm-org-rifle
      :after (helm org)
      :preface
      (autoload 'helm-org-rifle-wiki "helm-org-rifle")
      :config
    ;  (add-to-list 'helm-org-rifle-actions '("Super Link" . sl-insert-link-rifle-action) t)
      (add-to-list 'helm-org-rifle-actions '("Insert link" . helm-org-rifle--insert-link) t)
    ;  (add-to-list 'helm-org-rifle-actions '("Insert link with custom ID" . helm-org-rifle--insert-link-with-custom-id) t)
      (add-to-list 'helm-org-rifle-actions '("Store link" . helm-org-rifle--store-link) t)
    ;  (add-to-list 'helm-org-rifle-actions '("Store link with custom ID" . helm-org-rifle--store-link-with-custom-id) t)
    ;  (add-to-list 'helm-org-rifle-actions '("Add org-edna dependency on this entry (with ID)" . akirak/helm-org-rifle-add-edna-blocker-with-id) t)
      (add-to-list 'helm-org-rifle-actions '("Go-to Entry and Narrow" . helm-org-rifle--narrow))
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
    
      (defun helm-org-rifle--narrow (candidate)
        "Go-to and then Narrow Selection"
        (helm-org-rifle-show-entry candidate)
        (org-narrow-to-subtree))
    
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
      (helm-org-rifle-directories-recursive t)
      (helm-org-rifle-show-path t)
      (helm-org-rifle-test-against-path t))
    
    (provide 'setup-helm-org-rifle)


<a id="orgfe2b591"></a>

## ROAM

These are my default ROAM settings

    (setq org-roam-directory "~/.org/")
    (setq org-roam-tag-sources '(prop all-directories))
    ;(setq org-roam-db-location "~/.org/roam.db")
    (add-to-list 'safe-local-variable-values
    '(org-roam-directory . "."))


<a id="orga26ee03"></a>

## ROAM Server

    (use-package org-roam-server
      :ensure t
      :config
      (setq org-roam-server-host "127.0.0.1"
            org-roam-server-port 8070
            org-roam-server-export-inline-images t
            org-roam-server-authenticate nil
            org-roam-server-network-poll nil
            org-roam-server-network-arrows 'from
            org-roam-server-network-label-truncate t
            org-roam-server-network-label-truncate-length 60
            org-roam-server-network-label-wrap-length 20))


<a id="org9a7c021"></a>

## ROAM Export Backlinks + Content

    (defun my/org-roam--backlinks-list-with-content (file)
      (with-temp-buffer
        (if-let* ((backlinks (org-roam--get-backlinks file))
                  (grouped-backlinks (--group-by (nth 0 it) backlinks)))
            (progn
              (insert (format "\n\n* %d Backlinks\n"
                              (length backlinks)))
              (dolist (group grouped-backlinks)
                (let ((file-from (car group))
                      (bls (cdr group)))
                  (insert (format "** [[file:%s][%s]]\n"
                                  file-from
                                  (org-roam--get-title-or-slug file-from)))
                  (dolist (backlink bls)
                    (pcase-let ((`(,file-from _ ,props) backlink))
                      (insert (s-trim (s-replace "\n" " " (plist-get props :content))))
                      (insert "\n\n")))))))
        (buffer-string)))
    
      (defun my/org-export-preprocessor (backend)
        (let ((links (my/org-roam--backlinks-list-with-content (buffer-file-name))))
          (unless (string= links "")
            (save-excursion
              (goto-char (point-max))
              (insert (concat "\n* Backlinks\n") links)))))
    
      (add-hook 'org-export-before-processing-hook 'my/org-export-preprocessor)


<a id="orgf36a248"></a>

## Reveal [HTML Presentations]

    (require 'ox-reveal)
    (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
    (setq org-reveal-title-slide nil)


<a id="org6508472"></a>

## Super Agenda Settings

    (org-super-agenda-mode t)
    
    (setq org-agenda-custom-commands
          '(("w" "Master Agenda"
             ((agenda ""
                      ((org-agenda-overriding-header "Master Agenda")
                       (org-agenda-files (append (file-expand-wildcards "~/.org/tasks/*.org")))
                       (org-agenda-time-grid nil)
                       (org-agenda-start-day (org-today))
                       (org-agenda-span '1)))
              (todo ""
                    ((org-agenda-overriding-header "Master TODO List")
                     (org-agenda-files (append (file-expand-wildcards "~/.org/tasks/*")))
                     (org-super-agenda-groups
                      '((:auto-category t)))))
              (todo ""
                    ((org-agenda-files (list "~/.doom.d/config.org"))
                     (org-super-agenda-groups
                      '((:auto-parent t)))))))
            ("i" "Inbox"
             ((todo ""
                    ((org-agenda-overriding-header "")
                     (org-agenda-files (list "~/.org/inbox.org"))
                     (org-super-agenda-groups
                      '((:category "Cases")
                        (:category "Emails")
                        (:category "Inbox")))))))
            ("x" "Someday"
             ((todo ""
                    ((org-agenda-overriding-header "Someday")
                     (org-agenda-files (list "~/.org/someday.org"))
                     (org-super-agenda-groups
                      '((:auto-parent t)))))))))


<a id="org1ed24f2"></a>

# Load Extras

    ;(load! "orgmode.el")
    ;(load! "customs.el")


<a id="orgcdf2e50"></a>

## Theme Settings

    (toggle-frame-maximized)
    (setq doom-theme 'doom-dracula)


<a id="orgb3eb910"></a>

# Ideas to Consider


<a id="org873a5f9"></a>

## GANTT Chart

1.  <https://github.com/legalnonsense/elgantt/>

