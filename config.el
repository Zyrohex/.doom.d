;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                        Global Settings                                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-auto-revert-mode t)
(org-super-agenda-mode t)
(add-to-list 'load-path  "~/.doom.d/modules/")
(setq user-full-name "Nicholas Martin"
      user-mail-address "nmartin84@gmail.com")
(setq doom-font (font-spec :family "Source Code Pro" :size 22)
      doom-big-font (font-spec :family "Source Code Pro" :size 28))
(setq doom-theme 'doom-city-lights)
(setq org-directory "~/.gtd/")
(setq display-line-numbers-type nil)
(setq org-ellipsis "▼")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                        Popup Rules                                                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; These settings will define how popups are handled.
(set-popup-rule! "^Capture.*\\.org$" :side 'right :height .30 :width 60 :select t :vslot 2 :ttl 3)
(set-popup-rule! "Dictionary" :side 'bottom :height .40 :width 20 :select t :vslot 3 :ttl 3)
(set-popup-rule! "*helm*" :side 'bottom :height 40 :select t :vslot 5 :ttl 3)
(set-popup-rule! "*deadgrep" :side 'bottom :height 40 :select t :vslot 4 :ttl 3)
(set-popup-rule! "*org agenda*" :side 'right :width 60 :height 40 :select t :vslot 6 :ttl 3)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                        To Change                                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                        Org Settings                                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-agenda-files
      '("~/.gtd/" "~/.references/"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                        Org Agenda                                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load! "config-keys")
(load! "config-doom")
(load! "config-orgmode")
(load! "config-orgmode_capture")
(load! "config-agenda")
(load! "config-keys")
(load! "config-deft")
(load! "config-publish")
(load! "config-mindmap")
(load! "config-elfeed")
(load! "config-plantuml")
(load! "config-gnuplot")
(load! "config-dictionary")
(load! "config-popups")
(load! "config-latex")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                        Org Capture                                                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                        Custom Modules                                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path  "~/.doom.d/modules/")
(require 'my-deft-title)
(advice-add 'deft-parse-title :around #'my-deft/parse-title-with-directory-prepended)

(defun my--browse-url (url &optional _new-window)
;; new-window ignored
"Opens link via powershell.exe"
(interactive (browse-url-interactive-arg "URL: "))
(let ((quotedUrl (format "start '%s'" url)))
(apply 'call-process "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe" nil
0 nil
(list "-Command" quotedUrl))))

(setq-default browse-url-browser-function 'my--browse-url)
