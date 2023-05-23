%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tiqqunazo
%
% Una clase de LaTeX personalizada basada en la clase extarticle,
%
% Fuertemente inspirada en el blog en español de Tiqqun y por la clase
% The Martian Report de Marina Rose "Mars" Geldard, con adaptaciones
% para fines editoriales.
%
% Autor: Aradenatorix
% 
% Disponible para uso de terceros bajo:
%
% La licencia MIT (https://opensource.org/licenses/MIT)
%
% Última actualización: 22/05/2023
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Tiqqunazo}[2023 Project Documentation LaTeX class]

% ESTABLECE LAS DIMENSIONES DE LA PÁGINA
\LoadClass[9pt,twoside]{extarticle}
\RequirePackage[%
  papersize={4.25in,5.5in}, % tamaño de papel media carta
  headheight=17pt,          % ajuste del amaño de la cabecera
  top=0.7in,                % mrgen superior
  bottom=0.6255in,          % margen inferior
  left=0.4375in,            % margen izquierdo
  right=0.4375in            % margen derecho
  ]{geometry}

% CARGA DE LOS PAQUETES NECESARIOS
  \RequirePackage[utf8]{inputenc}
  \RequirePackage[T1]{fontenc}
  \RequirePackage[english,spanish,mexico]{babel}
  \RequirePackage[spanish=mexican]{csquotes}
  \RequirePackage{xparse}
  \RequirePackage{markdown}
  \RequirePackage{graphicx}
  \RequirePackage[table]{xcolor}
  \RequirePackage{tocloft}
  \RequirePackage{parskip}
  \RequirePackage{fancyhdr}
  \RequirePackage{wrapfig2}
  \RequirePackage{titlesec}
  \RequirePackage[hidelinks]{hyperref}
  \RequirePackage{xurl}

% CAMBIO DE TIPOGRAFÍAS
  \RequirePackage{ebgaramond}
  \RequirePackage{inconsolata}

% INFORMACIÓN DE USUARIO
  \newcommand{\imagefolder}[1]{\def\@imagefolder{#1}}
  \newcommand{\version}[1]{\def\@revision{#1}}
  \newcommand{\project}[1]{\def\@project{#1}}
  \newcommand{\logo}[1]{\def\@logo{#1}}
  \newcommand{\footertext}[2]{\def\@lfooter{#1} \def\@rfooter{#2}}
  \newcommand{\nofootertext}{\def\@lfooter{} \def\@rfooter{}}
  \newcommand{\imageref}[1]{\def\@imageref{#1}}

% ESTABLECE VALORES POR DEFECTO EN CASO CONTRARIO
  \title{Documento de prueba}
  \author{~}
  \project{~}
  \imagefolder{.}
  \version{Versi\'on 1.0}
  \def\@lfooter{\@title}
  \def\@rfooter{\@author}
  \imageref{~}

  % PERSONALIZACIÓN DEL ÍNDICE DE CONTENIDOS
  \renewcommand{\cftdot}{}
  \cftpagenumbersoff{subsection}
  \setcounter{tocdepth}{2}
    \renewcommand{\cftsecpresnum}{\begin{lrbox}{\@tempboxa}}
    \renewcommand{\cftsecaftersnum}{\end{lrbox}}
  \setlength{\cftsecnumwidth}{0pt}
    \renewcommand{\cftsubsecpresnum}{\begin{lrbox}{\@tempboxa}}
    \renewcommand{\cftsubsecaftersnum}{\end{lrbox}}
  \setlength{\cftsubsecnumwidth}{0pt}
  \cftsetindents{subsection}{0em}{0em}

  % CREACIÓN DE LA CARÁTULA
  \AtBeginDocument{\pagestyle{fancyplain}\titlepage%
    \ifsectionnumbers 
      \renewcommand{\thesection}{\arabic{section}}
      \renewcommand{\thesubsection}{\arabic{section}.\arabic{subsection}}
      \renewcommand{\thesubsubsection}{
        \arabic{section}.\arabic{subsection}.\arabic{subsubsection}
      } 
    \else 
      \ifsubsectionnumbers 
        \renewcommand{\thesection}{\kern-1em}
        \renewcommand{\thesubsection}{\arabic{subsection}}
        \renewcommand{\thesubsubsection}{
          \arabic{subsection}.\arabic{subsubsection}
        }
      \else 
        \setcounter{secnumdepth}{0} 
      \fi 
    \fi 
  }
  \renewcommand{\titlepage}{%
    \thispagestyle{title}
    \begin{flushleft}
      {\fontsize{24}{21}\selectfont\textbf{\MakeUppercase{\@title}}\par}
      \Large\@author 
      \vspace{12pt}\linebreak 
      \textbf{\Huge\@project}
      \vspace{9pt}\linebreak 
      \ifdefined\@logo
        \edef\tmp{%
          \noexpand%
          \includegraphics[width=0.3\textwidth]{\@imagefolder/\@logo}%
          }\tmp%
      \fi 
      \linebreak\vfill
    \end{flushleft}
  
    \begin{centering}
      \parbox{0.98\linewidth}{\@starttoc{toc}} 
      \vspace{10pt}\linebreak
    \end{centering}
    \rule{\textwidth}{1pt} 
    \pagebreak 
  }

  % ESTILO DE CABECERA/PIE DE PÁGINA
  \fancypagestyle{title}{%
    \renewcommand{\headrulewidth}{1pt} 
    \fancyhf{}
    \lhead{\rule[-2ex]{0pt}{2ex}\textbf{\@revision}}
    \rhead{\rule[-2ex]{0pt}{2ex}\textbf{\@date}} 
  }

  \renewcommand{\headrulewidth}{0pt}
  \fancyhead[RE,RO]{}
  \fancyhead[LE,LO]{}
  \lfoot{\footnotesize\MakeUppercase\@lfooter}
  \cfoot{\footnotesize\thepage}
  \rfoot{\footnotesize\MakeUppercase\@rfooter}

  % CONFIGURACIÓN DE ESTILO DE CABECERA/PIE DE PÁGINA
  \renewcommand\section{%
    \@startsection{section}{1}{\z@}{0.1ex}{3ex}{\Huge\textbf}%
  }
  \let\oldsection\section
  \RenewDocumentCommand{\section}{s m g o}{%
    \clearpage
    \IfNoValueF{#3}
    {
      \includegraphics[width=\textwidth]{\@imagefolder/#3}
      \linebreak    
    }
    \rule{\textwidth}{1pt}
    \IfBooleanTF{#1}{\oldsection*{#2}}{\oldsection{#2}}%
    \IfNoValueF{#4}{\label{sec:#4}\ifdrafting
                                    \textit{\color{magenta}~Anchor sec:#4}
                                  \fi
                    }
  }

% CONFIGURACIÓN DE ESTILOS DE ENCABEZAMIENTO DE SUBSECCIÓN
\renewcommand\subsection{%
  \@startsection{subsection}{2}{\z@}{2ex}{2ex}{%
    \Large\bfseries\MakeUppercase}%
} 
  \let\oldsubsection\subsection 
  \RenewDocumentCommand{\subsection}{s m o}{%
    \IfBooleanTF{#1}{\oldsubsection*{#2}}{\oldsubsection{#2}}%
    \IfNoValueF{#3}{\label{sub:#3}\ifdrafting
                                    \textit{\color{magenta}~Anchor sub:#3}
                                  \fi
                    }
  }

\renewcommand\subsubsection{%
  \@startsection{subsubsection}{3}{\z@}{2ex}{2ex}{\large\textbf}%
  }
  \let\oldsubsubsection\subsubsection
  \RenewDocumentCommand{\subsubsection}{s m o}{%
    \IfBooleanTF{#1}{\oldsubsubsection*{#2}}{\oldsubsubsection{#2}}%
    \IfNoValueF{#3}{\label{sss:#3}\ifdrafting
                                    \textit{\color{magenta}~Anchor sss:#3}
                                  \fi
                    } 
  }

\newcommand{\subsubsubsection}[1]{%
  \begin{flushleft}
    \vspace{12pt} 
    \textbf{-- #1}
  \end{flushleft}
}

\newcommand{\subsubsubsubsection}[1]{%
  \begin{flushleft}
    \vspace{12pt} 
    \textbf{---- #1}
  \end{flushleft}
}

\newcommand{\subsubsubsubsubsection}[1]{%
  \begin{flushleft}
    \vspace{12pt} 
    \MakeUppercase{#1}
  \end{flushleft}
}

\newcommand{\subsubsubsubsubsubsection}[1]{%
  \begin{flushleft}
    \vspace{12pt} 
    \MakeUppercase{-- #1}
  \end{flushleft}
}

\newcommand{\subsubsubsubsubsubsubsection}[1]{%
  \begin{flushleft}
    \vspace{12pt} 
    \MakeUppercase{---- #1}
  \end{flushleft}
}

% OPCIONES DE BOSQUEJO
\newif\ifdrafting 
  \newcommand{\drafting}{%
    \draftingtrue 
  } 
  \newcommand{\temp}[1]{%
    \ifdrafting 
      \textit{\color{blue}#1} 
    \fi 
  }

  \newcommand{\crit}[1]{%
    \ifdrafting 
      \textit{\color{red}#1} 
    \fi 
  }

% CONFIGURACIÓN DEL TEXTO DE HIPERVÍNCULO
\definecolor{linkblue}{RGB}{0,69,217} 
\NewDocumentCommand{\link}{m g}{%
  \IfNoValueTF{#2}{% 
    \href{#1}{\color{linkblue}#1}%
  }
  {%
    \href{#1}{\color{linkblue}#2}%
  }%
}

% CONFIGURACIÓN DE IMÁGENES DE CABECERA DE SECCIÓN
\AtEndDocument{\vfill\textit{\@imageref}}
  \NewDocumentCommand{\image}{m m g}{%
    \begin{figure}[h!]
      \centering
      \includegraphics[width=#1\textwidth]{\@imagefolder/#2}
      \IfNoValueF{#3}{
        \caption{\label{img:#2} #3}
      }
  \end{figure}
}

% APOSTILLAS
\renewcommand{\arraystretch}{1.5} 
\NewDocumentCommand{\tipbox}{s m m}{%
  \IfBooleanTF{#1}{%
    \begin{wrapfigure}{r}{0.33\textwidth}
      \begin{tabular}{|p{0.3\textwidth}|}
        \cellcolor{black}
        \textbf{\textcolor{white}{#2}}\\
        \textit{#3}\\
        \hline
      \end{tabular}
    \end{wrapfigure}
  }{%
    \begin{figure}[h]
      \centering
      \begin{tabular}{|p{0.3\textwidth}|}
        \cellcolor{black}
        \textbf{\textcolor{white}{#2}}\\
        \textit{#3}\\
        \hline
      \end{tabular}
    \end{figure}
  } 
}

% LISTAS BONITAS
\newenvironment{nicelist}[1]{%
  \parindent1em 
  \textbf{#1}
    \begin{itemize}
}
{%
  \end{itemize}%
}
    
% ENUMERACIONES BONITAS
\newenvironment{niceenum}[1]{%
  \parindent1em 
  \textbf{#1}
    \begin{enumerate}
}
{%
  \end{enumerate}%
}

% DESCRIPCIONES BONITAS
\newenvironment{nicedesc}[1]{%
  \parindent1em
  \textbf{#1}
    \begin{description}
}
{%
  \end{description}%
}
    
% OPCIONES DE NUMERACIÓN
\newif\ifsectionnumbers 
\newcommand{\sectionnumbers}{%
  \sectionnumberstrue 
}

\newif\ifsubsectionnumbers 
\newcommand{\subsectionnumbers}{%
  \subsectionnumberstrue 
}

\newif\ifresetnumbering 
\NewDocumentCommand{\resetnumbering}{g g}{%
  \def\@nextsectionnumber{1} 
  \def\@nextpagenumber{1}
  \IfNoValueF{#1}{%
    \if\relax\detokenize{#1}\relax
    % parámetro vacío, no cambiar
    \else 
      \def\@nextsectionnumber{#1} 
    \fi 
  }   
  \IfNoValueF{#2}{%
    \if\relax\detokenize{#2}\relax
    % parámetro vacío, no cambiar
    \else 
      \def\@nextpagenumber{#2} 
    \fi 
  } 
  \resetnumberingtrue 
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AYUDA
\newcommand{\printhelp}{%
  \clearpage
  \textbf{\Huge ¡Bienvenido al Tiqqunazo!}\\
  
  \underline{Comandos para antes del \textbackslash begin\{document\}}\\

  Sobrescribir o ignorar y obtener estos valores predeterminados:
  
    \textbf{\textbackslash title\{Documento de prueba\}}
    
    \textbf{\textbackslash author\{\}}
    
    \textbf{\textbackslash project\{\}}
    
    \textbf{\textbackslash imagefolder\{.\}}
    
    \textbf{\textbackslash version\{Version 1.0\}}
    
    \textbf{\textbackslash footertext\{\textbackslash
      @title\}\{\textbackslash @author\}}
    
    \textbf{\textbackslash imageref\{\}}
    
  Opcional para definir y cambiar los aspectos visuales:
  
    \textbf{\textbackslash logo\{logo.png\}} \% Pone el logotipo en la
    caratula si se proporciona
    
    \textbf{\textbackslash nofootertext} \% Hace que en el pie de página
    aparezca sólo el número
    
    \textbf{\textbackslash footertext\{\}\{\}} \% Cambia el texto del
    pie de página al texto dado
  
  \underline{Comandos para el interior del documento}\\
  
  Sobreescriben los comandos normales:
  
    \textbf{\textbackslash section\{Título de la sección\}} \%
    Compotamiento predeterminado
    
    \textbf{\textbackslash section\{Título de la sección\}
    \{nombredeimagen.png\}} \% Encuentra la imagen en \textbackslash 
    imagefolder y pone la imagen en la cabecera\\
  
  Mejoras y variantes:
  
    \textbf{\textbackslash temp\{Texto en azul y cursiva para
    borradores\}} \% Sólo se muestra si \textbackslash drafting está en el 
    preámbulo
    
    \textbf{\textbackslash crit\{Texto en rojo y cursiva para
    borradores\}} \% Sólo se muestra si \textbackslash drafting está en el 
    preámbulo
    
    \textbf{\textbackslash link \{direccióndeenlace.com\}\{Texto a
    mostrar\}} \% Igual que href, pero con estilo personalizado. si no se 
    ofrece, el 2º parámetro sustituye al primero (muestra la url como texto 
    clicable)
    
    \textbf{\textbackslash image\{0.5\}\{nombre\_de\_imagen.png\}%
    \{Parámetro adicional opcional para la leyenda de la figura\}}%
    \% El primer parámetro es la anchura de la imagen en formato decimal de% 
    \textbackslash textwidth \& si se proporciona, el 3º parámetro incluirá% 
    el comando \textbackslash label {img:nombre\_de\_imagen.png} para que% 
    pueda remitirse con \textbackslash ref

    \textbf{\textbackslash begin\{nicelist\}\{Título de la lista\}...
    \textbackslash end\{nicelist\}} \% Lo mismo que itemize pero con un 
    título

    \textbf{\textbackslash begin\{niceenum\}\{Título de Enumeración\}... 
    \textbackslash end\{niceenum\}} \% Lo mismo que enumerate pero con un 
    título

    \textbf{\textbackslash tipbox\{Título del recuadro\}\{El texto que va 
    en el recuadro puede ser tan largo como quieras.\}} \% Usa la opción 
    con asterisco para rodear el texto si sabes que después viene un 
    párrafo\\
  
  ¡A disfrutar!\pagebreak
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%