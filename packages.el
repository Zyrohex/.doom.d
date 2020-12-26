;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)

;;  testing for org-mode performance improvement, Mon Dec  7 08:13:51 2020:
;;  https://www.reddit.com/r/orgmode/comments/k6f5fx/ann_experimental_orgmode_branch_improving/?%24deep_link=true&correlation_id=ccca9cde-01c3-449b-ad8b-9d9ee958a806&ref=email_digest&ref_campaign=email_digest&ref_source=email&%243p=e_as&%24original_url=https%3A%2F%2Fwww.reddit.com%2Fr%2Forgmode%2Fcomments%2Fk6f5fx%2Fann_experimental_orgmode_branch_improving%2F%3F%24deep_link%3Dtrue%26correlation_id%3Dccca9cde-01c3-449b-ad8b-9d9ee958a806%26ref%3Demail_digest%26ref_campaign%3Demail_digest%26ref_source%3Demail&_branch_match_id=712684382232251840
;; (package! org-mode
;;   :recipe (:host github
;;            :repo "yantar92/org"
;;            :branch "feature/org-fold"
;;            :files ("*.el" "lisp/*.el" "contrib/lisp/*.el")
;;            :build (with-temp-file (expand-file-name "org-version.el" (straight--repos-dir "org"))
;;                     (insert "(fset 'org-release (lambda () \"9.5\"))\n"
;;                             "(fset 'org-git-version #'ignore)\n"
;;                             "(provide 'org-version)\n")))
;;   :pin "308c4f57d26307c0f57ad387a4638b051f541a9c"
;;   :shadow 'org)

;; (package! helm-org-rifle)
;; (package! org-super-agenda)
;; (package! org-ql)
;;(package! elfeed)
;;(package! elfeed-org)
;;(package! org-board)
;; (package! org-mind-map)
(package! zetteldeft)                   ; required by deft
; The following using org-roam on its development branch does not interfere with Doom's settings.
; It just override Doom's package definition.

;; (unpin! org-roam company-org-roam)
;; With unpin! above, the folloving is not needed:
;; (package! org-roam
;;    :recipe (:host github :repo "jethrokuan/org-roam" :branch "develop")
;;    )
(unpin! org-roam company-org-roam)      ; they are already integrated in Doom, and can use the latest
(package! org-roam-server :recipe (:host github :repo "org-roam/org-roam-server" :files ("*")))
(package! company-org-roam :recipe (:host github :repo "org-roam/company-org-roam"))

(package! ox-pandoc)

(package! conda)
(package! ox-ipynb
   :recipe (:host github :repo "jkitchin/ox-ipynb" :files ("*.el" "/")))

;;(package! ox-twbs)
(package! org-re-reveal)

;; (package! dictionary)
;; (package! powerthesaurus)
;; (package! pdf-tools)
;;(package! gnuplot)
;;(package! gnuplot-mode)
;;(package! deadgrep)
;;(package! metrics-tracker)
;;(package! org-web-tools)
;;(package! grip-mode)
;; ;; for using emacs-jupyter with jupyter kernel and virutal environment
(package! pyim) ; for Chinese input inside emacs
(package! pyim-basedict)
(package! evil-tutor)                   ; for learning evil
