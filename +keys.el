;;; c:/Users/nmart/.doom.d/+keys.el -*- lexical-binding: t; -*-

(map! :leader
      :n "e" #'ace-window
      :n "@" #'swiper-all
      (:prefix "o"
        :n "e" #'elfeed
        :n "u" #'elfeed-update
        :n "n" #'deft
        :n "w" #'plain-org-wiki
        :n "g" #'plain-org-gtd)
      (:prefix "f"
        :n "n" #'deft-new-file-named)
      (:prefix "b"
        :n "c" #'org-board-new
        :n "e" #'org-board-open))
