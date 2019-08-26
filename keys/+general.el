;;; ~/.doom.d/keys/+general.el -*- lexical-binding: t; -*-

(map! :leader :nv "g" nil)

(map! :leader
      :nv "a" nil
      (:prefix ("a" . "org-mode")
        :n "i" #'org-clock-in
        :n "o" #'org-clock-out
        :n "s" #'org-clock-switch-task
        :n "h" #'org-toggle-heading
        :n "-" #'org-toggle-item
        (:prefix ("g" . "GTD")
          :n "c" #'helm-org-capture-templates
          :n "b" #'org-brain-visualize
          :n "a" #'org-agenda
          :n "n" #'deft-new-file-named
          :n "d" #'deft)))
