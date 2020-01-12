;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                        Global Settings                                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load! "config-agenda")
(load! "config-capture")
(load! "config-extras")
(load! "config-keys")
(load! "config-latex")
(load! "config-orgmode")
(load! "config-publish")
(setq-default fill-column 140)
(setq diary-file "~/.org/gtd/diary.org")
(global-auto-revert-mode t)
(add-to-list 'load-path  "~/.doom.d/modules/")
(setq user-full-name "Nicholas Martin"
      user-mail-address "nmartin84@gmail.com")
(setq doom-font (font-spec :family "InputMono" :size 18)
      doom-variable-pitch-font (font-spec :family "InputMono")
      doom-unicode-font (font-spec :family "DejaVu Sans")
      doom-big-font (font-spec :family "InputMono" :size 20))
(setq doom-theme 'doom-city-lights)
(setq display-line-numbers-type nil)
(setq org-ellipsis "▼")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                        Popup Rules                                                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; These settings will define how popups are handled.
(set-popup-rule! "^Capture.*\\.org$" :side 'right :height .30 :width 60 :select t :vslot 2 :ttl 3)
(set-popup-rule! "Dictionary" :side 'bottom :height .40 :width 20 :select t :vslot 3 :ttl 3)
(set-popup-rule! "*helm*" :side 'bottom :height .40 :select t :vslot 5 :ttl 3)
(set-popup-rule! "*deadgrep" :side 'bottom :height .40 :select t :vslot 4 :ttl 3)
(set-popup-rule! "*org agenda*" :side 'right :size .40 :select t :vslot 2 :ttl 3)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                        To Change                                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun jethro/org-agenda-process-inbox-item ()
  "Process a single item in the org-agenda."
  (org-with-wide-buffer
   (org-agenda-set-tags)
   (org-agenda-priority)
   (call-interactively 'jethro/my-org-agenda-set-effort)
   (org-agenda-refile nil nil t)))
(provide 'jethro/org-agenda-process-inbox-item)

(defun zyrohex/org-tasks-refile ()
  "Process a single TODO task item."
  (interactive)
  (call-interactively 'org-agenda-schedule)
  (org-agenda-set-tags)
  (org-agenda-priority)
  (let ((org-refile-targets '((helm-read-file-name :maxlevel .6)))
        (call-interactively #'org-refile))))
(provide 'zyrohex/org-tasks-refile)

(defun zyrohex/org-reference-refile (arg)
  "Process an item to the reference bucket"
  (interactive "P")
  (let ((org-refile-targets '(("~/.gtd/references.org" :maxlevel . 6))))
    (call-interactively #'org-refile)))
(provide 'zyrohex/org-reference-refile)

(defun zyrohex/org-notes-refile ()
  "Process an item to the references bucket"
  (interactive)
  (let ((org-refile-targets '(("~/.gtd/references.org" :maxlevel . 6)))
        (org-refile-allow-creating-parent-nodes 'confirm))
    (call-interactively #'org-refile)))
(provide 'zyrohex/org-notes-refile)
