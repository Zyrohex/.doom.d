;;; c:/Users/nmart/.doom.d/latex-classes.el -*- lexical-binding: t; -*-

(setq org-latex-to-pdf-process
  '("xelatex -interaction nonstopmode %f"
     "xelatex -interaction nonstopmode %f"))

(setq org-latex-classes
             '("koma-article"
               "\\documentclass{scrartcl}
\\usepackage[T1]{fontenc}
\\usepackage[bitstream-charter]{mathdesign}
\\usepackage[scaled=.9]{helvet}
\\usepackage{courier} % tt
\\usepackage{geometry}
\\usepackage{booktabs}
\\usepackage{multicol}
\\usepackage{paralist}
\\geometry{letter, textwidth=6.5in, textheight=10in,
            marginparsep=7pt, marginparwidth=.6in}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
