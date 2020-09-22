
# Table of Contents

-   [New Changes](#org1fe9507)
-   [Requirements](#org1c805ce)
-   [Default Settings](#org8151e6c)
-   [User Information](#org226e2e5)
-   [Misc Settings](#org5a0d59b)
-   [Key Bindings](#org3f3ffdd)
-   [Terminal Mode](#orga137eea)
-   [Default folder(s) and file(s)](#org1ee70bc)
-   [Setup Layout by Monitor Profile](#org52431ef)
-   [Org mode settings](#org6fe8529)
    -   [Capture Templates](#org203ce58)
-   [Directory settings](#orgf011c4a)
-   [Export Settings](#org0312ad9)
-   [Misc Org Mode settings](#orgbcfc7be)
-   [Keywords](#org6d675c3)
-   [Logging and Drawers](#org55dda0c)
-   [Properties](#org6c08298)
-   [Publishing](#orga1a1bd9)
-   [Refiling Defaults](#org3435167)
-   [Orgmode Startup](#orga483996)
-   [Org Protocol](#org5b5f71d)
-   [Default Tags](#org1fff40c)
-   [Buffer Settings](#org7f09723)
-   [Misc Settings](#orgab7e9d7)
-   [Module Settings](#org67193ed)
    -   [company mode](#orgd948536)
    -   [Define Word](#org3771699)
    -   [Misc Modules [Bookmarks, PDF Tools]](#org4d302e9)
    -   [Graphs and Chart Modules](#orga88d606)
    -   [Elfeed](#orgf3c9b40)
    -   [DEFT](#org99b1f96)
    -   [Org-Rifle](#orgf5bc7ed)
    -   [Pandoc](#org070490d)
    -   [ROAM](#org117fe83)
    -   [ROAM Server](#orgc6cd31a)
    -   [ROAM Export Backlinks + Content](#orga799bdb)
    -   [Reveal [HTML Presentations]](#org93b87c7)
    -   [Super Agenda Settings](#orgfd95832)
-   [Loading secrets](#orge342cfd)
-   [Hacks](#org4b99df2)
    -   [Embed Images in HTML org-export](#orga6cb5c0)
-   [Custom Functions](#org6be994b)
    -   [Time Stamps](#org358bd19)
    -   [Capture Template File Picker](#org93af5f6)
-   [Theme Settings](#org2fec88e)



<a id="org1fe9507"></a>

# New Changes

1.  <span class="timestamp-wrapper"><span class="timestamp">[2020-06-02 Tue]</span></span>
    1.  Added `org-roam`
    2.  Added agenda schdules faces (thanks to )
    3.  Search and narrow&#x2026; Bound to `SPC ^`, this provides a function to pick a headline from the current buffer and narrow to it.
    4.  Agenda-Hook to narrow on current subtree
    5.  Deft mode with custom title maker (thanks to [jingsi&rsquo;s space](https://jingsi.space/post/2017/04/05/organizing-a-complex-directory-for-emacs-org-mode-and-deft/))
    6.  GTD Inbox Processing &#x2026; Credit to Jethro for his function. Function is bound to `jethro/org-inbox-process`
    7.  [Org-Web-Tools](https://github.com/alphapapa/org-web-tools), thanks Alphapapa for the awesome package.
2.  <span class="timestamp-wrapper"><span class="timestamp">[2020-06-21 Sun]</span></span>
    1.  metrics-tracker + capture-template for habit tracker (see ~/.doom.d/templates/habitstracker.org)
    2.  new templates for captures, breakfix, meeting-notes, diary and more&#x2026; (check the ~/.doom.d/templates/.. directory)
    3.  added org-roam-server
3.  <span class="timestamp-wrapper"><span class="timestamp">[2020-07-22 Wed]</span></span>
    1.  Added new functions specifically for GTD workflow, this will require some changes to fit your needs:
    2.  Moved GTD Module to <gtd.el>
    3.  Configure your variable settings in Setting up my GTD Methodology
4.  <span class="timestamp-wrapper"><span class="timestamp">[2020-08-26 Wed]</span></span>
    1.  Moved `roam-db-directory` to **.emacs.d** directory FIXME address syncthing permission issue
    2.  Added **FiraCode** fonts (see [Requirements](#org1c805ce))


<a id="org1c805ce"></a>

# Requirements

These are some items that are required outside of the normal DOOM EMACS installation, before you can use this config. The idea here is to keep this minimum so as much of this is close to regular DOOM EMACS.

1.  **SQLITE3 Installation**: You will need to install sqlite3, typicalled installed via your package manager as `sudo apt install sqlite3`
2.  For fonts please download [Input](https://input.fontbureau.com/download/), [DejaVu](http://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-ttf-2.37.tar.bz2) and [FiraCode](https://github.com/tonsky/FiraCode)


<a id="org8151e6c"></a>

# Default Settings

In this section we are going to cover all the basics, and then tangle the results into `config.el`


<a id="org226e2e5"></a>

# User Information

Environment settings, which are specific to the user and system. First up are user settings.

    (setq user-full-name "Nick Martin"
          user-mail-address "nmartin84@gmail.com")


<a id="org5a0d59b"></a>

# Misc Settings

Now we load some default settings for EMACS.

    (display-time-mode 1)
    (setq display-time-day-and-date t)


<a id="org3f3ffdd"></a>

# Key Bindings

From here we load some extra key bindings that I use often
TODO add org-agenda-mode-map key-binds for org-clock-convenience
TODO remove un-used key-binds

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
          :desc "Ripgrep Directory" "d" #'counsel-rg
          :desc "Rifle Buffer" "b" #'helm-org-rifle-current-buffer
          :desc "Rifle Agenda Files" "a" #'helm-org-rifle-agenda-files
          :desc "Rifle Project Files" "#" #'helm-org-rifle-project-files
          :desc "Rifle Other Project(s)" "$" #'helm-org-rifle-other-files
          :prefix ("l" . "+links")
          "o" #'org-open-at-point
          "g" #'eos/org-add-ids-to-headlines-in-file)
    
    (map! :leader
          :desc "Set Bookmark" "`" #'my/goto-bookmark-location
          :prefix ("s" . "search")
          :desc "Deadgrep Directory" "d" #'deadgrep
          :desc "Swiper All" "@" #'swiper-all
          :prefix ("o" . "open")
          :desc "Elfeed" "e" #'elfeed
          :desc "Deft" "w" #'deft
          :desc "Next Tasks" "n" #'org-find-next-tasks-file)


<a id="orga137eea"></a>

# Terminal Mode

Set a few settings if we detect terminal mode

    (when (equal (window-system) nil)
      (and
       (bind-key "C-<down>" #'+org/insert-item-below)
       (setq doom-theme 'doom-monokai-pro)
       (setq doom-font (font-spec :family "Input Mono" :size 20))))


<a id="org1ee70bc"></a>

# Default folder(s) and file(s)

Then we will define some default files. I&rsquo;m probably going to use default task files for inbox/someday/todo at some point so expect this to change. Also note, all customer functions will start with a `+` to distinguish from major symbols.
TODO add org-directory to this section

    (setq diary-file "~/.org/diary.org")


<a id="org52431ef"></a>

# Setup Layout by Monitor Profile

TODO clean up function and simplify the process

    (when (equal system-type 'gnu/linux)
      (setq doom-font (font-spec :family "Fira Code" :size 18)
            doom-big-font (font-spec :family "Fira Code" :size 26)))
    (when (equal system-type 'windows-nt)
      (setq doom-font (font-spec :family "InputMono" :size 18)
            doom-big-font (font-spec :family "InputMono" :size 22)))
    (defun zyro/monitor-width-profile-setup ()
      "Calcuate or determine width of display by Dividing height BY width and then setup window configuration to adapt to monitor setup"
      (let ((size (* (/ (float (display-pixel-height)) (float (display-pixel-width))) 10)))
        (when (= size 2.734375)
          (set-popup-rule! "^\\*lsp-help" :side 'left :size .40 :select t)
          (set-popup-rule! "*helm*" :side 'left :size .30 :select t)
          (set-popup-rule! "*Capture*" :side 'left :size .30 :select t)
          (set-popup-rule! "*CAPTURE-*" :side 'left :size .30 :select t)
          (set-popup-rule! "*Org Agenda*" :side 'left :size .25 :select t))))


<a id="org6fe8529"></a>

# Org mode settings

First I like to add some extra fancy stuff to make orgmode more appealing when i&rsquo;m using `+pretty` flag.

    (after! org (setq org-hide-emphasis-markers t
                      org-hide-leading-stars t
                      org-list-demote-modify-bullet '(("+" . "-") ("1." . "a.") ("-" . "+"))
                      org-ellipsis "▼"))

Other options for ellipsis &ldquo;▼, ↴, ⬎, ⤷,…, and ⋱.&rdquo;

Add a when condition that only adjust settings when certain features are enabled&#x2026; This depends on where i&rsquo;m running Emacs from (eg: Terminla, X11 or native).

    (when (require 'org-superstar nil 'noerror)
      (setq org-superstar-headline-bullets-list '("∴")
            org-superstar-item-bullet-alist nil))

Extra options for headline-bullets-list: &ldquo;◉&rdquo; &ldquo;●&rdquo; &ldquo;○&rdquo;

Adding additional search functions

    (defun zyro/rifle-roam ()
      "Rifle through your ROAM directory"
      (interactive)
      (helm-org-rifle-directories org-roam-directory))
    
    (map! :after org
          :map org-mode-map
          :leader
          :prefix ("n" . "notes")
          :desc "Rifle ROAM Notes" "!" #'zyro/rifle-roam)

Setting up my initial agenda settings

    (after! org (setq org-agenda-diary-file "~/.org/diary.org"
                      org-agenda-dim-blocked-tasks t
                      org-agenda-use-time-grid t
                      org-agenda-hide-tags-regexp "\\w+"
                      org-agenda-compact-blocks nil
                      org-agenda-block-separator ""
                      org-agenda-skip-scheduled-if-done t
                      org-agenda-skip-deadline-if-done t
                      org-enforce-todo-checkbox-dependencies nil
                      org-enforce-todo-dependencies t
                      org-habit-show-habits t))
    (after! org (setq org-agenda-files (append (file-expand-wildcards "~/.org/gtd/*.org"))))

Adjusting clock settings

    (after! org (setq org-clock-continuously t))


<a id="org203ce58"></a>

## Capture Templates

Here we setup the capture templates we want for `org-capture`. I use a file template that&rsquo;s pre-filled out with my monthly scheduled transactions.

    (after! org (setq org-capture-templates
          '(("!" "Quick Capture" plain (file "~/.org/gtd/inbox.org")
             "* TODO %(read-string \"Task: \")\n:PROPERTIES:\n:CREATED: %U\n:END:")
            ("p" "New Project" plain (file nick/org-capture-file-picker)
             (file "~/.doom.d/templates/template-projects.org"))
            ("$" "Scheduled Transactions" plain (file "~/.org/gtd/finances.ledger")
             (file "~/.doom.d/templates/ledger-scheduled.org"))
            ("l" "Ledger Transaction" plain (file "~/.org/gtd/finances.ledger")
             "%(format-time-string \"%Y/%m/%d\") * %^{transaction}\n Income:%^{From Account|Checking|Card|Cash}  -%^{dollar amount}\n Expenses:%^{category}  %\\3\n" :empty-lines-before 1))))

Example ledger template file:

    %(format-time-string "%Y/%m")/24 * Transaction name
        Income:Checking                           -dollar amount
        Expenses:Insurance                         dollar amount


<a id="orgf011c4a"></a>

# Directory settings

TODO add function to set image-width to **80%** of the window size.

    (after! org (setq org-image-actual-width nil
                      org-archive-location "~/.org/gtd/archives.org::datetree"
                      projectile-project-search-path '("~/projects/")))


<a id="org0312ad9"></a>

# Export Settings

TODO add the embed images code to this section

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


<a id="orgbcfc7be"></a>

# Misc Org Mode settings

    (require 'org-id)
    (setq org-link-file-path-type 'relative)


<a id="org6d675c3"></a>

# Keywords

After much feedback and discussing with other users, I decided to simplify the keyword list to make it simple. Defining a project will now focus on the tag word **:project:** so that all child task are treated as part of the project.

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Keyword</th>
<th scope="col" class="org-left">Description</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">\TODO</td>
<td class="org-left">Task has actionable items defined and ready to be worked.</td>
</tr>


<tr>
<td class="org-left">HOLD</td>
<td class="org-left">Has actionable items, but is on hold due to various reasons.</td>
</tr>


<tr>
<td class="org-left">NEXT</td>
<td class="org-left">Is ready to be worked and should be worked on soon.</td>
</tr>


<tr>
<td class="org-left">DONE</td>
<td class="org-left">Task is completed and closed.</td>
</tr>


<tr>
<td class="org-left">KILL</td>
<td class="org-left">Abandoned or terminated.</td>
</tr>
</tbody>
</table>

    
    (setq org-todo-keywords
          '((sequence "TODO(t)" "NEXT(n)" "HOLD(h)" "|" "DONE(d)" "KILL(k)")))


<a id="org55dda0c"></a>

# Logging and Drawers

For the logging drawers, we like to keep our notes and clock history **seperate** from our properties drawer&#x2026;

    (after! org (setq org-log-state-notes-insert-after-drawers nil))

Next, we like to keep a history of our activity of a task so we **track** when changes occur, and we also keep our notes logged in **their own drawer**. Optionally you can also add the following in-buffer settings to override the `org-log-into-drawer` function. `#+STARTUP: logdrawer` or `#+STARTUP: nologdrawer`

    (after! org (setq org-log-into-drawer t
                      org-log-done 'time
                      org-log-repeat 'time
                      org-log-redeadline 'note
                      org-log-reschedule 'note))


<a id="org6c08298"></a>

# Properties

    (setq org-use-property-inheritance t ; We like to inhert properties from their parents
          org-catch-invisible-edits 'error) ; Catch invisible edits


<a id="orga1a1bd9"></a>

# Publishing

REVIEW do we need to re-define our publish settings for the ROAM directory?

    (after! org (setq org-publish-project-alist
                      '(("attachments"
                         :base-directory "~/.org/"
                         :recursive t
                         :base-extension "jpg\\|jpeg\\|png\\|pdf\\|css"
                         :publishing-directory "~/publish_html"
                         :publishing-function org-publish-attachment)
                        ("notes-to-orgfiles"
                         :base-directory "~/.org/notes/"
                         :publishing-directory "~/notes/"
                         :base-extension "org"
                         :recursive t
                         :publishing-function org-org-publish-to-org)
                        ("notes"
                         :base-directory "~/.org/notes/"
                         :publishing-directory "~/nmartin84.github.io"
                         :section-numbers nil
                         :base-extension "org"
                         :with-properties nil
                         :with-drawers (not "LOGBOOK")
                         :with-timestamps active
                         :recursive t
                         :exclude "journal/.*"
                         :auto-sitemap t
                         :sitemap-filename "index.html"
                         :publishing-function org-html-publish-to-html
                         :html-head "<link rel=\"stylesheet\" href=\"https://raw.githack.com/nmartin84/raw-files/master/htmlpro.css\" type=\"text/css\"/>"
    ;                     :html-head "<link rel=\"stylesheet\" href=\"https://codepen.io/nmartin84/pen/RwPzMPe.css\" type=\"text/css\"/>"
    ;                     :html-head-extra "<style type=text/css>body{ max-width:80%;  }</style>"
                         :html-link-up "../"
                         :with-email t
                         :html-link-up "../../index.html"
                         :auto-preamble t
                         :with-toc t)
                        ("myprojectweb" :components("attachments" "notes" "notes-to-orgfiles")))))


<a id="org3435167"></a>

# Refiling Defaults

TODO tweak refiling settings to match new GTD setup

    (after! org (setq org-refile-targets '((nil :maxlevel . 9)
                                           (org-agenda-files :maxlevel . 4))
                      org-refile-use-outline-path 'buffer-name
                      org-outline-path-complete-in-steps nil
                      org-refile-allow-creating-parent-nodes 'confirm))


<a id="orga483996"></a>

# Orgmode Startup

    (after! org (setq org-startup-indented 'indent
                      org-startup-folded 'content
                      org-src-tab-acts-natively t))
    (add-hook 'org-mode-hook 'org-indent-mode)
    (add-hook 'org-mode-hook 'turn-off-auto-fill)


<a id="org5b5f71d"></a>

# Org Protocol

    (require 'org-roam-protocol)
    (setq org-protocol-default-template-key "d")


<a id="org1fff40c"></a>

# Default Tags

REVIEW should we define any additional tags?

    (setq org-tags-column 0)
    (setq org-tag-alist '((:startgrouptag)
                          ("Context")
                          (:grouptags)
                          ("@home" . ?h)
                          ("@computer")
                          ("@work")
                          ("@place")
                          ("@bills")
                          ("@order")
                          ("@labor")
                          ("@read")
                          ("@brainstorm")
                          ("@planning")
                          (:endgrouptag)
                          (:startgrouptag)
                          ("Categories")
                          (:grouptags)
                          ("vehicles")
                          ("health")
                          ("house")
                          ("hobby")
                          ("coding")
                          ("material")
                          ("goal")
                          (:endgrouptag)
                          (:startgrouptag)
                          ("Section")
                          (:grouptags)
                          ("#coding")
                          ("#research")))


<a id="org7f09723"></a>

# Buffer Settings

    (global-auto-revert-mode 1)
    (setq undo-limit 80000000
          evil-want-fine-undo t
    ;      auto-save-default t
          inhibit-compacting-font-caches t)
    (whitespace-mode -1)
    
    (defun zyro/remove-lines ()
      "Remove lines mode."
      (display-line-numbers-mode -1))
    (remove-hook! '(org-roam-mode-hook) #'zyro/remove-lines)


<a id="orgab7e9d7"></a>

# Misc Settings

    (setq display-line-numbers-type t)
    (setq-default
     delete-by-moving-to-trash t
     tab-width 4
     uniquify-buffer-name-style 'forward
     window-combination-resize t
     x-stretch-cursor t)


<a id="org67193ed"></a>

# Module Settings


<a id="orgd948536"></a>

## company mode

    (after! org
      (set-company-backend! 'org-mode 'company-capf '(company-yasnippet company-org-roam company-elisp))
      (setq company-idle-delay 0.25))


<a id="org3771699"></a>

## Define Word

    (use-package define-word
      :config
      (map! :after org
            :map org-mode-map
            :leader
            :desc "Define word at point" "@" #'define-word-at-point))


<a id="org4d302e9"></a>

## Misc Modules [Bookmarks, PDF Tools]

Configuring PDF support and ORG-NOTER for note taking

    ;(use-package org-pdftools
    ;  :hook (org-load . org-pdftools-setup-link))


<a id="orga88d606"></a>

## Graphs and Chart Modules

Eventually I would like to have org-mind-map generating charts like Sacha&rsquo;s [evil-plans](https://pages.sachachua.com/evil-plans/).

    (after! org (setq org-ditaa-jar-path "~/.emacs.d/.local/straight/repos/org-mode/contrib/scripts/ditaa.jar"))
    
    (use-package gnuplot
      :defer
      :config
      (setq gnuplot-program "gnuplot"))
    
    ; MERMAID
    (use-package mermaid-mode
      :defer
      :config
      (setq mermaid-mmdc-location "/node_modules/.bin/mmdc"
            ob-mermaid-cli-path "/node-modules/.bin/mmdc"))
    
    ; PLANTUML
    (use-package ob-plantuml
      :ensure nil
      :commands
      (org-babel-execute:plantuml)
      :defer
      :config
      (setq plantuml-jar-path (expand-file-name "~/.doom.d/plantuml.jar")))


<a id="orgf3c9b40"></a>

## Elfeed

    (use-package elfeed-org
      :defer
      :config
      (setq rmh-elfeed-org-files (list "~/.elfeed/elfeed.org")))
    (use-package elfeed
      :defer
      :config
      (setq elfeed-db-directory "~/.elfeed/"))
    
    ;; (require 'elfeed-org)
    ;; (elfeed-org)
    ;; (setq elfeed-db-directory "~/.elfeed/")
    ;; (setq rmh-elfeed-org-files (list "~/.elfeed/elfeed.org"))


<a id="org99b1f96"></a>

## DEFT

When this variable is set to `t` your deft directory will be updated to your projectile-project root&rsquo;s folder when switching projects, and the deft buffer&rsquo;s contents will be refreshed.

    (setq deft-use-projectile-projects t)
    (defun zyro/deft-update-directory ()
      "Updates deft directory to current projectile's project root folder and updates the deft buffer."
      (interactive)
      (if (projectile-project-p)
          (setq deft-directory (expand-file-name (doom-project-root)))))
    (when deft-use-projectile-projects
      (add-hook 'projectile-after-switch-project-hook 'zyro/deft-update-directory)
      (add-hook 'projectile-after-switch-project-hook 'deft-refresh))

Configuring DEFT default settings

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


<a id="orgf5bc7ed"></a>

## Org-Rifle

    (use-package helm-org-rifle
      :after (helm org)
      :preface
      (autoload 'helm-org-rifle-wiki "helm-org-rifle")
      :config
      (add-to-list 'helm-org-rifle-actions '("Insert link" . helm-org-rifle--insert-link) t)
      (add-to-list 'helm-org-rifle-actions '("Store link" . helm-org-rifle--store-link) t)
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
    
      ;; (defun helm-org-rifle--narrow (candidate)
      ;;   "Go-to and then Narrow Selection"
      ;;   (helm-org-rifle-show-entry candidate)
      ;;   (org-narrow-to-subtree))
    
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


<a id="org070490d"></a>

## Pandoc

    (setq org-pandoc-options '((standalone . t) (self-contained . t)))


<a id="org117fe83"></a>

## ROAM

These are my default ROAM settings

    (setq org-roam-tag-sources '(prop last-directory))
    (setq org-roam-db-location "~/.org/roam.db")
    (setq org-roam-directory "~/.org/")
    (add-to-list 'safe-local-variable-values
    '(org-roam-directory . "."))
    
    (setq org-roam-dailies-capture-templates
       '(("d" "daily" plain (function org-roam-capture--get-point) ""
          :immediate-finish t
          :file-name "journal/%<%Y-%m-%d-%a>"
          :head "#+TITLE: %<%Y-%m-%d %a>\n#+STARTUP: content\n\n")))
    
    (setq org-roam-capture-templates
            '(("b" "book" plain (function org-roam-capture--get-point)
               :file-name "book/${slug}%<%Y%m%d%H%M>"
               :head "#+TITLE: ${slug}\n#+roam_tags: %^{tags}\n\nsource :: [[%^{link}][%^{link_desc}]]\n\n"
               "%?"
               :unnarrowed t)
              ("c" "curiousity" plain (function org-roam-capture--get-point)
               :file-name "curious/${slug}"
               :head "#+TITLE: ${title}\n#+roam_tags: %^{roam_tags}\n\n"
               "%?"
               :unnarrowed t)
              ("d" "digest" plain (function org-roam-capture--get-point)
               "%?"
               :file-name "digest/${slug}"
               :head "#+title: ${title}\n#+roam_tags: %^{roam_tags}\n\nsource :: [[%^{link}][%^{link_desc}]]\n\n"
               :unnarrowed t)
              ("f" "fleeting" plain (function org-roam-capture--get-point)
               "%?"
               :file-name "fleeting/${slug}"
               :head "#+title: ${title}\n#+roam_tags: %^{roam_tags}\n\n"
               :unnarrowed t)
              ("p" "private" plain (function org-roam-capture--get-point)
               "%?"
               :file-name "private/${slug}"
               :head "#+title: ${title}\n"
               :unnarrowed t)
              ("x" "programming" plain (function org-roam-capture--get-point)
               :file-name "%<%Y%m%d%H%M%S-${slug}"
               :head "#+title: ${title}\n#+roam_tags: %^{tags}\n- source :: [[%^{link}][%^{description}]] \\\n- metadata :: %?\n\n* Notes\n\n* Follow-up Actions"
               :unnarrowed t)
              ("r" "research" entry (function org-roam--capture-get-point)
               (file "~/.doom.d/templates/org-roam-research.org")
               :file-name "research/${slug}"
               "%?"
               :unnarrowed t)
              ("t" "technical" plain (function org-roam-capture--get-point)
               "%?"
               :file-name "technical/${slug}"
               :head "#+title: ${title}\n#+roam_tags: %^{roam_tags}\n\n"
               :unnarrowed t)))


<a id="orgc6cd31a"></a>

## ROAM Server

    (use-package org-roam-server
      :ensure t
      :config
      (setq org-roam-server-host "192.168.1.82"
            org-roam-server-port 8070
            org-roam-server-export-inline-images t
            org-roam-server-authenticate nil
            org-roam-server-network-poll nil
            org-roam-server-network-arrows 'from
            org-roam-server-network-label-truncate t
            org-roam-server-network-label-truncate-length 60
            org-roam-server-network-label-wrap-length 20))


<a id="orga799bdb"></a>

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


<a id="org93b87c7"></a>

## Reveal [HTML Presentations]

    (require 'ox-reveal)
    (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
    (setq org-reveal-title-slide nil)


<a id="orgfd95832"></a>

## Super Agenda Settings

    (org-super-agenda-mode t)
    
    (setq org-agenda-custom-commands
          '(("g" "Getting Things Done(gtd)"
             ((agenda ""
                      ((org-agenda-files (append (file-expand-wildcards "~/.org/gtd/*.org")))
                       (org-agenda-overriding-header "Agenda")
                       (org-agenda-start-day (org-today))
                       (org-agenda-span '1)))
              (tags-todo "-project/NEXT"
                         ((org-agenda-files (list "~/.org/gtd/next.org"))
                          (org-agenda-overriding-header "Next")))
              (tags-todo "-project/TODO"
                         ((org-agenda-files (list "~/.org/gtd/next.org"))
                          (org-agenda-overriding-header "Inbox")))
              (tags-todo "-project/HOLD"
                         ((org-agenda-files (list "~/.org/gtd/next.org"))
                          (org-agenda-overriding-header "On Hold")))
              (tags-todo "project/TODO|NEXT|HOLD"
                         ((org-agenda-files (list "~/.org/gtd/next.org"))
                          (org-agenda-overriding-header "Projects")))))
            ("l" "The List"
             ((todo ""
                    ((org-agenda-files (list "~/.org/gtd/thelist.org"))
                     (org-super-agenda-groups '((:auto-tags t)))))))
            ("i" "Inbox"
             ((todo "TODO|HOLD"
                    ((org-agenda-files (list "~/.org/gtd/inbox.org"))
                     (org-super-agenda-groups '((:auto-ts t)))))))
            ("x" "Someday"
             ((todo ""
                    ((org-agenda-files (append (file-expand-wildcards "~/.org/gtd/incubate.org")))
                     (org-super-agenda-groups
                      '((:auto-parent t)))))))))


<a id="orge342cfd"></a>

# Loading secrets

    (let ((secrets (expand-file-name "secrets.el" doom-private-dir)))
    (when (file-exists-p secrets)
      (load secrets)))


<a id="org4b99df2"></a>

# Hacks


<a id="orga6cb5c0"></a>

## Embed Images in HTML org-export

    (defun replace-in-string (what with in)
      (replace-regexp-in-string (regexp-quote what) with in nil 'literal))
    
    (defun org-html--format-image (source attributes info)
      (progn
        (setq source (replace-in-string "%20" " " source))
        (format "<img src=\"data:image/%s;base64,%s\"%s />"
                (or (file-name-extension source) "")
                (base64-encode-string
                 (with-temp-buffer
                   (insert-file-contents-literally source)
                  (buffer-string)))
                (file-name-nondirectory source))))


<a id="org6be994b"></a>

# Custom Functions

Ideas for functions I need:

-   [ ] Clarify task function


<a id="org358bd19"></a>

## Time Stamps

    (defun +nick/org-insert-timestamp ()
      "Insert active timestamp at POS."
      (interactive)
      (insert (format "<%s> " (format-time-string "%Y-%m-%d %H:%M:%p"))))
    (map! :after org
          :map org-mode-map
          :localleader
          :prefix ("j" . "nicks functions")
          :desc "Insert timestamp at POS" "i" #'+nick/org-insert-timestamp)


<a id="org93af5f6"></a>

## Capture Template File Picker

    (defun nick/org-capture-file-picker ()
      "Select a file from the PROJECTS folder and return file-name."
      (let ((file (read-file-name "Project: " "~/.org/gtd/projects/")))
        (expand-file-name (format "%s" file))))


<a id="org2fec88e"></a>

# Theme Settings

    (after! org (zyro/monitor-width-profile-setup)
      (toggle-frame-fullscreen)
      (setq doom-theme 'doom-one))

