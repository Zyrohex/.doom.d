(require 'org)
(require 'helm-org-rifle)

(defvar sl-backlink-into-drawer t
  "Controls how/where to insert the backlinks.
If non-nil a drawer will be created and backlinks inserted there.  The
default is BACKLINKS.  If this is set to a string a drawer will be
created using that string.  For example LINKS.  If nil backlinks will
just be inserted under the heading.")

(defvar sl-backlink-entry-format "[%s] <- [[%s][%s]]"
  "This is a string passed to `format`.
The substitution order being time, link, description.  If
`sl-backlink-prefix` is a string it will be inserted before this.  I
may refactor this to be a format function instead.")

(defvar sl-backlink-prefix nil
  "Prefix string to insert before the result of `sl-backlink-entry-format`.")

(defun sl-backlink-into-drawer ()
  "Name of the backlink drawer, as a string, or nil.
This is the value of `sl-backlink-into-drawer'.  However, if the
current entry has or inherits a BACKLINK_INTO_DRAWER property, it will
be used instead of the default value."
  (let ((p (org-entry-get nil "BACKLINK_INTO_DRAWER" 'inherit t)))
    (cond ((equal p "nil") nil)
	  ((equal p "t") "BACKLINKS")
	  ((stringp p) p)
	  (p "BACKLINKS")
	  ((stringp sl-backlink-into-drawer) sl-backlink-into-drawer)
	  (sl-backlink-into-drawer "BACKLINKS"))))

(defun sl-backlink-prefix ()
  "Return the name of the prefix for the link as a string or nil."
  (let ((p (org-entry-get nil "BACKLINK_PREFIX" 'inherit t)))
    (cond ((equal p "nil") nil)
	  ((equal p "t") "BACKLINK")
	  ((stringp p) p)
	  (p "BACKLINK")
	  ((stringp sl-backlink-prefix) sl-backlink-prefix)
	  (sl-backlink-prefix "BACKLINK"))))

(advice-add 'org-capture :before 'sl-store-link)

(defun sl-insert-link-action (candidate)
  "Wrapper for `sl--insert-link` for helm/rifle integration.
CANDIDATE is a helm candidate."
  (-let (((buffer . pos) candidate))
    (sl--insert-link buffer pos)))

(add-to-list 'helm-org-rifle-actions '("Super Link" . sl-insert-link-action) t)

(defun sl-link ()
  "Insert a link and add a backlink to the target heading."
  (interactive)
  (add-to-list 'helm-org-rifle-actions '("super-link-temp" . sl-insert-link-action) nil)
  (helm-org-rifle-directories (doom-project-root))
  (pop helm-org-rifle-actions))

(provide 'org-super-links)

;----------------------------------------------------- CORE FUNCTIONS
(defun sl-insert-link ()
  "Insert a super link from the register."
  (interactive)
  (let* ((marker (get-register 'sl-link))
	 (buffer (if marker (marker-buffer marker) nil))
	 (pos (if marker (marker-position marker) nil)))
    (if (and buffer pos)
	(progn
	  (sl--insert-link buffer pos)
	  (set-register 'sl-link nil))
      (message "No link to insert!"))))

(defun sl-store-link (&optional goto keys)
  "Stores link to TARGET reference and SETS register for sl-link"
  (interactive)
  ;; we probably don't want to link to buffers not visiting a file?
  ;; definitely not if capture is called through org-protocol for example.
  (if (buffer-file-name (current-buffer))
      (progn
        (call-interactively 'org-store-link)
        (point-to-register 'sl-link)
        (message "Link copied"))
    (message "No method for storing a link to this buffer.")))

(defun sl--insert-link (buffer pos)
  "Insert link to BUFFER POS at current point, and create backlink from TARGET to here"
  (interactive)
  (setq org-stored-links nil)
  (call-interactively 'org-store-link)
  (with-current-buffer buffer
    (save-excursion
      (goto-char pos)
      (when (string-equal major-mode "org-mode")
        (sl-insert-backlink))
      (setq org-stored-links nil)
      (call-interactively 'org-store-link)))
(org-insert-last-stored-link 1))

(defun sl-insert-backlink ()
  "Insert a backlink to LINK using DESC after the current headline."
  (let* ((note-format-base (concat sl-backlink-entry-format "\n"))
         (time-format (substring (cdr org-time-stamp-formats) 1 -1))
         (time-stamp (format-time-string time-format (current-time)))
         (org-log-into-drawer (sl-backlink-into-drawer))
         (prefix (sl-backlink-prefix))
         (note-format (if (equal prefix nil) note-format-base (concat prefix ": " note-format-base)))
         (beg (org-log-beginning t)))
    (goto-char beg)
    (insert "- " (format-time-string "[%Y-%m-%d %a %H:%M]") " -> ")
    (org-insert-last-stored-link 1)
    (org-indent-region beg (point))))
