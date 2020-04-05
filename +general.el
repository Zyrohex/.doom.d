;;; ~/.doom.d/+general.el -*- lexical-binding: t; -*-

(global-auto-revert-mode t) ;; nil = do not revert on file change / t = revert buffer when file changes are made

(setq user-full-name "Nicholas Martin"
      user-mail-address "nmartin84.com")

(setq doom-font (font-spec :family "InputMono" :size 18)
      doom-variable-pitch-font (font-spec :family "InputMono" :height 120)
      doom-unicode-font (font-spec :family "InputMono")
      doom-big-font (font-spec :family "InputMono" :size 24))
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(setq doom-modeline-gnus t
      doom-modeline-gnus-timer 'nil)

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
