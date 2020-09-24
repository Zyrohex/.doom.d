(setq user-full-name "Nick Martin"
      user-mail-address "nmartin84@gmail.com")

(display-time-mode 1)
(setq display-time-day-and-date t)

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

(when (equal (window-system) nil)
  (and
   (bind-key "C-<down>" #'+org/insert-item-below)
   (setq doom-theme 'doom-monokai-pro)
   (setq doom-font (font-spec :family "Input Mono" :size 20))))

(setq diary-file "~/.org/diary.org")

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

(after! org (setq org-hide-emphasis-markers t
                  org-hide-leading-stars t
                  org-list-demote-modify-bullet '(("+" . "-") ("1." . "a.") ("-" . "+"))
                  org-ellipsis "▼"))

(when (require 'org-superstar nil 'noerror)
  (setq org-superstar-headline-bullets-list '("∴")
        org-superstar-item-bullet-alist nil))

(defun zyro/rifle-roam ()
  "Rifle through your ROAM directory"
  (interactive)
  (helm-org-rifle-directories org-roam-directory))

(map! :after org
      :map org-mode-map
      :leader
      :prefix ("n" . "notes")
      :desc "Rifle ROAM Notes" "!" #'zyro/rifle-roam)

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

(after! org (setq org-clock-continuously t))

(after! org (setq org-capture-templates
      '(("!" "Quick Capture" plain (file "~/.org/gtd/inbox.org")
         "* TODO %(read-string \"Task: \")\n:PROPERTIES:\n:CREATED: %U\n:END:")
        ("p" "New Project" plain (file nick/org-capture-file-picker)
         (file "~/.doom.d/templates/template-projects.org"))
        ("$" "Scheduled Transactions" plain (file "~/.org/gtd/finances.ledger")
         (file "~/.doom.d/templates/ledger-scheduled.org"))
        ("l" "Ledger Transaction" plain (file "~/.org/gtd/finances.ledger")
         "%(format-time-string \"%Y/%m/%d\") * %^{transaction}\n Income:%^{From Account|Checking|Card|Cash}  -%^{dollar amount}\n Expenses:%^{category}  %\\3\n" :empty-lines-before 1))))

(after! org (setq org-image-actual-width nil
                  org-archive-location "~/.org/gtd/archives.org::datetree"
                  projectile-project-search-path '("~/projects/")))

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

(require 'org-id)
(setq org-link-file-path-type 'relative)

(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "HOLD(h)" "|" "DONE(d)" "KILL(k)")))

(after! org (setq org-log-state-notes-insert-after-drawers nil))

(after! org (setq org-log-into-drawer t
                  org-log-done 'time
                  org-log-repeat 'time
                  org-log-redeadline 'note
                  org-log-reschedule 'note))

(setq org-use-property-inheritance t ; We like to inhert properties from their parents
      org-catch-invisible-edits 'error) ; Catch invisible edits

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

(after! org (setq org-refile-targets '((nil :maxlevel . 9)
                                       (org-agenda-files :maxlevel . 4))
                  org-refile-use-outline-path 'buffer-name
                  org-outline-path-complete-in-steps nil
                  org-refile-allow-creating-parent-nodes 'confirm))

(after! org (setq org-startup-indented 'indent
                  org-startup-folded 'content
                  org-src-tab-acts-natively t))
(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'turn-off-auto-fill)

(require 'org-roam-protocol)
(setq org-protocol-default-template-key "d")

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

(setq display-line-numbers-type t)
(setq-default
 delete-by-moving-to-trash t
 tab-width 4
 uniquify-buffer-name-style 'forward
 window-combination-resize t
 x-stretch-cursor t)

(after! org
  (set-company-backend! 'org-mode 'company-capf '(company-yasnippet company-org-roam company-elisp))
  (setq company-idle-delay 0.25))

(use-package define-word
  :config
  (map! :after org
        :map org-mode-map
        :leader
        :desc "Define word at point" "@" #'define-word-at-point))

;(use-package org-pdftools
;  :hook (org-load . org-pdftools-setup-link))

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

(setq deft-use-projectile-projects t)
(defun zyro/deft-update-directory ()
  "Updates deft directory to current projectile's project root folder and updates the deft buffer."
  (interactive)
  (if (projectile-project-p)
      (setq deft-directory (expand-file-name (doom-project-root)))))
(when deft-use-projectile-projects
  (add-hook 'projectile-after-switch-project-hook 'zyro/deft-update-directory)
  (add-hook 'projectile-after-switch-project-hook 'deft-refresh))

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

(setq org-pandoc-options '((standalone . t) (self-contained . t)))

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
           :file-name "%<%Y%m%d%H%M%S>-${slug}"
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

(require 'ox-reveal)
(setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
(setq org-reveal-title-slide nil)

(org-super-agenda-mode t)

(setq org-agenda-custom-commands
      '(("g" "Getting things done (GTD)"
         ((agenda ""
                  ((org-agenda-files (append (file-expand-wildcards "~/.org/gtd/*.org")))
                   (org-agenda-start-day (org-today))
                   (org-agenda-span '1)))
          (tags-todo "-project/NEXT"
                ((org-agenda-files (append (list "~/.org/gtd/next.org")))
                 (org-agenda-prefix-format " %-12:c [%-5e] %(my-agenda-prefix) ")
                 (org-agenda-overriding-header "Next")
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled))))
          (tags-todo "project/NEXT|TODO"
                ((org-agenda-files (append (list "~/.org/gtd/next.org")))
                 (org-agenda-prefix-format " %-12:c [%-5e] %(my-agenda-prefix) ")
;                 (org-agenda-prefix-format " %i %-12:c [%-5e]%l↳ ")
                 (org-agenda-overriding-header "Projects")
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled))))
          (tags-todo "-project/TODO"
                ((org-agenda-files (append (list "~/.org/gtd/next.org")))
                 (org-agenda-prefix-format " %-12:c [%-5e] %(my-agenda-prefix) ")
                 (org-agenda-overriding-header "Inbox")
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled))))
          (todo "HOLD"
                ((org-agenda-files (append (list "~/.org/gtd/next.org")))
                 (org-agenda-prefix-format " %-12:c [%-5e] %(my-agenda-prefix) ")
                 (org-agenda-overriding-header "On Hold")
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled))))
          (tags "CLOSED>=\"<today>\""
                ((org-agenda-overriding-header "\nCompleted today\n")
                 (org-agenda-prefix-format " %-12:c [%-5e] %(my-agenda-prefix) ")
                 (org-agenda-files (append (file-expand-wildcards "~/.org/gtd/*.org")))))))
        ("i" "Inbox"
         ((todo ""
                ((org-agenda-files (list "~/.org/gtd/inbox.org"))
                 (org-super-agenda-groups '((:auto-ts t)))))))
        ("x" "Someday"
         ((todo ""
                ((org-agenda-files (list "~/.org/gtd/incubate.org"))
                 (org-super-agenda-groups
                  '((:auto-parent t)))))))))

(let ((secrets (expand-file-name "secrets.el" doom-private-dir)))
(when (file-exists-p secrets)
  (load secrets)))

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

(load! "customs.el")

(defun +nick/org-insert-timestamp ()
  "Insert active timestamp at POS."
  (interactive)
  (insert (format "<%s> " (format-time-string "%Y-%m-%d %H:%M:%p"))))
(map! :after org
      :map org-mode-map
      :localleader
      :prefix ("j" . "nicks functions")
      :desc "Insert timestamp at POS" "i" #'+nick/org-insert-timestamp)

(defun nick/org-capture-file-picker ()
  "Select a file from the PROJECTS folder and return file-name."
  (let ((file (read-file-name "Project: " "~/.org/gtd/projects/")))
    (expand-file-name (format "%s" file))))

(after! org (zyro/monitor-width-profile-setup)
  (toggle-frame-fullscreen)
  (setq doom-theme 'doom-one))
