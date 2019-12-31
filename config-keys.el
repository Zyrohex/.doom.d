;;; c:/Users/nmart/.doom.d/+keys.el -*- lexical-binding: t; -*-

(map!
 :nvime "<f5> d" #'helm-org-rifle-directories
 :nvime "<f5> b" #'helm-org-rifle-current-buffer
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
        :n "o" #'org-open-at-point
        :n "u" #'elfeed-update
        :n "w" #'deft)
      (:prefix "n"
        :n "D" #'dictionary-lookup-definition
        :n "T" #'powerthesaurus-lookup-word)
      (:prefix "s"
        :n "d" #'deadgrep
        :n "b" #'helm-org-rifle-current-buffer
        :n "." #'helm-org-rifle-directories)
      (:prefix "b"
        :n "c" #'org-board-new
        :n "e" #'org-board-open)
      (:prefix "t"
        :n "s" #'org-narrow-to-subtree
        :n "w" #'widen)
      (:prefix "/"
        :n "j" #'org-journal-search))
