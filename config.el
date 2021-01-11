(defun nm/capture-bullet-journal ()
  "Finds bullet journal headline to nest capture headline under."
  (let* ((date (format-time-string "%Y-%m-%d %a")))
    (goto-char (point-min))
    (unless (re-search-forward (format "^*+\s%s" date) nil t)
      (goto-char (point-max))
      (insert (format "* %s %s" date "[/]")))))

(defun nm/skip-non-stuck-projects ()
  "Skip trees that are not stuck projects."
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (outline-next-heading))))
      (if (bh/is-project-p)
          (let* ((subtree-end (org-end-of-subtree t))
                 (has-next))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next) (< (point) subtree-end) (and (not (bh/is-project-p)) (nm/has-next-condition)))
                (unless (member (or "WAITING" "SOMEDAY") (org-get-tags-at))
                  (setq has-next t))))
            (if has-next
                next-headline
              nil))
        next-headline))))

(defun nm/project-tasks-ready ()
  "Skip trees that are not projects"
      (let ((next-headline (save-excursion (outline-next-heading)))
            (subtree-end (org-end-of-subtree t)))
        (if (nm/skip-non-stuck-projects)
            (cond
             ((and (bh/is-project-subtree-p) (nm/has-next-condition)) nil)
             (t subtree-end))
          subtree-end)))

(defun nm/has-next-condition ()
  "Returns t if headline has next condition state"
  (save-excursion
    (cond
     ((nm/is-scheduled-p) t)
     ((nm/exist-context-tag-p) t)
     ((nm/checkbox-active-exist-p) t))))

(defun nm/standard-tasks-ready ()
  "Show non-project tasks. Skip project and sub-project tasks, habits, and project related tasks."
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
           (next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((bh/is-project-p) next-headline)
       ((bh/is-project-subtree-p) next-headline)
       ((and (bh/is-task-p) (not (nm/has-next-condition))) subtree-end)
       (t nil)))))

(defun nm/stuck-projects ()
  "Returns t when a project has no defined next actions for any of its subtasks."
  (let ((next-headline (save-excursion (outline-next-heading)))
        (subtree-end (org-end-of-subtree t)))
    (if (or (bh/is-project-p) (bh/is-project-subtree-p))
        (cond
         ((and (bh/is-project-subtree-p) (not (nm/has-next-condition))) nil))
      subtree-end)))

(defun nm/tasks-refile ()
  "Returns t if the task is not part of a project and has no next state conditions."
  (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
         (next-heading (save-excursion (outline-next-heading))))
    (cond
     ((nm/has-next-condition) next-heading)
     ((bh/is-project-p) subtree-end))))

(defun nm/capture-project-timeframes ()
  "Captures under the given projects timeframe headline."
  (let ((p-name (ivy-completing-read "Select file: " (find-lisp-find-files "~/projects/orgmode/gtd/" "\.org$")))
        (h-name "* Timeframe")
        (c-name (read-string "Entry name: ")))
    (goto-char (point-min))
    (find-file p-name)
    (unless (re-search-forward h-name nil t)
      (progn (goto-char (point-max)) (newline) (insert "* Timeframe")))
    (org-end-of-subtree t)
    (newline 2)
    (insert (format "** %s %s" (format-time-string "[%Y-%m-%d %a %H:%M]") c-name))
    (newline)))

(defvar doom-fav-themes '("doom-one" "doom-solarized-dark" "doom-dracula" "doom-vibrant" "doom-city-lights" "doom-moonlight" "doom-horizon" "doom-old-hope" "doom-oceanic-next" "doom-monokai-pro" "doom-material" "doom-henna" "doom-gruvbox" "doom-one-light" "doom-gruvbox-light" "doom-solarized-light" "doom-flatwhite" "chocolate"))
(defun nm/load-theme ()
  (interactive)
  (ivy-read "Load custom theme: " doom-fav-themes
            :action #'counsel-load-theme-action
            :caller 'counsel-load-theme))

;; This function was found on a stackoverflow post -> https://stackoverflow.com/questions/6681407/org-mode-capture-with-sexp
 (defun get-page-title (url)
  "Get title of web page, whose url can be found in the current line"
  ;; Get title of web page, with the help of functions in url.el
  (with-current-buffer (url-retrieve-synchronously url)
    ;; find title by grep the html code
    (goto-char 0)
    (re-search-forward "<title>\\([^<]*\\)</title>" nil t 1)
    (setq web_title_str (match-string 1))
    ;; find charset by grep the html code
    (goto-char 0)

    ;; find the charset, assume utf-8 otherwise
    (if (re-search-forward "charset=\\([-0-9a-zA-Z]*\\)" nil t 1)
        (setq coding_charset (downcase (match-string 1)))
      (setq coding_charset "utf-8")
    ;; decode the string of title.
    (setq web_title_str (decode-coding-string web_title_str (intern
                                                             coding_charset))))
  (concat "[[" url "][" web_title_str "]]")))

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

(after! org (org-link-set-parameters "id" :complete #'nm/org-id-prompt-id))

(defun nm/org-capture-log ()
  "Initiate the capture system and find headline to capture under."
  (let* ((org-agenda-files (find-lisp-find-files "~/projects/orgmode/gtd/" "\.org$"))
         (dest (org-refile-get-location))
         (file (cadr dest))
         (pos (nth 3 dest))
         (title (nth 2 dest)))
    (find-file file)
    (goto-char pos)
    (nm/org-end-of-headline)))

(defun nm/org-end-of-headline()
  "Move to end of current headline"
  (interactive)
  (outline-next-heading)
  (forward-char -1))

(defun nm/org-capture-to-task-file ()
  "Capture file to your default tasks file, and prompts to select a date where to file the task file to."
  (let* ((child-l nil)
         (parent "Checklists")
         (date (org-read-date))
         (heading (format "Items for")))
    (goto-char (point-min))
    ;;; Locate or Create our parent headline
    (unless (search-forward (format "* %s" parent) nil t)
      (goto-char (point-max))
      (newline)
      (insert (format "* %s" parent))
      (nm/org-end-of-headline))
    (nm/org-end-of-headline)
    ;;; Capture outline level
    (setq child-l (format "%s" (make-string (+ 1 (org-outline-level)) ?*)))
    ;;; Next we locate or create our subheading using the date string passed by the user.
    (let* ((end (save-excursion (org-end-of-subtree t nil))))
      (unless (re-search-forward (format "%s %s %s" child-l heading date) end t)
        (newline 2)
        (insert (format "%s %s %s %s" child-l heading date "[/]"))))))

(defun nm/add-newline-between-headlines ()
  ""
  (when (equal major-mode 'org-mode)
    (unless (org-at-heading-p)
      (org-back-to-heading))
    (nm/org-end-of-headline)
    (if (not (org--line-empty-p 1))
        (newline))))

(defun nm/add-space-end-of-line ()
  "If N-1 at end of heading is #+end_src then insert blank character on last line."
  (interactive)
  (when (equal major-mode 'org-mode)
    (unless (org-at-heading-p)
      (org-back-to-heading))
    (nm/org-end-of-headline)
    (next-line -1)
    (if (org-looking-at-p "^#\\+end_src$")
        (progn (next-line 1) (insert " ")))))

(defun nm/newlines-between-headlines ()
  "Uses the org-map-entries function to scan through a buffer's
   contents and ensure newlines are inserted between headlines"
  (interactive)
  (org-map-entries #'nm/add-newline-between-headlines t 'file))

(add-hook 'org-insert-heading-hook #'nm/newlines-between-headlines)

(defun nm/capture-to-journal ()
  "When org-capture-template is initiated, it creates the respected headline structure."
  (let ((file "~/projects/orgmode/gtd/journal.org")
        (parent nil)
        (child nil))
    (unless (file-exists-p file)
      (with-temp-buffer (write-file file)))
    (find-file file)
    (goto-char (point-min))
    ;; Search for headline, or else create it.
    (unless (re-search-forward "* Journal" nil t)
      (progn (goto-char (point-max)) (newline) (insert "* Journal")))
    (unless (re-search-forward (format "** %s" (format-time-string "%b '%y")) (save-excursion (org-end-of-subtree)) t)
      (progn (org-end-of-subtree t) (newline) (insert (format "** %s" (format-time-string "%b '%y")))))))

(defun nm/setup-productive-windows (arg1 arg2)
  "Delete all other windows, and setup our ORGMODE production window layout."
  (interactive)
  (progn
    (delete-other-windows)
    (progn
      (find-file arg1))
    (progn
      (split-window-right)
      (evil-window-right 1)
      (org-agenda nil "n"))
    (progn
      (split-window)
      (evil-window-down 1)
      (find-file arg2)
      (goto-char 1)
      (re-search-forward (format "*+\s\\w+\sTasks\sfor\s%s" (format-time-string "%Y-%m-%d")))
      (org-tree-to-indirect-buffer))))

(defun nm/productive-window ()
  "Setup"
  (interactive)
  (nm/setup-productive-windows "~/projects/orgmode/gtd/next.org" "~/projects/orgmode/gtd/tasks.org"))

(map! :after org
      :map org-mode-map
      :leader
      :prefix ("TAB" . "workspace")
      :desc "Load ORGMODE Setup" "," #'nm/productive-window)

(defun nm/get-headlines-org-files (arg &optional indirect)
  "Searches org-directory for headline and returns results to indirect buffer
   ARG being a directory to search and optional INDIRECT should return t if you
   want results returned to an indirect buffer."
  (interactive)
  (let* ((org-agenda-files (find-lisp-find-files arg "\.org$"))
         (org-refile-use-outline-path 'file)
         (org-refile-history nil)
         (dest (org-refile-get-location))
         (buffer nil)
         (first (frame-first-window)))
    (save-excursion
      (if (eq first (next-window first))
          (progn (evil-window-vsplit) (evil-window-right 1))
        (other-window 1))
      (find-file (cadr dest))
      (goto-char (nth 3 dest))
      (if indirect
          (org-tree-to-indirect-buffer)
        nil))))

(defun nm/search-headlines-org-directory ()
  "Search the ORG-DIRECTORY, prompting user for headline and returns its results to indirect buffer."
  (interactive)
  (nm/get-headlines-org-files "~/projects/orgmode/"))

(defun nm/search-headlines-org-tasks-directory ()
  "Search the GTD folder, prompting user for headline and returns its results to indirect buffer."
  (interactive)
  (nm/get-headlines-org-files "~/projects/orgmode/gtd/"))

(map! :after org
      :map org-mode-map
      :leader
      :prefix ("s" . "search")
      :desc "Outline Org-Directory" "c" #'nm/search-headlines-org-directory
      :desc "Outline GTD directory" "!" #'nm/search-headlines-org-tasks-directory)

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
      :prefix ("z" . "orgmode")
      :desc "Outline" "o" #'counsel-outline
      :desc "Find File" "f" #'nm/find-file-or-create
      :prefix ("s" . "+search")
      :desc "Occur" "." #'occur
      :desc "Outline" "o" #'counsel-outline
      :desc "Counsel ripgrep" "d" #'counsel-rg
      :desc "Swiper All" "@" #'swiper-all
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

(setq diary-file "~/projects/orgmode/diary.org")
(setq org-directory "~/projects/orgmode/")
(setq projectile-project-search-path "~/projects/")

(setq doom-theme 'doom-moonlight)

(after! org (set-popup-rule! "^\\*lsp-help" :side 'bottom :size .30 :select t)
  (set-popup-rule! "*helm*" :side 'right :size .30 :select t)
  (set-popup-rule! "*Org QL View:*" :side 'right :size .25 :select t)
  (set-popup-rule! "*Capture*" :side 'left :size .30 :select t)
  (set-popup-rule! "*eww*" :side 'right :size .50 :select t)
  (set-popup-rule! "*CAPTURE-*" :side 'left :size .30 :select t)
  (set-popup-rule! "*Org Agenda*" :side 'bottom :size .30 :select t))

(require 'all-the-icons)

(setq inhibit-compacting-font-caches t)

(setq doom-font (font-spec :family "Roboto Mono" :size 20)
      doom-big-font (font-spec :family "Roboto Mono" :size 32)
      doom-variable-pitch-font (font-spec :family "Roboto Mono" :size 20)
      doom-serif-font (font-spec :family "IBM Plex Mono" :weight 'light))

(add-hook! 'org-mode-hook #'+org-pretty-mode #'mixed-pitch-mode)

(custom-set-faces!
  '(outline-1 :weight extra-bold :height 1.15)
  '(outline-2 :weight bold :height 1.13)
  '(outline-3 :weight bold :height 1.11)
  '(outline-4 :weight semi-bold :height 1.09)
  '(outline-5 :weight semi-bold :height 1.07)
  '(outline-6 :weight semi-bold :height 1.05)
  '(outline-8 :weight semi-bold :height 1.03)
  '(outline-9 :weight semi-bold :height 1.01))

(after! org
  (custom-set-faces!
    '(org-document-title :height 1.15)))

;; (when (equal system-type 'gnu/linux)
;;   (setq doom-font (font-spec :family "JetBrains Mono" :size 20 :weight 'normal)
;;         doom-big-font (font-spec :family "JetBrains Mono" :size 22 :weight 'normal)))
;; (when (equal system-type 'windows-nt)
;;   (setq doom-font (font-spec :family "InputMono" :size 18)
;;         doom-big-font (font-spec :family "InputMono" :size 22)))

(require 'org-habit)
(require 'org-id)
(require 'org-checklist)
(after! org (setq org-archive-location "~/projects/orgmode/gtd/archives.org::* %s"
                  ;org-image-actual-width (truncate (* (display-pixel-width) 0.15))
                  org-link-file-path-type 'relative
                  org-log-state-notes-insert-after-drawers t
                  org-catch-invisible-edits 'error
                  org-refile-targets '((nil :maxlevel . 9)
                                       (org-agenda-files :maxlevel . 4))
                  org-refile-use-outline-path 'buffer-name
                  org-outline-path-complete-in-steps nil
                  org-refile-allow-creating-parent-nodes 'confirm
                  org-startup-indented 'indent
                  org-insert-heading-respect-content t
                  org-startup-folded 'content
                  org-src-tab-acts-natively t
                  org-list-allow-alphabetical nil))

(add-hook 'org-mode-hook 'auto-fill-mode)
;(add-hook 'org-mode-hook 'hl-todo-mode)
(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode -1)))

(setq org-agenda-todo-ignore-scheduled nil
      org-agenda-tags-todo-honor-ignore-options t
      org-agenda-fontify-priorities t)

(setq org-agenda-custom-commands nil)
(push '("o" "overview"
        ((agenda ""
                 ((org-agenda-span '1)
                  (org-agenda-files (append (file-expand-wildcards "~/projects/orgmode/gtd/*.org")))
                  (org-agenda-start-day (org-today))))
         (tags-todo "-SOMEDAY-@delegated/+NEXT"
                    ((org-agenda-overriding-header "Next Tasks")
                     (org-agenda-todo-ignore-scheduled t)
                     (org-agenda-todo-ignore-deadlines t)
                     (org-agenda-todo-ignore-with-date t)
                     (org-agenda-sorting-strategy
                      '(category-up))))
         (tags-todo "-SOMEDAY/+READ"
                    ((org-agenda-overriding-header "To Read")
                     (org-agenda-todo-ignore-scheduled t)
                     (org-agenda-todo-ignore-deadlines t)
                     (org-agenda-todo-ignore-with-date t)
                     (org-agenda-sorting-strategy
                      '(category-up))))
         (tags-todo "-@delegated-SOMEDAY/-NEXT-REFILE-READ"
                    ((org-agenda-overriding-header "Other Tasks")
                     (org-agenda-todo-ignore-scheduled t)
                     (org-agenda-todo-ignore-deadlines t)
                     (org-agenda-todo-ignore-with-date t)
                     (org-agenda-sorting-strategy
                      '(category-up)))))) org-agenda-custom-commands)

(push '("b" "bullet"
        ((agenda ""
                 ((org-agenda-span '2)
                  (org-agenda-files (append (file-expand-wildcards "~/projects/orgmode/bullet/*.org")))
                  (org-agenda-start-day (org-today))))
         (tags-todo "-someday/"
                    ((org-agenda-overriding-header "Task Items")
                     (org-agenda-files (append (file-expand-wildcards "~/projects/orgmode/bullet/*.org")))
                     (org-agenda-todo-ignore-scheduled t)
                     (org-agenda-todo-ignore-deadlines t)
                     (org-agenda-todo-ignore-with-date t)))
         (tags "note"
               ((org-agenda-overriding-header "Notes")
                (org-agenda-files (append (file-expand-wildcards "~/projects/orgmode/bullet/*.org"))))))) org-agenda-custom-commands)

(push '("g" "goals"
        ((tags-todo "Goal=\"prof-python\"/")
         (tags-todo "Goal=\"prof-datascience\"/"))) org-agenda-custom-commands)

(push '("i" "inbox"
        ((todo "REFILE"
               ((org-tags-match-list-sublevels nil)
                                        ;(org-agenda-skip-function 'nm/tasks-refile)
                (org-agenda-overriding-header "Ready to Refile"))))) org-agenda-custom-commands)

(setq org-capture-templates '(("c" " checklist")
                              ("g" " gtd")
                              ("b" " bullet journal")
                              ("n" " notes")
                              ("r" " resources")
                              ("p" " projects")))

(push '("pt" " project task" entry (function nm/find-project-file) "* REFILE %^{task} %^g") org-capture-templates)
(push '("pf" " new timeframe" entry (function nm/capture-project-timeframes) "%?") org-capture-templates)

(push '("cs" " simple checklist" checkitem (file+olp "~/projects/orgmode/gtd/tasks.org" "Checklists") "- [ ] %?") org-capture-templates)
(push '("cd" " checklist [date]" checkitem (file+function "~/projects/orgmode/gtd/tasks.org" nm/org-capture-to-task-file) "- [ ] %?") org-capture-templates)

(push '("gs" " simple task" entry (file+olp "~/projects/orgmode/gtd/tasks.org" "Inbox") "* REFILE %^{task} %^g\n:PROPERTIES:\n:CREATED: %U\n:END:\n") org-capture-templates)
(push '("gk" " task [kill-ring]" entry (file+olp "~/projects/orgmode/gtd/tasks.org" "Inbox") "* REFILE %^{task} %^g\n:PROPERTIES:\n:CREATED: %U\n:END:\n%c") org-capture-templates)
(push '("gg" " task with goal" entry (file+olp "~/projects/orgmode/gtd/tasks.org" "Inbox") "* REFILE %^{task}%^{GOAL}p %^g\n:PROPERTIES:\n:CREATED: %U\n:END:\n") org-capture-templates)

(push '("bt" " bullet task" entry (file+function "~/projects/orgmode/gtd/bullet.org" nm/capture-bullet-journal) "* REFILE %^{task} %^g\n:PROPERTIES:\n:CREATED: %U\n:END:\n" :empty-lines-before 1 :empty-lines-after 1) org-capture-templates)

(push '("nj" " journal" entry (function nm/capture-to-journal) "* %^{entry}\n:PROPERTIES:\n:CREATED: %U\n:END:\n%?") org-capture-templates)
(push '("na" " append" plain (function nm/org-capture-log) " *Note added:* [%<%Y-%m-%d %a %H:%M>]\n%?" :empty-lines-before 1 :empty-lines-after 1) org-capture-templates)
(push '("nn" " new note" plain (function nm/create-notes-file) "%?" :unnarrowed t :empty-lines-before 1 :empty-lines-after 1) org-capture-templates)

(push '("rr" " research literature" entry (file+function "~/projects/orgmode/gtd/websources.org" nm/enter-headline-websources) "* READ %(get-page-title (current-kill 0))") org-capture-templates)
(push '("rf" " rss feed" entry (file+function "~/projects/orgmode/elfeed.org" nm/return-headline-in-file) "* %^{link}") org-capture-templates)

(defun nm/find-project-file ()
  "Find and open project file."
  (nm/find-file-or-create "~/projects/orgmode/gtd/projects/"))

(defun nm/return-headline-in-file ()
  "Returns the headline position."
  (let* ((org-agenda-files "~/projects/orgmode/elfeed.org")
        (location (nth 3 (org-refile-get-location nil nil 'confirm))))
    (goto-char location)
    (org-end-of-line)))

(defun nm/enter-headline-websources ()
  "This is a simple function for the purposes when using org-capture to add my entries to a custom Headline, and if URL is not in clipboard it'll return an error and cancel the capture process."
  (let* ((file "~/projects/orgmode/gtd/websources.org")
         (headline (read-string "Headline? ")))
    (progn
      (nm/check-headline-exist file headline)
      (goto-char (point-min))
      (re-search-forward (format "^\*+\s%s" (upcase headline))))))

(defun nm/check-headline-exist (file-arg headline-arg)
  "This function will check if HEADLINE-ARG exists in FILE-ARG, and if not it creates the headline."
  (save-excursion (find-file file-arg) (goto-char (point-min))
                  (unless (re-search-forward (format "* %s" (upcase headline-arg)) nil t)
                    (goto-char (point-max)) (insert (format "* %s" (upcase headline-arg))) (org-set-property "CATEGORY" (downcase headline-arg)))) t)

(after! org (setq org-clock-continuously t)) ; Will fill in gaps between the last and current clocked-in task.

(setq org-tags-column 0)

(setq org-tag-alist '(("@home")
                      ("@computer")
                      ("@email")
                      ("@call")
                      ("@brainstorm")
                      ("@write")
                      ("@read")
                      ("@code")
                      ("@research")
                      ("@purchase")
                      ("@payment")
                      ("@place")))

(push '("delegated") org-tag-alist)
(push '("waiting") org-tag-alist)
(push '("someday") org-tag-alist)
(push '("remember") org-tag-alist)

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

(custom-declare-face '+org-todo-next '((t (:inherit (bold font-lock-constant-face org-todo)))) "")
(custom-declare-face '+org-todo-project '((t (:inherit (bold font-lock-doc-face org-todo)))) "")
(custom-declare-face '+org-todo-onhold  '((t (:inherit (bold warning org-todo)))) "")
(custom-declare-face '+org-todo-next '((t (:inherit (bold font-lock-keyword-face org-todo)))) "")
(custom-declare-face 'org-checkbox-statistics-todo '((t (:inherit (bold font-lock-constant-face org-todo)))) "")

  (setq org-todo-keywords
        '((sequence
           "TODO(t)"  ; A task that needs doing & is ready to do.
           "READ(R)" ; Task item that needs to be read.
           "NEXT(n)" ; Task items that are ready to be worked.
           "REFILE(r)" ; Signifies a new task that needs to be categorized and bucketed.
           "PROJ(p)"  ; Project with multiple task items.
           "WAIT(w)"  ; Something external is holding up this task.
           "|"
           "DONE(d)"  ; Task successfully completed.
           "KILL(k)")) ; Task was cancelled, aborted or is no longer applicable.
        org-todo-keyword-faces
        '(("WAIT" . +org-todo-onhold)
          ("NEXT" . +org-todo-next)
          ("READ" . +org-todo-active)
          ("REFILE" . +org-todo-onhold)
          ("PROJ" . +org-todo-project)
          ("TODO" . +org-todo-active)))

(after! org (setq org-agenda-diary-file "~/projects/orgmode/diary.org"
                  org-agenda-dim-blocked-tasks t ; grays out task items that are blocked by another task (EG: Projects with subtasks)
                  org-agenda-use-time-grid nil
                  org-agenda-tags-column 0
;                  org-agenda-hide-tags-regexp "\\w+" ; Hides tags in agenda-view
                  org-agenda-compact-blocks nil
                  org-agenda-block-separator " "
                  org-agenda-skip-scheduled-if-done t
                  org-agenda-skip-deadline-if-done t
                  org-agenda-window-setup 'current-window
                  org-enforce-todo-checkbox-dependencies nil ; This has funny behavior, when t and you try changing a value on the parent task, it can lead to Emacs freezing up. TODO See if we can fix the freezing behavior when making changes in org-agenda-mode.
                  org-enforce-todo-dependencies t
                  org-habit-show-habits t))

(after! org (setq org-agenda-files (append (file-expand-wildcards "~/projects/orgmode/gtd/*.org") (file-expand-wildcards "~/projects/orgmode/gtd/*/*.org"))))

(after! org (setq org-log-into-drawer t
                  org-log-done 'time
                  org-log-repeat 'time
                  org-log-redeadline 'note
                  org-log-reschedule 'note))

(after! org (setq org-hide-emphasis-markers t
                  org-hide-leading-stars t
                  org-list-demote-modify-bullet '(("+" . "-") ("1." . "a.") ("-" . "+"))))

(when (require 'org-superstar nil 'noerror)
  (setq org-superstar-headline-bullets-list '("#")
        org-superstar-item-bullet-alist nil))

(when (require 'org-fancy-priorities nil 'noerror)
  (setq org-fancy-priorities-list '("⚑" "❗" "⬆")))

(after! org (setq org-use-property-inheritance t))

(after! org (setq org-publish-project-alist
                  '(("attachments"
                     :base-directory "~/projects/orgmode/"
                     :recursive t
                     :base-extension "jpg\\|jpeg\\|png\\|pdf\\|css"
                     :publishing-directory "~/publish_html"
                     :publishing-function org-publish-attachment)
                    ("Markdown-to-Orgmode"
                     :base-directory "~/projects/notes/"
                     :publishing-directory "~/projects/notes-md-to-org/"
                     :base-extension "md"
                     :recursive t
                     :publishing-function org-md-publish-to-org)
                    ("notes"
                     :base-directory "~/projects/orgmode/notes/"
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
                    ("myprojectweb" :components("attachments" "notes" "ROAM")))))

(after! org
  (set-company-backend! 'org-mode '(company-yasnippet company-elisp))
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
  (setq deft-directory "~/projects/orgmode/"
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
  (setq rmh-elfeed-org-files (list "~/projects/orgmode/elfeed.org")))
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

(after! org (setq org-journal-dir "~/projects/orgmode/gtd/journal/"
                  org-journal-enable-agenda-integration t
                  org-journal-file-type 'monthly
                  org-journal-carryover-items "TODO=\"TODO\"|TODO=\"NEXT\"|TODO=\"PROJ\"|TODO=\"STRT\"|TODO=\"WAIT\"|TODO=\"HOLD\""))

(setq org-pandoc-options '((standalone . t) (self-contained . t)))

(require 'ox-reveal)
(setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
(setq org-reveal-title-slide nil)

(setq org-roam-tag-sources '(prop last-directory))
(setq org-roam-db-location "~/projects/orgmode/roam.db")
(setq org-roam-directory "~/projects/orgmode/")
(setq org-roam-buffer-position 'right)
(setq org-roam-completion-everywhere t)

(setq org-roam-dailies-capture-templates
      '(("d" "daily" plain (function org-roam-capture--get-point) ""
         :immediate-finish t
         :file-name "journal/%<%Y-%m-%d-%a>"
         :head "#+TITLE: %<%Y-%m-%d %a>\n#+STARTUP: content\n\n")))

(setq org-roam-capture-templates
      '(("l" "literature" plain (function org-roam-capture--get-point)
         :file-name "literature/%<%Y%m%d%H%M>-${slug}"
         :head "#+title: ${title}\n#+author: %(concat user-full-name)\n#+email: %(concat user-mail-address)\n#+created: %(format-time-string \"[%Y-%m-%d %H:%M]\")\n#+roam_tags: %^{roam_tags}\n\nsource: \n\n%?"
         :unnarrowed t)
        ("f" "fleeting" plain (function org-roam-capture--get-point)
         :file-name "fleeting/%<%Y%m%d%H%M>-${slug}"
         :head "#+title: ${title}\n#+author: %(concat user-full-name)\n#+email: %(concat user-mail-address)\n#+created: %(format-time-string \"[%Y-%m-%d %H:%M]\")\n\n%?"
         :unnarrowed t)
        ("p" "permanent in nested folder" plain (function org-roam-capture--get-point)
         :file-name "%(read-string \"string: \")/%<%Y%m%d%H%M>-${slug}"
         :head "#+title: ${title}\n#+author: %(concat user-full-name)\n#+email: %(concat user-mail-address)\n#+created: %(format-time-string \"[%Y-%m-%d %H:%M]\")\n#+roam_tags: %(read-string \"tags: \")\n\n"
         :unnarrowed t
         "%?")))

(push '("x" "Projects" plain (function org-roam-capture--get-point)
        :file-name "gtd/projects/%<%Y%m%d%H%M>-${slug}"
        :head "#+title: ${title}\n#+roam_tags: %^{tags}\n\n%?"
        :unnarrowed t) org-roam-capture-templates)

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

(load! "org-helpers.el")

(defun nm/convert-filename-format (&optional time-p folder-path)
  "Prompts user for filename and directory, and returns the value in a cleaned up format.
   If TIME-P is t, then includes date+time stamp in filename, FOLDER-PATH is the folder
   location to search for files.
"
  (let* ((file (replace-in-string " " "-" (downcase (read-file-name "select file: " (if folder-path (concat folder-path) org-directory))))))
    (if (file-exists-p file)
        (concat file)
      (if (s-ends-with? ".org" file)
          (concat (format "%s%s" (file-name-directory file) (if time-p (concat (format-time-string "%Y%m%d%H%M%S-") (file-name-nondirectory (downcase file)))
                                                              (concat (file-name-nondirectory (downcase file))))))
        (concat (format "%s%s.org" (file-name-directory file) (if time-p (concat (format-time-string "%Y%m%d%H%M%S-") (file-name-nondirectory (downcase
                                                                                                                                               file)))
                                                                (concat (file-name-nondirectory (downcase file))))))))))

(defun nm/find-file-or-create (time-p &optional type)
  "Creates a new file, if TYPE is set to NOTE then also insert file-template."
  (interactive)
  (let* ((file (nm/convert-filename-format time-p)))
    (if (file-exists-p file)
        (find-file file)
      (when (equal "note" type) (find-file file)
            (insert (format "%s\n%s\n%s\n\n"
                            (downcase (format "#+title: %s" (replace-in-string "-" " " (replace-regexp-in-string "[0-9]+-" "" (replace-in-string ".org" "" (file-name-nondirectory file))))))
                            (downcase (concat "#+author: " user-full-name))
                            (downcase (concat "#+email: " user-mail-address)))))
      (when (equal nil type) (find-file)))))

(defun nm/create-notes-file ()
  "Function for creating a notes file under org-capture-templates."
  (nm/find-file-or-create t "note"))

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

(defun nm/emacs-change-font ()
  "Change font based on available font list."
  (interactive)
  (let ((font (ivy-completing-read "font: " nm/font-family-list))
        (size (ivy-completing-read "size: " '("16" "18" "20" "22" "24" "26" "28" "30")))
        (weight (ivy-completing-read "weight: " '(normal light bold extra-light ultra-light semi-light extra-bold ultra-bold)))
        (width (ivy-completing-read "width: " '(normal condensed expanded ultra-condensed extra-condensed semi-condensed semi-expanded extra-expanded ultra-expanded))))
    (setq doom-font (font-spec :family font :size (string-to-number size) :weight (intern weight) :width (intern width))
          doom-big-font (font-spec :family font :size (+ 2 (string-to-number size)) :weight (intern weight) :width (intern width))))
  (doom/reload-font))

(defvar nm/font-family-list '("JetBrains Mono" "Roboto Mono" "VictorMono Nerd Font Mono" "Fira Code" "Hack" "Input Mono" "Anonymous Pro" "Cousine" "PT Mono" "DejaVu Sans Mono" "Victor Mono" "Liberation Mono"))

(let ((secrets (expand-file-name "secrets.el" doom-private-dir)))
  (when (file-exists-p secrets)
    (load secrets)))
