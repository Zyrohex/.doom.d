;;; private/rschmukler/+bindings.el -*- lexical-binding: t; -*-

;; Configuring my keyboard mappings
(map! :m "M-j" #'multi-next-line

      ;; Window Manipulation
      :n "C-h" #'evil-window-left
      :n "C-j" #'evil-window-down
      :n "C-k" #'evil-window-up
      :n "C-l" #'evil-window-right

      ;; Testing
      :n "SPC / d" #'deadgrep
      :m "C-s l" #'+lookup/online-select
      :m "C-s i" #'counsel-imenu
      :m "C-s t" #'org-todo
      :n "SPC o v" #'org-brain-visualize
      :n "SPC e" #'org-capture
      :n "SPC ," #'+ivy/projectile-find-file
      :n "SPC @" #'counsel-org-goto-all

      ;; Markdown Editing
      :m "w" #'markdown-cycle)
