;; Place your private configuration here
(load! "./settings/config-keys")
(load! "./settings/config-agenda")
(load! "./settings/config-publish")
(load! "./settings/config-mindmap")
(load! "./settings/config-orgmode")
(load! "./settings/config-deft")
(load! "./settings/config-elfeed")
(load! "./settings/config-doom")
(load! "./settings/config-latex")

(use-package dictionary)

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
