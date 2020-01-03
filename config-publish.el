;;; ~/.doom.d/publish.el -*- lexical-binding: t; -*-

(setq org-publish-project-alist
      '(("references-attachments"
         :base-directory "~/.notes/images/"
         :base-extension "jpg\\|jpeg\\|png\\|pdf\\|css"
         :publishing-directory "~/publish_html/references/images"
         :publishing-function org-publish-attachment)
        ("references-md"
         :base-directory "~/.notes/"
         :publishing-directory "~/publish_md"
         :base-extension "org"
         :recursive t
         :headline-levels 5
         :publishing-function org-html-publish-to-html
         :section-numbers nil
         :html-head "<link rel=\"stylesheet\" href=\"http://thomasf.github.io/solarized-css/solarized-light.min.css\" type=\"text/css\"/>"
         :infojs-opt "view:t toc:t ltoc:t mouse:underline buttons:0 path:http://thomas.github.io/solarized-css/org-info.min.js"
         :with-email t
         :with-toc t)
        ("tasks"
         :base-directory "~/.gtd/"
         :publishing-directory "~/publish_tasks"
         :base-extension "org"
         :recursive t
         :auto-sitemap t
         :sitemap-filename "index"
         :html-link-home "../index.html"
         :publishing-function org-html-publish-to-html
         :section-numbers nil
;         :html-head "<link rel=\"stylesheet\"
;href=\"https://codepen.io/nmartin84/pen/MWWdwbm.css\"
;type=\"text/css\"/>"
         :with-email t
         :html-link-up ".."
         :auto-preamble t
         :with-toc t)
        ("pdf"
         :base-directory "~/.gtd/references/"
         :base-extension "org"
         :publishing-directory "~/publish"
         :preparation-function somepreparationfunction
         :completion-function  somecompletionfunction
         :publishing-function org-latex-publish-to-pdf
         :recursive t
         :latex-class "koma-article"
         :headline-levels 5
         :with-toc t)
         ("myprojectweb" :components("references-attachments" "pdf" "references-md" "tasks"))))
