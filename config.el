;; This is the default config file that loads some generic settings. Additional modules will get loaded under ./config or ./modules
;; Extra Configs
;; You can comment out whichever line you do not wish to use

;(load! "config/+bindings2")
(load! "config/+extra")
(load! "config/+capture")
(load! "config/+todo")
(load! "keys/+general")


;; General Settings

;(menu-bar-mode 1)
(setq doom-font (font-spec :family "Source Code Pro" :size 20))
(display-time-mode 1) ;; Display time and System Load on modeline
(global-auto-revert-mode t) ;; Auto revert files when file changes detected on disk
(add-to-list 'org-modules 'org-habit t)

;; Agenda Custom Command


(setq org-agenda-custom-commands
      '(("u" "Start of day review"
         ((agenda ""
                  ((org-agenda-start-day (org-today)))
                  ((org-super-agenda-groups
                    '((:name "Today"
                             :time-grid t)
                      (:name "Overdue"
                             :scheduled past
                             :deadline past)
                      (:name "Future"
                             :scheduled future
                             :deadline future)
                      (:discard (:anything t))))))))
        ("r" "Review"
         ((todo ""
                ((org-agenda-overriding-header "Inbox Review")
                 (org-super-agenda-groups
                  '((:name none
                           :category "Refile")
                    (:name "Someday"
                           :category "Someday")
                    (:discard (:anything t))))))))))


;; Defaults

(setq org-directory (expand-file-name "~/Google Drive/org/")
      org-archive-location "~/Google Drive/org/gtd/archive.org::datetree/"
      org-default-notes-file "~/Google Drive/org/gtd/agenda/inbox.org"
      projectile-project-search-path '("~/Google Drive/org/"))


;; Task Switcher

(add-to-list 'load-path  "~/.doom.d/local/org-switch")
(require 'orgclockswitch)


;; Brain

(map! :n "SPC o v" #'org-brain-visualize)

(use-package org-brain
  :init
  (setq org-brain-path "~/Google Drive/org/gtd/brain")
  ;; For Evil users
  (with-eval-after-load 'evil
    (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
  :config
  (setq org-id-track-globally t)
  (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
  (setq org-brain-visualize-default-choices 'all)
  (setq org-brain-title-max-length 12))

;; Capture Templates

(map! :n "SPC n x" #'helm-org-capture-templates)


;; Elfeed

(map! :n "SPC o e" #'elfeed
      :n "SPC o u" #'elfeed-update)

(require 'elfeed)
(require 'elfeed-org)
(elfeed-org)
(setq rmh-elfeed-org-files (list "~/Google Drive/org/gtd/elfeed.org"))
(setq elfeed-db-directory "~/Google Drive/org/elfeed/")


;; Link Abbreviations

(setq org-link-abbrev-alist
      '(("gg" . "http://www.google.com/search?q=")
        ("gmap" . "http://maps.google.com/maps?q=%s")
        ("wikibooks" . "https://en.wikibooks.org/w/index.php?sort=relevance&search=%s")
        ("github" . "https://github.com/search?q=%s")
        ("youtube" . "https://www.youtube.com/results?search_query=%s")))


;; Pretty symbols



;; Deft

(map! :n "SPC o n" #'deft
      :n "SPC o N" #'deft-new-file-named)

(setq deft-extension
      '("org" "md" "txt")
      deft-recursive t
      deft-text-mode 'org-mode
      deft-directory "~/Google Drive/org/gtd/notes/"
      deft-use-filename-as-title t
      deft-auto-save-interval 0)


;; Refile

(setq org-refile-targets '((org-agenda-files . (:maxlevel . 6)))
      org-outline-path-complete-in-steps nil
      org-refile-allow-creating-parent-nodes 'confirm)


;; Tags

(setq org-tags-column -80
      org-tag-alist '(("@email" . ?e) ("@phone" . ?p) ("@work" . ?w) ("@personal" . ?l)))


;; Org-Ref

(setq org-ref-default-bibliography '("~/Google Drive/org/ref/master.bib")
      org-ref-bibliography-notes "~/Google Drive/org/ref/notes.org"
      org-ref-pdf-directory "~/Google Drive/org/ref/pdfs/")


;; Logging

(setq org-log-state-notes-insert-after-drawers nil
      org-log-done 'time
      org-log-repeat 'time
      org-log-refile 'time
      org-log-redeadline 'time
      org-log-reschedule 'time)


;; Agenda + Super Agenda

(setq org-super-agenda-groups
        '((:auto-category t)))

(setq org-agenda-files (list "~/Google Drive/org/gtd/agenda/")
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t)


;; Popup Rules

(set-popup-rule! "^\\*Org Agenda" :side 'right :size 80 :select t :ttl nil)
(set-popup-rule! "^CAPTURE.*\\.org$" :side 'bottom :size 0.70 :select t :ttl nil)
(set-popup-rule! "^\\*org-brain" :side 'bottom :size 0.30 :select t :ttl nil)
(set-popup-rule! "^\\*Deft*" :side 'right :size 1.00 :select t :ttl nil)
(set-popup-rule! "^\\*Deadgrep*" :side 'right :size 1.00 :select t :ttl nil)
(set-popup-rule! "^\\*Info*" :side 'right :size 1.00 :select t :ttl nil)
(set-popup-rule! "^\\*Helm*" :side 'bottom :size 0.30 :select t :ttl nil)
(set-popup-rule! "^\\*Docker*" :side 'bottom :size 0.30 :select t :ttl nil)
(set-popup-rule! "^\\*Calc*" :side 'bottom :size 0.20 :select t :ttl nil)


;; Exporters

(add-to-list 'org-export-backends 'latex)
(add-to-list 'org-export-backends 'odt)
(custom-set-variables
 '(markdown-command "pandoc"))
