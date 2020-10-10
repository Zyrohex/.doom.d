(setq user-full-name "Yu Shen (Aaron)"
      user-mail-address "yshen@bart.gov | yubrshen@gmail.com")

(setq-hook! '(shell-mode-hook eshell-mode-hook) company-idle-delay nil)

(setq org-agenda-files '("~/Dropbox/org/TODOs/tasks.org" "~/Dropbox/org/TODOs/projects.org"
                         "~/Dropbox/org/errors_orgmode_commits.org"))

(use-package! org-journal
  :after org
  :init
  (setq org-journal-dir "~/Dropbox/org/Daily/"
        org-journal-date-prefix "#+TITLE: "
        org-journal-file-format "%Y-%m-%d.org"
        org-journal-date-format "%A, %d %B %Y")
  :config
  (setq org-journal-find-file #'find-file-other-window )
  :bind
  ("C-c n j" . org-journal-new-entry)
  ("C-c n s" . evil-save-modified-and-close)
  :defer t
  )

(setq org-journal-enable-agenda-integration t)

(setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-start-day nil ;; i.e. today
      org-agenda-block-separator nil
      org-agenda-tags-column 100 ;; from testing this seems to be a good value
      org-agenda-compact-blocks t)

(setq org-agenda-custom-commands
      '(("z" "Zen View"
         ((agenda "" ((org-agenda-span 'day)
                      (org-super-agenda-groups
                       '((:name "Today "
                                :time-grid t
                                :date today
                                :todo "TODAY"
                                :scheduled today
                                :order 1)
                        ;; (:discard (:anything t))
                        ))))
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '((:name "Next"
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
                          (:name "Church"
                                 :tag "church"
                                 :order 32)
                          (:name "BART"
                                 :tag "bart"
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
                          ;; (:discard ;; (:tag ("Chore" "Routine" "Daily"))
                          ;;  (:anything t)
                          ;;  )
                          ))))
          ))))

(setq doom-font (font-spec :family "Iosevka Term SS04" :size 16) ; 24
      doom-big-font (font-spec :family "Iosevka Term SSO4" :size 36)
            ;; doom-variable-pitch-font (font-spec :family "ETBembo" :size 24)
            ;; doom-serif-font (font-spec :family "ETBembo" :size 24)
            )

(setq doom-theme 'doom-gruvbox-light)

(setq doom-modeline-modal-icon t)

(setq display-line-numbers-type `relative)

;(setq org-roam-directory "~/Dropbox/org/org-roam")
(after! org-roam
        (setq org-roam-ref-capture-templates
            '(("r" "ref" plain (function org-roam-capture--get-point)
               "%?"
               :file-name "websites/${slug}"
               :head "#+TITLE: ${title}
    #+ROAM_KEY: ${ref}
    - source :: ${ref}"
               :unnarrowed t))
            org-roam-db-location
            ;; set location for org-roam.db away from org-roam to avoid conflct due to Dropbox file synch
            "~/.emacs.d/.cache/org-roam.db"
            org-roam-directory "~/Dropbox/org/org-roam"
            )
        (map! :leader
            :prefix "n"
            :desc "org-roam" "l" #'org-roam
            :desc "org-roam-insert" "i" #'org-roam-insert
            :desc "org-roam-switch-to-buffer" "b" #'org-roam-switch-to-buffer
            :desc "org-roam-find-file" "f" #'org-roam-find-file
            :desc "org-roam-show-graph" "g" #'org-roam-show-graph
            :desc "org-roam-capture" "c" #'org-roam-capture))

(use-package! org-roam-server
  :after org-roam
  :defer t
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-export-inline-images t
        org-roam-server-authenticate nil
        org-roam-server-label-truncate t
        org-roam-server-label-truncate-length 60
        org-roam-server-label-wrap-length 20)
  (defun org-roam-server-open ()
    "Ensure the server is active, then open the roam graph."
    (interactive)
    (org-roam-server-mode 1)
    (server-start)                          ; start emacs server required for org-roam-server to provide click and open org file
    (browse-url-xdg-open (format "http://localhost:%d" org-roam-server-port))))

(after! org-roam
  (org-roam-server-mode))

(use-package! org-roam-protocol
  :after org-roam
  :defer t)

;; (use-package! org-roam
;;   :commands (org-roam-insert org-roam-find-file org-roam)
;;   :init
;;   (setq org-roam-directory "~/Dropbox/org/zettelkasten")
;;   (map! :leader
;;         :prefix "n"
;;         :desc "Org-Roam-Insert" "i" #'org-roam-insert
;;         :desc "Org-Roam-Find"   "/" #'org-roam-find-file
;;         :desc "Org-Roam-Buffer" "r" #'org-roam)
;;   :config
;;   (org-roam-mode +1)

;; (server-start)

(setq org-directory "~/Dropbox/org/"
      org-image-actual-width nil
      +org-export-directory "~/.export/"
      org-archive-location "~/Dropbox/org/archive.org::datetree/"
      org-default-notes-file "~/Dropbox/org/inbox.org"
      projectile-project-search-path '("~/")
      )

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
       ;org-agenda-files (list my/project my/inbox)
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

(use-package! zetteldeft
  :after deft
:init
(setq deft-directory "~/Dropbox/org"
      ; "~"                ; ~/ didn't work. I want to try be able to search all my org files my computer
      deft-recursive t)
(general-define-key
  :prefix "SPC"
  :non-normal-prefix "C-SPC"
  :states '(normal visual motion emacs)
  :keymaps 'override
  "d"  '(nil :wk "deft")
  "dd" '(deft :wk "deft")
  "dD" '(zetteldeft-deft-new-search :wk "new search")
  "dR" '(deft-refresh :wk "refresh")
  "ds" '(zetteldeft-search-at-point :wk "search at point")
  "dc" '(zetteldeft-search-current-id :wk "search current id")
  "df" '(zetteldeft-follow-link :wk "follow link")
  "dF" '(zetteldeft-avy-file-search-ace-window :wk "avy file other window")
  "dl" '(zetteldeft-avy-link-search :wk "avy link search")
  "dt" '(zetteldeft-avy-tag-search :wk "avy tag search")
  "dT" '(zetteldeft-tag-buffer :wk "tag list")
  "di" '(zetteldeft-find-file-id-insert :wk "insert id")
  "dI" '(zetteldeft-find-file-full-title-insert :wk "insert full title")
  "do" '(zetteldeft-find-file :wk "find file")
  "dn" '(zetteldeft-new-file :wk "new file")
  "dN" '(zetteldeft-new-file-and-link :wk "new file & link")
  "dr" '(zetteldeft-file-rename :wk "rename")
  "dx" '(zetteldeft-count-words :wk "count words"))
  )

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

;; (after! ox-latex
;;   (setq org-latex-pdf-process
;;             '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;               "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;               "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;               "xelatex -interaction nonstopmode -output-directory %o %f"
;;               "xelatex -interaction nonstopmode -output-directory %o %f"
;;               "xelatex -interaction nonstopmode -output-directory %o %f"
;;               ;;"rm -fr %b.out %b.log %b.tex auto"
;;               )))
(after! ox-latex
  (setq org-latex-pdf-process
            '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
              "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
              "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
              "xelatex -interaction nonstopmode -output-directory %o %f"
              "xelatex -interaction nonstopmode -output-directory %o %f"
              "xelatex -interaction nonstopmode -output-directory %o %f"
              ;"rm -fr %b.out %b.log %b.tex auto"
              )))

(after! org
  (setq org-babel-default-header-args:jupyter-python '((:async . "yes")
                                                       (:session . "py")
                                                       (:kernel . "python3"))))
(use-package! ox-ipynb
  :after ox)

(use-package conda
 :config (progn
           (conda-env-initialize-interactive-shells)
           (conda-env-initialize-eshell)
           (conda-env-autoactivate-mode t)
           (setq conda-env-home-directory (expand-file-name "~/.conda/"))
           (custom-set-variables '(conda-anaconda-home "/home/yubrshen/anaconda3/"))))

(use-package! org-re-reveal
  ;:custom
  ;(setq org-re-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js"
  ;;       org-reveal-title-slide nil
  ;      )
)

(after! org-re-reveal
  (setq org-re-reveal-width 1900        ; I like slide as wide as possible
        org-re-reveal-height 1200
        org-re-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js"
        org-reveal-title-slide nil
        )
  )

(after! org (setq org-todo-keyword-faces
      '(("TODO" :foreground "tomato" :weight bold)
        ("WAITING" :foreground "light sea green" :weight bold)
        ("STARTED" :foreground "DodgerBlue" :weight bold)
        ("DELEGATED" :foreground "Gold" :weight bold)
        ("NEXT" :foreground "violet red" :weight bold)
        ("DONE" :foreground "slategrey" :weight bold))))

(after! org (setq org-todo-keywords
      '((sequence "TODO(t)" "WAITING(w!)" "STARTED(s!)" "NEXT(n!)" "DELEGATED(D!)" "|" "INVALID(I!)" "DONE(d!)" "HOLD(h)" "PNEDING(p)" "CANCELED(c)"))))

(after! plantuml-mode
  (setq plantuml-default-exec-mode 'jar
        plantuml-jar-path (expand-file-name "~/bin/plantuml.jar")))

(use-package! ob-plantuml
  ;:ensure nil
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

(use-package! pyim
  :config
  (use-package! pyim-basedict
    :config
    (pyim-basedict-enable)
    )
  (setq default-input-method "pyim"
        pyim-default-scheme 'microsoft-shuangpin)

  ;; (setq-default pyim-english-input-switch-functions
  ;;               '(pyim-probe-dynamic-english
  ;;                 pyim-probe-isearch-mode
  ;;                 pyim-probe-program-mode
  ;;                 pyim-probe-org-structure-template))
  ;; (setq-default pyim-punctuation-half-width-functions
  ;;                '(pyim-probe-punctuation-line-beginning
  ;;                  pyim-probe-punctuation-after-punctuation))
  ;; 开启拼音搜索功能
  ;; (pyim-isearch-mode 1)

  ;; 使用 popup-el 来绘制选词框, 如果用 emacs26, 建议设置
  ;; 为 'posframe, 速度很快并且菜单不会变形，不过需要用户
  ;; 手动安装 posframe 包。
  (setq pyim-page-tooltip 'popup)

  ;; 选词框显示5个候选词
  (setq pyim-page-length 9)

  ;; The following keybingings are used in org-mode:
  ;; :bind
  ;; (("M-j" . pyim-convert-string-at-point) ;与 pyim-probe-dynamic-english 配合
  ;;  ("C-;" . pyim-delete-word-from-personal-buffer))
  )

;; {{ make IME compatible with evil-mode
(defun evil-toggle-input-method ()
  "when toggle on input method, goto evil-insert-state. "
  (interactive)

  ;; load IME when needed, less memory footprint
  ;; (unless (featurep 'chinese-pyim)
  ;;   (require 'chinese-pyim))

  (cond
   ((and (boundp 'evil-mode) evil-mode)
    ;; evil-mode
    (cond
     ((eq evil-state 'insert)
      (toggle-input-method))
     (t
      (evil-insert-state)
      (unless current-input-method
        (toggle-input-method))
      ))
    (if current-input-method (message "IME on!")))
   (t
    ;; NOT evil-mode, some guy don't use evil-mode at all
    (toggle-input-method))))

(defadvice evil-insert-state (around evil-insert-state-hack activate)
  ad-do-it
  (if current-input-method (message "IME on!")))

(global-set-key (kbd "C-\\") 'evil-toggle-input-method)
;; }}
