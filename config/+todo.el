(setq
		org-todo-keywords
        '((sequence "TODO(t)" "WORKING(W!)" "NEXT(n!)" "WAITING(w!)" "LATER(l!)" "|" "INVALID(I!)" "DONE(d!)"))
        org-todo-keyword-faces
        '(("TODO" :foreground "#f5ff36" :weight bold)
          ("WAITING" :foreground "#ffff29" :weight normal :underline t)
          ("WORKING" :foreground "#a8d7ff" :weight normal :underline t)
          ("NEXT" :foreground "#ff3d47" :weight bold)
          ("LATER" :foreground "#29edff" :weight normal)
          ("DONE" :foreground "#50a14f" :weight normal)))