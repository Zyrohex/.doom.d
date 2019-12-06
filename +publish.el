;;; ~/.doom.d/publish.el -*- lexical-binding: t; -*-

(setq org-publish-project-alist
      '(("references-attachments"
         :base-directory "~/.references/images/"
         :base-extension "jpg\\|jpeg\\|png\\|pdf\\|css"
         :publishing-directory "~/publish_html/references/images"
         :publishing-function org-publish-attachment)
        ("references"
         :base-directory "~/.references/"
         :publishing-directory "~/publish_html/references"
         :base-extension "org"
         :recursive t
         :html-link-home "./sitemap.html"
         :auto-sitemap t
         :publishing-function org-html-publish-to-html
         :section-numbers nil
         :html-head "<link rel=\"stylesheet\"
href=\"https://codepen.io/nmartin84/pen/MWWdwbm.css\"
type=\"text/css\"/>"
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
         :html-head "<link rel=\"stylesheet\"
href=\"https://codepen.io/nmartin84/pen/MWWdwbm.css\"
type=\"text/css\"/>"
         :with-email t
         :html-link-up "."
         :auto-preamble t
         :with-toc t)
        ("myprojectweb" :components("references-attachments" "references" "tasks"))))
