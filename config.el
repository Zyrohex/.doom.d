(global-set-key (kbd "C-c C-x i") #'org-mru-clock-in)
(global-set-key (kbd "C-c C-x C-j") #'org-mru-clock-select-recent-task)
(bind-key "C-<down>" #'+org/insert-item-below)
(map!
 :nvime "<f5> d" #'helm-org-rifle-directories
 :nvime "<f5> b" #'helm-org-rifle-current-buffer
 :nvime "<f5> o" #'helm-org-rifle-org-directory
 :nvime "<f5> a" #'helm-org-rifle-agenda-files)

(map! :leader
      :n "e" #'ace-window
      :desc "Search buffer" :n "!" #'swiper
      :desc "Search all" :n "@" #'swiper-all
      :desc "Deadgrep search" :n "#" #'deadgrep
      :desc "Rifle directories" :n "$" #'helm-org-rifle-directories
      :desc "Capture" :n "X" #'org-capture
      (:prefix "o"
        :desc "Open Elfeed" :n "e" #'elfeed
        :n "g" #'metrics-tracker-graph
        :n "o" #'org-open-at-point
        :n "u" #'elfeed-update
        :n "w" #'deft)
      (:prefix "f"
        :n "o" #'plain-org-wiki-helm)
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

(global-auto-revert-mode t)

(after! org (set-popup-rule! "^Capture.*\\.org$" :side 'right :size .50 :select t :vslot 2 :ttl 3))
(after! org (set-popup-rule! "Dictionary" :side 'bottom :size .30 :select t :vslot 3 :ttl 3))
(after! org (set-popup-rule! "*helm*" :side 'bottom :size .30 :select t :vslot 5 :ttl 3))
(after! org (set-popup-rule! "*eww*" :side 'right :size .30 :slect t :vslot 5 :ttl 3))
(after! org (set-popup-rule! "*deadgrep" :side 'bottom :height .40 :select t :vslot 4 :ttl 3))
(after! org (set-popup-rule! "*org-roam" :side 'right :size .40 :select t :vslot 4 :ttl 3))
(after! org (set-popup-rule! "\\Swiper" :side 'bottom :size .30 :select t :vslot 4 :ttl 3))
(after! org (set-popup-rule! "*Ledger Report*" :side 'right :size .30 :select t :vslot 4 :ttl 3))
(after! org (set-popup-rule! "*xwidget" :side 'right :size .50 :select t :vslot 5 :ttl 3))
;(after! org (set-popup-rule! "*org agenda*" :side 'right :size .50 :select t :vslot 2 :ttl 3))
(after! org (set-popup-rule! "*Org ql" :side 'right :size .50 :select t :vslot 2 :ttl 3))

(setq user-full-name "Nicholas Martin"
      user-mail-address "nmartin84.com")

(setq doom-font (font-spec :family "InputMono" :size 18)
      doom-variable-pitch-font (font-spec :family "InputMono" :height 120)
      doom-unicode-font (font-spec :family "InputMono")
      doom-big-font (font-spec :family "InputMono" :size 20))
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(setq doom-modeline-gnus t
      doom-modeline-gnus-timer 'nil)

(setq doom-theme 'doom-city-lights)
(if (equal doom-theme 'doom-snazzy)
    (custom-theme-set-faces
     'user
     '(org-block ((t (:background "#20222b"))))
     '(org-block-begin-line ((t (:background "#282A36"))))))
(if (equal doom-theme 'doom-city-lights)
    (setq org-emphasis-alist
          '(("*" (bold :foreground "MediumPurple"))
            ("/" (italic :foreground "VioletRed"))
            ("_" underline)
            ("=" (:foreground "PaleTurquoise"))
            ("~" (:foreground "PaleTurquoise"))
            ("+" (:strike-through t))))
    (custom-theme-set-faces
     'user))

(after! org (setq org-agenda-use-time-grid nil
                  org-agenda-skip-scheduled-if-done t
                  org-agenda-skip-deadline-if-done t
                  org-habit-show-habits t))
(after! org (setq org-super-agenda-groups
                  '((:auto-category t))))

(load-library "find-lisp")
(after! org (setq org-agenda-files
(find-lisp-find-files "~/.org/" "\.org$")))

(defun my/generate-org-diary-name ()
  (setq my-org-note--name (read-string "Name: "))
  (setq my-org-note--time (format-time-string "%Y-%m-%d"))
  (expand-file-name (format "%s %s.org" my-org-note--time my-org-note--name) "~/.org/diary/"))

(after! org (setq org-capture-templates
                  '(("d" "Diary" plain (file my/generate-org-diary-name)
                     "%(format \"#+TITLE: %s\n\" my-org-note--name my-org-note--time)
%u %?")
                    ("l" "Ledger"))))

(defun my/generate-org-task-name ()
  (setq my-org-note--name (read-string "Name: "))
  (setq my-org-note--time (format-time-string "%Y-%m-%d"))
  (expand-file-name (format "%s %s.org" my-org-note--time my-org-note--name) "~/.org/tasks/"))

(after! org (add-to-list 'org-capture-templates
             '("t" "Task File" plain (file my/generate-org-task-name)
               "%(format \"#+TITLE: %s\n\" my-org-note--name)
\* INBOX %(format my-org-note--name) %?
:PROPERTIES:
:CREATED: %U
:END:
")))

(after! org (add-to-list 'org-capture-templates
             '("c" "Child Task" entry (file+function buffer-name org-back-to-heading-or-point-min)
"* %^{keyword|TODO|INBOX} %u %^{task}
%?" :empty-lines 1)))

(setq my/org-note-categories '(("Topic: ") ("Account: ") ("Symptom: ")))
(defun my/generate-org-note-categories ()
  "Select a category for Notes"
  (interactive (list (completing-read "Select a category: " my/org-note-categories))))
(defun my/generate-org-note-name ()
  (setq my-org-note--category (read-string "Category: "))
  (setq my-org-note--name (read-string "Name: "))
  (expand-file-name (format "%s.org" my-org-note--name) "~/.org/notes/"))

(after! org (add-to-list 'org-capture-templates
                         '("n" "Note" plain (file my/generate-org-note-name)
                           "%(format \"#+TITLE: %s: %s\n\" my-org-note--category my-org-note--name)
%?")))

(after! org (add-to-list 'org-capture-templates
             '("x" "Capture [WORKLOAD]" entry (file "~/.org/workload/inbox.org")
"* INBOX %^{taskname}%?
:PROPERTIES:
:CREATED:    %U
:END:
" :immediate-finish t)))

(after! org (add-to-list 'org-capture-templates
             '("w" "Workout Log" entry(file+olp+datetree"~/.org/journal/workout.org")
               "** %\\1 (%\\2 calories) :: %\\3 (reps)
:PROPERTIES:
:ACTIVITY: %^{ACTIVITY}
:CALORIES: %^{CALORIES}
:REPS:     %^{REPS}
:COMMENT:  %^{COMMENT}
")))

(after! org (add-to-list 'org-capture-templates
             '("F" "Food Log" entry(file+olp+datetree"~/.org/journal/food.org")
"** %\\1 [%\\2]
:PROPERTIES:
:FOOD:     %^{FOOD}
:CALORIES: %^{CALORIES}
:COMMENT:  %^{COMMENT}
:END:")))

(after! org (add-to-list 'org-capture-templates
             '("W" "Weigh In" entry(file+olp+datetree"~/.org/journal/food.org")
"** %\\1 [%\\2]
:PROPERTIES:
:WEIGHT: %^{WEIGHT}
:COMMENT:  %^{COMMENT}
:END:")))

(after! org (add-to-list 'org-capture-templates
             '("le" "Ledger Expense" plain(file"~/.org/journal/finance.dat")
               "%<%Y/%m/%d> * %^{Creditor}
    Expenses:%^{category|Snacks|Eating Out|Drinks|Movies|Games|Clothes|Shopping|Electronics}   %^{Dollar ammount}
    Assets:%^{account|Checking|CreditCard}" :empty-lines 1)))

(after! org (add-to-list 'org-capture-templates
             '("ld" "Ledger Expense Date" plain(file"~/.org/journal/finance.dat")
               "2020/%^{month}/%^{date} * %^{Creditor}
    Expenses:%^{category}   %^{Dollar ammount}
    Income:%^{account}" :empty-lines 1)))

(after! org (add-to-list 'org-capture-templates
             '("li" "Ledger Income" plain(file"~/.org/journal/finance.dat")
               "%<%Y/%m/%d> * %^{Payee}
    Income:%^{account}   %^{Dollar ammount}
    Payee:%^{who}" :empty-lines 1)))

(after! org (setq org-directory "~/.org/"
                  org-image-actual-width nil
                  +org-export-directory "~/.export/"
                  org-archive-location "~/.org/gtd/archive.org::datetree/"
                  org-default-notes-file "~/.org/gtd/inbox.org"
                  projectile-project-search-path '("~/.org/")))

(after! org (setq org-html-head-include-scripts t
                  org-export-with-toc t
                  org-export-with-author t
                  org-export-headline-levels 5
                  org-export-with-drawers t
                  org-export-with-email t
                  org-export-with-footnotes t
                  org-export-with-latex t
                  org-export-with-section-numbers nil
                  org-export-with-properties t
                  org-export-with-smart-quotes t
                  org-export-backends '(pdf ascii html md latex odt pandoc)))

(after! org (setq org-todo-keyword-faces
      '(("TODO" :foreground "tomato" :weight bold)
        ("WAITING" :foreground "light sea green" :weight bold)
        ("STARTED" :foreground "DodgerBlue" :weight bold)
        ("SOMEDAY" :foreground "sky blue" :weight bold)
        ("INBOX" :foreground "spring green" :weight bold)
        ("DELEGATED" :foreground "Gold" :weight bold)
        ("NEXT" :foreground "violet red" :weight bold)
        ("DONE" :foreground "slategrey" :weight bold))))

(after! org (setq org-todo-keywords
      '((sequence "TODO(t!)" "ACTIVE(a!)" "HOLDING(h!)" "NEXT(n!)" "DELEGATED(e!)" "INBOX(i!)" "SOMEDAY(s!)" "|" "INVALID(I!)" "DONE(d!)"))))

(use-package ledger-mode
  :mode ("\\.dat\\'"
         "\\.ledger\\'")
  :custom (ledger-clear-whole-transactions t))

(use-package flycheck-ledger :after ledger-mode)

(after! org (setq org-link-abbrev-alist
                  '(("doom-repo" . "https://github.com/hlissner/doom-emacs/%s")
                    ("wolfram" . "https://wolframalpha.com/input/?i=%s")
                    ("duckduckgo" . "https://duckduckgo.com/?q=%s")
                    ("gmap" . "https://maps.google.com/maps?q=%s")
                    ("gimages" . "https://google.com/images?q=%s")
                    ("google" . "https://google.com/search?q=")
                    ("youtube" . "https://youtube.com/watch?v=%s")
                    ("youtu" . "https://youtube.com/results?search_query=%s")
                    ("github" . "https://github.com/%s")
                    ("attachments" . "~/.org/.attachments/"))))

(after! org (setq org-log-state-notes-insert-after-drawers nil
                  org-log-into-drawer t
                  org-log-done 'time
                  org-log-repeat 'time
                  org-log-redeadline 'note
                  org-log-reschedule 'note))

(after! org (setq org-bullets-bullet-list '("◉" "○")
                  org-hide-emphasis-markers nil
                  org-list-demote-modify-bullet '(("+" . "-") ("1." . "a.") ("-" . "+"))
                  org-ellipsis "▼"))

(after! org (setq org-publish-project-alist
                  '(("references-attachments"
                     :base-directory "~/.org/attachments/"
                     :base-extension "jpg\\|jpeg\\|png\\|pdf\\|css"
                     :publishing-directory "~/publish_html/attachments"
                     :publishing-function org-publish-attachment)
                    ("references-md"
                     :base-directory "~/.org/brain/"
                     :publishing-directory "~/publish"
                     :base-extension "org"
                     :auto-sitemap t
                     :sitemap-filename "index.html"
                     :recursive t
                     :headline-levels 5
                     :publishing-function org-html-publish-to-html
                     :section-numbers nil
                     :html-head "<link rel=\"stylesheet\" href=\"http://thomasf.github.io/solarized-css/solarized-light.min.css\" type=\"text/css\"/>"
                     :infojs-opt "view:t toc:t ltoc:t mouse:underline buttons:0 path:http://thomas.github.io/solarized-css/org-info.min.js"
                     :with-email t
                     :with-toc t)
                    ("myprojectweb" :components("references-attachments" "references-md")))))

(after! org (setq org-refile-targets '((org-agenda-files . (:maxlevel . 3)))
                  org-outline-path-complete-in-steps nil
                  org-refile-allow-creating-parent-nodes 'confirm))

(after! org (setq org-startup-indented t
                  org-src-tab-acts-natively t))
(add-hook 'org-mode-hook (lambda () (org-autolist-mode)))
;(add-hook 'org-mode-hook 'org-num-mode)

(after! org (setq org-tags-column -80))
(after! org (setq org-tag-alist '((:startgrouptag)
                                  ("GTD")
                                  (:grouptags)
                                  ("Control" . ?c)
                                  ("Persp")
                                  (:endgrouptag)
                                  (:startgrouptag)
                                  ("Control")
                                  (:grouptags)
                                  ("Context")
                                  ("Task")
                                  (:endgrouptag))))

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
  (setq deft-directory "~/.org/notes/"
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

;(use-package gnuplot
;  :config
;  (setq gnuplot-program "gnuplot"))

;(after! org (setq org-agenda-property-list '("WHO" "NEXTACT")
;                  org-agenda-property-position 'where-it-fits))

(setq org-mru-clock-how-many 10)
(setq org-mru-clock-completing-read #'ivy-completing-read)
(setq org-mru-clock-keep-formatting t)
(setq org-mru-clock-files #'org-agenda-files)

;(defun org-clock-switch ()
;  "Switch task and go-to that task"
;  (interactive)
;  (setq current-prefix-arg '(12)) ; C-u
;  (call-interactively 'org-clock-goto)
;  (org-clock-in)
;  (org-clock-goto))
;(provide 'org-clock-switch)

;(use-package org-mind-map
;  :init
;  (require 'ox-org)
;  ;; Uncomment the below if 'ensure-system-packages` is installed
;  ;;:ensure-system-package (gvgen . graphviz)
;  :config
;  (setq org-mind-map-engine "dot")       ; Default. Directed Graph
;  ;; (setq org-mind-map-engine "neato")  ; Undirected Spring Graph
;  ;; (setq org-mind-map-engine "twopi")  ; Radial Layout
;  ;; (setq org-mind-map-engine "fdp")    ; Undirected Spring Force-Directed
;  ;; (setq org-mind-map-engine "sfdp")   ; Multiscale version of fdp for the layout of large graphs
;  ;; (setq org-mind-map-engine "twopi")  ; Radial layouts
;  ;; (setq org-mind-map-engine "circo")  ; Circular Layout
;  )

;(require 'org)

;(org-add-link-type "outlook" 'org-outlook-open)

;(defun org-outlook-open (id)
;   "Open the Outlook item identified by ID.  ID should be an Outlook GUID."
;   (w32-shell-execute "open" (concat "outlook:" id)))

;(provide 'org-outlook)
;(require 'org-outlook)

(use-package ob-plantuml
  :ensure nil
  :commands
  (org-babel-execute:plantuml)
  :config
  (setq org-plantuml-jar-path (expand-file-name "~/.tools/plantuml.jar")))

(setq-default truncate-lines t)

(defun jethro/truncate-lines-hook ()
  (setq truncate-lines nil))

(add-hook 'text-mode-hook 'jethro/truncate-lines-hook)

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
                         '(("k" "Tasks"
                            ((agenda "TODO|ACTIVE|HOLDING|NEXT"
                                     ((org-agenda-files '("~/.org/gtd/tasks.org"))
                                      (org-agenda-overriding-header "What's on my calendar")
                                      (org-agenda-span 'day)
                                      (org-agenda-start-day (org-today))
                                      (org-agenda-current-span 'day)
                                      (org-time-budgets-for-agenda)
                                      (org-super-agenda-groups
                                       '((:name "Today's Schedule"
                                                :scheduled t
                                                :time-grid t
                                                :deadline t)))))
                             (todo "TODO|ACTIVE|HOLDING|NEXT"
                                   ((org-agenda-overriding-header "[[~/.org/gtd/tasks.org][Task list]]")
                                    (org-agenda-prefix-format " %(my-agenda-prefix) ")
                                    (org-agenda-files '("~/.org/gtd/"))
                                    (org-super-agenda-groups
                                     '((:auto-category t)))))))
                           ("i" "Inbox"
                            ((todo "INBOX|REFILE"
                                   ((org-agenda-files '("~/.org/gtd/"))
                                    (org-agenda-overriding-header "Items in my inbox")
                                    (org-super-agenda-groups
                                     '((:auto-ts t)))))))
                           ("x" "Get to someday"
                            ((todo "SOMEDAY"
                                   ((org-agenda-overriding-header "Projects marked Someday")
                                    (org-agenda-prefix-format " %(my-agenda-prefix) ")
                                    (org-agenda-files '("~/.org/gtd/"))
                                    (org-super-agenda-groups
                                     '((:auto-outline-path t))))))))))

(defvar org-archive-directory "~/.org/archives/")
(defun org-archive-file ()
  "Moves the current buffer to the archived folder"
  (interactive)
  (let ((old (or (buffer-file-name) (user-error "Not visiting a file")))
        (dir (read-directory-name "Move to: " org-archive-directory)))
    (write-file (expand-file-name (file-name-nondirectory old) dir) t)
    (delete-file old)))
(provide 'org-archive-file)

(defun +org/insert-item-below-w-timestamp (count)
  "Inserts a new item below with inactive timestamp asserted."
  (interactive "p")
  (dotimes (_ count) (+org--insert-item 'below) (org-end-of-line) (insert (org-format-time-string "[%Y-%m-%d %a]") " ")))
(map! :n "S-<return>" #'+org/insert-item-below-w-timestamp)

(defun my/last-captured-org-note ()
  "Move to the last line of the last org capture note."
  (interactive)
  (goto-char (point-max)))

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

(defun my/generate-org-note-name ()
  (setq my-org-note--name (read-string "Name: "))
  (expand-file-name (format "%s.org"my-org-note--name) "~/.org/gtd/projects/"))

(defun org-update-cookies-after-save()
  (interactive)
  (let ((current-prefix-arg '(4)))
    (org-update-statistics-cookies "ALL")))

(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'org-update-cookies-after-save nil 'make-it-local)))
(provide 'org-update-cookies-after-save)

(defun zyrohex/org-notes-refile ()
  "Process an item to the references bucket"
  (interactive)
  (let ((org-refile-targets '(("~/.gtd/references.org" :maxlevel . 6)))
        (org-refile-allow-creating-parent-nodes 'confirm))
    (call-interactively #'org-refile)))
(provide 'zyrohex/org-notes-refile)

(defun zyrohex/org-reference-refile (arg)
  "Process an item to the reference bucket"
  (interactive "P")
  (let ((org-refile-targets '(("~/.gtd/references.org" :maxlevel . 6))))
    (call-interactively #'org-refile)))
(provide 'zyrohex/org-reference-refile)

(defun zyrohex/org-tasks-refile ()
  "Process a single TODO task item."
  (interactive)
  (call-interactively 'org-agenda-schedule)
  (org-agenda-set-tags)
  (org-agenda-priority)
  (let ((org-refile-targets '((helm-read-file-name :maxlevel .6)))
        (call-interactively #'org-refile))))
(provide 'zyrohex/org-tasks-refile)
