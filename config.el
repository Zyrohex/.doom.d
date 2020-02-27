(setq user-full-name "Yu Shen (Aaron)"
      user-mail-address "yubrshen@gmail.com")

(use-package! dart-mode
  :mode "\\.dart\\'")

(setq
      org-agenda-diary-file "~/Dropbox/org/diary.org"
      diary-file            "~/Dropbox/org/diary.org"
      org-agenda-use-time-grid nil
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-habit-show-habits t
       my/inbox "~/Dropbox/org/inbox.org"
       my/project "~/Dropbox/org/tasks.org"
       my/someday "~/Dropbox/org/someday.org"
       my/birthdays "~/Dropbox/org/birthdays.org"
       org-agenda-files (list my/project my/inbox)
      )

(after! org (setq org-capture-templates
      '(("g" "Getting things done")
        ("r" "References")
        ("d" "Diary")
        ("p" "Graph Data")
        ("t" "Data Tracker"))))

(after! org (add-to-list 'org-capture-templates
             '("gx" "Recurring Task" entry (file "~/Dropbox/org/recurring.org")
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
             '("gp" "Project" entry (file+headline"~/Dropbox/org/tasks.org" "Projects")
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
             '("gt" "Task" entry (file"~/Dropbox/org/inbox.org")
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
             '("re" "Yank new Example" entry(file+headline"~/Dropbox/org/notes/examples.org" "INBOX")
"* %^{example}
:PROPERTIES:
:SOURCE:  %^{source|Command|Script|Code|Usage}
:SUBJECT: %^{subject}
:END:

\#+BEGIN_SRC
%x
\#+END_SRC
%?")))

(after! org (add-to-list 'org-capture-templates
             '("rn" "Yank new Example" entry(file+headline"~/Dropbox/org/notes/references.org" "INBOX")
"* %^{example}
:PROPERTIES:
:CATEGORY: %^{category}
:SUBJECT:  %^{subject}
:END:
:RESOURCES:
:END:

%?")))

(after! org (add-to-list 'org-capture-templates
             '("dn" "New Diary Entry" entry(file+olp+datetree"~/Dropbox/org/diary.org" "Dailies")
"* %^{example}
:PROPERTIES:
:CATEGORY: %^{category}
:SUBJECT:  %^{subject}
:MOOD:     %^{mood}
:END:
:RESOURCES:
:END:

\*What was one good thing you learned today?*:
- %^{whatilearnedtoday}

\*List one thing you could have done better*:
- %^{onethingdobetter}

\*Describe in your own words how your day was*:
- %?")))

(setq org-directory "~/Dropbox/org/"
      org-image-actual-width nil
      +org-export-directory "~/.export/"
      org-archive-location "~/Dropbox/org/archive.org::datetree/"
      org-default-notes-file "~/Dropbox/org/inbox.org"
      projectile-project-search-path '("~/")

      )

(after! ox-latex
  (add-to-list 'org-latex-classes
               '("tufte-handout"
                 "\\documentclass[twoside,nobib]{tufte-handout}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")))
  (add-to-list 'org-latex-classes
               '("tufte-book"
                 "\\documentclass[twoside,nobib]{tufte-book}
                                  [NO-DEFAULT-PACKAGES]"
                 ("\\part{%s}" . "\\part*{%s}")
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}"))))

(after! ox-latex
  (setq org-latex-pdf-process '("xelatex \\\\nonstopmode\\\\input %f")))

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
        ("STARTED" :foreground "DodgerBlue" :weight bold)
        ("DELEGATED" :foreground "Gold" :weight bold)
        ("NEXT" :foreground "violet red" :weight bold)
        ("DONE" :foreground "slategrey" :weight bold))))

(after! org (setq org-todo-keywords
      '((sequence "TODO(t)" "WAITING(w!)" "STARTED(s!)" "NEXT(n!)" "DELEGATED(d!)" "|" "INVALID(I!)" "DONE(d!)" "HOLD(h)" "PNEDING(p)" "CANCELED(c)"))))

(after! plantuml-mode
  (setq plantuml-default-exec-mode 'jar
        plantuml-jar-path (expand-file-name "~/bin/plantuml.jar")))

(use-package ob-plantuml
  :ensure nil
  :commands
  (org-babel-execute:plantuml)
  )

(setq org-log-state-notes-insert-after-drawers nil
      org-log-into-drawer t
      org-log-done 'time
      org-log-repeat 'time
      org-log-redeadline 'note
      org-log-reschedule 'note)

(setq org-refile-targets '((org-agenda-files . (:maxlevel . 6)))
      org-hide-emphasis-markers nil
      org-outline-path-complete-in-steps nil
      org-refile-allow-creating-parent-nodes 'confirm)

(setq spacemacs-theme-org-agenda-height nil
      org-agenda-time-grid '((daily today require-timed) "----------------------" nil)
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-include-diary nil ; t
      org-agenda-block-separator t ;nil
      org-agenda-compact-blocks t ; must be t to have the TODO'S and NEXT's
      org-agenda-start-with-log-mode nil; with org-agenda-start-with-log-mode being t, all the DONE tasks will be shownt
      org-agenda-prefix-format '((todo . "%-10b") (tags . "%-10b") (agenda . "%-10b")))

(setq org-agenda-custom-commands
      '(("z" "Super zaen view"
         ((agenda "" ((org-agenda-span 3) ; 'day would not work, it only show the Saturday of last week
                              (org-agenda-start-day "-1d")
                      (org-super-agenda-groups
                       '((:name "Today"
                                :time-grid t
                                :date today
                                :todo "TODAY"
                                :scheduled today
                                :order 1)))))
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '((:name "Next to do"
                                 :todo "NEXT"
                                 :order 1)
                          (:name "Important"
                                 :tag "Important"
                                 :priority "A"
                                 :order 6)
                          (:name "Due Today"
                                 :deadline today
                                 :order 2)
                          (:name "Due Soon"
                                 :deadline future
                                 :order 8)
                          (:name "Overdue"
                                 :deadline past
                                 :order 7)
                          (:name "Assignments"
                                 :tag "Assignment"
                                 :order 10)
                          (:name "Issues"
                                 :tag "Issue"
                                 :order 12)
                          (:name "Projects"
                                 :tag "Project"
                                 :order 14)
                          (:name "Emacs"
                                 :tag "Emacs"
                                 :order 13)
                          (:name "Research"
                                 :tag "Research"
                                 :order 15)
                          (:name "To read"
                                 :tag "Read"
                                 :order 30)
                          (:name "Waiting"
                                 :todo "WAITING"
                                 :order 20)
                          (:name "trivial"
                                 :priority<= "C"
                                 :tag ("Trivial" "Unimportant")
                                 :todo ("SOMEDAY" )
                                 :order 90)
                          (:discard (:tag ("Chore" "Routine" "Daily")))))))))
   ("g" "My General Agenda"
    (
     (agenda ""
             (;; (org-agenda-files (list my/inbox my/project my/birthdays))
              (org-agenda-span 3) ; 'day would not work, it only show the Saturday of last week
              (org-agenda-start-day "-1d"))) ; day dose not work
     (tags "@heavy-@home+TODO=\"NEXT\""
           ((org-agenda-overriding-header "NEXT @heavy")
            (org-agenda-sorting-strategy '(priority-down))
            (org-agenda-skip-function
             '(or
               (my/org-skip-inode-and-root)
               (org-agenda-skip-entry-if 'scheduled)))))
     (tags "-@heavy-@home+TODO=\"NEXT\""
           ((org-agenda-overriding-header "NEXT non-heavy")
            (org-agenda-sorting-strategy '(priority-down))
            (org-agenda-skip-function
             '(or
               (my/org-skip-inode-and-root)
               (org-agenda-skip-entry-if 'scheduled)))))
     (tags "@heavy-@home+TODO=\"TODO\""
           ((org-agenda-overriding-header "@heavy")
            (org-agenda-sorting-strategy '(priority-down))
            (org-agenda-skip-function
             '(or
               (my/org-skip-inode-and-root)
               (org-agenda-skip-entry-if 'scheduled)))))
     (tags "-@heavy-@home+TODO=\"TODO\""
           ((org-agenda-overriding-header "non-heavy")
            (org-agenda-sorting-strategy '(priority-down))
            (org-agenda-skip-function
             '(or
               (my/org-skip-inode-and-root)
               (org-agenda-skip-entry-if 'scheduled)))))
     (tags "@home+@heavy+TODO=\"NEXT\""
           ((org-agenda-overriding-header "NEXT @heavy@home")
            (org-agenda-sorting-strategy '(priority-down))
            (org-agenda-skip-function
             '(or
               (my/org-skip-inode-and-root)
               (org-agenda-skip-entry-if 'scheduled)))))
     (tags "@home-@heavy+TODO=\"NEXT\""
           ((org-agenda-overriding-header "NEXT @home")
            (org-agenda-sorting-strategy '(priority-down))
            (org-agenda-skip-function
             '(or
               (my/org-skip-inode-and-root)
               (org-agenda-skip-entry-if 'scheduled)))))
     (tags "@home+@heavy+TODO=\"TODO\""
           ((org-agenda-overriding-header "@heavy@home")
            (org-agenda-sorting-strategy '(priority-down))
            (org-agenda-skip-function
             '(or
               (my/org-skip-inode-and-root)
               (org-agenda-skip-entry-if 'scheduled)))))
     (tags "@home-@heavy+TODO=\"TODO\""
           ((org-agenda-overriding-header "@home")
            (org-agenda-sorting-strategy '(priority-down))
            (org-agenda-skip-function
             '(or
               (my/org-skip-inode-and-root)
               (org-agenda-skip-entry-if 'scheduled)))))

     (tags "TODO={.*}"
           ((org-agenda-files (list my/inbox))
            (org-agenda-overriding-header "Inbox")
            (org-tags-match-list-sublevels nil)
            (org-agenda-sorting-strategy '(priority-down))))
     (todo "WAITING"
           ((org-agenda-overriding-header "Waiting")
            (org-agenda-sorting-strategy '(priority-down))))
     (tags "-{^@.*}+TODO={NEXT\\|TODO}"
           (
            (org-agenda-overriding-header "Tasks Without Context")
            (org-agenda-skip-function #'my/org-skip-inode-and-root)
            (org-agenda-sorting-strategy
             '(todo-state-down priority-down))))
     (tags "TODO=\"TODO\"+@office"
           ((org-agenda-overriding-header "Active Work Projects")
            (org-agenda-sorting-strategy '(priority-down))
            (org-tags-match-list-sublevels nil)
            (org-agenda-skip-function
             '(or
               (my/org-skip-leaves)
               (org-agenda-skip-subtree-if 'nottodo '("NEXT"))))))
     (tags "TODO=\"TODO\"+@office"
           ((org-agenda-overriding-header "Stuck Work Projects")
            (org-agenda-sorting-strategy '(priority-down))
            (org-tags-match-list-sublevels nil)
            (org-agenda-skip-function
             '(or
               (my/org-skip-leaves)
               (org-agenda-skip-subtree-if 'todo '("NEXT"))))))
     (tags "TODO=\"TODO\"-@office"
           ((org-agenda-overriding-header "Active Projects")
            (org-agenda-sorting-strategy '(priority-down))
            (org-tags-match-list-sublevels nil)
            (org-agenda-skip-function
             '(or
               (my/org-skip-leaves)
               (org-agenda-skip-subtree-if 'nottodo '("NEXT"))))))
     (tags "TODO=\"TODO\"-@office"
           ((org-agenda-overriding-header "Stuck Projects")
            (org-agenda-sorting-strategy '(priority-down))
            (org-tags-match-list-sublevels nil)
            (org-agenda-skip-function
             '(or
               (my/org-skip-leaves)
               (org-agenda-skip-subtree-if 'todo '("NEXT"))))))
     (tags "@read_watch_listen+TODO=\"NEXT\""
           ((org-agenda-overriding-header "NEXT @read/watch/listen")
            (org-agenda-sorting-strategy '(priority-down effort-up))
            (org-agenda-skip-function
             '(or
               (my/org-skip-inode-and-root)
               (org-agenda-skip-entry-if 'scheduled)))))
     (tags "@read_watch_listen+TODO=\"TODO\""
           ((org-agenda-overriding-header "@read/watch/listen")
            (org-agenda-sorting-strategy '(priority-down effort-up))
            (org-agenda-skip-function
             '(or
               (my/org-skip-inode-and-root)
               (org-agenda-skip-entry-if 'scheduled)))))
     ))
        ))

(defun my/org-skip-inode-and-root ()
  "
Retrun the position of the next child heading, if
a. there is any child
b. the first child's heading containts keyword
otherwise, return nil
"
  (when                                 ; when first child found and go to that
    (save-excursion
      (org-goto-first-child))
    (let ((eos (save-excursion          ; eos: end of the subtree or the end of the buffer
                 (or (org-end-of-subtree t)
                   (point-max))))
           (nh (save-excursion          ; nh: the position of the next heading or the end the buffer
                 (or (outline-next-heading)
                   (point-max))))
           (ks org-todo-keywords-1)     ; ks: all TODO and DONE keywords in the buffer
           mat)                         ; mat intialized to nil
      (save-excursion
        (org-goto-first-child)
        (while (and ks (not mat))       ; while there is still keywords, and mat is nil; that is to search one of the keywords
          (setq mat
            (re-search-forward (concat "\\*\\W+"
                                 (car ks)
                                 "\\W*")
              eos t))
          (setq ks (cdr ks))))
      (when mat                          ; when a keyword is found, return the position of the next heading
        nh))))

;;; my/org-skip-leaves
(defun my/org-skip-leaves ()
  "Returns the end of the subtree, if
a. there is no child, or
b. the first child has no keyword;
otherwise, return nil"
  (let ((eos (save-excursion            ; eos: end of the subtree or the end of the buffer
               (or (org-end-of-subtree t)
                 (point-max)))))
    (if (not (save-excursion
               (org-goto-first-child)))
      eos                               ; if there is no child (leave), returns the end of the current subtree
      (let ((ks org-todo-keywords-1)
             mat)                       ; mat initialized to nil
        (save-excursion
          (org-goto-first-child)
          (while (and ks (not mat))     ; while there is still keywords to search and there is none found
            (setq mat
              (re-search-forward (concat "\\*\\W+"
                                   (car ks)
                                   "\\W*")
                eos t))
            (setq ks (cdr ks))))
        (when (not mat)                 ; if no keyword found at the first child, returns the end of the subtree
          eos)))))                      ; otherwise returns nil

;;; my/org-skip-non-root-task-subtree
(defun my/org-skip-non-root-task-subtree ()
  "Returns the end of the current subtree if it's contained in a TODO task"
  (let ((eos (save-excursion
               (or (org-end-of-subtree t)
                 (point-max))))
         nonroot)                       ; nonroot initialized to nil
    (save-excursion
      (org-save-outline-visibility nil
        (org-reveal)
        (while (and (not nonroot) (org-up-heading-safe)) ; go to the parennt until a todo taks is found
          (setq nonroot (org-entry-get (point) "TODO")))))
    (when nonroot                       ; return the end of the current subtree if it's contained in a TODO task
      eos)))

;;; my/disallow-todo-state-for-projects
(defun my/disallow-todo-state-for-projects ()
  "Reset the heading to be TODO, if it is not one of TODO, DONE or CANCELLED"
  (when (my/org-skip-inode-and-root)
    (let ((ts (org-get-todo-state)))    ; ts: the TODO keyword of the current subtree
      (when (not (or (equal ts "TODO")
                   (equal ts "DONE")
                   (equal ts "CANCELLED")))
        (org-set-property "TODO" "TODO")))))

 (add-hook 'org-after-todo-state-change-hook 'my/disallow-todo-state-for-projects)

;;; my/repeated-task-template
(defun my/repeated-task-template ()
  "Capture template for repeated tasks."
  (concat "* NEXT %?\n"
          "  SCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d>>\")\n"
          "  :PROPERTIES:\n"
          "  :REPEAT_TO_STATE: NEXT\n"
          "  :RESET_CHECK_BOXES: t\n  :END:\n  %U\n  %a"))
