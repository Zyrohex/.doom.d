;;; plain-org-gtd.el --- Simple jump-to-org-files in a directory package -*- lexical-binding: t -*-

;; Copyright (C) 2015-2019 Oleh Krehel

;; Author: Oleh Krehel <ohwoeowho@gmail.com>
;; URL: https://github.com/abo-abo/plain-org-gtd
;; Version: 0.1.0
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
;; Call `plain-org-gtd' to either open your Org files, or create new
;; ones.

;;; Code:

(require 'ivy)

(defgroup plain-org-gtd nil
  "Simple jump-to-org-file package."
  :group 'org
  :prefix "plain-org-gtd-")

(defcustom plain-org-gtd-directory "~/org/wiki/"
  "Directory where files for `plain-org-gtd' are stored."
  :type 'directory)

(defvar plain-org-gtd-extra-dirs nil
  "List of extra directories in addition to `plain-org-gtd-directory'.")

(defun plain-org-gtd-files-in-dir (dir)
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

(defun plain-org-gtd-files ()
  "Return .org files in `plain-org-gtd-directory'."
  (cl-mapcan #'plain-org-gtd-files-in-dir
             (cons plain-org-gtd-directory plain-org-gtd-extra-dirs)))

(defvar ffip-project-root)

(defun plain-org-gtd-files-recursive ()
  "Return .org files in `plain-org-gtd-directory' and subdirectories."
  (let ((ffip-project-root plain-org-gtd-directory))
    (delq nil
          (mapcar (lambda (x)
                    (when (equal (file-name-extension (car x)) "org")
                      (file-name-sans-extension (car x))))
                  (ffip-project-search "" nil)))))

(defun plain-org-gtd-find-file (x)
  "Open X as a file with org extension in `plain-org-gtd-directory'."
  (when (consp x)
    (setq x (cdr x)))
  (with-ivy-window
    (if (file-exists-p x)
        (find-file x)
      (if (string-match "org$" x)
          (find-file
           (expand-file-name x plain-org-gtd-directory))
        (find-file
         (expand-file-name
          (format "%s.org" x) plain-org-gtd-directory))))))

;;;###autoload
(defun plain-org-gtd-helm ()
  "Select an org-file to jump to."
  (interactive)
  (require 'helm)
  (require 'helm-multi-match)
  (helm :sources
        '(((name . "Projects")
           (candidates . plain-org-gtd-files)
           (action . plain-org-gtd-find-file))
          ((name . "Create org-gtd")
           (dummy)
           (action . plain-org-gtd-find-file)))))

(defvar plain-org-gtd-history nil
  "History for `plain-org-gtd'.")

;;;###autoload
(defun plain-org-gtd ()
  "Select an org-file to jump to."
  (interactive)
  (ivy-read "pattern: " (plain-org-gtd-files)
            :history 'plain-org-gtd-history
            :action 'plain-org-gtd-find-file
            :caller 'plain-org-gtd))

(provide 'plain-org-gtd)

;;; plain-org-gtd.el ends here
