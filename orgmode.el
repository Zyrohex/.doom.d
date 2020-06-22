;;------ Agenda Settings
(after! org (setq org-agenda-files (directory-files-recursively "~/.org/gtd/" "\.org$")))
(after! org (setq org-agenda-diary-file "~/.org/diary.org"
                  org-agenda-window-setup 'only-window
                  org-agenda-dim-blocked-tasks t
                  org-agenda-use-time-grid t
                  org-agenda-hide-tags-regexp ":\\w+:"
                  org-agenda-compact-blocks nil
                  org-agenda-block-separator 61
                  org-agenda-skip-scheduled-if-done t
                  org-agenda-skip-deadline-if-done t
                  org-enforce-todo-checkbox-dependencies t
                  org-enforce-todo-dependencies t
                  org-habit-show-habits t))
;(setq org-agenda-sorting-strategy '(category-up priority-up))
;;------ Agenda Hook
;(defun org-mode-switch-to-narrow-hook ()
;  (org-narrow-to-subtree))
;(add-hook 'org-agenda-after-show-hook 'org-mode-switch-to-narrow-hook)
(add-hook 'auto-save-hook 'org-save-all-org-buffers)

;;------ Captures

(setq org-capture-templates
      '(("c" "Captures")
        ("d" "Diary" plain (file zyro/capture-file-name)
         (file "~/.doom.d/templates/diary.org"))
        ("cc" "Capture" entry (file "~/.org/gtd/inbox.org")
         (file "~/.doom.d/templates/capture.org"))
        ("cb" "Breakfix" entry (file "~/.org/gtd/inbox.org")
         (file "~/.doom.d/templates/breakfix.org"))
        ("cr" "Reference" entry
         (file "~/.org/gtd/refs.org")
         "* NOTE %^{Title} %^G\n%?")
        ("m" "Metrics Tracker" plain
         (file+olp+datetree diary-file "Metrics Tracker")
         (file "~/.doom.d/templates/metrics.org") :immediate-finish t)
        ("h" "Habits Tracker" entry
         (file+olp+datetree diary-file "Metrics Tracker")
         (file "~/.doom.d/templates/habitstracker.org") :immediate-finish t)
        ("a" "Article" plain
         (file+headline "~/.org/gtd/articles.org" "Inbox")
         "%(call-interactively #'org-cliplink-capture)")
        ("x" "Time Tracker" entry (file+headline "~/.org/timetracking.org" "Time Tracker")
         (file "~/.doom.d/templates/timetracker.org") :clock-in t :clock-resume t)))

(defun zyro/capture-file-name ()
  "Generate filename at time of capture"
  (setq zyro/capture-headline (read-string "Document Title: "))
  (expand-file-name (concat "~/.org/diary/"
                            (format "(%s)%s.org" (format-time-string "%b-%d-%Y") zyro/capture-headline))))

(defun zyro/capture-pick-headline ()
  "Pick headline from Inbox"
  (interactive)
  (let ((org-agenda-files "~/.org/gtd/inbox.org"))
    (counsel-org-agenda-headlines)))

(defun zyro/capture-template-selector ()
  "Prompt to select template"
  (interactive)
  (let ((filename (counsel-find-file (concat (doom-dir) "/templates/"))))
    (expand-file-name (format "%s" (counsel-find-file (concat (doom-dir) "/templates/"))))))

;;------ Directories
(after! org (setq org-directory "~/.org/"
                  org-image-actual-width nil
                  +org-export-directory "~/.export/"
                  org-archive-location "::* ARCHIVES"
                  projectile-project-search-path '("~/.org/")))

;;------ Export Settings
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

;;------ Extras
(require 'org-id)
;(setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)
(setq org-link-file-path-type 'relative)
(setq org-passwords-file "~/.org/gtd/passwords.org")

;;------ TODO Keywords
(setq org-todo-keywords
      '((sequence "REFILE(r!)" "SOMEDAY(s!)" "TODO(t!)" "NEXT(n!)" "INPROGRESS(i!)" "|" "DONE(d!)")))

;;------ Logging & Drawers
(after! org (setq org-log-state-notes-insert-after-drawers nil
                  org-log-into-drawer t
                  org-log-done 'time
                  org-log-repeat 'time
                  org-log-redeadline 'note
                  org-log-reschedule 'note))

;;------ Prettify
(after! org (setq org-hide-emphasis-markers nil
                  org-hide-leading-stars t
                  org-list-demote-modify-bullet '(("+" . "-") ("1." . "a.") ("-" . "+"))))

;;------ Properties
(setq org-use-property-inheritance t ; We like to inhert properties from their parents
      org-catch-invisible-edits 'error) ; Catch invisible edits

;;------ Publishing
(after! org (setq org-publish-project-alist
                  '(("attachments"
                     :base-directory "~/.org/"
                     :recursive t
                     :base-extension "jpg\\|jpeg\\|png\\|pdf\\|css"
                     :publishing-directory "~/publish_html"
                     :publishing-function org-publish-attachment)
                    ("notes"
                     :base-directory "~/.org/"
                     :publishing-directory "~/publish_html"
                     :section-numbers nil
                     :base-extension "org"
                     :with-properties nil
                     :with-drawers (not "LOGBOOK")
                     :with-timestamps active
                     :recursive t
                     :auto-sitemap t
                     :sitemap-filename "sitemap.html"
                     :publishing-function org-html-publish-to-html
                     :html-head "<link rel=\"stylesheet\" href=\"http://dakrone.github.io/org.css\" type=\"text/css\"/>"
;                     :html-head "<link rel=\"stylesheet\" href=\"https://codepen.io/nmartin84/pen/RwPzMPe.css\" type=\"text/css\"/>"
;                     :html-head-extra "<style type=text/css>body{ max-width:80%;  }</style>"
                     :html-link-up "../"
                     :with-email t
                     :html-link-up "../../index.html"
                     :auto-preamble t
                     :with-toc t)
                    ("myprojectweb" :components("attachments" "notes")))))

;;----- Refiling
(after! org (setq org-refile-targets '((nil :maxlevel . 9)
                                       (org-agenda-files :maxlevel . 4))
                  org-outline-path-complete-in-steps nil
                  org-refile-allow-creating-parent-nodes 'confirm))

;;------ Startup
(after! org (setq org-startup-indented 'indent
                  org-startup-folded 'content
                  org-src-tab-acts-natively t))
(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'turn-off-auto-fill)
