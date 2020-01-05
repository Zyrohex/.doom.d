;;; c:/Users/nmart/.doom.d/+keys.el -*- lexical-binding: t; -*-

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
        :n "b" #'helm-org-rifle-current-buffer
        :n "a" #'helm-org-rifle-org-directory
        :n "." #'helm-org-rifle-directories)
      (:prefix "b"
        :n "c" #'org-board-new
        :n "e" #'org-board-open)
      (:prefix "t"
        :n "s" #'org-narrow-to-subtree
        :n "w" #'widen)
      (:prefix "/"
        :n "j" #'org-journal-search))
