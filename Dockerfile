FROM texlive/texlive:latest WORKDIR / COPY . / RUN pdflatex scriptbook.tex
