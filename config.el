(setq display-line-numbers t)

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

(setq-default fill-column 80)
(global-auto-revert-mode t)

(after! org (set-popup-rule! "^Capture.*\\.org$" :side 'right :size .40 :select t :vslot 2 :ttl 3))
(after! org (set-popup-rule! "Dictionary" :side 'bottom :height .40 :width 20 :select t :vslot 3 :ttl 3))
(after! org (set-popup-rule! "*helm*" :side 'bottom :height .40 :select t :vslot 5 :ttl 3))
(after! org (set-popup-rule! "*eww*" :side 'right :size .40 :slect t :vslot 5 :ttl 3))
(after! org (set-popup-rule! "*deadgrep" :side 'bottom :height .40 :select t :vslot 4 :ttl 3))
(after! org (set-popup-rule! "*org-roam" :side 'right :size .40 :select t :vslot 4 :ttl 3))
(after! org (set-popup-rule! "\\Swiper" :side 'bottom :size .30 :select t :vslot 4 :ttl 3))
(after! org (set-popup-rule! "*xwidget" :side 'right :size .40 :select t :vslot 5 :ttl 3))
(after! org (set-popup-rule! "*org agenda*" :side 'right :size .40 :select t :vslot 2 :ttl 3))
(after! org (set-popup-rule! "*Org ql" :side 'right :size .40 :select t :vslot 2 :ttl 3))

(setq user-full-name "Nicholas Martin"
      user-mail-address "nmartin84.com")

(setq doom-font (font-spec :family "InputMono" :size 20)
      doom-variable-pitch-font (font-spec :family "InputMono" :height 120)
      doom-unicode-font (font-spec :family "InputMono")
      doom-big-font (font-spec :family "InputMono" :size 20))
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

(setq doom-modeline-gnus t
      doom-modeline-gnus-timer 'nil)

(setq doom-theme 'doom-gruvbox)

(after! org (setq org-agenda-use-time-grid nil
                  org-agenda-skip-scheduled-if-done t
                  org-agenda-skip-deadline-if-done t
                  org-habit-show-habits t))
(after! org (setq org-super-agenda-groups
                  '((:auto-category t))))

(load-library "find-lisp")
(after! org (setq org-agenda-files
(find-lisp-find-files "~/.org/" "\.org$")))

(after! org (setq org-capture-templates
                  '(("t" "Tasks")
                    ("p" "Projects")
                    ("r" "References"))))

(after! org (add-to-list 'org-capture-templates
             '("ta" "Append new entry to existing header" entry (file+function buffer-name org-back-to-heading-or-point-min)
"* %^{topic}
:PROPERTIES:
:CREATED:    %U
:END:
:LOGBOOK:
:END:

%?" :clock-in t :clock-resume t)))

(after! org (add-to-list 'org-capture-templates
             '("c" "Capture [GTD]" entry (file "~/.org/gtd/inbox.org")
"* TODO %^{taskname}%?
:PROPERTIES:
:CREATED:    %U
:END:
" :immediate-finish t)))

(after! org (add-to-list 'org-capture-templates
             '("tp" "Add Parent w/child to Current" entry (file+function buffer-name org-back-to-heading-or-point-min)
"* TODO %^{taskname}
:PROPERTIES:
:CREATED:    %U
:END:
:LOGBOOK:
:END:

%?

\** TODO %^{child task}" :clock-in t :clock-resume t)))

(after! org (add-to-list 'org-capture-templates
             '("pn" "New Project" entry (file+function my/generate-org-note-name org-back-to-heading-or-point-min)
"* TODO %^{projectname}
:PROPERTIES:
:GOAL:    %^{goal}
:END:
:RESOURCES:
:END:

+ REQUIREMENTS:
  %^{requirements}

\** TODO %^{task1}")))

(after! org (add-to-list 'org-capture-templates
             '("tc" "Add Task to Current" entry (file+function buffer-name org-back-to-heading-or-point-min)
"* TODO %^{taskname}
:PROPERTIES:
:CREATED:    %U
:END:
:LOGBOOK:
:END:

%?" :clock-in t :clock-resume t)))

(after! org (add-to-list 'org-capture-templates
                         '("tr" "Recurring Task" entry (file "~/.org/gtd/recurring.org")
                           "* TODO %^{description} %?
:SCHEDULED: %^{schedule}t
:PROPERTIES:
:CREATED:    %U
:END:
:RESOURCES:
:END:
")))

(after! org (add-to-list 'org-capture-templates
             '("rn" "Yank new Example" entry(file+headline"~/.org/notes/references.org" "INBOX")
"* %^{example}
:PROPERTIES:
:CATEGORY: %^{category}
:SUBJECT:  %^{subject}
:END:
:RESOURCES:
:END:

%?")))

(after! org (add-to-list 'org-capture-templates
             '("re" "Yank new Example" entry(file+headline"~/.org/notes/examples.org" "INBOX")
"* %^{example}
:PROPERTIES:
:SOURCE:  %^{source|Command|Script|Code|Usage}
:SUBJECT: %^{subject}
:END:

\#+BEGIN_SRC %^{lang}
%x
\#+END_SRC
%?")))

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
             '("d" "Diary Log" entry(file+datetree"~/.org/journal/diary.org")
               "** <%<%I:%M:%S>> %^{diary entry}
%?")))

(after! org (setq org-directory "~/.org/"
                  org-image-actual-width nil
                  +org-export-directory "~/.export/"
                  org-archive-location "~/.org/gtd/archive.org::datetree/"
                  org-default-notes-file "~/.org/gtd/inbox.org"
                  projectile-project-search-path '("~/")))

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
                  org-export-backends '(pdf ascii html latex odt pandoc)))

(after! org (setq org-todo-keyword-faces
      '(("TODO" :foreground "tomato" :weight bold)
        ("WAITING" :foreground "light sea green" :weight bold)
        ("STARTED" :foreground "DodgerBlue" :weight bold)
        ("DELEGATED" :foreground "Gold" :weight bold)
        ("NEXT" :foreground "violet red" :weight bold)
        ("DONE" :foreground "slategrey" :weight bold))))

(after! org (setq org-todo-keywords
      '((sequence "TODO(t)" "WAITING(w!)" "STARTED(s!)" "NEXT(n!)" "DELEGATED(e!)" "|" "INVALID(I!)" "DONE(d!)"))))

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
(setq org-emphasis-alist
  '(("*" (bold :foreground "Orange" ))
    ("/" italic)
    ("_" underline)
    ("=" (:foreground "maroon"))
    ("~" (:foreground "deep sky blue"))
    ("+" (:strike-through t))))

(after! org (setq org-publish-project-alist
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
                     ;:html-head "<link rel=\"stylesheet\"
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
                    ("myprojectweb" :components("references-attachments" "pdf" "references-md" "tasks")))))

(after! org (setq org-refile-targets '((org-agenda-files . (:maxlevel . 6)))
                  org-outline-path-complete-in-steps nil
                  org-refile-allow-creating-parent-nodes 'confirm))

(after! org (setq org-startup-indented t
                  org-src-tab-acts-natively t))
(add-hook 'org-mode-hook 'variable-pitch-mode)
(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook (lambda () (org-autolist-mode)))
(add-hook 'org-agenda-finalize-hook 'org-timeline-insert-timeline :append)

;(add-hook 'org-mode-hook 'org-num-mode)

(after! org (setq org-tags-column -80))
(after! org (setq org-tag-alist '((:startgrouptag)
                                  ("GTD")
                                  (:grouptags)
                                  ("Control")
                                  ("Persp")
                                  (:endgrouptag)
                                  (:startgrouptag)
                                  ("Control")
                                  (:grouptags)
                                  ("Context")
                                  ("Task")
                                  (:endgrouptag))))

(setq alert-default-style 'mode-line)

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

;; Requires Org 9.0 now

(require 'dash)
(require 's)

  ;;; RMR and daily caloric expenditure

;; Verified to match RMR from Mifflin, St. Jeor, et al method as
;; described at http://www.calculateyourrmr.com/ which is the same as
;; the one in YAYOG

(defvar org-fitness-desired-loss-rate 2.5
  "Desired weight-loss rate in pounds-per-week.")

;; Activity multiplier (sedentary=1.2, moderate/YAYOG=1.55)
(defvar org-fitness-activity-multiplier 1.2)

(defvar org-fitness-birthday-encoded (encode-time 0 0 0 1 1 1984))
(defvar org-fitness-height-inches 72)

;;;; Code

(defun org-fitness-age ()
  (let* ((current-ts (float-time (current-time)))
         (birthday-ts (float-time org-fitness-birthday-encoded))
         (difference (- current-ts birthday-ts))
         (seconds-per-year (* 60 60 24 365)))
    (/ difference seconds-per-year)))

(defun org-fitness-rmr ()
  "Calculate RMR in kcal from data."
  (let* ((weight-lbs (string-to-number (caar (last (org-fitness-select-columns "weight-log" '("Weight"))))))
         (weight-kg (/ weight-lbs 2.2))
         (height-in org-fitness-height-inches)
         (height-cm (* height-in 2.54))
         (age (org-fitness-age)))
    (+ (- (+ (* 10 weight-kg)
             (* 6.25 height-cm))
          (* 5 age))
       5)))

(defun org-fitness-daily-caloric-expenditure ()
  "Return daily kcal expenditure from RMR and activity multiplier."
  (* (org-fitness-rmr) org-fitness-activity-multiplier))

(defun org-fitness-daily-calorie-deficit ()
  "Return daily caloric deficit based on desired pounds-per-week loss rate."
  (/ (* 3500 org-fitness-desired-loss-rate) 7))

(defun org-fitness-daily-calorie-goal ()
  "Return daily calorie goal."
  (round (- (org-fitness-daily-caloric-expenditure) (org-fitness-daily-calorie-deficit))))

  ;;; Functions

(defmacro org-fitness-number-or-string (val)
  (let ((gval (gensym))
        (gnum (gensym)))
    `(let* ((,gval ,val)
            (,gnum (string-to-number ,gval)))
       (if (or (string= ,gval "")  ; In the case of free food, I might prefer an empty string over a 0.00
               (string= ,gval "0")
               (string= ,gval "0.0")
               (string= ,gval "0.00")
               (< 0 ,gnum))
           ;; Number
           ,gnum
         ;; String
         ,gval))))

(defun org-fitness-table-data-without-hlines (table-name)
  "Return table data as list without hline rows."
  (org-with-table table-name
    (--remove (equal 'hline it)
              (org-table-to-lisp))))

(defun org-fitness-sum-table-lines ()
  "Sum each numeric column in table lines touched by the region."
  (interactive)
  (org-with-wide-buffer
   (let* (
          ;; Add empty column because (org-table-get-specials) leaves the empty one out, which throws off the indices
          (header (cons nil (org-table-column-names)))
          (start (save-excursion
                   (goto-line (line-number-at-pos (region-beginning)))
                   (line-beginning-position)))
          (end (save-excursion
                 (goto-line (line-number-at-pos (region-end)))
                 (line-end-position)))
          (lines (buffer-substring-no-properties start end))
          (table (--remove (equal 'hline it)
                           (org-table-to-lisp lines)))
          (indices (cdr  ; Drop index representing first column, which is always empty
                    (butlast  ; Drop index representing last column, which is comments
                     (-find-indices (lambda (col)
                                      (or (string= col "")  ; In the case of free food, I might prefer an empty string over a 0.00
                                          (string= col "0")
                                          (string= col "0.0")
                                          (string= col "0.00")
                                          (< 0 (string-to-number col))))
                                    (car table)))))
          (sums (cl-loop for i in indices
                         collect (-reduce '+ (-map 'string-to-number
                                                   (-select-column i table)))))
          (result (-zip (-select-by-indices indices header) sums)))
     (org-fitness-display-values result :prefix "Lines: "))))

(defun org-fitness-get-column-index (column header)
  "Return index of column named COLUMN according to HEADER."
  (--find-index (string= column it) header))

(defun org-fitness-summarize-food-list (food-list)
  "Print message to minibuffer summarizing food data in FOOD-LIST.
    FOOD-LIST should be the food-log Org table converted to a list."
  (let* ((header (car food-list))
         (data (cdr food-list))
         (calories-index (org-fitness-get-column-index "Calories" header))
         (protein-index (org-fitness-get-column-index "Protein" header))
         (cost-index (org-fitness-get-column-index "Price" header))
         (calories (-reduce '+ (-map 'string-to-number (-select-column calories-index data))))
         (protein (-reduce '+ (-map 'string-to-number (-select-column protein-index data))))
         (cost (-reduce '+ (-map 'string-to-number (-select-column cost-index data))))
         (calories-per-dollar (/ calories cost))
         (protein-per-dollar (/ protein cost))
         (calories-per-protein (/ calories protein))
         (calories-string (org-fitness-colorize-string "Calories" org-fitness-calories-color))
         (protein-string (org-fitness-colorize-string "Protein" org-fitness-protein-color))
         (cost-string (org-fitness-colorize-string "Cost" org-fitness-cost-color))
         (cost (format "%.2f" cost)))
    (message "%s: %s (%d/$) | %s: %sg (%d/$) (%d cal/g) | %s: %s"
             "Calories" (org-fitness-colorize-string calories org-fitness-calories-color :weight 'bold) calories-per-dollar
             "Protein" (org-fitness-colorize-string protein org-fitness-protein-color :weight 'bold) protein-per-dollar calories-per-protein
             "Cost" (org-fitness-colorize-string cost org-fitness-cost-color :weight 'bold))))

(defun org-fitness-summarize-food-table-lines ()
  "Summarize data in food-log table touched by the region."
  (interactive)
  (org-with-wide-buffer
   (let* ((header (cons nil (org-table-column-names)))
          (start (save-excursion
                   (goto-line (line-number-at-pos (region-beginning)))
                   (line-beginning-position)))
          (end (save-excursion
                 (goto-line (line-number-at-pos (region-end)))
                 (line-end-position)))
          (lines (buffer-substring-no-properties start end))
          (table (--remove (equal 'hline it)
                           (org-table-to-lisp lines))))
     (org-fitness-summarize-food-list (cons header table)))))

(defun org-fitness-display-values (values &key region)
  "Display list of data in minibuffer, colorized according to ht.
      VALUES should be a list of (NAME . VALUE) pairs."
  (message (concat region (s-join " | "
                                  (--map (org-fitness-colorize-pair it)
                                         values)))))

(defun org-fitness-colorize-pair (pair)
  (let* ((name (car pair))
         (color (ht-get org-fitness-colors-ht name))
         (value (cdr pair))
         (value (if (stringp value)
                    value
                  (if (floatp value)
                      (format "%.2f" value)
                    (format "%s" value)))))
    (add-face-text-property 0 (length value) `(:foreground ,color :weight bold) nil value)
    (format "%s: %s" name value)))

(defun org-fitness-todays-timestamp ()
  "Return Org timestamp for today, or yesterday if before 4am."
  (let* ((decoded-time (decode-time))
         (hour (nth 2 decoded-time))
         (day (nth 3 decoded-time))
         encoded-time)
    (when (< hour 4)
      (setq decoded-time (-replace-at 3 (1- day) decoded-time)))
    (setq encoded-time (apply 'encode-time decoded-time))
    (with-temp-buffer
      (org-insert-time-stamp encoded-time nil t)
      (buffer-string))))

(defun org-fitness-summarize-food-for-day (&optional date)
  "Display sums of food data for the day at point.
  If DATE is supplied (as an Org timestamp), display the data for
  that date.  Otherwise, if point in an Org table, use the date
  column.  Otherwise, use today's date."
  (interactive)
  (let* ((date (cond
                (date date)
                ((org-at-table-p)
                 ;; In a table; get date field
                 ;; TODO: Use a function to get the date column index
                 (let ((date (org-with-wide-buffer (org-table-get-field 2))))
                   (if (or (string-empty-p date)
                           (string= "Date" (s-trim date)))
                       ;; In a table but not in a data row; use today
                       (org-fitness-todays-timestamp)
                     date)))
                (t  ;; Use today's date by default
                 (org-fitness-todays-timestamp))))
         (calories (org-fitness-sum-column "food-log" "Calories" date))
         (protein (org-fitness-sum-column "food-log" "Protein" date))
         (cost (org-fitness-sum-column "food-log" "Price" date))
         (calories-per-dollar (/ calories cost))
         (protein-per-dollar (/ protein cost))
         (calories-per-protein (/ calories protein))
         (calories-string (org-fitness-colorize-string "Calories" org-fitness-calories-color))
         (protein-string (org-fitness-colorize-string "Protein" org-fitness-protein-color))
         (cost-string (org-fitness-colorize-string "Cost" org-fitness-cost-color))
         (cost (format "%.2f" cost)))

    (message "%s: %s (%d/$) | %s: %sg (%d/$) (%d cal/g) | %s: %s"
             "Calories" (org-fitness-colorize-string calories org-fitness-calories-color :weight 'bold) calories-per-dollar
             "Protein" (org-fitness-colorize-string protein org-fitness-protein-color :weight 'bold) protein-per-dollar calories-per-protein
             "Cost" (org-fitness-colorize-string cost org-fitness-cost-color :weight 'bold))))

(defun org-fitness-colorize-string (s color &rest rest)
  "Add COLOR property and other properties REST to string S.
       If S is not a string, format it into one."
  (unless (stringp s)
    (setq s (format "%s" s)))
  (add-face-text-property 0 (length s) `(:foreground ,color ,@rest) nil s)
  s)

(defun org-fitness-goto-table (name)
  "Go to table named NAME if point is not in any table."
  (unless (org-at-table-p)
    (let ((org-babel-results-keyword "NAME"))
      (org-babel-goto-named-result name)
      (forward-line 2))))

(defun org-fitness-sum-rectangle ()
  "Sum values in marked rectangle."
  (interactive)
  (message "%s: %.2f"
           (org-fitness-column-name-at-point)
           (->> (extract-rectangle (region-beginning) (region-end))
                (-map 'string-to-number)
                (-sum))))

(defmacro org-with-table (table-name &rest body)
  "Move point to inside Org table TABLE-NAME and execute BODY."
  (declare (indent defun))
  `(org-with-wide-buffer
    (let ((org-babel-results-keyword "NAME"))
      (org-babel-goto-named-result ,table-name)
      (forward-line 2)
      ,@body)))

(defun org-table-name-at-point ()
  "Return name of table at point."
  (org-with-wide-buffer
   (goto-char (org-table-begin))
   (forward-line -1)
   (beginning-of-line)
   (re-search-forward (rx "#+NAME:" (1+ space) (group (1+ (not space))) eol))
   (match-string-no-properties 1)))

(defun org-table-column-names (&optional table-name)
  "Return list of column names for TABLE-NAME or table at point."
  (org-with-table
    (or table-name (org-table-name-at-point))
    (org-table-analyze)
    (--map (org-no-properties (car it))
           org-table-column-names)))

(defun org-fitness-timestamp-at-point ()
  "Return any Org timestamp at point, or nil."
  (when (org-at-timestamp-p t) (match-string-no-properties 0)))

(defun org-fitness-column-names-at-point ()
  "Return list of column names for table at point."
  (org-table-analyze)
  (--map (org-no-properties (car it))
         org-table-column-names))

(defun org-fitness-column-name-at-point ()
  "Return name of column at point."
  (let ((column (org-table-current-column)))
    (org-with-wide-buffer
     (org-table-goto-line 0)
     (s-trim (substring-no-properties (org-table-get-field column))))))

(defun org-fitness-table-name-at-point ()
  (org-with-wide-buffer
   (goto-char (org-table-begin))
   (forward-line -1)
   (beginning-of-line)
   (re-search-forward (rx "#+NAME:" (1+ space) (group (1+ (not space))) eol))
   (match-string-no-properties 1)))

(defun org-fitness-sum-column (&optional table column date)
  "Return sum of COLUMN in TABLE for DATE.
       TABLE should be the name of an Org table. If nil and point is in
       a table, the current table will be used.

       DATE should be an Org timestamp. If nil and point is on a
       timestamp, DATE will be picked up from point.  If just nil, date
       will be ignored.

       COLUMN should be the name of a column's header field. If nil and
       the point is in an Org table, the name of the current column will
       be used."
  (interactive)
  (let* ((table (or table (org-fitness-table-name-at-point)))
         (column (or column (org-fitness-column-name-at-point)))
         (ts-at-point (org-fitness-timestamp-at-point))
         (date (or date
                   (when (and ts-at-point
                              (org-at-table-p))
                     ;; TODO: Use a function to get the date column index
                     (org-with-wide-buffer (org-table-get-field 2)))))
         (sum (-sum (-map 'string-to-number
                          (-flatten (org-fitness-select-columns table (list column) date))))))
    ;; (if (floatp sum)
    ;; (format "%0.2f" sum)
    ;; sum)
    sum))

(defun org-fitness-select-columns (table-name column-names &optional date)
  "Return list of rows with selected COLUMN-NAMES in TABLE-NAME for DATE.

  COLUMN-NAMES is a list of strings.

  If DATE is nil, ignore date.  If DATE is symbol `today', today's
  date will be used.

  This function expects the table to have a header row in which the
  date column is named \"Date\" and contains Org timestamps."
  (let* ((org-extend-today-until 4)
         (day-number (cond
                      ((null date) nil)
                      ((equal date 'today) (org-today))
                      (date (1+ (date-to-day date)))))
         (table-data (--remove (or (equal 'hline it)
                                   ;; Remove lines without a date (second column)
                                   (string-empty-p (nth 1 it)))
                               (org-with-table table-name
                                 (org-table-to-lisp))))
         (header (car table-data))
         (date-column-number (--find-index (string= "date" (downcase it)) header))
         (column-numbers
          ;; The indexes of the columns we need to "pre-select", including the date, even if the date is not being returned
          (-sort '< (-uniq (--map (-find-index (-partial 'string= it) header)
                                  column-names))))
         (final-columns
          ;; The adjusted indexes of the columns we're returning, after they've been pre-selected
          (number-sequence 1 (length column-numbers))))
    (->> (cdr table-data) ; Remove header
         (-select-columns (cons date-column-number column-numbers))
         ((lambda (row)
            (if (null day-number)
                row
              (--filter (= day-number
                           (->> (car it) ; Date column is first
                                (org-time-string-to-time)
                                (time-to-days)))
                        row))))

         ;; Remove date column if not requested
         (-select-columns final-columns))))

(defun org-fitness-remove-columns-by-indices (indices table)
  "Return TABLE without columns specified by INDICES.
      INDICES is a list of integers and TABLE is a list of lists."
  (let* ((num-columns (length (car table)))
         (columns (-remove (lambda (col)
                             (memq col indices))
                           (number-sequence 0 (1- num-columns)))))
    (-select-columns columns table)))

(defun org-fitness-call-src-blocks (names)
  "Call source blocks specified by NAMES.
       NAMES should be a list of symbols (not strings) matching the
       source blocks' \"#+NAME:\" header."
  ;; Based on <http://kitchingroup.cheme.cmu.edu/blog/2014/08/11/Using-org-mode-outside-of-Emacs-sort-of/>
  ;; This works better than the org-sbe (aka sbe) macro, because it
  ;; calls the block upon expansion, making it difficult to bind to
  ;; a command to run later
  (dolist (name names)
    (org-with-wide-buffer
     (-when-let (src (org-element-map (org-element-parse-buffer) 'src-block
                       (lambda (element)
                         (when (string= (symbol-name name) (org-element-property :name element))
                           element))
                       nil ;info
                       t ))
       (goto-char (org-element-property :begin src))
       (let ((org-confirm-babel-evaluate nil))
         (org-babel-execute-src-block))))))

  ;;;; Food-listing functions

(cl-defun org-fitness-list-food-by (sort-column &key reverse)
  "Return table in list form of food sorted by SORT-COLUMN.
        SORT-COLUMN is the name of a column according to the header row."
  (let* ((table-name "food-log")
         (table-data (org-fitness-table-data-without-hlines table-name))
         (header (car table-data))
         ;; Remove unwanted columns
         (date-col-index (--find-index (string= (downcase "date") (downcase it)) header))
         (table-data (org-fitness-remove-columns-by-indices (list 0 date-col-index) table-data))
         (header (car table-data))
         (sort-col-index (--find-index (string= (downcase sort-column) (downcase it)) header))
         (-compare-fn (lambda (a b)
                        ;; Compare first column (food name) in -uniq
                        (equal (car a) (car b))))
         (result (cons header
                       (->> (cdr table-data)
                            (--remove (member "Raw calorie data" it))
                            (-sort (lambda (row-a row-b)
                                     (let ((a-val (org-fitness-number-or-string (nth sort-col-index row-a)))
                                           (b-val (org-fitness-number-or-string (nth sort-col-index row-b))))
                                       (when (and (numberp a-val)
                                                  (numberp b-val))
                                         (< a-val b-val)))))
                            (-uniq)))))
    (if reverse
        (nreverse result)
      result)))

(cl-defun org-fitness-list-food-by-calories-per-protein (&key reverse)
  "Return table in list form of food sorted by calories per gram of protein."
  (let* ((table-name "food-log")
         (table-data (org-fitness-table-data-without-hlines table-name))
         (header (car table-data))
         ;; Remove unwanted columns
         (date-col-index (--find-index (string= (downcase "date") (downcase it)) header))
         (table-data (org-fitness-remove-columns-by-indices (list 0 date-col-index) table-data))
         (header (car table-data))
         (calories-col-index (--find-index (string= "Calories" it) header))
         (protein-col-index (--find-index (string= "Protein" it) header))
         (-compare-fn (lambda (a b)
                        ;; Compare first column (food name) in -uniq
                        (equal (car a) (car b))))
         (unique-foods (->> (cdr table-data)
                            (--remove (member "Raw calorie data" it))
                            (-uniq)))
         ;; Remove foods without protein
         (unique-foods (--remove (= 0 (org-fitness-number-or-string (nth protein-col-index it)))
                                 unique-foods))
         (analyzed-foods (-map (lambda (row)
                                 (let* ((calories (org-fitness-number-or-string (nth calories-col-index row)))
                                        (protein (org-fitness-number-or-string (nth protein-col-index row)))
                                        (calories-per-protein (when (> protein 0)
                                                                (round (/ calories protein)))))
                                   (-insert-at 1 calories-per-protein row)))
                               unique-foods))
         (result (cons (-insert-at 1 "Calories/Protein" header)
                       (-sort (lambda (a b)
                                (< (nth 1 a) (nth 1 b)))
                              analyzed-foods))))
    (if reverse
        (nreverse result)
      result)))

;;;; Capturing

(defun ap/get-unique-food-items ()
  (let ((buffer (get-buffer "fitness.org"))
        (table-name "food-log")
        (skip-lines 3)
        (-compare-fn (lambda (a b)
                       ;; Compare food names
                       (string= (nth 2 a)
                                (nth 2 b)))))
    (with-current-buffer buffer
      (org-with-wide-buffer
       (goto-char (point-min))
       ;; Find table
       (re-search-forward (rx-to-string `(: "#+NAME: " ,table-name)))
       (forward-line 1)
       (cl-loop for item in (->> (org-table-to-lisp)
                                 (-drop skip-lines)    ; 2 hlines and header
                                 (--remove (eq 'hline it))
                                 (-distinct))
                collect (cl-destructuring-bind (_ date name calories protein price comment) item
                          (list :name name :calories calories :protein protein :price price)))))))

(cl-defun ap/complete-food-items (&key (times 1) ask)
  "Return food data plist TIMES items long, completed with Helm.
Data entered may contain math expressions which will be evaluated
with `calc-eval'."
  (cl-macrolet ((ask (prompt value)
                     (let ((op-chars (list "+" "-" "*" "/")))
                       `(if (or ask (not ,value))
                            (progn
                              (setq value (read-from-minibuffer ,prompt ,value nil nil ,value))
                              (if (--any? (s-contains? it value) ',op-chars)
                                  ;; value contains math operation; eval it
                                  (format "%0.2f" (string-to-number (calc-eval value)))
                                value))
                          ;; Not asking and value is already set
                          ,value))))
    (cl-loop with food-data = (ap/get-unique-food-items)
             repeat times
             for selected-name = (helm-comp-read "Food: " (--map (plist-get it :name) food-data))
             for selected-data = (cl-loop for item in food-data
                                          if (string= (plist-get item :name) selected-name)
                                          return item)
             while selected-name
             ;; Would like to use -let here, but it doesn't seem to work when nested inside cl-loop
             collect (list :name selected-name
                           :calories (string-to-int (ask "Calories: " (plist-get selected-data :calories)))
                           :protein (string-to-int (ask "Protein: " (plist-get selected-data :protein)))
                           :price (format "%0.2f" (string-to-number (ask "Price: " (plist-get selected-data :price))))
                           :comment (ask "Comment: " "")))))

(cl-defun ap/complete-food-items-multi (&key (times 1) ask)
  "Return food data plist TIMES items long, completed with Helm.
Multiple items may be selected with Helm.  Numerical data entered
may contain math expressions which will be evaluated with
`calc-eval'."
  (cl-macrolet ((ask (prompt value)
                     (let ((op-chars (list "+" "-" "*" "/")))
                       `(if (or ask (not ,value))
                            (progn
                              (setq value (read-from-minibuffer ,prompt ,value nil nil ,value))
                              (if (--any? (s-contains? it value) ',op-chars)
                                  ;; value contains math operation; eval it
                                  (format "%0.2f" (string-to-number (calc-eval value)))
                                value))
                          ;; Not asking and value is already set
                          ,value))))
    (apply 'append
           (cl-loop with food-data = (ap/get-unique-food-items)
                    repeat times
                    for selected-names = (helm-comp-read "Food: " (--map (plist-get it :name) food-data)
                                                         :marked-candidates t)
                    for selected-items = (cl-loop for item in food-data
                                                  if (member (plist-get item :name) selected-names)
                                                  collect item)
                    do (when (and (null selected-items) selected-names)
                         ;; New food names, so ask for info
                         (setq selected-items (--map (list :name it) selected-names)))
                    ;; Would like to use -let here, but it doesn't seem to work when nested inside cl-loop
                    collect (cl-loop for item in selected-items
                                     collect (list :name (plist-get item :name)
                                                   :calories (string-to-number (ask "Calories: " (plist-get item :calories)))
                                                   :protein (string-to-number (ask "Protein: " (plist-get item :protein)))
                                                   :price (format "%0.2f" (string-to-number (ask "Price: " (plist-get item :price))))
                                                   :comment (ask "Comment: " "")))))))

(cl-defun ap/capture-food (prefix &key yesterday ask)
  (interactive "P")
  (switch-to-buffer (ap/org-get-file-buffer "fitness.org"))
  (let* ((table-name "food-log")
         (date-time (with-temp-buffer
                      (org-insert-time-stamp (org-current-time) nil t)
                      (when yesterday
                        (org-timestamp-down-day))
                      (buffer-string)))
         (insert-hline (not (string= (org-no-properties (org-table-get-remote-range table-name "@II$2"))
                                     date-time)))
         (foods (ap/complete-food-items-multi :times (prefix-numeric-value prefix) :ask ask))
         (pos (save-excursion
                (goto-char (point-min))
                (if (re-search-forward (concat "^[ \t]*#\\+\\(tbl\\)?name:[ \t]*" (regexp-quote table-name) "[ \t]*$") nil t)
                    (progn
                      (goto-char (match-beginning 0))
                      (forward-line 3)
                      (line-end-position))
                  (error "Unable to find %s table." table-name)))))
    (goto-char pos)
    ;; Insert new hline if necessary
    (when insert-hline
      (org-table-insert-hline t)
      (forward-line -1))
    (dolist (food foods)
      (end-of-line)
      (cl-destructuring-bind (&key name calories protein price comment) food
        (insert (format "\n|   | %s | %s | %s | %s | %s | %s |" date-time name calories protein price comment))))
    (backward-char 4)
    (org-table-justify-field-maybe)
    (call-interactively 'org-table-next-field)))

(defun ap/capture-food-ask (prefix)
  "Run `ap/capture-food' with `:ask' set."
  (interactive "P")
  (funcall 'ap/capture-food prefix :ask t))

(defun ap/capture-food-yesterday (prefix)
  (interactive "P")
  (ap/capture-food prefix :yesterday t))

;;;;;;; Workout-capturing

(cl-defun ap/org-complete-table-column (table column &key hline prompt selector)
  "Return unique value from COLUMN in TABLE with Helm completion.

If HLINE is specified, start after that number hline in table.

If SELECTOR is specified, use that instead of constructing one from TABLE, COLUMN, and HLINE.

If PROMPT is specified, use it as prompt in minibuffer."
  (unless prompt
    (setq prompt (concat (capitalize column) ": ")))
  (when hline
    (setq hline (s-repeat hline "I")))
  (unless selector
    (setq selector (concat "@" hline "$" column ".." "@>" "$" column)))
  (helm-comp-read prompt (->> (org-table-get-remote-range table selector)
                              (-map 'org-no-properties)
                              (-uniq)
                              (-sort 'string<))))

(defun ap/capture-workout-data (prefix)
  (interactive "P")
  (switch-to-buffer (ap/org-get-file-buffer "fitness.org"))
  (--dotimes (if prefix (prefix-numeric-value prefix) 1)
    (let* ((date-time (with-temp-buffer
                        (org-insert-time-stamp (org-current-time) nil t)))
           (insert-hline (not (string= (org-no-properties (org-table-get-remote-range "workout-log" "@II$Date"))
                                       date-time)))
           (movement (ap/org-complete-table-column "workout-log" "Movement" :hline 2))
           (type (ap/org-complete-table-column "workout-log" "Type" :hline 2))
           (reps (read-from-minibuffer "Reps: "))
           (comment (read-from-minibuffer "Comment: "))
           (pos (save-excursion
                  (goto-char (point-min))
                  (if (re-search-forward (concat "^[ \t]*#\\+\\(tbl\\)?name:[ \t]*" (regexp-quote "workout-log") "[ \t]*$") nil t)
                      (progn
                        (goto-char (match-beginning 0))
                        (forward-line 3)
                        (line-end-position))
                    (error "Unable to find workout-log table.")))))
      (goto-char pos)
      (when insert-hline
        (setq insert-hline nil)       ; Only insert one line
        (org-table-insert-hline t)
        (forward-line -1))
      (end-of-line)
      (insert (format "\n|   | %s | %s | %s | %s | %s |" date-time movement reps type comment))
      (backward-char 4)
      (org-table-justify-field-maybe)
      (call-interactively 'org-table-next-field))))

;;; Make keymap and bind keys

(use-local-map (copy-keymap org-mode-map))

(cl-macrolet ((bind-kli (&rest forms)
                        ;; This works because somehow splicing into the
                        ;; explicit progn works, even though there's also
                        ;; an implicit progn around the explicit progn
                        (let ((res (-map
                                    (-lambda ((key . body))
                                      `(local-set-key (kbd ,key)
                                                      (lambda (prefix)
                                                        (interactive "P")
                                                        ,@body)))
                                    forms)))
                          `(progn ,@res))))
  (bind-kli
   ("C-l"
    (helm-org-in-buffer-headings)
    (recenter-top-bottom 1))
   ("C-c C-h"
    (progn (unless (org-at-table-p)
             (org-fitness-goto-table "food-log")
             (org-table-goto-line 2)))
    (org-fitness-summarize-food-for-day)
    (hydra-org-fitness/body))
   ("C-c C-f"
    (ap/capture-food prefix)
    (org-fitness-call-src-blocks '(modular-plotting))
    (org-redisplay-inline-images))
   ("C-c C-p"
    (org-fitness-call-src-blocks '(modular-plotting-hp))
    (org-redisplay-inline-images))
   ("C-c C-w"
    (ap/capture-workout-data prefix)
    (org-fitness-call-src-blocks '(modular-plotting-hp))
    (org-redisplay-inline-images))
   ("C-c C-s"
    (if (region-active-p)
        (org-fitness-summarize-food-table-lines)
      (unless (org-at-table-p)
        (org-fitness-goto-table "food-log")
        (org-table-goto-line 2))
      (org-fitness-summarize-food-for-day (org-fitness-timestamp-at-point))))
   ))

(require 'ht)


(defhydra hydra-org-fitness (:color red :hint nil)
  "
       Summarize data for day:
       ^^^^-----------------------
       _c_urrent
       _p_revious
       _n_ext               _q_uit
       "
  ("c" (org-fitness-summarize-food-for-day))
  ;; ("i" (message "%s: %s" (org-fitness-column-name-at-point) (org-fitness-sum-column-for-date)))
  ("n" (progn
         (org-fitness-goto-table "food-log")
         (re-search-forward (rx bol "|-"))
         (forward-line 1)
         (org-fitness-summarize-food-for-day)))
  ("p" (progn
         (org-fitness-goto-table "food-log")
         (re-search-backward (rx bol "|-"))
         (forward-line -1)
         (org-fitness-summarize-food-for-day)))
  ("q" nil))

       ;;; Set faces

;; Set the org-date face to monospace in this file, so the table columns will line up.
(face-remap-add-relative 'org-date :background "#073642" :family (face-attribute 'default :family))
(face-remap-add-relative 'org-formula :background "#073642" :family (face-attribute 'default :family))
(face-remap-add-relative 'org-table :background "#073642")

       ;;; Misc

(require 'ob-table)
(toggle-truncate-lines 1)

;; Run Python blocks without prompting
(unless (member '(python . t) org-babel-load-languages)
  (add-to-list 'org-babel-load-languages '(python . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages))

;(use-package gnuplot
;  :config
;  (setq gnuplot-program "gnuplot"))

(require 'org)

(defun org-cycle-hide-drawers (state)
  "Re-hide all drawers after a visibility state change."
  (when (and (derived-mode-p 'org-mode)
             (not (memq state '(overview folded contents))))
    (save-excursion
      (let* ((globalp (memq state '(contents all)))
             (beg (if globalp
                    (point-min)
                    (point)))
             (end (if globalp
                    (point-max)
                    (if (eq state 'children)
                      (save-excursion
                        (outline-next-heading)
                        (point))
                      (org-end-of-subtree t)))))
        (goto-char beg)
        (while (re-search-forward org-drawer-regexp end t)
          (save-excursion
            (beginning-of-line 1)
            (when (looking-at org-drawer-regexp)
              (let* ((start (1- (match-beginning 0)))
                     (limit
                       (save-excursion
                         (outline-next-heading)
                           (point)))
                     (msg (format
                            (concat
                              "org-cycle-hide-drawers:  "
                              "`:END:`"
                              " line missing at position %s")
                            (1+ start))))
                (if (re-search-forward "^[ \t]*:END:" limit t)
                  (outline-flag-region start (point-at-eol) t)
                  (user-error msg))))))))))

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

;(after! org (setq org-agenda-property-list '("WHO" "NEXTACT")
;                  org-agenda-property-position 'where-it-fits))

(require 'org)

(org-add-link-type "outlook" 'org-outlook-open)

(defun org-outlook-open (id)
   "Open the Outlook item identified by ID.  ID should be an Outlook GUID."
   (w32-shell-execute "open" (concat "outlook:" id)))

(provide 'org-outlook)
(require 'org-outlook)

(defun org-clock-switch ()
  "Switch task and go-to that task"
  (interactive)
  (setq current-prefix-arg '(12)) ; C-u
  (call-interactively 'org-clock-goto)
  (org-clock-in)
  (org-clock-goto))
(provide 'org-clock-switch)

(setq org-mru-clock-how-many 10)
(setq org-mru-clock-completing-read #'ivy-completing-read)
(setq org-mru-clock-keep-formatting t)
(setq org-mru-clock-files #'org-agenda-files)

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



(use-package ob-plantuml
  :ensure nil
  :commands
  (org-babel-execute:plantuml)
  :config
  (setq org-plantuml-jar-path (expand-file-name "~/.tools/plantuml.jar")))

(defun org-update-cookies-after-save()
  (interactive)
  (let ((current-prefix-arg '(4)))
    (org-update-statistics-cookies "ALL")))

(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'org-update-cookies-after-save nil 'make-it-local)))
(provide 'org-update-cookies-after-save)

(defun my--browse-url (url &optional _new-window)
  ;; new-window ignored
  "Opens link via powershell.exe"
  (interactive (browse-url-interactive-arg "URL: "))
  (let ((quotedUrl (format "start '%s'" url)))
    (apply 'call-process "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe" nil
           0 nil
           (list "-Command" quotedUrl))))

(setq-default browse-url-browser-function 'my--browse-url)

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

(defun my/last-captured-org-note ()
  "Move to the last line of the last org capture note."
  (interactive)
  (goto-char (point-max)))

(defun my/generate-org-note-name ()
  (setq my-org-note--name (read-string "Name: "))
  (expand-file-name (format "%s.org"my-org-note--name) "~/.org/gtd/projects/"))

(org-super-agenda-mode t)
(after! org-agenda (setq org-agenda-custom-commands
                         '(("k" "Tasks"
                            ((agenda ""
                                     ((org-agenda-files '("~/.org/gtd/tasks.org" "~/.org/gtd/tickler.org" "~/.org/gtd/projects.org"))
                                      (org-agenda-overriding-header "What's on my calendar")
                                      (org-agenda-span 'day)
                                      (org-agenda-start-day (org-today))
                                      (org-agenda-current-span 'day)
                                      (org-time-budgets-for-agenda)
                                      (org-super-agenda-groups
                                       '((:name "Today's Schedule"
                                                :scheduled t
                                                :time-grid t
                                                :deadline t
                                                :order 13)))))
                             (todo ""
                                   ((org-agenda-overriding-header "[[~/.org/gtd/tasks.org][Task list]]")
                                    (org-agenda-prefix-format " %(my-agenda-prefix) ")
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
                             (todo "DELEGATED"
                                   ((org-agenda-overriding-header "Delegated Tasks by WHO")
                                    (org-agenda-files '("~/.org/gtd/tasks.org"))
                                    (org-super-agenda-groups
                                     '((:auto-property "WHO")))))
                             (todo ""
                                   ((org-agenda-overriding-header "References")
                                    (org-agenda-files '("~/.org/gtd/references.org"))
                                    (org-super-agenda-groups
                                     '((:auto-ts t)))))))
                           ("i" "Inbox"
                            ((todo ""
                                   ((org-agenda-files '("~/.org/gtd/inbox.org"))
                                    (org-agenda-overriding-header "Items in my inbox")
                                    (org-super-agenda-groups
                                     '((:auto-ts t)))))))
                           ("x" "Get to someday"
                            ((todo ""
                                   ((org-agenda-overriding-header "Projects marked Someday")
                                    (org-agenda-files '("~/.org/gtd/someday.org"))
                                    (org-super-agenda-groups
                                     '((:auto-ts t))))))))))
