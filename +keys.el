;;; c:/Users/nmart/.doom.d/+keys.el -*- lexical-binding: t; -*-

(map! :leader
      :n "e" #'ace-window
      :n "!" #'swiper
      :n "@" #'swiper-all
      :n "X" #'helm-org-capture-templates
      (:prefix "o"
        :n "e" #'elfeed
        :n "u" #'elfeed-update
        (:prefix "n"
          :n "w" #'deft
          :n "n" #'plain-org-wiki
          :n "g" #'plain-org-gtd))
      (:prefix "f"
        :n "w" #'deft
        :n "g" #'plain-org-gtd
        :n "n" #'plain-org-wiki
        :n "d" #'org-journal-new-entry)
      (:prefix "b"
        :n "c" #'org-board-new
        :n "e" #'org-board-open)
      (:prefix "t"
        :n "s" #'org-narrow-to-subtree
        :n "w" #'widen)
      (:prefix "/"
        :n "j" #'org-journal-search))
