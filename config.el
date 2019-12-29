;; Place your private configuration here
(load! "./settings/config-doom")
(load! "./settings/config-orgmode")
(load! "./settings/config-orgmode_capture")
(load! "./settings/config-agenda")
(load! "./settings/config-keys")
(load! "./settings/config-deft")
(load! "./settings/config-publish")
;(load! "./settings/config-mindmap")
(load! "./settings/config-elfeed")
(load! "./settings/config-plantuml")
(load! "./settings/config-dictionary")
(load! "./settings/config-popups")
(load! "./settings/config-latex")

;; Custom modules
(load! "./modules/my-deft-title")

(require 'my-deft-title)
(advice-add 'deft-parse-title :around #'my-deft/parse-title-with-directory-prepended)

(set-popup-rule! "^Capture.*\\.org$" :side 'right :height .30 :width 60 :select t :vslot 2 :ttl 3)
(set-popup-rule! "Dictionary" :side 'bottom :height .40 :width 20 :select t :vslot 3 :ttl 3)

(global-auto-revert-mode t) ;; Auto revert files when file changes detected on disk
(add-to-list 'load-path  "~/.doom.d/modules/") ; Load plain-org-wiki .el module

(defun org-update-cookies-after-save()
  (interactive)
  (let ((current-prefix-arg '(4)))
    (org-update-statistics-cookies "ALL")))

(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'org-update-cookies-after-save nil 'make-it-local)))
