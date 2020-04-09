(setq doom-font (font-spec :family "InputMono" :size 16)
      doom-variable-pitch-font (font-spec :family "InputMono" :height 120)
      doom-unicode-font (font-spec :family "DejaVu Sans")
      doom-big-font (font-spec :family "InputMono" :size 20))

(setq doom-theme 'doom-city-lights)
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

(setq user-full-name "Nicholas Martin"
      user-mail-address "nmartin84.com")

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
      :prefix ("s" . "search")
      :desc "Deadgrep Directory" "d" #'deadgrep
      :desc "Swiper All" "@" #'swiper-all
      :prefix ("o" . "open")
      :desc "Elfeed" "e" #'elfeed
      :desc "Deft" "w" #'deft)

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

(global-auto-revert-mode t)

(setq deft-directory "~/.org/notes/")
(setq deft-current-sort-method 'title)

(setq rmh-elfeed-org-files "~/.elfeed/elfeed.org")

(after! org (setq org-agenda-files '("~/.org/workload/tasks.org" "~/.org/workload/references.org")))
;(after! org (setq org-super-agenda-groups
;                  '((:auto-category t))))
(after! org (setq org-agenda-diary-file "~/.org/diary.org"
                  org-agenda-dim-blocked-tasks t
                  org-agenda-use-time-grid t
                  org-agenda-hide-tags-regexp ":\\w+:"
;                  org-agenda-prefix-format " %(my-agenda-prefix) "
                  org-agenda-skip-scheduled-if-done t
                  org-agenda-skip-deadline-if-done t
                  org-enforce-todo-checkbox-dependencies nil
                  org-habit-show-habits t))

(load-library "find-lisp")
(after! org (setq org-agenda-files
                  (find-lisp-find-files "~/.org/" "\.org$")))

(after! org (setq org-capture-templates
                  '(("a" "Append")
                    ("c" "Captures"))))

(after! org (add-to-list 'org-capture-templates
             '("ct" "Task" entry (file+headline "~/.org/workload/tasks.org" "INBOX")
               "* TODO %^{taskname} %^{CATEGORY}p
:PROPERTIES:
:CREATED: %U
:END:
")))

(after! org (add-to-list 'org-capture-templates
             '("cr" "Reference" entry (file "~/.org/workload/references.org")
"* TODO %u %^{reference}
%?")))

(defun my/generate-org-note-name ()
  (setq my-org-note--name (read-string "Name: "))
  (expand-file-name (format "%s.org" my-org-note--name) "~/.org/notes/"))

(after! org (add-to-list 'org-capture-templates
                         '("cn" "Note" plain (file my/generate-org-note-name)
                           "%(format \"#+TITLE: %s\n\" my-org-note--name)
%?")))

(defun org-capture-file-selector ()
  "test file selector"
  (interactive)
  (setq org-notes-directory "~/.org/notes/")
  (concat (read-file-name "Select file: " org-notes-directory)))
(after! org (add-to-list 'org-capture-templates
                         '("fnh" "New Headline to Note" entry (file org-capture-file-selector)
                           "* %?")))

(defun org-capture-file-selector ()
  "test file selector"
  (interactive)
  (setq org-notes-directory "~/.org/notes/")
  (concat (read-file-name "Select file: " org-notes-directory)))
(after! org (add-to-list 'org-capture-templates
                         '("fni" "New Item to Headline" plain (file+function org-capture-file-selector org-capture-headline-finder)
                           "+ %u %?")))

(after! org (add-to-list 'org-capture-templates
             '("fti" "+Task Item" plain (file+function "~/.org/workload/tasks.org" org-capture-headline-finder)
"+ %u %?")))

(after! org (add-to-list 'org-capture-templates
             '("ftc" "Child Task" entry (file+function "~/.org/workload/tasks.org" org-find-task-headline)
"* TODO %u %^{task}%? %^G")))

(after! org (add-to-list 'org-capture-templates
             '("bt" "Task" entry (file+function buffer-name org-find-task-headline)
"* TODO %u %^{task} %^G
%?")))

(after! org (add-to-list 'org-capture-templates
                         '("cd" "Daily Task List" plain (file+headline "~/.org/workload/tasks.org" "Daily Items")
                           "- [ ] %t %?")))

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

(after! org (add-to-list 'org-capture-templates
             '("at" "Task" entry (file+function buffer-name org-back-to-heading-or-point-min)
"* TODO %^{task}%?")))

(after! org (add-to-list 'org-capture-templates
                         '("ai" "Add List to Headline" plain (file+function buffer-name org-end-of-subtree)
                         "- %?")))

(after! org (add-to-list 'org-capture-templates
                         '("af" "Add List to Find Headline" plain (file+function org-capture-file-selector org-capture-headline-finder)
                         "+ %?")))

(after! org (add-to-list 'org-capture-templates
             '("an" "New Headline" entry (file+function buffer-name org-back-to-heading-or-point-min)
"* %^{note}%?")))

(after! org (setq org-directory "~/.org/"
                  org-image-actual-width nil
                  +org-export-directory "~/.export/"
                  org-archive-location "~/.org/workload/archive.org::datetree/"
                  org-default-notes-file "~/.org/workload/inbox.org"
                  projectile-project-search-path '("~/.org/")))

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

(after! org (setq org-todo-keyword-faces
      '(("TODO" :foreground "OrangeRed" :weight bold)
        ("NEXT" :foreground "SteelBlue" :weight bold)
        ("SOMEDAY" :foreground "gold" :weight bold)
        ("ACTIVE" :foreground "DeepPink" :weight bold)
        ("NEXT" :foreground "spring green" :weight bold)
        ("DONE" :foreground "slategrey" :weight bold :strike-through t))))

(after! org (setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n!)" "SOMEDAY(s!)" "HOLDING(h!)" "DELEGATED(e!)" "|" "DONE(d!)"))))

(after! org (setq org-log-state-notes-insert-after-drawers nil
                  org-log-into-drawer t
                  org-log-done 'time
                  org-log-repeat 'time
                  org-log-redeadline 'note
                  org-log-reschedule 'note))

;(after! org (setq org-bullets-bullet-list '("•" "◦")
(after! org (setq org-hide-emphasis-markers nil
                  org-bullets-bullet-list '("◉" "⚫" "○")
                  org-list-demote-modify-bullet '(("+" . "-") ("1." . "a.") ("-" . "+"))
                  org-ellipsis "▼"))

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

(after! org (setq org-refile-targets '((org-agenda-files . (:maxlevel . 6)))
                  org-outline-path-complete-in-steps nil
                  org-refile-allow-creating-parent-nodes 'confirm))

(after! org (setq org-startup-indented t
                  org-src-tab-acts-natively t))
;(add-hook 'org-mode-hook (lambda () (org-autolist-mode)))
(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'turn-off-auto-fill)

(after! org (setq org-tags-column -80))

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
                    (:auto-category t)))))
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

(defun +org/insert-item-below-w-timestamp (count)
  "Inserts a new item below with inactive timestamp asserted."
  (interactive "p")
  (dotimes (_ count) (+org--insert-item 'below) (org-end-of-line) (insert (org-format-time-string "[%Y-%m-%d %a]") " ")))
(map! :n "S-<return>" #'+org/insert-item-below-w-timestamp)

(defun my--browse-url (url &optional _new-window)
  ;; new-window ignored
  "Opens link via powershell.exe"
  (interactive (browse-url-interactive-arg "URL: "))
  (let ((quotedUrl (format "start '%s'" url)))
    (apply 'call-process "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe" nil
           0 nil
           (list "-Command" quotedUrl))))
(setq-default browse-url-browser-function 'my--browse-url)

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

(defvar my-archive-dir "~/.org/archives/" "My Archive Directory")

(defun my/org-archive-task ()
  "Moves the current buffer to the archived folder"
  (interactive)
  (let ((old (or (buffer-file-name) (user-error "Not visiting a file")))
        (dir (read-directory-name "Move to: " my-archive-dir)))
    (write-file (expand-file-name (file-name-nondirectory old) dir) t)
    (delete-file old)))

(defvar org-archive-directory "~/.org/archives/")
(defun org-archive-file ()
  "Moves the current buffer to the archived folder"
  (interactive)
  (let ((old (or (buffer-file-name) (user-error "Not visiting a file")))
        (dir (read-directory-name "Move to: " org-archive-directory)))
    (write-file (expand-file-name (file-name-nondirectory old) dir) t)
    (delete-file old)))
(provide 'org-archive-file)

(defun org-capture-file-selector ()
  "test file selector"
  (interactive)
  (setq org-notes-directory "~/.org/notes/")
  (concat (read-file-name "Select file: " org-notes-directory)))

(defun org-capture-headline-finder (&optional arg)
  "Like `org-todo-list', but using only the current buffer's file."
  (interactive "P")
  (let ((org-agenda-files (list (buffer-file-name (current-buffer)))))
    (if (null (car org-agenda-files))
        (error "%s is not visiting a file" (buffer-name (current-buffer)))
      (counsel-org-agenda-headlines)))
  (goto-char (org-end-of-subtree)))

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

(defun org-find-task-headline ()
  "Find headline in Task Files"
  (interactive)
  (setq org-agenda-files '("~/.org/workload/tasks.org"))
  (counsel-org-agenda-headlines))

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

(defun org-task-item-option ()
  "Simple function to select if you want a item or checklist inserted"
  (interactive)
  (let (choices ("Item" "Checklist")))
  (if (equal (choices "Item"))
      (concat "+ %u %?")
    (concat "+ [ ] %u %?")))

(defun org-update-cookies-after-save()
  (interactive)
  (let ((current-prefix-arg '(4)))
    (org-update-statistics-cookies "ALL")))

(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'org-update-cookies-after-save nil 'make-it-local)))
(provide 'org-update-cookies-after-save)

(setq-default truncate-lines t)

(defun jethro/truncate-lines-hook ()
  (setq truncate-lines nil))

(add-hook 'text-mode-hook 'jethro/truncate-lines-hook)
