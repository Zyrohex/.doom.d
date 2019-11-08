;;; plain-org-wiki.el --- Simple jump-to-org-files in a directory package -*- lexical-binding: t -*-

;; Copyright (C) 2015-2019 Oleh Krehel

;; Author: Oleh Krehel <ohwoeowho@gmail.com>
;; URL: https://github.com/abo-abo/plain-org-wiki
;; Version: 0.1.0
;; Package-Requires: ((emacs "24.3") (ivy "0.12.0"))
;; Keywords: convenience

;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Call `plain-org-wiki' to either open your Org files, or create new
;; ones.

;;; Code:

(require 'ivy)

(defgroup plain-org-wiki nil
  "Simple jump-to-org-file package."
  :group 'org
  :prefix "plain-org-wiki-")

(defcustom plain-org-wiki-directory "~/org/wiki/"
  "Directory where files for `plain-org-wiki' are stored."
  :type 'directory)

(defvar plain-org-wiki-extra-dirs nil
  "List of extra directories in addition to `plain-org-wiki-directory'.")

(defun plain-org-wiki-files-in-dir (dir)
  "Return a list of cons cells for DIR.
Each cons cell is a name and file path."
  (let ((default-directory dir))
    (mapcar
     (lambda (x)
       (cons (file-name-sans-extension x)
             (expand-file-name x)))
     (append
      (file-expand-wildcards "*.org")
      (file-expand-wildcards "*.org.gpg")))))

(defun plain-org-wiki-files ()
  "Return .org files in `plain-org-wiki-directory'."
  (cl-mapcan #'plain-org-wiki-files-in-dir
             (cons plain-org-wiki-directory plain-org-wiki-extra-dirs)))

(defvar ffip-project-root)
(declare-function ffip-project-search "ext:find-file-in-project")

(defun plain-org-wiki-files-recursive ()
  "Return .org files in `plain-org-wiki-directory' and subdirectories."
  (let ((ffip-project-root plain-org-wiki-directory))
    (delq nil
          (mapcar (lambda (x)
                    (when (equal (file-name-extension (car x)) "org")
                      (file-name-sans-extension (car x))))
                  (ffip-project-search "" nil)))))

(defun plain-org-wiki-find-file (x)
  "Open X as a file with org extension in `plain-org-wiki-directory'."
  (when (consp x)
    (setq x (cdr x)))
  (with-ivy-window
    (if (file-exists-p x)
        (find-file x)
      (if (string-match "org$" x)
          (find-file
           (expand-file-name x plain-org-wiki-directory))
        (find-file
         (expand-file-name
          (format "%s.org" x) plain-org-wiki-directory))))))

(declare-function helm "ext:helm.el" t)

;;;###autoload
(defun plain-org-wiki-helm ()
  "Select an org-file to jump to."
  (interactive)
  (helm :sources
        '(((name . "Projects")
           (candidates . plain-org-wiki-files)
           (action . plain-org-wiki-find-file))
          ((name . "Create org-wiki")
           (dummy)
           (action . plain-org-wiki-find-file)))))

(defvar plain-org-wiki-history nil
  "History for `plain-org-wiki'.")

;;;###autoload
(defun plain-org-wiki ()
  "Select an org-file to jump to."
  (interactive)
  (ivy-read "pattern: " (plain-org-wiki-files)
            :history 'plain-org-wiki-history
            :action 'plain-org-wiki-find-file
            :caller 'plain-org-wiki))

(provide 'plain-org-wiki)

;;; plain-org-wiki.el ends here
