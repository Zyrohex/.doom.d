(defun zyro/monitor-width-profile-setup ()
  "Calcuate or determine width of display by Dividing height BY width and then setup window configuration to adapt to monitor setup"
  (let ((size (* (/ (float (display-pixel-height)) (float (display-pixel-width))) 10)))
    (when (= size 2.734375)
      (set-popup-rule! "^\\*lsp-help" :side 'left :size .40 :select t)
      (set-popup-rule! "*helm*" :side 'left :size .30 :select t)
      (set-popup-rule! "*Capture*" :side 'left :size .30 :select t)
      (set-popup-rule! "*CAPTURE-*" :side 'left :size .30 :select t)
      (set-popup-rule! "*Org Agenda*" :side 'left :size .25 :select t))))

(zyro/monitor-width-profile-setup)

(defun zyro/monitor-size-profile-setup ()
  "Calcuate our monitor size and then configure element sizes accordingly"
  (let ((size (/ (* (float (display-pixel-width)) (float (display-pixel-height))) 100)))
    (when (> size 71600.0)
      (setq doom-font (font-spec :family "Input Mono" :size 16)
            doom-big-font (font-spec :family "Input Mono" :size 20)))))

(zyro/monitor-size-profile-setup)

(setq org-superstar-headline-bullets-list '("●" "○"))
(setq org-ellipsis "▼")
(setq org-hide-emphasis-markers t)
;(add-hook 'org-mode-hook #'+org-pretty-mode)

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

(setq org-directory "~/.org/")
(load! "gtd.el")
(setq org-gtd-task-files '("next.org" "personal.org" "work.org" "study.org"))

(defun jethro/org-process-inbox ()
  "Called in org-agenda-mode, processes all inbox items."
  (interactive)
  (org-agenda-bulk-mark-regexp "inbox:")
  (jethro/bulk-process-entries))

(defvar jethro/org-current-effort "1:00"
  "Current effort for agenda items.")

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

(defun jethro/org-agenda-process-inbox-item ()
  "Process a single item in the org-agenda."
  (org-with-wide-buffer
   (org-agenda-set-tags)
   (org-agenda-set-property)
   (org-agenda-priority)
   (call-interactively 'org-agenda-schedule)
   (call-interactively 'jethro/my-org-agenda-set-effort)
   (org-agenda-refile nil nil t)))

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

(defun jethro/org-inbox-capture ()
  (interactive)
  "Capture a task in agenda mode."
  (org-capture nil "i"))

(defun zyro/rifle-roam ()
  "Rifle through your ROAM directory"
  (interactive)
  (helm-org-rifle-directories org-roam-directory))

(map! :after org
      :map org-mode-map
      :leader
      :prefix ("n" . "notes")
      :desc "Rifle ROAM Notes" "!" #'zyro/rifle-roam)

(require 'org-roam-protocol)
(setq org-protocol-default-template-key "d")

(setq org-clock-continuously t)

(setq org-tags-column 0)

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

(setq org-agenda-files (append (file-expand-wildcards "~/.org/gtd/*.org")))

(setq user-full-name "Nick Martin"
      user-mail-address "nmartin84@gmail.com")

(setq diary-file "~/.org/diary.org")

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

(when (equal (window-system) nil)
  (and
   (bind-key "C-<down>" #'+org/insert-item-below)
   (setq doom-theme 'doom-monokai-pro)
   (setq doom-font (font-spec :family "Input Mono" :size 20))))

;  (set-popup-rule! "*Org Agenda*" :side 'bottom :size .30 :select t :vslot 2 :ttl 3)
;  (set-popup-rule! "*Capture*" :side 'bottom :size .30 :select t :vslot 2 :ttl 3)
(set-popup-rule! "*helm*" :side 'left :size .30 :select t :vslot 5 :ttl 3)
                                        ;(after! org (set-popup-rule! "*Deft*" :side 'right :size .50 :select t :vslot 2 :ttl 3))
                                        ;(after! org (set-popup-rule! "*Select Link*" :side 'bottom :size .40 :select t :vslot 3 :ttl 3))
                                        ;(after! org (set-popup-rule! "*deadgrep" :side 'bottom :height .40 :select t :vslot 4 :ttl 3))
                                        ;(after! org (set-popup-rule! "\\Swiper" :side 'bottom :size .30 :select t :vslot 4 :ttl 3))

(global-auto-revert-mode 1)
(setq undo-limit 80000000
      evil-want-fine-undo t
      auto-save-default t
      inhibit-compacting-font-caches t)
(whitespace-mode -1)

(setq display-line-numbers-type t)
(setq-default
 delete-by-moving-to-trash t
 tab-width 4
 uniquify-buffer-name-style 'forward
 window-combination-resize t
 x-stretch-cursor t)

(setq company-idle-delay 0.5)

;(use-package org-pdftools
;  :hook (org-load . org-pdftools-setup-link))

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

(require 'elfeed-org)
(elfeed-org)
(setq elfeed-db-directory "~/.elfeed/")
(setq rmh-elfeed-org-files (list "~/google-drive/.elfeed/elfeed.org"))

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

(setq org-roam-directory "~/.org/notes/")
(setq org-roam-tag-sources '(prop all-directories))
(setq org-roam-db-location "~/.org/roam.db")
(add-to-list 'safe-local-variable-values
'(org-roam-directory . "."))

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

;;   (defun my/org-export-preprocessor (backend)
;;     (let ((links (my/org-roam--backlinks-list-with-content (buffer-file-name))))
;;       (unless (string= links "")
;;         (save-excursion
;;           (goto-char (point-max))
;;           (insert (concat "\n* Backlinks\n") links)))))

;;   (add-hook 'org-export-before-processing-hook 'my/org-export-preprocessor)

(require 'ox-reveal)
(setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
(setq org-reveal-title-slide nil)

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

;(load! "orgmode.el")
;(load! "customs.el")

(toggle-frame-maximized)
(setq doom-theme 'doom-one)
