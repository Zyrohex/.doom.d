(defun zyro/adjust-font-on-display ()
  "Adjust font size to display"
  (if (equal (display-pixel-width) 5120)
      (setq doom-font (font-spec :family "Input Mono" :size 20)
            doom-big-font (font-spec :family "Input Mono" :size 24))
    (setq doom-font (font-spec :family "Input Mono" :size 16)
          doom-big-font (font-spec :family "Input Mono" :size 20))))
(when (equal (display-pixel-width) 3440)
  (setq doom-font (font-spec :family "Input Mono" :size 22)
        doom-big-font (font-spec :family "Input Mono" :size 26)))
;(zyro/adjust-font-on-display)

;(font-lock-add-keywords 'org-mode
;                        '(("^ *\\([-]\\) "
;                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "◈"))))))
;(font-lock-add-keywords 'org-mode
;                        '(("^ *\\([+]\\) "
;                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "⟡"))))))

(setq org-tags-column 0)
;(setq org-superstar-headline-bullets-list '("●" "○"))
(setq org-ellipsis "▼")

(setq user-full-name "Nicholas Martin"
      user-mail-address "nmartin84@gmail.com")

(setq diary-file "~/.org/diary.org")

(display-time-mode 1)
(setq display-time-day-and-date t)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(bind-key "<f5>" #'org-cycle-hide-all-drawers)
(bind-key "C-M-<up>" #'evil-window-up)
(bind-key "C-M-<down>" #'evil-window-down)
(bind-key "C-M-<left>" #'evil-window-left)
(bind-key "C-M-<right>" #'evil-window-right)
(map! :after org
      :map org-mode-map
      :leader
      :desc "Move up window" "<up>" #'evil-window-up
      :desc "Move down window" "<down>" #'evil-window-down
      :desc "Move left window" "<left>" #'evil-window-left
      :desc "Move right window" "<right>" #'evil-window-right
      :desc "Toggle Narrowing" "!" #'org-toggle-narrow-to-subtree
      :desc "Find and Narrow" "^" #'+org-find-headline-narrow
      :desc "Rifle Project Files" "P" #'helm-org-rifle-project-files
      :prefix ("s" . "+search")
      :desc "Counsel Narrow" "n" #'counsel-narrow
      :desc "Rifle Buffer" "b" #'helm-org-rifle-current-buffer
      :desc "Rifle Agenda Files" "a" #'helm-org-rifle-agenda-files
      :desc "Deadgrep" "d" #'deadgrep
      :desc "Rifle Project Files" "#" #'helm-org-rifle-project-files
      :desc "Rifle Other Project(s)" "$" #'helm-org-rifle-other-files
      :prefix ("l" . "+links")
      "o" #'org-open-at-point
      "g" #'eos/org-add-ids-to-headlines-in-file
      :prefix ("G" . "gtd")
       :desc "Next" "n" #'+org-gtd-next-tasks
       :desc "Inbox" "i" #'+org-gtd-inbox
       :desc "Someday" "s" #'+org-gtd-someday
       :desc "References" "r" #'+org-gtd-references)

(map! :leader
      :desc "Set Bookmark" "`" #'my/goto-bookmark-location
      :prefix ("s" . "search")
      :desc "Deadgrep Directory" "d" #'deadgrep
      :desc "Swiper All" "@" #'swiper-all
      :prefix ("o" . "open")
      :desc "Elfeed" "e" #'elfeed
      :desc "Deft" "w" #'deft)

(when (equal (window-system) nil)
  (and
   (bind-key "C-<down>" #'+org/insert-item-below)
   (setq doom-theme 'doom-monokai-pro)
   (setq doom-font (font-spec :family "Input Mono" :size 20))))

;(after! org (set-popup-rule! "CAPTURE*" :side 'bottom :size .40 :select t :vslot 2 :ttl 3))
;(after! org (set-popup-rule! "*Deft*" :side 'right :size .50 :select t :vslot 2 :ttl 3))
;(after! org (set-popup-rule! "*Select Link*" :side 'bottom :size .40 :select t :vslot 3 :ttl 3))
;(after! org (set-popup-rule! "*helm*" :side 'bottom :size .50 :select t :vslot 5 :ttl 3))
;(after! org (set-popup-rule! "*deadgrep" :side 'bottom :height .40 :select t :vslot 4 :ttl 3))
;(after! org (set-popup-rule! "\\Swiper" :side 'bottom :size .30 :select t :vslot 4 :ttl 3))
;(after! org (set-popup-rule! "*Org Agenda*" :side 'right :size .40 :select t :vslot 2 :ttl 3))

(global-auto-revert-mode 1)
(setq undo-limit 80000000
      evil-want-fine-undo t
      auto-save-default t
      inhibit-compacting-font-caches t)
(whitespace-mode -1)

(setq display-line-numbers-type t)
(setq-default
 delete-by-moving-to-trash t
 tab-width 4
 uniquify-buffer-name-style 'forward
 window-combination-resize t
 x-stretch-cursor t)

(require 'bookmark+)

(use-package org-pdftools
  :hook (org-load . org-pdftools-setup-link))

(after! org (setq org-ditaa-jar-path "~/.emacs.d/.local/straight/repos/org-mode/contrib/scripts/ditaa.jar"))

; GNUPLOT
(use-package gnuplot
  :config
  (setq gnuplot-program "gnuplot"))

; MERMAID
(setq mermaid-mmdc-location "~/node_modules/.bin/mmdc"
      ob-mermaid-cli-path "~/node_modules/.bin/mmdc")

; ORG-MIND-MAP
(use-package org-mind-map
  :init
  (require 'ox-org)
  ;; Uncomment the below if 'ensure-system-packages` is installed
  ;;:ensure-system-package (gvgen . graphviz)
  :config
  ;;(setq org-mind-map-engine "dot")       ; Default. Directed Graph
   (setq org-mind-map-engine "neato")  ; Undirected Spring Graph
  ;; (setq org-mind-map-engine "twopi")  ; Radial Layout
  ;; (setq org-mind-map-engine "fdp")    ; Undirected Spring Force-Directed
  ;; (setq org-mind-map-engine "sfdp")   ; Multiscale version of fdp for the layout of large graphs
  ;; (setq org-mind-map-engine "twopi")  ; Radial layouts
  ;; (setq org-mind-map-engine "circo")  ; Circular Layout
  )

; PLANTUML
(use-package ob-plantuml
  :ensure nil
  :commands
  (org-babel-execute:plantuml)
  :config
  (setq plantuml-jar-path (expand-file-name "~/.doom.d/plantuml.jar")))

(require 'elfeed-org)
(elfeed-org)
(setq rmh-elfeed-org-files (list "~/.elfeed/elfeed.org"))

(load! "my-deft-title.el")
(use-package deft
  :bind (("<f8>" . deft))
  :commands (deft deft-open-file deft-new-file-named)
  :config
  (setq deft-directory "~/.org/notes/"
        deft-auto-save-interval 0
        deft-recursive t
        deft-current-sort-method 'title
        deft-extensions '("md" "txt" "org")
        deft-use-filter-string-for-filename t
        deft-use-filename-as-title nil
        deft-markdown-mode-title-level 1
        deft-file-naming-rules '((nospace . "-"))))
(require 'my-deft-title)
(advice-add 'deft-parse-title :around #'my-deft/parse-title-with-directory-prepended)

(use-package helm-org-rifle
  :after (helm org)
  :preface
  (autoload 'helm-org-rifle-wiki "helm-org-rifle")
  :config
;  (add-to-list 'helm-org-rifle-actions '("Super Link" . sl-insert-link-rifle-action) t)
  (add-to-list 'helm-org-rifle-actions '("Insert link" . helm-org-rifle--insert-link) t)
;  (add-to-list 'helm-org-rifle-actions '("Insert link with custom ID" . helm-org-rifle--insert-link-with-custom-id) t)
  (add-to-list 'helm-org-rifle-actions '("Store link" . helm-org-rifle--store-link) t)
;  (add-to-list 'helm-org-rifle-actions '("Store link with custom ID" . helm-org-rifle--store-link-with-custom-id) t)
;  (add-to-list 'helm-org-rifle-actions '("Add org-edna dependency on this entry (with ID)" . akirak/helm-org-rifle-add-edna-blocker-with-id) t)
  (add-to-list 'helm-org-rifle-actions '("Go-to Entry and Narrow" . helm-org-rifle--narrow))
  (defun helm-org-rifle--store-link (candidate &optional use-custom-id)
    "Store a link to CANDIDATE."
    (-let (((buffer . pos) candidate))
      (with-current-buffer buffer
        (org-with-wide-buffer
         (goto-char pos)
         (when (and use-custom-id
                    (not (org-entry-get nil "CUSTOM_ID")))
           (org-set-property "CUSTOM_ID"
                             (read-string (format "Set CUSTOM_ID for %s: "
                                                  (substring-no-properties
                                                   (org-format-outline-path
                                                    (org-get-outline-path t nil))))
                                          (helm-org-rifle--make-default-custom-id
                                           (nth 4 (org-heading-components))))))
         (call-interactively 'org-store-link)))))

  (defun helm-org-rifle--narrow (candidate)
    "Go-to and then Narrow Selection"
    (helm-org-rifle-show-entry candidate)
    (org-narrow-to-subtree))

  (defun helm-org-rifle--store-link-with-custom-id (candidate)
    "Store a link to CANDIDATE with a custom ID.."
    (helm-org-rifle--store-link candidate 'use-custom-id))

  (defun helm-org-rifle--insert-link (candidate &optional use-custom-id)
    "Insert a link to CANDIDATE."
    (unless (derived-mode-p 'org-mode)
      (user-error "Cannot insert a link into a non-org-mode"))
    (let ((orig-marker (point-marker)))
      (helm-org-rifle--store-link candidate use-custom-id)
      (-let (((dest label) (pop org-stored-links)))
        (org-goto-marker-or-bmk orig-marker)
        (org-insert-link nil dest label)
        (message "Inserted a link to %s" dest))))

  (defun helm-org-rifle--make-default-custom-id (title)
    (downcase (replace-regexp-in-string "[[:space:]]" "-" title)))

  (defun helm-org-rifle--insert-link-with-custom-id (candidate)
    "Insert a link to CANDIDATE with a custom ID."
    (helm-org-rifle--insert-link candidate t))

  (helm-org-rifle-define-command
   "wiki" ()
   "Search in \"~/lib/notes/writing\" and `plain-org-wiki-directory' or create a new wiki entry"
   :sources `(,(helm-build-sync-source "Exact wiki entry"
                 :candidates (plain-org-wiki-files)
                 :action #'plain-org-wiki-find-file)
              ,@(--map (helm-org-rifle-get-source-for-file it) files)
              ,(helm-build-dummy-source "Wiki entry"
                 :action #'plain-org-wiki-find-file))
   :let ((files (let ((directories (list "~/lib/notes/writing"
                                         plain-org-wiki-directory
                                         "~/lib/notes")))
                  (-flatten (--map (f-files it
                                            (lambda (file)
                                              (s-matches? helm-org-rifle-directories-filename-regexp
                                                          (f-filename file))))
                                   directories))))
         (helm-candidate-separator " ")
         (helm-cleanup-hook (lambda ()
                              ;; Close new buffers if enabled
                              (when helm-org-rifle-close-unopened-file-buffers
                                (if (= 0 helm-exit-status)
                                    ;; Candidate selected; close other new buffers
                                    (let ((candidate-source (helm-attr 'name (helm-get-current-source))))
                                      (dolist (source helm-sources)
                                        (unless (or (equal (helm-attr 'name source)
                                                           candidate-source)
                                                    (not (helm-attr 'new-buffer source)))
                                          (kill-buffer (helm-attr 'buffer source)))))
                                  ;; No candidates; close all new buffers
                                  (dolist (source helm-sources)
                                    (when (helm-attr 'new-buffer source)
                                      (kill-buffer (helm-attr 'buffer source))))))))))
  :general
  (:keymaps 'org-mode-map
   "M-s r" #'helm-org-rifle-current-buffer)
  :custom
  (helm-org-rifle-directories-recursive t)
  (helm-org-rifle-show-path t)
  (helm-org-rifle-test-against-path t))

(provide 'setup-helm-org-rifle)

(setq org-roam-directory "~/.org/")

(defun my/org-roam--backlinks-list-with-content (file)
  (with-temp-buffer
    (if-let* ((backlinks (org-roam--get-backlinks file))
              (grouped-backlinks (--group-by (nth 0 it) backlinks)))
        (progn
          (insert (format "\n\n* %d Backlinks\n"
                          (length backlinks)))
          (dolist (group grouped-backlinks)
            (let ((file-from (car group))
                  (bls (cdr group)))
              (insert (format "** [[file:%s][%s]]\n"
                              file-from
                              (org-roam--get-title-or-slug file-from)))
              (dolist (backlink bls)
                (pcase-let ((`(,file-from _ ,props) backlink))
                  (insert (s-trim (s-replace "\n" " " (plist-get props :content))))
                  (insert "\n\n")))))))
    (buffer-string)))

  (defun my/org-export-preprocessor (backend)
    (let ((links (my/org-roam--backlinks-list-with-content (buffer-file-name))))
      (unless (string= links "")
        (save-excursion
          (goto-char (point-max))
          (insert (concat "\n* Backlinks\n") links)))))

  (add-hook 'org-export-before-processing-hook 'my/org-export-preprocessor)

(require 'ox-reveal)
(setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
(setq org-reveal-title-slide nil)

(org-super-agenda-mode t)

(setq org-agenda-custom-commands
      '(("k" "New Tasks"
         ((agenda ""
                  ((org-agenda-overriding-header "Agenda")
                   (org-agenda-files (list (concat (doom-project-root) "tasks/")))
                   (org-agenda-time-grid nil)
                   (org-agenda-include-diary nil)
                   (org-agenda-start-day (org-today))
                   (org-agenda-span '1)
                   (org-agenda-super-groups
                    '((:auto-parent t)))))
          (todo "NEXT|INPROGRESS|TODO"
                ((org-agenda-overriding-header "Not Scheduled")
                 (org-agenda-prefix-format " %(my-agenda-prefix) ")
                 (org-agenda-files (list (concat (doom-project-root) "tasks/")))
                 (org-agenda-skip-function
                  '(or
                    (org-agenda-skip-if 'nil '(timestamp))))
                 (org-super-agenda-groups
                  '((:auto-category t)))))
          (todo ""
                ((org-agenda-overriding-header "References")
                 (org-agenda-files (list (concat (doom-project-root) "refs.org")))))))
        ("i" "Inbox"
         ((todo ""
                ((org-agenda-overriding-header "")
                 (org-agenda-files (list (concat (doom-project-root) "inbox.org")))
                 (org-agenda-prefix-format " %(my-agenda-prefix) ")
                 (org-super-agenda-groups
                  '((:auto-ts t)))))))
        ("x" "Someday"
         ((todo ""
                ((org-agenda-overriding-header "Someday")
                 (org-agenda-files (list (concat (doom-project-root) "someday.org")))
                 (org-agenda-prefix-format " %(my-agenda-prefix) ")
                 (org-super-agenda-groups
                  '((:auto-parent t)))))))))

;(load! "superlinks.el")
(load! "orgmode.el")
(load! "customs.el")

(toggle-frame-maximized)
(after! org (if (y-or-n-p "Load theme? ")
                (counsel-load-theme)
              (setq doom-theme 'doom-one)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/.local/etc/bookmarks")
 '(org-agenda-files
   '("~/.org/gtd/tasks/aexp.org" "~/.org/gtd/tasks/4hr-delivery.org" "~/.org/gtd/tasks/bios.org" "~/.org/gtd/tasks/boot.org" "~/.org/gtd/tasks/commands.org" "~/.org/gtd/tasks/cpu.org" "~/.org/gtd/tasks/customer.org" "~/.org/gtd/tasks/damage.org" "~/.org/gtd/tasks/devices.org" "~/.org/gtd/tasks/documenting.org" "~/.org/gtd/tasks/dps-projects.org" "~/.org/gtd/tasks/firmware.org" "~/.org/gtd/tasks/gpus.org" "~/.org/gtd/tasks/idrac.org" "~/.org/gtd/tasks/linux.org" "~/.org/gtd/tasks/mechanical.org" "~/.org/gtd/tasks/memory.org" "~/.org/gtd/tasks/misses.org" "~/.org/gtd/tasks/networking.org" "~/.org/gtd/tasks/oem.org" "~/.org/gtd/tasks/oment.org" "~/.org/gtd/tasks/performance-issues.org" "~/.org/gtd/tasks/power.org" "~/.org/gtd/tasks/security-vulnerabilities.org" "~/.org/gtd/tasks/storage.org" "~/.org/gtd/tasks/support-assist-enterprise.org" "~/.org/gtd/tasks/support.org" "~/.org/gtd/tasks/sysman.org" "~/.org/gtd/tasks/system-crashes.org" "~/.org/gtd/tasks/systemic-analysis.org" "~/.org/gtd/tasks/thermals.org" "~/.org/gtd/tasks/todos.org" "~/.org/gtd/tasks/tools.org" "~/.org/gtd/inbox.org" "~/.org/gtd/next.org" "~/.org/gtd/refs.org" "~/.org/gtd/someday.org" "~/.org/gtd/tickler.org")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
