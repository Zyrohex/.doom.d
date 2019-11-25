;;; ~/.doom.d/publish.el -*- lexical-binding: t; -*-

(setq org-publish-project-alist
      '(("references-programming"
         :base-directory "~/.references/programming"
         :base-directory "~/.gtd"
         :publishing-directory "~/publish_html/references/programming"
         :base-extension "org"
         :publishing-function org-html-publish-to-html
         :section-numbers nil
         :with-email t
         :with-drawer t
         :html-link-up ".."
         :auto-preamble t
         :with-toc t)
        ("references-attachments"
         :base-directory "~/.references/images/"
         :base-extension "jpg\\|jpeg\\|png\\|pdf\\|css"
         :publishing-directory "~/publish_html/images"
         :publishing-function org-publish-attachment)
        ("references-applications"
         :base-directory "~/.references/applications/"
         :publishing-directory "~/publish_html/references/applications"
         :base-extension "org"
         :publishing-function org-html-publish-to-html
         :section-numbers nil
         :with-email t
         :with-drawer t
         :html-link-up "."
         :auto-preamble t
         :with-toc t)
        ("references-software"
         :base-directory "~/.references/software/"
         :publishing-directory "~/publish_html/references/software"
         :base-extension "org"
         :publishing-function org-html-publish-to-html
         :section-numbers nil
         :with-email t
         :with-drawer t
         :html-link-up "."
         :auto-preamble t
         :with-toc t)
        ("references-personal"
         :base-directory "~/.references/personal/"
         :publishing-directory "~/publish_html/references/personal"
         :base-extension "org"
         :publishing-function org-html-publish-to-html
         :section-numbers nil
         :with-email t
         :with-drawer t
         :html-link-up "."
         :auto-preamble t
         :with-toc t)
        ("references"
         :base-directory "~/.references/"
         :publishing-directory "~/publish_html/references"
         :base-extension "org"
         :publishing-function org-html-publish-to-html
         :section-numbers nil
         :with-email t
         :with-drawer t
         :html-link-up "."
         :auto-preamble t
         :with-toc t)
        ("myprojectweb" :components("references-programming" "references-personal" "references-applications" "references-software" "references-attachments" "references"))))
