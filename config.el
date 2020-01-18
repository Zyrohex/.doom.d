(setq doom-font (font-spec :family "InputMono" :size 18)
      doom-variable-pitch-font (font-spec :family "InputMono")
      doom-unicode-font (font-spec :family "DejaVu Sans")
      doom-big-font (font-spec :family "InputMono" :size 20))

(setq display-line-numbers-type t)

(map!
 :nvime "<f5> d" #'helm-org-rifle-directories
 :nvime "<f5> b" #'helm-org-rifle-current-buffer
 :nvime "<f5> o" #'helm-org-rifle-org-directory
 :nvime "<f5> a" #'helm-org-rifle-agenda-files)

(map! :leader
      :n "e" #'ace-window
      :n "!" #'swiper
      :n "@" #'swiper-all
      :n "#" #'deadgrep
      :n "$" #'helm-org-rifle-directories
      :n "X" #'org-capture
      (:prefix "o"
        :n "e" #'elfeed
        :n "g" #'metrics-tracker-graph
        :n "o" #'org-open-at-point
        :n "u" #'elfeed-update
        :n "w" #'deft)
      (:prefix "f"
        :n "o" #'plain-org-wiki-helm)
      (:prefix "m"
        (:prefix "r"
          :n "." #'+org/refile-to-current-file
          :n "O" #'+org/refile-to-other-buffer
          :n "c" #'+org/refile-to-running-clock
          :n "l" #'+org/refile-to-last-location
          :n "o" #'+org/refile-to-other-window
          :n "v" #'+org/refile-to-visible
          :n "r" #'org-refile
          :n "x" #'zyrohex/org-reference-refile
          :n "z" #'zyrohex/org-tasks-refile))
      (:prefix "n"
        :n "D" #'dictionary-lookup-definition
        :n "T" #'powerthesaurus-lookup-word)
      (:prefix "s"
        :n "d" #'deadgrep
        :n "q" #'org-ql-search
        :n "b" #'helm-org-rifle-current-buffer
        :n "o" #'helm-org-rifle-org-directory
        :n "." #'helm-org-rifle-directories)
      (:prefix "b"
        :n "c" #'org-board-new
        :n "e" #'org-board-open)
      (:prefix "t"
        :n "s" #'org-narrow-to-subtree
        :n "w" #'widen)
      (:prefix "/"
        :n "j" #'org-journal-search))

(setq-default fill-column 140)
(setq diary-file "~/.org/gtd/diary.org")
(global-auto-revert-mode t)

(setq doom-theme 'doom-solarized-light)

(setq org-agenda-files '("~/.org/gtd/" "~/.org/notes/")
      org-agenda-diary-file "~/.org/diary.org"
      org-agenda-use-time-grid nil
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-habit-show-habits t)

(after! org (setq org-capture-templates
      '(("g" "Getting things done")
        ("d" "Diary")
        ("p" "Graph Data")
        ("t" "Data Tracker"))))

(after! org (add-to-list 'org-capture-templates
             '("gx" "Recurring Task" entry (file "~/.org/gtd/recurring.org")
               "* TODO %^{description}
:PROPERTIES:
:CREATED:    %U
:END:
:RESOURCES:
%^{url}
:END:

\** notes
%?")))

(after! org (add-to-list 'org-capture-templates
             '("gp" "Project" entry (file+headline"~/.org/gtd/tasks.org" "Projects")
"* TODO %^{Description}
:PROPERTIES:
:SUBJECT: %^{subject}
:GOAL:    %^{goal}
:END:
:RESOURCES:
[[%^{url}]]
:END:

\*requirements*:
%^{requirements}

\*notes*:
%?

\** TODO %^{task1}")))

(after! org (add-to-list 'org-capture-templates
             '("gt" "Task" entry (file"~/.org/gtd/inbox.org")
"** TODO %^{description}
:PROPERTIES:
:CREATED:    %U
:END:
:RESOURCES:
[[%^{url}]]
:END:

\*next steps*:
- [ ] %^{next steps}

\*notes*:
%?")))

(after! org (add-to-list 'org-capture-templates
             '("n" "Note" entry(file"~/.org/gtd/notes.org")
"* [%<%a %m-%d %H:%M>] %^{note}
%?")))

(setq org-directory "~/.org/"
      org-image-actual-width nil
      +org-export-directory "~/.export/"
      org-archive-location "~/.org/gtd/archive.org::datetree/"
      org-default-notes-file "~/.org/gtd/inbox.org"
      projectile-project-search-path '("~/"))

(setq org-html-head-include-scripts t
      org-export-with-toc t
      org-export-with-author t
      org-export-headline-levels 5
      org-export-with-drawers t
      org-export-with-email t
      org-export-with-footnotes t
      org-export-with-latex t
      org-export-with-section-numbers nil
      org-export-with-properties t
      org-export-with-smart-quotes t)

;(after! org (add-to-list 'org-export-backends 'pandoc))
(after! org (add-to-list 'org-export-backends 'pdf))

(after! org (setq org-todo-keyword-faces
      '(("TODO" :foreground "tomato" :weight bold)
        ("WAITING" :foreground "light sea green" :weight bold)
        ("STARTED" :foreground "Turquoise" :weight bold)
        ("NEXT" :foreground "violet red" :weight bold)
        ("DONE" :foreground "slategrey" :weight bold))))

(after! org (setq org-todo-keywords
      '((sequence "TODO(t)" "WAITING(w!)" "STARTED(s!)" "NEXT(n!)" "|" "INVALID(I!)" "DONE(d!)"))))

(setq org-link-abbrev-alist
      '(("doom-repo" . "https://github.com/hlissner/doom-emacs/%s")
        ("wolfram" . "https://wolframalpha.com/input/?i=%s")
        ("duckduckgo" . "https://duckduckgo.com/?q=%s")
        ("gmap" . "https://maps.google.com/maps?q=%s")
        ("gimages" . "https://google.com/images?q=%s")
        ("google" . "https://google.com/search?q=")
        ("youtube" . "https://youtube.com/watch?v=%s")
        ("youtu" . "https://youtube.com/results?search_query=%s")
        ("github" . "https://github.com/%s")
        ("attachments" . "~/.org/.attachments/")))

(setq org-log-state-notes-insert-after-drawers nil
      org-log-into-drawer t
      org-log-done 'note
      org-log-repeat 'time
      org-log-redeadline 'time
      org-log-reschedule 'time)

(setq org-bullets-bullet-list '("✖" "✚")
      org-ellipsis "▼")

(setq org-publish-project-alist
      '(("references-attachments"
         :base-directory "~/.org/notes/images/"
         :base-extension "jpg\\|jpeg\\|png\\|pdf\\|css"
         :publishing-directory "~/publish_html/references/images"
         :publishing-function org-publish-attachment)
        ("references-md"
         :base-directory "~/.org/notes/"
         :publishing-directory "~/publish_md"
         :base-extension "org"
         :recursive t
         :headline-levels 5
         :publishing-function org-html-publish-to-html
         :section-numbers nil
         :html-head "<link rel=\"stylesheet\" href=\"http://thomasf.github.io/solarized-css/solarized-light.min.css\" type=\"text/css\"/>"
         :infojs-opt "view:t toc:t ltoc:t mouse:underline buttons:0 path:http://thomas.github.io/solarized-css/org-info.min.js"
         :with-email t
         :with-toc t)
        ("tasks"
         :base-directory "~/.org/gtd/"
         :publishing-directory "~/publish_tasks"
         :base-extension "org"
         :recursive t
         :auto-sitemap t
         :sitemap-filename "index"
         :html-link-home "../index.html"
         :publishing-function org-html-publish-to-html
         :section-numbers nil
;         :html-head "<link rel=\"stylesheet\"
;href=\"https://codepen.io/nmartin84/pen/MWWdwbm.css\"
;type=\"text/css\"/>"
         :with-email t
         :html-link-up ".."
         :auto-preamble t
         :with-toc t)
        ("pdf"
         :base-directory "~/.org/gtd/references/"
         :base-extension "org"
         :publishing-directory "~/publish"
         :preparation-function somepreparationfunction
         :completion-function  somecompletionfunction
         :publishing-function org-latex-publish-to-pdf
         :recursive t
         :latex-class "koma-article"
         :headline-levels 5
         :with-toc t)
         ("myprojectweb" :components("references-attachments" "pdf" "references-md" "tasks"))))

(setq org-log-state-notes-insert-after-drawers nil
      org-log-into-drawer t
      org-log-done 'note
      org-log-repeat 'time
      org-log-redeadline 'time
      org-log-reschedule 'time)

(setq org-tags-column -80
      org-tag-persistent-alist '(("@email" . ?e) ("@write" . ?W) ("@phone" . ?p) ("@configure" . ?C) ("@work" . ?w) ("@personal" . ?l) ("@read" . ?r) ("@watch" . ?W) ("@computer" . ?c) ("@bills" . ?b) ("@purchase" . ?P)))

(use-package ob-plantuml
  :ensure nil
  :commands
  (org-babel-execute:plantuml)
  :config
  (setq org-plantuml-jar-path (expand-file-name "~/.tools/plantuml.jar")))

(use-package org-mind-map
  :init
  (require 'ox-org)
  ;; Uncomment the below if 'ensure-system-packages` is installed
  ;;:ensure-system-package (gvgen . graphviz)
  :config
  (setq org-mind-map-engine "dot")       ; Default. Directed Graph
  ;; (setq org-mind-map-engine "neato")  ; Undirected Spring Graph
  ;; (setq org-mind-map-engine "twopi")  ; Radial Layout
  ;; (setq org-mind-map-engine "fdp")    ; Undirected Spring Force-Directed
  ;; (setq org-mind-map-engine "sfdp")   ; Multiscale version of fdp for the layout of large graphs
  ;; (setq org-mind-map-engine "twopi")  ; Radial layouts
  ;; (setq org-mind-map-engine "circo")  ; Circular Layout
  )

(use-package gnuplot
  :config
  (setq gnuplot-program "gnuplot"))

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

(use-package deft
  :bind (("<f8>" . deft))
  :commands (deft deft-open-file deft-new-file-named)
  :config
  (setq deft-directory "~/.org/"
        deft-auto-save-interval 0
        deft-use-filename-as-title nil
        deft-current-sort-method 'title
        deft-recursive t
        deft-extensions '("md" "txt" "org")
        deft-markdown-mode-title-level 1
        deft-file-naming-rules '((noslash . "-")
                                 (nospace . "-")
                                 (case-fn . downcase))))
(require 'my-deft-title)
(advice-add 'deft-parse-title :around #'my-deft/parse-title-with-directory-prepended)

(use-package elfeed
  :config
  (setq elfeed-db-directory "~/.elfeed/"))

(use-package elfeed-org
  :config
  (setq rhm-elfeed-org-files (list "~/.elfeed/elfeed.org")))

(require 'elfeed)
(require 'elfeed-org)
(elfeed-org)
(after! org (setq rmh-elfeed-org-files (list "~/.elfeed/elfeed.org")
                  elfeed-db-directory "~/.elfeed/"))

(defun org-clock-switch ()
  "Switch task and go-to that task"
  (interactive)
  (setq current-prefix-arg '(12)) ; C-u
  (call-interactively 'org-clock-goto)
  (org-clock-in)
  (org-clock-goto))
(provide 'org-clock-switch)

(defun org-update-cookies-after-save()
  (interactive)
  (let ((current-prefix-arg '(4)))
    (org-update-statistics-cookies "ALL")))

(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'org-update-cookies-after-save nil 'make-it-local)))
(provide 'org-update-cookies-after-save)

(defun zyrohex/org-tasks-refile ()
  "Process a single TODO task item."
  (interactive)
  (call-interactively 'org-agenda-schedule)
  (org-agenda-set-tags)
  (org-agenda-priority)
  (let ((org-refile-targets '((helm-read-file-name :maxlevel .6)))
        (call-interactively #'org-refile))))
(provide 'zyrohex/org-tasks-refile)

(defun zyrohex/org-reference-refile (arg)
  "Process an item to the reference bucket"
  (interactive "P")
  (let ((org-refile-targets '(("~/.gtd/references.org" :maxlevel . 6))))
    (call-interactively #'org-refile)))
(provide 'zyrohex/org-reference-refile)

(defun zyrohex/org-notes-refile ()
  "Process an item to the references bucket"
  (interactive)
  (let ((org-refile-targets '(("~/.gtd/references.org" :maxlevel . 6)))
        (org-refile-allow-creating-parent-nodes 'confirm))
    (call-interactively #'org-refile)))
(provide 'zyrohex/org-notes-refile)

(defun my--browse-url (url &optional _new-window)
  ;; new-window ignored
  "Opens link via powershell.exe"
  (interactive (browse-url-interactive-arg "URL: "))
  (let ((quotedUrl (format "start '%s'" url)))
    (apply 'call-process "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe" nil
           0 nil
           (list "-Command" quotedUrl))))

(setq-default browse-url-browser-function 'my--browse-url)

(org-super-agenda-mode t)
(after! org-agenda (setq org-agenda-custom-commands
                         '(("t" "Tasks"
                            ((agenda ""
                                     ((org-agenda-files '("~/.org/gtd/tasks.org" "~/.org/gtd/tickler.org" "~/.org/gtd/projects.org"))
                                      (org-agenda-overriding-header "What's on my calendar")
                                      (org-agenda-span 'day)
                                      (org-agenda-start-day (org-today))
                                      (org-agenda-current-span 'day)
                                      (org-super-agenda-groups
                                       '((:name "[[~/.org/gtd/habits.org][Habits]]"
                                                :habit t
                                                :order 1)
                                         (:name "[[~/.org/gtd/recurring.org][Bills]]"
                                                :tag "@bills"
                                                :order 4)
                                         (:name "Today's Schedule"
                                                :time-grid t
                                                :scheduled t
                                                :deadline t
                                                :order 13)))))
                             (todo "TODO|NEXT|DELEGATED|REVIEW|WAITING|IN-PROGRESS"
                                   ((org-agenda-overriding-header "[[~/.org/gtd/tasks.org][Task list]]")
                                    (org-agenda-files '("~/.org/gtd/tasks.org"))
                                    (org-super-agenda-groups
                                     '((:name "CRITICAL"
                                              :priority "A"
                                              :order 1)
                                       (:name "NEXT UP"
                                              :todo "NEXT"
                                              :order 2)
                                       (:name "Emacs Reading"
                                              :and (:category "Emacs" :tag "@read")
                                              :order 3)
                                       (:name "Emacs Config"
                                              :and (:category "Emacs" :tag "@configure")
                                              :order 4)
                                       (:name "Emacs Misc"
                                              :category "Emacs"
                                              :order 5)
                                       (:name "Task Reading"
                                              :and (:category "Tasks" :tag "@read")
                                              :order 6)
                                       (:name "Task Other"
                                              :category "Tasks"
                                              :order 7)
                                       (:name "Projects"
                                              :category "Projects"
                                              :order 8)))))
                             (agenda ""
                                     ((org-agenda-overriding-header "Habits")
                                      (org-agenda-files '("~/.org/gtd/habits.org"))
                                      (org-agenda-span 'day)
                                      (org-agenda-start-day (org-today))))))
                           ("i" "Inbox"
                            ((todo ""
                                   ((org-agenda-files '("~/.org/gtd/inbox.org"))
                                    (org-agenda-overriding-header "Items in my inbox")
                                    (org-super-agenda-groups
                                     '((:auto-ts t)))))))
                           ("x" "Get to someday"
                            ((tags-todo "-@computer-@email-@configure-@read-@watch-@personal"
                                        ((org-agenda-overriding-header "Projects marked Someday")
                                         (org-agenda-files '("~/.org/gtd/someday.org"))
                                         (org-super-agenda-groups
                                          '((:auto-ts t))))))))))
