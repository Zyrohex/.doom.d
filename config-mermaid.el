;;; c:/Users/nmart/.doom.d/settings/config-mermaid.el -*- lexical-binding: t; -*-

(use-package ob-mermaid
  :ensure nil
  :commands
  (org-babel-execute:mermaid)
  :config
  (setq ob-mermaid-cli-path "mmdc"))

(setq mermaid-mmdc-location "C:/Users/nmart/node_modules/.bin/mmdc")
