;;; ~/.doom.d/agenda.el -*- lexical-binding: t; -*-

;; Prompt user for answers
(defun org-capture-template-selector ()
  "Function to choose which template you want to create"
  (interactive)
  (let ((choose '("New File" "Existing File")))
    (org-completing-read "Choose: " choose)))
(org-capture-template-selector)
(defun org-capture-template-select ()
  "Select which template you want"
  (interactive)
  (org-capture-template-selector)
  (if (equal choose "New File")
      (message "true")
    (message "false")))
(org-capture-template-select)

;; Define parent or child task
(defun org-capture-template-parchild ()
  "Function to choose which template you want to create"
  (interactive)
  (let ((choose '("Parent" "Child")))
    (org-completing-read "Choose: " choose)))
(org-capture-template-parchild)

;;
(defun org-capture-template-builder ()
  "Dynamic template builder"
  (if (equal org-capture-template-parchild "Parent")))
