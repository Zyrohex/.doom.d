; set language as Japanese
(set-language-environment 'Japanese)
;; coding UTF8
(set-language-environment  'utf-8)
(prefer-coding-system 'utf-8)

; https://www.reddit.com/r/emacs/comments/9x2gbd/pure_tty_emacs_all_the_time/
;; Permit kill-saving text to and from to X11 clipboard
(defun kill-save-to-x-clipboard ()
  (interactive)
  (progn
    (shell-command-on-region (region-beginning) (region-end) "xsel -i")
    (message "Kill-saved region to clipboard!")
    (deactivate-mark)))
(global-set-key (kbd "C-c k") 'kill-save-to-x-clipboard)

(defun yank-from-x-clipboard ()
  (interactive)
  (progn
    (insert (shell-command-to-string "xsel -o")))
    (message "Yanked region from clipboard!"))
(global-set-key (kbd "C-c y") 'yank-from-x-clipboard)

;; Allow GUI Emacs to access content from clipboard.
(setq x-select-enable-clipboard t
      x-select-enable-primary t)
; https://emacs.stackexchange.com/a/48584
;; setup browser function when running in WSL
(defconst powershell-exe "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe")
(when (file-executable-p powershell-exe)
(defun my-WSL-browse-url (url &optional _new-window)
  (interactive (browse-url-interactive-arg "URL: "))
  (let ((quotedUrl (format "start '%s'" url)))
    (apply 'call-process powershell-exe
           nil 0 nil (list "-Command" quotedUrl))))
(setq-default browse-url-browser-function 'my-WSL-browse-url))
