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
 x-stretch-cursor nil)

(bind-key "<f6>" #'link-hint-copy-link)
(bind-key "<f12>" #'org-cycle-agenda-files)
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

(when (equal (window-system) nil)
  (and
   (bind-key "C-<down>" #'+org/insert-item-below)
   (setq doom-theme nil)
   (setq doom-font (font-spec :family "Roboto Mono" :size 20))))

(setq diary-file "~/.org/diary.org")
(setq org-directory "~/.org/")
(setq projectile-project-search-path "~/projects/")

(setq doom-theme 'doom-solarized-dark)

(after! org (set-popup-rule! "^\\*lsp-help" :side 'bottom :size .30 :select t)
  (set-popup-rule! "*helm*" :side 'right :size .30 :select t)
  (set-popup-rule! "*Org QL View:*" :side 'right :size .25 :select t)
  (set-popup-rule! "*Capture*" :side 'left :size .30 :select t)
  (set-popup-rule! "*CAPTURE-*" :side 'left :size .30 :select t))
;  (set-popup-rule! "*Org Agenda*" :side 'right :size .40 :select t))

(when (equal system-type 'gnu/linux)
  (setq doom-font (font-spec :family "Roboto Mono" :size 18 :weight 'light)
        doom-big-font (font-spec :family "Roboto Mono" :size 22 :weight 'light)))
(when (equal system-type 'windows-nt)
  (setq doom-font (font-spec :family "InputMono" :size 18)
        doom-big-font (font-spec :family "InputMono" :size 22)))

(require 'org-habit)
(require 'org-id)
(after! org (setq org-archive-location "~/.org/gtd/archives.org::* %s"
                  org-image-actual-width (truncate (* (display-pixel-width) 0.15))
                  org-link-file-path-type 'relative
                  org-log-state-notes-insert-after-drawers nil
                  org-catch-invisible-edits 'error
                  org-refile-targets '((nil :maxlevel . 9)
                                       (org-agenda-files :maxlevel . 4))
                  org-refile-use-outline-path 'buffer-name
                  org-outline-path-complete-in-steps nil
                  org-refile-allow-creating-parent-nodes 'confirm
                  org-startup-indented 'indent
                  org-insert-heading-respect-content nil
                  org-startup-folded 'content
                  org-src-tab-acts-natively t
                  org-list-allow-alphabetical nil))

(add-hook 'org-mode-hook 'turn-off-auto-fill)
(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode -1)))

(after! org (setq org-hide-emphasis-markers t
                  org-hide-leading-stars t
                  org-list-demote-modify-bullet '(("+" . "-") ("1." . "a.") ("-" . "+"))))

(when (require 'org-superstar nil 'noerror)
  (setq org-superstar-headline-bullets-list '("•")
        org-superstar-item-bullet-alist nil))

(after! org (setq org-agenda-diary-file "~/.org/diary.org"
                  org-agenda-dim-blocked-tasks t ; grays out task items that are blocked by another task (EG: Projects with subtasks)
                  org-agenda-use-time-grid nil
                  org-agenda-tags-column 0
;                  org-agenda-hide-tags-regexp "\\w+" ; Hides tags in agenda-view
                  org-agenda-compact-blocks nil
                  org-agenda-block-separator ""
                  org-agenda-skip-scheduled-if-done t
                  org-agenda-skip-deadline-if-done t
                  org-agenda-window-setup 'current-window
                  org-enforce-todo-checkbox-dependencies nil ; This has funny behavior, when t and you try changing a value on the parent task, it can lead to Emacs freezing up. TODO See if we can fix the freezing behavior when making changes in org-agenda-mode.
                  org-enforce-todo-dependencies t
                  org-habit-show-habits t))

(after! org (setq org-agenda-files (append (file-expand-wildcards "~/.org/gtd/*.org") (file-expand-wildcards "~/.org/gtd/*/*.org"))))

(after! org (setq org-clock-continuously t)) ; Will fill in gaps between the last and current clocked-in task.

(after! org (setq org-capture-templates
      '(("!" "Quick Capture" entry (file+headline "~/.org/gtd/inbox.org" "Inbox")
         "* TODO %(read-string \"Task: \")\n:PROPERTIES:\n:CREATED: %U\n:END:")
        ("j" "Journal Entry" entry (file+olp+datetree "~/.org/gtd/journal.org")
         "* %^{title}\n:PROPERTIES:\n:CREATED: %T\n:END:\n%?")
        ("n" "New Note" entry (file "~/.org/gtd/notes.org")
         "* %^{title} :NOTE:\n:PROPERTIES:\n:CREATED: %U\n:END:\n%?")
        ("t" "Tasks")
        ("tn" "New Task" entry (file+olp "~/.org/gtd/personal.org" "dailies")
         "* TODO %^{title}\n:PROPERTIES:\n:CREATED: %U\n:END:\n%?")
        ("z" "Logs")
        ("zx" "Log w/killring" plain (function nm/org-capture-weeklies)
         "#+caption: recap of \"%(read-string \"title: \")\" on [%<%Y-%m-%d %a %H:%M>]\n%c %?" :empty-lines-before 1 :empty-lines-after 1)
        ("zz" "Quick log" plain (function nm/org-capture-weeklies)
         "#+caption: recap of \"%(read-string \"title: \")\" on [%<%Y-%m-%d %a %H:%M>]\n%?" :empty-lines-before 1 :empty-lines-after 1)
        ("l" "Ledger")
        ("ls" "Add scheduled Transactions" plain (file "~/.org/gtd/finances.ledger")
         (file "~/.doom.d/templates/ledger-scheduled.org"))
        ("la" "Add Transaction" plain (file "~/.org/gtd/finances.ledger")
         "%(format-time-string \"%Y/%m/%d\") * %^{transaction}\n Income:%^{From Account|Checking|Card|Cash}  -%^{dollar amount}\n Expenses:%^{category}  %\\3\n" :empty-lines-before 1))))

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

(after! org (setq org-log-into-drawer t
                  org-log-done 'time
                  org-log-repeat 'time
                  org-log-redeadline 'note
                  org-log-reschedule 'note))

(after! org (setq org-use-property-inheritance t)) ; We like to inhert properties from their parents

(after! org (setq org-publish-project-alist
                  '(("attachments"
                     :base-directory "~/.org/"
                     :recursive t
                     :base-extension "jpg\\|jpeg\\|png\\|pdf\\|css"
                     :publishing-directory "~/publish_html"
                     :publishing-function org-publish-attachment)
                    ("org files to MD"
                     :base-directory "~/.org/"
                     :publishing-directory "~/org-md/"
                     :base-extension "org"
                     :recursive t
                     :publishing-function org-md-publish-to-md)
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
                    ("myprojectweb" :components("attachments" "notes" "org files to MD")))))

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

(after! org
  (set-company-backend! 'org-mode 'company-capf '(company-yasnippet company-elisp))
  (setq company-idle-delay 0.25))

(setq deft-use-projectile-projects t)
(defun zyro/deft-update-directory ()
  "Updates deft directory to current projectile's project root folder and updates the deft buffer."
  (interactive)
  (if (projectile-project-p)
      (setq deft-directory (expand-file-name (doom-project-root)))))
(when deft-use-projectile-projects
  (add-hook 'projectile-after-switch-project-hook 'zyro/deft-update-directory)
  (add-hook 'projectile-after-switch-project-hook 'deft-refresh))

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

(advice-add 'deft-parse-title :around #'my-deft/parse-title-with-directory-prepended)

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

(after! org (setq org-journal-dir "~/.org/gtd/journal/"
                  org-journal-enable-agenda-integration t
                  org-journal-file-type 'monthly
                  org-journal-carryover-items "TODO=\"TODO\"|TODO=\"NEXT\"|TODO=\"PROJ\"|TODO=\"STRT\"|TODO=\"WAIT\"|TODO=\"HOLD\""))

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

(setq org-ql-views '(("Overview: Agenda-like" :buffers-files org-agenda-files :query
                      (and (not (done))
                           (or (habit) (deadline auto) (scheduled :to today) (scheduled :on today)))
                      :sort
                      (date priority todo)
                      :super-groups org-super-agenda-groups :title "Agenda Like")
                     ("Overview: Project Sub-tasks" :buffers-files org-agenda-files
                      :query (and (todo "TODO" "NEXT" "WAIT") (ancestors (todo "PROJ")))
                      :sort nil :narrow nil :super-groups ((:auto-parent t))
                      :title "Overview: Project Sub-tasks")
                     ("Overview: Sub-projects" :buffers-files org-agenda-files
                      :query (and (todo "PROJ") (ancestors (todo "PROJ")))
                      :sort nil :narrow nil
                      :super-groups ((:auto-parent t))
                      :title "Overview: Sub-projects")
                     ("Inbox Bucket" :buffers-files org-agenda-files
                      :query (and (todo "TODO") (not (tags "SOMEDAY")))
                      :sort (date)
                      :narrow nil :super-groups ((:auto-ts t))  :title "Inbox Bucket")
                     ("Recent Items" :buffers-files org-agenda-files
                      :query (and (ts :from -7 :to today) (not (or (todo) (todo "DONE"))))
                      :sort (date)
                      :narrow nil
                      :super-groups ((:auto-ts t))
                      :title "Recent Items")))

(map! :after org
      :map org-mode-map
      :leader
      :prefix ("o" . "open")
      :desc "org-ql" "q" #'org-ql-view)

(bind-key "<f9>" #'org-ql-view)

(setq org-pandoc-options '((standalone . t) (self-contained . t)))

(require 'ox-reveal)
(setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
(setq org-reveal-title-slide nil)

;; (setq org-roam-tag-sources '(prop last-directory))
;; (setq org-roam-db-location "~/.org/roam.db")
;; (setq org-roam-directory "~/.org/")

;; (use-package company-org-roam
;;   :ensure t
;;   ;; You may want to pin in case the version from stable.melpa.org is not working
;;   ; :pin melpa
;;   :config
;;   (push 'company-org-roam company-backends))

;; (setq org-roam-dailies-capture-templates
;;    '(("d" "daily" plain (function org-roam-capture--get-point) ""
;;       :immediate-finish t
;;       :file-name "journal/%<%Y-%m-%d-%a>"
;;       :head "#+TITLE: %<%Y-%m-%d %a>\n#+STARTUP: content\n\n")))

;; (setq org-roam-capture-templates
;;         '(("d" "digest" plain (function org-roam-capture--get-point)
;;            "%?"
;;            :file-name "notes/digest/%<%Y%m%d%H%M>-${slug}"
;;            :head "#+title: ${title}\n#+roam_tags: %^{roam_tags}\n\nsource :: [[%^{link}][%^{link_desc}]]\n\n"
;;            :unnarrowed t)
;;           ("n" "notes" plain (function org-roam-capture--get-point)
;;            :file-name "notes/${slug}"
;;            :head "#+title: ${title}\n#+roam_tags: %(read-string \"tags: \")\n\n"
;;            :unnarrowed t
;;            "%?")
;;           ("p" "private" plain (function org-roam-capture--get-point)
;;            :file-name "notes/private/${slug}"
;;            :head "#+title: ${title}\n#+roam_tags: %(read-string \"tags: \")\n\n"
;;            :unnarrowed t
;;            "%?")
;;           ("r" "reveal slide" plain (function org-roam-capture--get-point)
;;            :file-name "slides/%<%Y%m%d%H%M>-${slug}"
;;            :head "#+title: ${title}\n#+options: num:nil toc:nil\n#+REVEAL_THEME: %^{theme|black|white|league|beige|sky|night|serif|simple|solarized|blood|moon}\n#+REVEAL_PLUGINS: (highlight)\n#+REVEAL_OVERVIEW: t\n\n"
;;            :unnarrow t
;;            "%?")))

;; (defun my/org-roam--backlinks-list-with-content (file)
;;   (with-temp-buffer
;;     (if-let* ((backlinks (org-roam--get-backlinks file))
;;               (grouped-backlinks (--group-by (nth 0 it) backlinks)))
;;         (progn
;;           (insert (format "\n\n* %d Backlinks\n"
;;                           (length backlinks)))
;;           (dolist (group grouped-backlinks)
;;             (let ((file-from (car group))
;;                   (bls (cdr group)))
;;               (insert (format "** [[file:%s][%s]]\n"
;;                               file-from
;;                               (org-roam--get-title-or-slug file-from)))
;;               (dolist (backlink bls)
;;                 (pcase-let ((`(,file-from _ ,props) backlink))
;;                   (insert (s-trim (s-replace "\n" " " (plist-get props :content))))
;;                   (insert "\n\n")))))))
;;     (buffer-string)))

;; (defun my/org-export-preprocessor (backend)
;;   (let ((links (my/org-roam--backlinks-list-with-content (buffer-file-name))))
;;     (unless (string= links "")
;;       (save-excursion
;;         (goto-char (point-max))
;;         (insert (concat "\n* Backlinks\n") links)))))

;; (add-hook 'org-export-before-processing-hook 'my/org-export-preprocessor)

;; (use-package org-roam-server
;;   :ensure t
;;   :config
;;   (setq org-roam-server-host "127.0.0.1"
;;         org-roam-server-port 8070
;;         org-roam-server-export-inline-images t
;;         org-roam-server-authenticate nil
;;         org-roam-server-network-poll nil
;;         org-roam-server-network-arrows 'from
;;         org-roam-server-network-label-truncate t
;;         org-roam-server-network-label-truncate-length 60
;;         org-roam-server-network-label-wrap-length 20))

(setq org-super-agenda-mode t
      org-agenda-todo-ignore-scheduled 'future
      org-agenda-tags-todo-honor-ignore-options t
      org-agenda-fontify-priorities t)

(setq org-agenda-custom-commands
      (quote (("N" "Notes" tags "NOTE"
               ((org-agenda-overriding-header "Notes")
                (org-tags-match-list-sublevels t)))
              ("h" "Habits" tags-todo "STYLE=\"habit\""
               ((org-agenda-overriding-header "Habits")
                (org-agenda-sorting-strategy
                 '(todo-state-down effort-up category-keep))))
              ("n" "Next Actions"
               ((agenda ""
                        ((org-agenda-span '1)
                         (org-agenda-files (append (file-expand-wildcards "~/.org/gtd/*.org")))
                         (org-agenda-start-day (org-today))))
                (tags-todo "-@delegated/-PROJ-TODO-WAIT-WATCH"
                           ((org-agenda-overriding-header "Project Tasks")
                            (org-agenda-skip-function 'bh/skip-non-projects)
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-sorting-strategy
                             '(category-up))))
                (tags-todo "-SOMEDAY-@delegated/-TODO-WAIT-PROJ-WATCH"
                           ((org-agenda-overriding-header (concat "Standalone Tasks"))
                            (org-agenda-skip-function 'nm/skip-project-tasks)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-agenda-sorting-strategy '(category-up))))
                (tags-todo "-SOMEDAY-@delegated/WATCH"
                           ((org-agenda-overriding-header "Keep eye on")
                            (org-agenda-sorting-strategy '(category-keep))))
                (tags-todo "@delegated/!"
                           ((org-agenda-overriding-header "Delegated")
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-agenda-sorting-strategy '(category-keep))))
                (tags-todo "-@delegated/WAIT"
                           ((org-agenda-overriding-header "On Hold")
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-SOMEDAY/TODO"
                           ((org-tags-match-list-sublevels nil)
                            (org-agenda-overriding-header "Inbox Bucket")))
                (tags-todo "-@delegated/PROJ"
                           ((org-agenda-overriding-header "Projects")
                            (org-agenda-skip-function 'bh/skip-non-projects)
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-sorting-strategy
                             '(category-keep))))))
              ("r" "Review"
               ((tags-todo "-CANCELLED/!"
                           ((org-agenda-overriding-header "Stuck Projects")
                            (org-agenda-skip-function 'bh/skip-non-stuck-projects)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
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
                (tags-todo "-SOMEDAY/TODO"
                           ((org-tags-match-list-sublevels nil)
                            (org-agenda-overriding-header "Inbox Bucket")))
                (tags-todo "SOMEDAY/"
                           ((org-agenda-overriding-header "Someday Tasks")
                            (org-agenda-skip-function 'nm/skip-scheduled)
                            (org-tags-match-list-sublevels nil)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks))))))))

(setq visual-fill-column 120)

(load! "org-helpers.el")

(defadvice org-archive-subtree (around fix-hierarchy activate)
  (let* ((fix-archive-p (and (not current-prefix-arg)
                             (not (use-region-p))))
         (location (org-archive--compute-location org-archive-location))
         (afile (car location))
         (offset (if (= 0 (length (cdr location)))
                     1
                   (1+ (string-match "[^*]" (cdr location)))))
         (buffer (or (find-buffer-visiting afile) (find-file-noselect afile))))
    ad-do-it
    (when fix-archive-p
      (with-current-buffer buffer
        (goto-char (point-max))
        (while (> (org-current-level) offset) (org-up-heading-safe))
        (let* ((olpath (org-entry-get (point) "ARCHIVE_OLPATH"))
               (path (and olpath (split-string olpath "/")))
               (level offset)
               tree-text)
          (when olpath
            (org-mark-subtree)
            (setq tree-text (buffer-substring (region-beginning) (region-end)))
            (let (this-command) (org-cut-subtree))
            (goto-char (point-min))
            (save-restriction
              (widen)
              (-each path
                (lambda (heading)
                  (if (re-search-forward
                       (rx-to-string
                        `(: bol (repeat ,level "*") (1+ " ") ,heading)) nil t)
                      (org-narrow-to-subtree)
                    (goto-char (point-max))
                    (unless (looking-at "^")
                      (insert "\n"))
                    (insert (make-string level ?*)
                            " "
                            heading
                            "\n"))
                  (cl-incf level)))
              (widen)
              (org-end-of-subtree t t)
              (org-paste-subtree level tree-text))))))))

(defface org-logbook-note
  '((t (:foreground "LightSkyBlue")))
  "Face for printr function")

(font-lock-add-keywords
 'org-mode
 '(("\\w+\s\\w+\s\\w+\s\\[\\w+-\\w+-\\w+\s\\w+\s\\w+:\\w+\\] \\\\\\\\" . 'org-logbook-note )))

(defun nm/insert-time-stamp-at-point ()
  "Insert active timestamp at POINT."
  (interactive)
  (format "%s " (org-insert-time-stamp nil t)))

(bind-key "C-S-l" #'nm/insert-time-stamp-at-point)
(map! :after org
      :map org-mode-map
      :localleader
      :prefix ("d" . "date/deadline")
      :desc "Insert timestamp at POS" "i" #'nm/insert-time-stamp-at-point)

(require 'find-lisp)
(defun nm/org-id-prompt-id ()
  "Prompt for the id during completion of id: link."
  (let ((org-agenda-files (find-lisp-find-files org-directory "\.org$")))
    (let ((dest (org-refile-get-location))
          (name nil)
          (id nil))
      (save-excursion
        (find-file (cadr dest))
        (goto-char (nth 3 dest))
        (setq id (org-id-get (point) t)
              name (org-get-heading t t t t)))
      (org-insert-link nil (concat "id:" id) name))))

(org-link-set-parameters "id" :complete #'nm/org-id-prompt-id)

(defun nm/org-capture-file-picker ()
  "Select a file from the PROJECTS folder and return file-name."
  (let ((file (read-file-name "Project: " "~/.org/gtd/projects/")))
    (expand-file-name (format "%s" file))))

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

(defun nm/org-clarify-metadata ()
  "Runs the clarify-task-metadata function with ARG being a list of property values." ; TODO work on this function and add some meaning to it.
  (interactive)
  (nm/org-clarify-task-properties org-tasks-properties-metadata))

(load! "org-task-automation.el")

(map! :after org
      :map org-mode-map
      :localleader
      :prefix ("j" . "nicks functions")
      :desc "Clarify properties" "c" #'nm/org-clarify-metadata)

(defun nm/org-capture-weeklies ()
  "Initiate the capture system and find headline to capture under."
  (let ((dest (org-refile-get-location)))
    (let ((file (cadr dest))
          (pos (nth 3 dest))
          (title (nth 2 dest)))
      (find-file file)
      (goto-char pos)
      (nm/org-end-of-headline))))

(defun nm/org-end-of-headline()
  "Move to end of current headline"
  (interactive)
  (outline-next-heading)
  (forward-char -1))

(defun nm/goto-headline-agenda-files ()
  "Searches org-directory for headline and returns results to indirect buffer."
  (interactive)
  (let ((org-agenda-files (find-lisp-find-files org-directory "\.org$"))
        (org-refile-use-outline-path nil)
        (org-refile-history nil))
    (let ((dest (org-refile-get-location))
          (buffer nil)
          (first (frame-first-window)))
      (save-excursion
        (if (eq first (next-window first))
            (progn (evil-window-vsplit) (evil-window-right 1))
          (other-window 1))
        (find-file (cadr dest))
        (goto-char (nth 3 dest))
        (org-tree-to-indirect-buffer)))))

(map! :after org
      :map org-mode-map
      :leader
      :desc "Outline all to indirect-buffer" "@" #'nm/goto-headline-agenda-files)

(defun nm/emacs-change-font ()
  "Change font based on available font list."
  (interactive)
  (let ((font (ivy-completing-read "font: " nm/font-family-list))
        (weight (ivy-completing-read "weight: " '(normal light medium))))
    (setq doom-font (font-spec :family font :size 18 :weight (intern weight))
          doom-big-font (font-spec :family font :size 22 :weight (intern weight))))
  (doom/reload-font))

(defvar nm/font-family-list '("Input Mono" "Anonymous Pro" "Cousine" "Bront" "Hack" "Fira Code" "IBM Plex Mono" "JetBrains Mono" "Roboto Mono" "PT Mono" "DejaVu Sans Mono" "Victor Mono" "Overpass Mono" "Liberation Mono" "FreeMono" "Ubuntu Mono"))

(let ((secrets (expand-file-name "secrets.el" doom-private-dir)))
(when (file-exists-p secrets)
  (load secrets)))
