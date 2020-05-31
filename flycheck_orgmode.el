;;------ Agenda Settings
;(after! org (setq org-agenda-files (directory-files-recursively "~/.org/" "\.org$")))
(setq org-agenda-files '("~/.org/gtd/"))
(after! org (setq org-agenda-diary-file "~/.org/diary.org"
                  org-agenda-dim-blocked-tasks t
                  org-agenda-use-time-grid t
                  org-agenda-hide-tags-regexp ":\\w+:"
                  org-agenda-compact-blocks nil
                  org-agenda-block-separator 61
;                  org-agenda-prefix-format " %(my-agenda-prefix) "
                  org-agenda-skip-scheduled-if-done t
                  org-agenda-skip-deadline-if-done t
                  org-enforce-todo-checkbox-dependencies t
                  org-enforce-todo-dependencies t
                  org-habit-show-habits t))
;;------ Agenda Hook
(defun org-mode-switch-to-narrow-hook ()
  (org-narrow-to-subtree))
(add-hook 'org-agenda-after-show-hook 'org-mode-switch-to-narrow-hook)

(add-hook 'auto-save-hook 'org-save-all-org-buffers)

;;------ Captures

(setq org-capture-templates
      `(("j" "Diary [w/clock]" entry
         (file+headline "~/.org/diary.org"
                        ,(format "%s" (format-time-string "%a, %b-%d")))
         "* %U %^{Title}\n:PROPERTIES:\n:END:\n:LOGBOOK:\n:END:\n%?" :clock-in :clock-resume)
        ("c" "Capture" entry
         (file "~/.org/gtd/inbox.org")
         "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:" :prepend t)
        ("a" "Article" plain
         (file+headline "~/.org/gtd/articles.org" "Inbox")
         "%(call-interactively #'org-cliplink-capture)")))

;;------ Directories
(after! org (setq org-directory "~/.org/"
                  org-image-actual-width nil
                  +org-export-directory "~/.export/"
                  org-archive-location "archive.org::datetree/"
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
                  org-export-with-section-numbers t
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
      '((sequence "TODO(t!)" "INPROGRESS(i!)" "|" "DONE(d!)")))

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
                     :base-directory "~/.org/gtd/"
                     :recursive t
                     :base-extension "jpg\\|jpeg\\|png\\|pdf\\|css"
                     :publishing-directory "~/publish_html"
                     :publishing-function org-publish-attachment)
                    ("notes"
                     :base-directory "~/.org/gtd/"
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
                     :html-head "<link rel=\"stylesheet\" href=\"https://codepen.io/nmartin84/pen/RwPzMPe.css\" type=\"text/css\"/>"
                     :html-head-extra "<style type=text/css>body{ max-width:80%;  }</style>"
                     :html-link-up "../"
                     :with-email t
                     :html-link-up "../../index.html"
                     :auto-preamble t
                     :with-toc t)
                    ("work"
                     :base-directory "~/.org/work/"
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
                     :html-head "<link rel=\"stylesheet\" href=\"https://codepen.io/nmartin84/pen/RwPzMPe.css\" type=\"text/css\"/>"
                     :html-head-extra "<style type=text/css>body{ max-width:80%;  }</style>"
                     :html-link-up "../"
                     :with-email t
                     :html-link-up "../../index.html"
                     :auto-preamble t
                     :with-toc t)
                    ("slides"
                     :base-directory "~/.org/slides/"
                     :publishing-directory "/ssh:nick@192.168.1.213:~/publish_html/slides/"
                     :publishing-function org-reveal-publish-to-reveal)
                    ("myprojectweb" :components("attachments" "notes" "slides" "work")))))

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
