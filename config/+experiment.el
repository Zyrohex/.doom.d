(defun ap/org-outline-numbers ()
    (interactive)
    (save-excursion
      (let* ((positions-levels (progn
                                 (goto-char (point-min))
                                 (when (org-before-first-heading-p)
                                   (outline-next-heading))
                                 (cl-loop while (not (eobp))
                                          collect (cons (point) (org-current-level))
                                          do (outline-next-heading))))
             (tree (cl-loop with current-top-level = 0
                            with current-subtree-numbers
                            with results
                            with previous-level
                            for (position . level) in positions-levels
                            if (= 1 level)
                            do (progn
                                 (setq current-subtree-numbers nil)
                                 (setq previous-level level)
                                 (push (a-list 'heading (save-excursion
                                                          (goto-char position)
                                                          (substring-no-properties
                                                           (org-get-heading t t)))
                                               'position position
                                               'level level
                                               'number (concat (number-to-string (incf current-top-level)) "."))
                                       results))
                            else do (let* ((current-level-number (cond ((<= level previous-level)
                                                                        (incf (map-elt current-subtree-numbers level)))
                                                                       ((> level previous-level)
                                                                        1)))
                                           text-number)
                                      (setq previous-level level)
                                      (map-put current-subtree-numbers level current-level-number)
                                      (setq text-number (cl-loop for lookup from level downto 1
                                                                 for lookedup = (map-elt current-subtree-numbers lookup)
                                                                 if lookedup
                                                                 collect lookedup into result
                                                                 else collect current-top-level into result
                                                                 finally return (s-join "." (mapcar #'number-to-string (nreverse result)))))
                                      (push (a-list 'heading (save-excursion
                                                               (goto-char position)
                                                               (substring-no-properties
                                                                (org-get-heading t t)))
                                                    'position position
                                                    'level level
                                                    'number text-number)
                                            results))
                            finally return (nreverse results))))
        (ov-clear)
        (--each tree
          (let-alist it
            (ov (+ .position (1- .level)) (+ .position .level)
                'display .number))))))
