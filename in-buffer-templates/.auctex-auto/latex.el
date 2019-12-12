(TeX-add-style-hook
 "latex"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("fontenc" "T1") ("mathdesign" "bitstream-charter") ("helvet" "scaled=.9")))
   (TeX-run-style-hooks
    "latex2e"
    "scrartcl"
    "scrartcl10"
    "geometry"
    "paralist"
    "fontenc"
    "mathdesign"
    "helvet"
    "courier")
   (TeX-add-symbols
    "itemize"
    "description"
    "enumerate"))
 :latex)

