;;; ~/.doom.d/publish.el -*- lexical-binding: t; -*-

(setq org-publish-project-alist
      '(("references-web"
         :base-directory "~/.references/"
         :publishing-directory "~/publish_html/references"
         :base-extension "org"
         :publishing-function org-html-publish-to-html
         :section-numbers nil
         :with-email t
         :auto-preamble t
         :with-toc t)
        ("references-attachments"
         :base-directory "~/.references/references/images/"
         :base-extension "jpg\\|jpeg\\|png\\|pdf"
         :publishing-directory "~/publish_html/images"
         :publishing-function org-publish-attachment)
        ("myprojectweb" :components("references-web" "references-attachments"))))
