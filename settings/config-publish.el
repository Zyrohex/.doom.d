;;; ~/.doom.d/publish.el -*- lexical-binding: t; -*-

(setq org-publish-project-alist
      '(("references-attachments"
         :base-directory "~/.references/images/"
         :base-extension "jpg\\|jpeg\\|png\\|pdf\\|css"
         :publishing-directory "~/publish_html/references/images"
         :publishing-function org-publish-attachment)
        ("references"
         :base-directory "~/.references/"
         :publishing-directory "~/publish_html"
         :base-extension "org"
         :recursive t
         :html-link-home "../sitemap.html"
         :auto-sitemap t
         :publishing-function org-html-publish-to-html
         :section-numbers nil
;         :html-head "<link rel=\"stylesheet\"
;href=\"https://codepen.io/nmartin84/pen/JjoYrzP.css\"
;type=\"text/css\"/>"
         :with-email t
         :html-link-up "."
         :auto-preamble t
         :with-toc t)
        ("references-md"
         :base-directory "~/.references/"
         :publishing-directory "~/publish_md"
         :base-extension "org"
         :recursive t
         :html-link-home "../readme.md"
         :sitemap-filename "index"
         :auto-sitemap t
         :publishing-function org-html-publish-to-html
         :section-numbers nil
;         :html-head "<link rel=\"stylesheet\"
;href=\"https://fniessen.github.io/org-html-themes/styles/readtheorg/css/htmlize.css\"
;type=\"text/css\"/> <link rel=\"stylesheet\" href=\"https://codepen.io/nmartin84/pen/ExaWKqy.css\" type=\"text/css\"/> <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js\"> <script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js\"></script> <script type=\"text/javascript\" src=\"https://fniessen.github.io/org-html-themes/styles/lib/js/jquery.stickytableheaders.min.js\"></script> <script type=\"text/javascript\" src=\"https://fniessen.github.io/org-html-themes/styles/readtheorg/js/readtheorg.js\"></script>"
         :with-email t
         :html-link-up "."
         :auto-preamble t
         :with-toc t)
        ("tasks"
         :base-directory "~/.gtd/"
         :publishing-directory "~/publish_html/gtd"
         :base-extension "org"
         :recursive t
         :html-link-home "./sitemap.html"
         :auto-sitemap t
         :publishing-function org-html-publish-to-html
         :section-numbers nil
;         :html-head "<link rel=\"stylesheet\"
;href=\"https://codepen.io/nmartin84/pen/MWWdwbm.css\"
;type=\"text/css\"/>"
         :with-email t
         :html-link-up "."
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
         ("myprojectweb" :components("references-attachments" "pdf" "references" "tasks"))))
