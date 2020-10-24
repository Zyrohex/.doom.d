;; [[file:../../../tmp/config.org.L5Zs54::*Initial Settings][Initial Settings:1]]
(setq user-full-name "Nick Martin"
      user-mail-address "nmartin84@gmail.com")

(display-time-mode 1)
(setq display-time-day-and-date t)

(global-auto-revert-mode 1)
(setq undo-limit 80000000
      evil-want-fine-undo t
      auto-save-default nil
      inhibit-compacting-font-caches t)
(whitespace-mode -1)

(setq display-line-numbers-type t)
(setq-default
 delete-by-moving-to-trash t
 tab-width 4
 uniquify-buffer-name-style 'forward
 window-combination-resize t
 x-stretch-cursor t)
;; Initial Settings:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Initial Settings][Initial Settings:2]]
(bind-key "<f6>" #'link-hint-copy-link)
(map! :after org
      :map org-mode-map
      :leader
      :desc "Move up window" "<up>" #'evil-window-up
      :desc "Move down window" "<down>" #'evil-window-down
      :desc "Move left window" "<left>" #'evil-window-left
      :desc "Move right window" "<right>" #'evil-window-right
      :prefix ("s" . "+search")
      :desc "Outline" "o" #'counsel-outline
      :desc "Counsel ripgrep" "d" #'counsel-rg
      :desc "Swiper All" "@" #'swiper-all
      :desc "Rifle Buffer" "b" #'helm-org-rifle-current-buffer
      :desc "Rifle Agenda Files" "a" #'helm-org-rifle-agenda-files
      :desc "Rifle Project Files" "#" #'helm-org-rifle-project-files
      :desc "Rifle Other Project(s)" "$" #'helm-org-rifle-other-files
      :prefix ("l" . "+links")
      "o" #'org-open-at-point
      "g" #'eos/org-add-ids-to-headlines-in-file)

(map! :after org-agenda
      :map org-agenda-mode-map
      :localleader
      :desc "Filter" "f" #'org-agenda-filter)
;; Initial Settings:2 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Initial Settings][Initial Settings:3]]
(when (equal (window-system) nil)
  (and
   (bind-key "C-<down>" #'+org/insert-item-below)
   (setq doom-theme nil)
   (setq doom-font (font-spec :family "Roboto Mono" :size 20))))
;; Initial Settings:3 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Initial Settings][Initial Settings:4]]
(setq diary-file "~/.org/diary.org")
(setq org-directory "~/.org/")
(setq projectile-project-search-path "~/projects/")
;; Initial Settings:4 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Initial Settings][Initial Settings:5]]
(setq doom-theme 'doom-one)

(after! org (set-popup-rule! "^\\*lsp-help" :side 'bottom :size .30 :select t)
  (set-popup-rule! "*helm*" :side 'right :size .30 :select t)
  (set-popup-rule! "*Org QL View:*" :side 'right :size .25 :select t)
  (set-popup-rule! "*Capture*" :side 'left :size .30 :select t)
  (set-popup-rule! "*CAPTURE-*" :side 'left :size .30 :select t))

(when (equal system-type 'gnu/linux)
  (setq doom-font (font-spec :family "Roboto Mono" :size 18)
        doom-big-font (font-spec :family "Roboto Mono" :size 26)))
(when (equal system-type 'windows-nt)
  (setq doom-font (font-spec :family "InputMono" :size 18)
        doom-big-font (font-spec :family "InputMono" :size 22)))
;; Initial Settings:5 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Org-Mode][Org-Mode:1]]
(require 'org-habit)
(require 'org-id)
(after! org (setq org-archive-location "~/.org/gtd/archives.org::datetree"
                  org-image-actual-width nil
                  org-link-file-path-type 'relative
                  org-log-state-notes-insert-after-drawers nil
                  org-catch-invisible-edits 'error
                  org-refile-targets '((nil :maxlevel . 9)
                                       (org-agenda-files :maxlevel . 4))
                  org-refile-use-outline-path 'buffer-name
                  org-outline-path-complete-in-steps nil
                  org-refile-allow-creating-parent-nodes 'confirm
                  org-startup-indented 'indent
                  org-startup-folded 'fold
                  org-src-tab-acts-natively t
                  org-list-allow-alphabetical nil))

(add-hook 'org-mode-hook 'turn-off-auto-fill)
;; Org-Mode:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Looks and Feels][Looks and Feels:1]]
(after! org (setq org-hide-emphasis-markers t
                  org-hide-leading-stars t
                  org-list-demote-modify-bullet '(("+" . "-") ("1." . "a.") ("-" . "+"))))

(when (require 'org-superstar nil 'noerror)
  (setq org-superstar-headline-bullets-list '("●" "○")
        org-superstar-item-bullet-alist nil))
;; Looks and Feels:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Loading agenda settings][Loading agenda settings:1]]
(after! org (setq org-agenda-diary-file "~/.org/diary.org"
                  org-agenda-dim-blocked-tasks t ; grays out task items that are blocked by another task (EG: Projects with subtasks)
                  org-agenda-use-time-grid t
                  org-agenda-hide-tags-regexp "\\w+" ; Hides tags in agenda-view
                  org-agenda-compact-blocks nil
                  org-agenda-block-separator ""
                  org-agenda-skip-scheduled-if-done t
                  org-agenda-skip-deadline-if-done t
                  org-agenda-window-setup 'current-window
                  org-enforce-todo-checkbox-dependencies t ; This has funny behavior, when t and you try changing a value on the parent task, it can lead to Emacs freezing up. TODO See if we can fix the freezing behavior when making changes in org-agenda-mode.
                  org-enforce-todo-dependencies t
                  org-habit-show-habits t))

(after! org (setq org-agenda-files (append (file-expand-wildcards "~/.org/gtd/*.org"))))
;; Loading agenda settings:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Clock Settings][Clock Settings:1]]
(after! org (setq org-clock-continuously t)) ; Will fill in gaps between the last and current clocked-in task.
;; Clock Settings:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Capture Templates][Capture Templates:1]]
(after! org (setq org-capture-templates
      '(("h" "Headline templates")
        ("l" "Ledger")
        ("j" "Journal")
        ("!" "Quick Capture" entry (file+headline "~/.org/gtd/inbox.org" "Inbox")
         "* TODO %(read-string \"Task: \")\n:PROPERTIES:\n:CREATED: %U\n:END:")
        ("jn" "New Entry" entry (file "~/.org/gtd/journal.org")
         "* <%<%Y-%m-%d %b %H:%M>> %?")
        ("jc" "Clocked Entry" entry (file "~/.org/gtd/journal.org")
         "* <%<%Y-%m-%d %b %H:%M>> %?" :clock-in t :clock-resume t)
        ("hn" "Note to headline" plain (function nm/org-end-of-headline)
         "<%<%Y-%m-%d %b %H:%M>> - %?" :empty-lines-before 1 :empty-lines-after 1 :unnarrow t)
        ("hf" "Find headline" plain (function nm/org-capture-weeklies)
         "%?" :empty-lines-before 1 :empty-lines-after 1)
        ("ls" "Add scheduled Transactions" plain (file "~/.org/gtd/finances.ledger")
         (file "~/.doom.d/templates/ledger-scheduled.org"))
        ("la" "Add Transaction" plain (file "~/.org/gtd/finances.ledger")
         "%(format-time-string \"%Y/%m/%d\") * %^{transaction}\n Income:%^{From Account|Checking|Card|Cash}  -%^{dollar amount}\n Expenses:%^{category}  %\\3\n" :empty-lines-before 1))))
;; Capture Templates:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Export Settings][Export Settings:1]]
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
;; Export Settings:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Export Settings][Export Settings:2]]
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
;; Export Settings:2 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Keywords][Keywords:1]]
(custom-declare-face '+org-todo-active  '((t (:inherit (bold font-lock-constant-face org-todo)))) "")
(custom-declare-face '+org-todo-project '((t (:inherit (bold font-lock-doc-face org-todo)))) "")
(custom-declare-face '+org-todo-onhold  '((t (:inherit (bold warning org-todo)))) "")
(custom-declare-face '+org-todo-next '((t (:inherit (bold font-lock-keyword-face org-todo)))) "")
(custom-declare-face 'org-checkbox-statistics-todo '((t (:inherit (bold font-lock-constant-face org-todo)))) "")

  (setq org-todo-keywords
        '((sequence
           "TODO(t)"  ; A task that needs doing & is ready to do
           "PROJ(p)"  ; Project with multiple task items.
           "NEXT(n)"  ; Task is next to be worked on.
           "WAIT(w)"  ; Something external is holding up this task
           "|"
           "DONE(d)"  ; Task successfully completed
           "KILL(k)")) ; Task was cancelled, aborted or is no longer applicable
        org-todo-keyword-faces
        '(("WAIT" . +org-todo-onhold)
          ("PROJ" . +org-todo-project)
          ("TODO" . +org-todo-active)
          ("NEXT" . +org-todo-next)))
;; Keywords:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Logging and Drawers][Logging and Drawers:1]]
(after! org (setq org-log-into-drawer t
                  org-log-done 'time
                  org-log-repeat 'time
                  org-log-redeadline 'note
                  org-log-reschedule 'note))
;; Logging and Drawers:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Properties][Properties:1]]
(after! org (setq org-use-property-inheritance t)) ; We like to inhert properties from their parents
;; Properties:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Publishing][Publishing:1]]
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
;; Publishing:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Default Tags][Default Tags:1]]
(after! org (setq org-tags-column 0
                  org-tag-alist '((:startgrouptag)
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
                                  ("WAIT")
                                  ("SOMEDAY"))))
;; Default Tags:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*company mode][company mode:1]]
(after! org
  (set-company-backend! 'org-mode 'company-capf '(company-yasnippet company-org-roam company-elisp))
  (setq company-idle-delay 0.25))
;; company mode:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Define Word][Define Word:1]]
(use-package define-word
  :config
  (map! :after org
        :map org-mode-map
        :leader
        :desc "Define word at point" "@" #'define-word-at-point))
;; Define Word:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Misc Modules \[Bookmarks, PDF Tools\]][Misc Modules [Bookmarks, PDF Tools]:1]]
;(use-package org-pdftools
;  :hook (org-load . org-pdftools-setup-link))
;; Misc Modules [Bookmarks, PDF Tools]:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Graphs and Chart Modules][Graphs and Chart Modules:1]]
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
;; Graphs and Chart Modules:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Elfeed][Elfeed:1]]
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
;; Elfeed:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*DEFT][DEFT:1]]
(setq deft-use-projectile-projects t)
(defun zyro/deft-update-directory ()
  "Updates deft directory to current projectile's project root folder and updates the deft buffer."
  (interactive)
  (if (projectile-project-p)
      (setq deft-directory (expand-file-name (doom-project-root)))))
(when deft-use-projectile-projects
  (add-hook 'projectile-after-switch-project-hook 'zyro/deft-update-directory)
  (add-hook 'projectile-after-switch-project-hook 'deft-refresh))
;; DEFT:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*DEFT][DEFT:2]]
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
;; DEFT:2 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Org-Rifle][Org-Rifle:1]]
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
;; Org-Rifle:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Pandoc][Pandoc:1]]
(setq org-pandoc-options '((standalone . t) (self-contained . t)))
;; Pandoc:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*ROAM][ROAM:1]]
(setq org-roam-tag-sources '(prop last-directory))
(setq org-roam-db-location "~/.org/roam.db")
(setq org-roam-directory "~/.org/")

(setq org-roam-dailies-capture-templates
   '(("d" "daily" plain (function org-roam-capture--get-point) ""
      :immediate-finish t
      :file-name "journal/%<%Y-%m-%d-%a>"
      :head "#+TITLE: %<%Y-%m-%d %a>\n#+STARTUP: content\n\n")))

(setq org-roam-capture-templates
        '(("d" "digest" plain (function org-roam-capture--get-point)
           "%?"
           :file-name "notes/digest/%<%Y%m%d%H%M>-${slug}"
           :head "#+title: ${title}\n#+roam_tags: %^{roam_tags}\n\nsource :: [[%^{link}][%^{link_desc}]]\n\n"
           :unnarrowed t)
          ("n" "notes" plain (function org-roam-capture--get-point)
           :file-name "notes/${slug}"
           :head "#+title: ${title}\n#+roam_tags: %(read-string \"tags: \")\n\n"
           :unnarrowed t
           "%?")
          ("p" "private" plain (function org-roam-capture--get-point)
           :file-name "notes/private/${slug}"
           :head "#+title: ${title}\n#+roam_tags: %(read-string \"tags: \")\n\n"
           :unnarrowed t
           "%?")
          ("r" "reveal slide" plain (function org-roam-capture--get-point)
           :file-name "slides/%<%Y%m%d%H%M>-${slug}"
           :head "#+title: ${title}\n#+options: num:nil toc:nil\n#+REVEAL_THEME: %^{theme|black|white|league|beige|sky|night|serif|simple|solarized|blood|moon}\n#+REVEAL_PLUGINS: (highlight)\n#+REVEAL_OVERVIEW: t\n\n"
           :unnarrow t
           "%?")))
;; ROAM:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*ROAM Server][ROAM Server:1]]
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
;; ROAM Server:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*ROAM Export Backlinks + Content][ROAM Export Backlinks + Content:1]]
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
;; ROAM Export Backlinks + Content:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Reveal \[HTML Presentations\]][Reveal [HTML Presentations]:1]]
(require 'ox-reveal)
(setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
(setq org-reveal-title-slide nil)
;; Reveal [HTML Presentations]:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Super Agenda Settings][Super Agenda Settings:1]]
(setq org-agenda-custom-commands
      (quote (("N" "Notes" tags "NOTE"
               ((org-agenda-overriding-header "Notes")
                (org-tags-match-list-sublevels t)))
              ("h" "Habits" tags-todo "STYLE=\"habit\""
               ((org-agenda-overriding-header "Habits")
                (org-agenda-sorting-strategy
                 '(todo-state-down effort-up category-keep))))
              ("i" "Inbox"
               ((tags-todo "-SOMEDAY/TODO"
                      ((org-agenda-overriding-header "New Tasks to Refile")
                       (org-tags-match-list-sublevels nil)))
                (tags-todo "SOMEDAY/"
                           ((org-agenda-overriding-header "Someday Tasks")
                            (org-agenda-skip-function 'nm/skip-scheduled)
                            (org-tags-match-list-sublevels nil)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)))))
              ("w" "Master Agenda"
               ((agenda ""
                        ((org-agenda-span '1)
                         (org-agenda-files (append (file-expand-wildcards "~/.org/gtd/*.org")))
                         (org-agenda-start-day (org-today))))
                (tags-todo "-CANCELLED/!"
                           ((org-agenda-overriding-header "Stuck Projects")
                            (org-agenda-skip-function 'bh/skip-non-stuck-projects)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-HOLD-CANCELLED/!"
                           ((org-agenda-overriding-header "Projects")
                            (org-agenda-skip-function 'bh/skip-non-projects)
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-CANCELLED/!NEXT"
                           ((org-agenda-overriding-header (concat "Project Next Tasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'nm/skip-projects-and-habits-and-single-tasks)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-sorting-strategy
                             '(todo-state-down effort-up category-keep))))
                (tags-todo "-SOMEDAY-REFILE-CANCELLED-WAITING-HOLD/!"
                           ((org-agenda-overriding-header (concat "Project Subtasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-non-project-tasks)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-SOMEDAY-REFILE-CANCELLED-/NEXT"
                           ((org-agenda-overriding-header (concat "Standalone Tasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'nm/skip-project-tasks)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-SOMEDAY+WAITING/"
                           ((org-agenda-overriding-header (concat "Waiting and Postponed Tasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'nm/skip-scheduled)
                            (org-tags-match-list-sublevels nil)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)))
                (tags "-REFILE/"
                      ((org-agenda-overriding-header "Tasks to Archive")
                       (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                       (org-tags-match-list-sublevels nil))))
               nil))))
;; Super Agenda Settings:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Custom Functions][Custom Functions:1]]
(load! "customs.el")
(load! "org-helpers.el")
;; Custom Functions:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Time Stamps][Time Stamps:1]]
(defun nm/org-insert-timestamp ()
  "Insert active timestamp at POS."
  (interactive)
  (insert (format "<%s> " (format-time-string "%Y-%m-%d %H:%M:%p"))))
(map! :after org
      :map org-mode-map
      :localleader
      :prefix ("j" . "nicks functions")
      :desc "Insert timestamp at POS" "i" #'nm/org-insert-timestamp)
;; Time Stamps:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Capture Template File Picker][Capture Template File Picker:1]]
(defun nm/org-capture-file-picker ()
  "Select a file from the PROJECTS folder and return file-name."
  (let ((file (read-file-name "Project: " "~/.org/gtd/projects/")))
    (expand-file-name (format "%s" file))))
;; Capture Template File Picker:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Clarify Tasks][Clarify Tasks:1]]
(defun nm/org-get-headline-property (arg)
  "Extract property from headline and return results."
  (interactive)
  (org-entry-get nil arg t))

(defun nm/org-get-headline-properties ()
  "Get headline properties for ARG."
  (org-back-to-heading)
  (org-element-at-point))

(defun nm/org-get-headline-title ()
  "Get headline title from current headline."
  (interactive)
  (org-element-property :title (nm/org-get-headline-properties)))

;;;;;;;;;;;;--------[ Clarify Task Properties ]----------;;;;;;;;;;;;;

(defun nm/update-task-tags ()
  "Update all child tasks in buffer that are missing a TAG value."
  (interactive)
  (org-show-all)
  (while (not (eobp))
    (progn
      (outline-next-heading)
      (org-narrow-to-subtree)
      (unless (eobp)
        (if (and (oh/is-task-p) (null (org-get-tags)))
            (counsel-org-tag)))
      (widen))))

(setq org-tasks-properties-metadata (list "SOURCE"))

(defun nm/org-clarify-task-properties (arg)
  "Update the metadata for a task headline."
  (unless (equal major-mode 'org-mode)
    (error "Not visiting an org-mode buffer."))
  (save-restriction
    (save-excursion
      (org-show-all)
      (goto-char (point-min))
      (let ((props arg))
        (while (not (eobp))
          (outline-next-heading)
          (org-narrow-to-subtree)
          (unless (eobp)
            (when (or (and (oh/is-project-p) (oh/is-todo-p)) (and (oh/is-task-p) (null (oh/has-parent-project-p)) (null (oh/has-subtask-p))))
              (mapcar (lambda (props)
                        (when (null (org-entry-get nil (upcase props) t))
                          (org-set-property (upcase props) (org-read-property-value (upcase props))))) props))
            (when (and (oh/is-todo-p) (not (oh/is-task-p)))
              (org-todo "PROJ"))
            (widen)))))))

(defun nm/update-task-states ()
  "Scans buffer and assigns all tasks that contain child-tasks the PROJ keyword and vice versa."
  (interactive)
  (save-excursion
    (goto-line 1)
    (while (not (eobp))
      (outline-next-heading)
      (unless (eobp)
        (nm/org-update-projects)
        (nm/org-set-next-state)))))

(defun nm/org-update-projects ()
  "If task is project then assign to PROJ keyword."
  (when (or (and (nm/has-subtask-active-p) (oh/is-todo-p)) (and (oh/is-todo-p) (nm/has-subtask-done-p) (nm/has-subtask-active-p)))
    (org-todo "PROJ")))
;  (when (or (and (not (nm/org-checkbox-exist-p)) (equal (org-get-todo-state) "PROJ") (oh/is-task-p))
;            (and (not (nm/org-checkbox-exist-p)) (oh/is-task-p) (not (equal (org-get-todo-state) "DONE"))))
;    (org-todo "TODO")))

(defun nm/org-set-next-state ()
  "If task contains checkbox  that's not DONE then set task state to NEXT."
  (interactive)
  (save-excursion
    (org-back-to-heading)
    (when (save-excursion (and (bh/is-task-p) (or (and (nm/exist-context-tag-p) (not (equal (org-get-todo-state) "DONE"))) (and (nm/checkbox-active-exist-p) (nm/checkbox-done-exist-p)) (nm/checkbox-active-exist-p) (nm/is-scheduled-p))))
      (org-todo "NEXT"))
    (when (and (not (equal (org-get-todo-state) "DONE")) (not (nm/is-scheduled-p)) (null (nm/exist-context-tag-p)) (bh/is-task-p) (not (nm/checkbox-done-exist-p)) (not (nm/checkbox-active-exist-p)))
      (org-todo "TODO"))
    (when (and (bh/is-task-p) (not (nm/checkbox-active-exist-p)) (not (nm/is-scheduled-p)) (not (nm/exist-context-tag-p)) (nm/checkbox-done-exist-p))
      (org-todo "DONE"))))

(defun nm/checkbox-active-exist-p ()
  "Checks if a checkbox that's not marked DONE exist in the tree."
  (interactive)
  (org-back-to-heading)
  (let ((end (save-excursion (org-end-of-subtree t))))
    (search-forward-regexp "^[-+] \\[\\W].+\\|^[1-9].\\W\\[\\W]" end t)))

(defun nm/checkbox-done-exist-p ()
  "Checks if a checkbox that's not marked DONE exist in the tree."
  (interactive)
  (org-back-to-heading)
  (let ((end (save-excursion (org-end-of-subtree t))))
    (search-forward-regexp "^[-+] \\[X].+\\|^[1-9].\\W\\[X]" end t)))

(defun nm/has-subtask-done-p ()
  "Returns t for any heading that has a subtask is DONE state."
  (interactive)
  (org-back-to-heading t)
  (let ((end (save-excursion (org-end-of-subtree t))))
    (outline-end-of-heading)
    (save-excursion
      (re-search-forward (concat "^\*+ " "\\(DONE\\|KILL\\)") nil end))))

(defun nm/has-subtask-active-p ()
  "Returns t for any heading that has subtasks."
  (save-restriction
    (widen)
    (org-back-to-heading t)
    (let ((end (save-excursion (org-end-of-subtree t))))
      (outline-end-of-heading)
      (save-excursion
        (re-search-forward (concat "^\*+ " "\\(NEXT\\|WAIT\\|TODO\\)") end t)))))

;; (defun nm/exist-tag-p (arg)
;;   "If headline has ARG tag keyword assigned, return t."
;;   (interactive)
;;   (let ((end (save-excursion (end-of-line))))
;;     (save-excursion
;;       (progn
;;         (unless (org-at-heading-p)
;;           (org-back-to-heading t))
;;         (beginning-of-line)
;;         (re-search-forward (format ":%s:" arg) end t)))))

(defun nm/exist-tag-p (arg)
  "If headline has ARG tag keyword assigned, return t."
  (interactive)
  (let ((end (save-excursion (end-of-line))))
    (save-excursion
      (member arg (org-get-tags)))))

(defconst nm/context-tags ".+\s\\(:@\w.+:\\)")

(defun nm/exist-context-tag-p (&optional arg)
  "If headline has context tag keyword assigned, return t."
  (interactive)
  (goto-char (org-entry-beginning-position))
  (let ((end (save-excursion (line-end-position))))
    (re-search-forward nm/context-tags end t)))

(defun nm/is-scheduled-p ()
  "Checks task for SCHEDULE and if found, return t."
  (save-excursion
    (org-back-to-heading)
    (let ((end (save-excursion (org-end-of-subtree t))))
      (re-search-forward org-scheduled-regexp end t))))

(defun nm/skip-project-tasks ()
  "Show non-project tasks.
Skip project and sub-project tasks, habits, and project related tasks."
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((bh/is-project-p) subtree-end)
       ((oh/is-scheduled-p) subtree-end)
       ((org-is-habit-p) subtree-end)
       ((bh/is-project-subtree-p) subtree-end)
       (t nil)))))

(defun nm/skip-projects-and-habits-and-single-tasks ()
  "Skip trees that are projects, tasks that are habits, single non-project tasks"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((org-is-habit-p) next-headline)
       ((nm/is-scheduled-p) next-headline)
       ((bh/is-project-p) next-headline)
       ((and (bh/is-task-p) (not (bh/is-project-subtree-p))) next-headline)
       (t nil)))))

(defun nm/skip-scheduled ()
  "Skip headlines that are scheduled."
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((nm/is-scheduled-p) next-headline)
       (t nil)))))

(add-hook 'before-save-hook #'nm/update-task-states)

(defun nm/org-clarify-metadata ()
  "Runs the clarify-task-metadata function with ARG being a list of property values."
  (interactive)
  (nm/org-clarify-task-properties org-tasks-properties-metadata))

(map! :after org
      :map org-mode-map
      :localleader
      :prefix ("j" . "nicks functions")
      :desc "Clarify properties" "c" #'nm/org-clarify-metadata)
;; Clarify Tasks:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Capture headline finder][Capture headline finder:1]]
(defun nm/org-capture-system ()
  "Capture stuff."
  (interactive)
  (save-restriction
    (let ((org-capture-templates
           '(("h" "headline capture" entry (function counsel-outline)
              "* %?" :empty-lines-before 1 :empty-lines-after 1)
             ("p" "plain capture" plain (function end-of-buffer)
              "<%<%Y-%m-%d %H:%M>> %?" :empty-lines-before 1 :empty-lines-after 1))))
      (find-file-other-window (read-file-name "file: " "~/.org/"))
      (if (counsel-outline-candidates)
          (org-capture nil "h"))
      (org-capture nil "p"))))

(defun nm/org-capture-to-file ()
  "Capture stuff."
  (interactive)
  (save-restriction
    (let ((org-capture-templates
           '(("h" "headline capture" entry (function counsel-outline)
              "* %?" :empty-lines-before 1 :empty-lines-after 1)
             ("p" "plain capture" plain (function end-of-buffer)
              "<%<%Y-%m-%d %H:%M>> %?" :empty-lines-before 1 :empty-lines-after 1))))
      (org-capture nil "h"))))

(bind-key "<f7>" #'nm/org-capture-to-file)

(defun nm/org-capture-weeklies ()
  "Find weeklies file and call counsel-outline."
  (interactive)
  (find-file (read-file-name "file: " "~/.org/"))
  (progn
    (counsel-outline)
    (nm/org-end-of-headline)))

(defun nm/org-end-of-headline()
  "Move to end of current headline"
  (interactive)
  (outline-next-heading)
  (forward-char -1))
;; Capture headline finder:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Search file headlines and send tree to indirect buffer][Search file headlines and send tree to indirect buffer:1]]
; TODO Write function that takes a file as input from user, then returns a searchable headline list and narrows the results to a indirect buffer.
;; Search file headlines and send tree to indirect buffer:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*Change Font][Change Font:1]]
(defun nm/emacs-change-font ()
  "Change font based on available font list."
  (interactive)
  (let ((font (ivy-completing-read "font: " (font-family-list))))
    (setq doom-font (font-spec :family font :size 18)
          doom-big-font (font-spec :family font :size 24)))
  (doom/reload-font))
;; Change Font:1 ends here

;; [[file:../../../tmp/config.org.L5Zs54::*End of file loading][End of file loading:1]]
(let ((secrets (expand-file-name "secrets.el" doom-private-dir)))
(when (file-exists-p secrets)
  (load secrets)))
;; End of file loading:1 ends here
