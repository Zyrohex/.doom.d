;;; c:/Users/nmart/.doom.d/+keys.el -*- lexical-binding: t; -*-

(map! :leader
      :n "e" #'ace-window
      :n "@" #'swiper-all
      (:prefix "o"
        :n "e" #'elfeed
        :n "u" #'elfeed-update
        :n "n" #'deft
        :n "w" #'plain-org-wiki
        :n "b" #'org-brain-visualize)
      (:prefix "f"
        :n "n" #'deft-new-file-named
        :n "w" #'plain-org-wiki)
      (:prefix "b"
        :n "c" #'org-board-new
        :n "e" #'org-board-open))
