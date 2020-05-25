%% study.cls
%% Copyright 2017-2020 David Purton
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is David Purton.
%
% This work consists of the files study.cls
\ProvidesClass{study}[2020/05/25 Bible Study Class (DCP)]

\RequirePackage{pdftexcmds}
\RequirePackage{iftex}

\ifx\useleadernotes\undefined
  \ltx@IfUndefined{pdf@shellescape}
    {}
    {\ifnum\pdf@shellescape=1
     \else
       \gdef\useleadernotes{0}%
     \fi}
\fi

\ifx\useleadernotes\undefined
  \ifluatex
    \pdf@system{%
      latexmk --lualatex --usepretex="\def\string\useleadernotes{0}" "\jobname"
    }%
    \pdf@system{%
      latexmk --lualatex --jobname="\jobname-leadernotes"
        --usepretex="\def\string\useleadernotes{1}" "\jobname"
    }%
  \fi
  \ifxetex
    \pdf@system{%
      latexmk --xelatex --usepretex="\def\string\useleadernotes{0}" "\jobname"
    }%
    \pdf@system{%
      latexmk --xelatex --jobname="\jobname-leadernotes"
        --usepretex="\def\string\useleadernotes{1}" "\jobname"
    }%
  \fi
  \expandafter\stop
\fi

\newif\ifbabel
\newif\ifform

\DeclareOption{a4paper}{%
  \PassOptionsToClass{a4paper}{article}%
  \PassOptionsToPackage{a4paper}{geometry}}
\DeclareOption{letterpaper}{%
  \PassOptionsToClass{letterpaper}{article}%
  \PassOptionsToPackage{letterpaper}{geometry}}
\DeclareOption{a5paper}{%
  \PassOptionsToClass{a5paper}{article}%
  \PassOptionsToPackage{a5paper}{geometry}}
\DeclareOption{babel}{%
  \babeltrue
}
\def\setstudypagelayout{}
\DeclareOption{2on1}{%
  \def\setstudypagelayout{%
    \pgfpagesuselayout{2 on 1}[a4paper,landscape]}}
\DeclareOption{repeated2up}{%
  \def\setstudypagelayout{%
    \pgfpagesuselayout{repeated 2-up}[a4paper,landscape]}}
\DeclareOption{form}{%
  \formtrue}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{a4paper}
\ProcessOptions
\LoadClass{article}

\ifbabel
%  \RequirePackage[nil]{babel}
%  \RequirePackage{fontspec}
%  \babelprovide[en-AU,main,language=Default]{australian}
%  \defaultfontfeatures{Ligatures=TeX}
%  \babelfont[australian]{rm}{Source Serif Pro}
%  \babelfont[australian]{sf}{Source Sans Pro}
%  \babelfont[australian]{sourcesansproextreme}[%
%    %BoldFont = Source Sans Pro Black,
%    %BoldItalicFont = Source Sans Pro Black Italic
%  ]{Source Sans Pro Extra Light}
%  \babelfont[australian]{sourcesansproextreme}[%
%    %BoldFont = Source Sans Pro Semibold,
%    %BoldItalicFont = Source Sans Pro Semibold Italic
%  ]{Source Sans Pro Light}
%  \renewcommand\familydefault{\sfdefault}
%  \def\sourcesansproextreme\sourcesansproextremefamily
%  \def\sourcesansprolight\sourcesansprolightfamily
\else
  \RequirePackage[default]{sourcesanspro}
\fi

\RequirePackage{realscripts}
\RequirePackage{microtype}
\RequirePackage{lettrine}
\RequirePackage[plain,headings]{nccfancyhdr}
\RequirePackage{footmisc}
\RequirePackage{calc}
\newlength{\psize}
\setlength{\psize}{\minof{\paperwidth}{\paperheight}}
\RequirePackage[headsep=7mm,includehead,margin=0.07\psize,marginparsep=-65mm,marginparwidth=65mm]{geometry}
\RequirePackage[inline]{enumitem}
\RequirePackage{graphicx}
\RequirePackage[table,cmyk]{xcolor}
\RequirePackage[normalem]{ulem}
\RequirePackage{multicol}
\RequirePackage{longtable}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\let\ifboolexpr\undefined
\RequirePackage{tikz}
\usetikzlibrary{positioning,chains,calc,arrows,matrix,intersections,
  decorations.text,backgrounds}
\RequirePackage[breakable,skins]{tcolorbox}
\RequirePackage{pantone+cmykcoated,pantone+colorbridgecoated-v3}
\RequirePackage{url}
\RequirePackage{pgfmorepages}

\pgfmorepagesloadextralayouts
\setstudypagelayout

\long\def\maketitle{%
  \par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent\hb@xt@ 1.8em{%
      \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum\col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@\@maketitle
    \fi
    \thispagestyle{empty}%
    \@thanks
  \endgroup
  \setcounter{footnote}{0}}

\newif\ifuseauthor
\newif\ifusedate
\newif\ifusefocuslogo

\usedatetrue
\usefocuslogotrue

\def\@maketitle{%
  \newpage
  \null
  \vskip 2em
  \begin{center}
    \let\footnote\thanks
    \ifusefocuslogo
      \includegraphics[height=2cm]{focus_adelaide_full_afesblue_cmyk.pdf}%
      \vskip 1.5em
    \fi
    {\LARGE\@title\par}%
    \ifuseauthor
      \vskip 1.5em
      {\large\lineskip .5em
       \begin{tabular}[t]{c}%
         \@author
       \end{tabular}%
       \par}%
    \fi
    \ifusedate
      \vskip 1em%
      {\large\@date}%
    \fi
  \end{center}%
  \par
  \vskip 1.5em}

\urlstyle{same}

\newcommand{\textelf}[1]{{\sourcesansproextreme #1}}
\newcommand{\textlf}[1]{{\sourcesansprolight #1}}
\newcommand{\textsbf}[1]{{\sourcesansprolight\bfseries #1}}
\newcommand{\textrbf}[1]{{\sourcesanspro\bfseries #1}}
\newcommand{\textbbf}[1]{{\sourcesansproextreme\bfseries #1}}
\newcommand{\elfseries}{\sourcesansproextreme}
\newcommand{\lfseries}{\sourcesansprolight}
\newcommand{\rbfseries}{\sourcesanspro\bfseries}
\newcommand{\sbfseries}{\sourcesansprolight\bfseries}
\newcommand{\bbfseries}{\sourcesansproextreme\bfseries}

\newcommand{\timer}[3]{%
  \smash{%
    \begin{tikzpicture}[scale=#1,line cap=rect,baseline={([yshift=-0.8ex]current
      bounding box.center)}]
      \fill [PANTONE-P-65-4-C, rotate=90] (-#2:1) arc[start angle=-#2, end
          angle=-#3, radius=1] -- (0,0) -- cycle;
      \fill [black!60] (0.1,1) -- (0.1,1.2) -- (-0.1,1.2) -- (-0.1,1) --
        cycle;
      \fill [black!60] (0.15,1.19) -- (0.15,1.45) -- (-0.15,1.45) -- (-0.15,1.19) --
        cycle;
      \draw [black!40, line width=1] (0,0) circle [radius=1];
      \draw [black!20, line width=0.5] (0,0) circle [radius=0.95];
      \foreach \angle in {60,30,...,-270}
        \draw[black!80, line width=0.5] (\angle:0.7) -- (\angle:0.8);
      \foreach \angle in {0,90,180,270}
        \draw[black!80, line width=0.5] (\angle:0.55) -- (\angle:0.8);
      \fill [black!80] (0,0) circle [radius=0.1];
      \fill [black!80,rotate=-#3] (0.05,0) -- (0,0.7) -- (-0.05,0) -- cycle;
    \end{tikzpicture}%
  }%
}
\newcommand{\firsttimer}{\timer{0.4}{0}{60}}
\newcommand{\secondtimer}{\timer{0.4}{60}{270}}
\newcommand{\thirdtimer}{\timer{0.4}{270}{360}}

\newcommand*{\yellowquotefont}{\footnotesize}
\newcommand*{\greenboxfont}{\small}

\tcbset{greenbox/.style={enhanced jigsaw, breakable, colback=white,
  colframe=PANTONE-P-142-8-C, left=2mm, right=2mm, fonttitle=\bfseries},
  pad at break*=0mm, fontupper=\greenboxfont,
  before upper=\setlength{\parindent}{1em}\everypar{{\setbox0\lastbox}\@minipagefalse\everypar{}}}
\tcbset{yellowquote/.style={enhanced jigsaw, breakable, colback=white,
  colframe=PANTONE-P-4-16-C, boxrule=0.5mm, leftrule=10pt, sharp corners,
  segmentation style={solid, PANTONE-P-4-16-C, line width=0.5mm},
  left=2mm, right=2mm, pad at break*=0mm, fontupper=\yellowquotefont}}

\newtcolorbox{greenbox}[1][]{greenbox,#1}
\newtcolorbox{yellowquote}[1][]{yellowquote,#1}

\newcolumntype{L}{>{\raggedright\arraybackslash}X}
\newcolumntype{R}{>{\raggedleft\arraybackslash}X}
\newcolumntype{C}{>{\centering\arraybackslash}X}

\newcommand{\gap}[1][3cm plus 1cm minus 1cm]{\strut\nobreak\leaders\hrule\hskip #1\strut}

\newcommand{\truefalse}{True \slash{} False}

\newcommand{\checkbox}[1][]{%
  ☐%
  \if\relax\detokenize{#1}\relax
  \else
    \enskip
    #1%
  \fi}

\flushbottom

\newcommand{\tighter}{%
  \ifform
    \setlength{\studyitemsep}{24mm}
    \let\skipanswerspace\skipnexttextfield
    \let\skipafterenumspace\skipnexttextfield
  \else
    \setlength{\studyitemsep}{8mm plus 5mm minus 2mm}
    \renewcommand{\skipanswerspace}{\vspace{\multlength{\studyitemsep}{-1}}}
    \renewcommand{\skipafterenumspace}{\vspace{\multlength{\studyitemsep}{-4/5}}}
  \fi
}

\newcommand{\looser}{%
  \ifform
    \setlength{\studyitemsep}{36mm}
    \let\skipanswerspace\skipnexttextfield
    \let\skipafterenumspace\skipnexttextfield
  \else
    \setlength{\studyitemsep}{12mm plus 5mm minus 2mm}
    \renewcommand{\skipanswerspace}{\vspace{\multlength{\studyitemsep}{-1}}}
    \renewcommand{\skipafterenumspace}{\vspace{\multlength{\studyitemsep}{-4/5}}}
  \fi
}

\setlength{\parindent}{0cm}
\newlength{\studyitemsep}
\ifform
  \setlength{\studyitemsep}{30mm}
\else
  \setlength{\studyitemsep}{10mm plus 5mm minus 2mm}
\fi
\newcommand{\skipanswerspace}{\vspace{\multlength{\studyitemsep}{-1}}}
\newcommand{\skipafterenumspace}{\vspace{\multlength{\studyitemsep}{-4/5}}}
\newcommand{\addanswerspace}{\vspace{\studyitemsep}}
\newcommand{\multlength}[2]{%
    \glueexpr#1*#2}
\setlist[enumerate]{itemsep=\studyitemsep}
\setlist[enumerate,1]{resume,after=\vspace{\multlength{\studyitemsep}{4/5}}}
\setlist[description]{font=\normalfont\sbfseries}
\setlist[itemize]{itemsep=0ex, leftmargin=7mm}
\renewcommand\arraystretch{1.2}

\newcommand*{\noitembreak}{%
  \@afterheading\vspace{\parsep}}

\newdimen\headwidth
\setlength{\headwidth}{\textwidth}
\renewcommand{\headrulewidth}{\z@}

\def\@header#1#2#3{%
  \setlength{\fboxsep}{1pt}%
  \makebox[0pt][l]{\hspace{2\fboxsep}#1}%
  \framebox[\headwidth][c]{#2\strut}%
  \makebox[0pt][r]{#3\hspace{2\fboxsep}}}

\def\study#1{\gdef\@study{#1}}
\def\@study{\@latex@warning@no@line{No \noexpand\study given}}
\def\passage#1{\gdef\@passage{#1}}
\def\@passage{\@latex@warning@no@line{No \noexpand\passage given}}

\newpagestyle{study}{%
  \fancyhead[LO]{\@header{\@study}{\emph{\@title}}{\textbf{\@passage}}}%
  \fancyhead[LE]{\@header{\textbf{\@passage}}{\emph{\@title}}{\@study}}%
}

\def\titlemark{}
\newpagestyle{studyheadings}[headings]{%
  \fancyhead[ce]{\nouppercase{%
    \fancycenter{\thepage}{}{%
      \addfontfeatures{Letters=SmallCaps,Letters=UppercaseSmallCaps}%
      \@title}}}%
  \fancyhead[co]{\nouppercase{\fancycenter{%
    \addfontfeatures{Letters=SmallCaps,Letters=UppercaseSmallCaps}%
    \leftmark}{}{\thepage}}}%
  \def\headrulewidth{0.4pt}%
}

\pagestyle{study}

\newcommand*{\leadernotescolour}{\color{black!40}}
\newcommand{\leadernotesfont}{}
\newskip\savedparindent
\newskip\savedparskip
\newskip\savedrightskip
\newcommand{\blap}[1]{%
  \savedparindent\parindent
  \savedparskip\parskip
  \savedrightskip\rightskip
  \noindent
  \begin{minipage}[t][0pt]{\linewidth}
    \parindent\savedparindent
    \parskip\savedparskip
    \rightskip\savedrightskip
    #1%
  \end{minipage}%
  \vspace*{-\parskip}\vspace*{-\baselineskip}%
}
\long\def\ifuseleadernotes{%
  \ifnum\useleadernotes=1\relax
    \expandafter\@firstoftwo
  \else
    \expandafter\@secondoftwo
  \fi}
\long\def\leadernotes{\@ifstar\@leadernotes@star\@leadernotes}
\long\def\@leadernotes#1{%
  \ifnum\useleadernotes=1%
    \begingroup
    \leadernotesfont\leadernotescolour
    \ifhmode #1\else #1\par\fi
    \endgroup
  \fi}
\long\def\@leadernotes@star#1{%
  \ifnum\useleaderntoes=1%
    \blap{%
      \begingroup
      \leadernotesfont\leadernotescolour#1%
      \endgroup}%
  \fi}
\long\def\tblleadernotes#1{%
  \ifnum\useleadernotes=1%
    \leavevmode
    \leadernotesfont\leadernotescolour#1%
  \fi}

\newcommand\LORD{\textsc{Lord}}

\setcounter{secnumdepth}{2}

\renewcommand\section{\@startsection{section}{1}{\z@}%
  {-2.75ex \@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\flushleft\normalfont\large\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-2.5ex\@plus -1ex \@minus -.2ex}%
  {1.25ex \@plus .2ex}%
  {\flushleft\normalfont\normalsize\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {-2.25ex\@plus -1ex \@minus -.2ex}%
  {1ex \@plus .2ex}%
  {\flushleft\normalfont\normalsize\sourcesansprolight\bfseries}}

\renewcommand*{\LettrineSecondString}{X}
\newcommand*{\ch}[1]{\lettrine[findent=0.5em,nindent=0em]{#1}{}}
\let\vs\textsuperscript
\newcommand*{\vslap}[1]{%
  \strut\llap{\textsuperscript{#1}}%
}
\newcommand*{\biblequotefont}{\footnotesize}
\newlength\psalmleftskip
\setlength\psalmleftskip{1em}
\newlength\psalmindent
\setlength{\psalmindent}{1em}
\newlength{\psalmchapindentlength}
\def\psalmchapindent{%
  \ifx\vs\vslap
    \hspace*{\psalmchapindentlength}%
  \else
    \hspace*{-\psalmindent}%
    \ifdim\psalmindent<\psalmchapindentlength
      \hspace*{\psalmchapindentlength}%
     \else
       \hspace*{\psalmindent}%
    \fi
  \fi}

\newif\ifpsalmdone

\newenvironment{psalm}
  {\par
   \global\psalmdonefalse
   \raggedright
   \leftskip\psalmleftskip
   \parskip 0pt
   \parindent\psalmindent
   \def\vs##1{\llap{\textsuperscript{##1}}}%
   \def\ch##1{%
     \lettrine[findent=0.5em,nindent=0em]{\hspace{-\psalmleftskip}##1}{}%
     \setlength{\psalmchapindentlength}{\LettrineWidth}%
     \addtolength{\psalmchapindentlength}{0.5em}%
     }%
   \def\par{%
     \ifvmode
       \let\vs\vslap
       \noindent
     \else
       \def\vs####1{\hspace{-\psalmindent}\vslap{####1}\hspace{\psalmindent}}
       \endgraf
     \fi
     \hangindent=3\psalmindent}
   \obeylines
  }{%
    \global\psalmdonetrue
    \global\everypar{\global\psalmdonefalse\everypar{}}
  }

\newcommand*{\bibleversion}{NIVUK}
\newcommand{\formatbibleversion}{%
  \def\empty@bibleversion{}%
  \ifx\empty@bibleversion\bibleversion
  \else
    \space(\bibleversion)%
  \fi}
\newcommand{\formatbibleref}[1]{%
  \textsbf{#1\formatbibleversion}}

\newenvironment{biblequote}[1][]%
  {%
    \par
    \global\psalmdonefalse
    \parindent 1em
    \biblequotefont
    \def\biblequote@ref{#1}%
    \def\empty@biblequote@ref{}%
    \ifx\empty@biblequote@ref\biblequote@ref%
      \def\biblequote@ref{}%
    \else
      \def\biblequote@ref{%
        {\unskip\nobreak\hfil\penalty50\hskip2em\hbox{}\nobreak
        \hfil\formatbibleref{#1}\parfillskip=0pt \finalhyphendemerits=0
            \par}}%
    \fi
    \noindent\ignorespaces
  }{%
    \ifpsalmdone
      \vspace{-\baselineskip}%
    \fi
    \biblequote@ref
  }

\newenvironment{bookquote}[1][]%
  {%
    \renewcommand*{\biblequotefont}{\small}%
    \renewcommand{\formatbibleref}[1]{(#1)}
    \begin{biblequote}[#1]
  }{%
    \end{biblequote}
  }

\newenvironment{yellowbiblequote}[1][]{%
  \begin{yellowquote}
    \begin{biblequote}[#1]
}{%
    \end{biblequote}
  \end{yellowquote}
}

\newenvironment{greenbookquote}[1][]{%
  \begin{greenbox}
    \begin{bookquote}[#1]
}{%
    \end{bookquote}
  \end{greenbox}
}

\renewcommand\@makefntext[1]{%
    \parindent\footnotemargin\@thefnmark.\@\space\footnotelayout #1}

\renewcommand\thanks[1]{%
  \begingroup
    \renewcommand\@makefntext[1]{%
      \parindent\footnotemargin\footnotelayout #1}%
    \renewcommand\thefootnote{}\footnote{#1}%
    \addtocounter{footnote}{-1}%
  \endgroup}

\newfontfamily\symbola{Symbola}[
  ItalicFont=Symbola,
  BoldFont=Symbola,
  BoldItalicFont=Symbola]

\tikzset{
  -|-/.style={
    to path={
      (\tikztostart) -| ($(\tikztostart)!#1!(\tikztotarget)$) |- (\tikztotarget)
      \tikztonodes
    }
  },
  -|-/.default=0.5,
  |-|/.style={
    to path={
      (\tikztostart) |- ($(\tikztostart)!#1!(\tikztotarget)$) -| (\tikztotarget)
      \tikztonodes
    }
  },
  |-|/.default=0.5,
}

% Form settings

\ifform

  \RequirePackage{xparse}
  \RequirePackage{xpatch}


  % Begin PDF form code

  \RequirePackage{l3pdf}

  \ExplSyntaxOn

  % # l3pdf extensions

  \cs_new_protected:Npn \__study_pdf_catalog_gput:nn #1#2
    { \exp_args:Nnx \__pdf_backend_catalog_gput:nn {#1} {#2} }

  % ## l3pdf annotation extensions
  \cs_new_protected:Npn \__study_pdf_annotation:nnnn #1#2#3#4
    { \__pdf_backend_annotation:nnnn {#1} {#2} {#3} {#4} }
  \cs_generate_variant:Nn \__study_pdf_annotation:nnnn { nnnx }
  \cs_new:Npn \__study_pdf_annotation_last:
    { \__pdf_backend_annotation_last: }

  % # default font object

  \pdf_object_new:nn { helv } { dict }
  \pdf_object_write:nx { helv }
    {
      /Type ~ /Font \iow_newline:
      /Subtype ~ /Type1 \iow_newline:
      /Name ~ /Helv \iow_newline:
      /BaseFont ~ /Helvetica
    }

  % # variables

  % ## global variables
  \clist_new:N \g__study_fields_clist
  \int_new:N \g__study_field_id_count_int

  % ## local variables
  \clist_new:N \l__study_radio_obj_clist
  \clist_new:N \l__study_radio_refs_clist
  \int_new:N \l__study_radio_count_int
  \tl_new:N \l__study_radio_id_tl

  % # l3keys set up

  \keys_define:nn { study }
    {
      multiline    .bool_set:N       = \l__study_field_multiline_bool,
      width        .dim_set:N        = \l__study_field_wd_dim,
      width        .value_required:n = true,
      height       .dim_set:N        = \l__study_field_ht_dim,
      height       .value_required:n = true,
      depth        .dim_set:N        = \l__study_field_dp_dim,
      depth        .value_required:n = true,
    }

  % # appearance streams

  \pdf_object_new:nn { yes } { stream }
  \pdf_object_write:nx { yes }
    {
      {
        /Type ~ /XObject \iow_newline:
        /Subtype ~ /Form \iow_newline:
        /FormType ~ 1 \iow_newline:
        /BBox ~ [ ~ 0 ~ 0 ~ 10 ~ 10 ~ ] \iow_newline:
        /Resources ~ << ~ /ProcSet ~ [ ~ /PDF ~ ] ~ >>
      }
      {
        0.02 ~ 0.14 ~ 0 ~ 0 ~ k \iow_newline:
        0 ~ 0 ~ 10 ~ 10 ~ re \iow_newline:
        f \iow_newline:
        0 ~ 0 ~ 0 ~ 1 ~ k \iow_newline:
        2 ~ 2 ~ m \iow_newline:
        8 ~ 8 ~ l \iow_newline:
        2 ~ 8 ~ m \iow_newline:
        8 ~ 2 ~ l \iow_newline:
        s
      }
    }

  \pdf_object_new:nn { off } { stream }
  \pdf_object_write:nx { off }
    {
      {
        /Type ~ /XObject \iow_newline:
        /Subtype ~ /Form \iow_newline:
        /FormType ~ 1 \iow_newline:
        /BBox ~ [ ~ 0 ~ 0 ~ 10 ~ 10 ~ ] \iow_newline:
        /Resources ~ << ~ /ProcSet ~ [ ~ /PDF ~ ] ~ >>
      }
      {
        0.02 ~ 0.14 ~ 0 ~ 0 ~ k \iow_newline:
        0 ~ 0 ~ 10 ~ 10 ~ re \iow_newline:
        f
      }
    }

  \cs_new_protected:Nn \__study_text_field_ap:nn
    {
      \pdf_object_now:nx { stream }
        {
          {
            /Type ~ /XObject \iow_newline:
            /Subtype ~ /Form \iow_newline:
            /BBox ~ [ ~ 0 ~ 0 ~
              \dim_to_decimal_in_bp:n { #1 } ~
              \dim_to_decimal_in_bp:n { #2 } ~ ] \iow_newline:
            /Resources ~ << ~ /ProcSet ~ [ ~ /PDF ~ /Text ~ ] \iow_newline:
              /Font ~ << ~ /Helv ~ \pdf_object_ref:n { helv } ~ >> \iow_newline:
              >>
          }
          {
            0.02 ~ 0.14 ~ 0 ~ 0 ~ k \iow_newline:
            0 ~ 0 ~
              \dim_to_decimal_in_bp:n { #1 } ~
              \dim_to_decimal_in_bp:n { #2 } ~ re \iow_newline:
            f
          }
        }
    }

  % # form set up

  \cs_new_protected:Nn \__study_field_add_to_list:n
    {
      \clist_gput_right:Nx \g__study_fields_clist { #1 }
    }

  \cs_new_protected:Nn \__study_field_add_to_aux_file:n
    {
      \legacy_if:nT { @filesw }
        {
          \iow_shipout_x:Nn \@mainaux
            {
              \exp_not:n
                {
                  \csname ~ __study_field_add_to_list:n \endcsname { #1 }
                }
            }
        }
    }
  \cs_generate_variant:Nn \__study_field_add_to_aux_file:n { x }

  \cs_new_protected:Nn \__study_acroform:
    {
      \clist_if_empty:NF \g__study_field_annots_clist
        {
          \pdf_object_new:nn { acroform } { dict }
          \pdf_object_write:nx { acroform }
            {
              /Fields ~ [ ~ \clist_use:Nn \g__study_fields_clist { ~ } ~ ] \iow_newline:
              /DA ~ (/Helv ~ 7 ~ Tf ~ 0 ~ g) \iow_newline:
              /DR ~ << ~ /Font ~ << ~
                /Helv ~ \pdf_object_ref:n { helv } ~ >> ~ >>
            }
          \__study_pdf_catalog_gput:nn
            { AcroForm }
            { \pdf_object_ref:n { acroform } }
        }
    }

  \AtEndDocument{\__study_acroform:}

  % # field macros

  \cs_new_protected:Nn \__study_checkbox_field:n
    {
      \group_begin:
        \dim_set:Nn \l_tmpa_dim { \box_ht:N \strutbox }
        \mode_leave_vertical:
        \hbox_to_wd:nn
          { \l_tmpa_dim }
          {
            \vrule width 0pt height 0.9 \l_tmpa_dim depth  0.1 \l_tmpa_dim
            \__study_pdf_annotation:nnnx
              { \dim_use:N \l_tmpa_dim }
              { \dim_eval:n { 0.9 \l_tmpa_dim } }
              { \dim_eval:n { 0.1 \l_tmpa_dim } }
              {
                /Subtype ~ /Widget \iow_newline:
                /FT ~ /Btn \iow_newline:
                /F ~ 4 \iow_newline:
                /T ~ ( study_field_id_ \int_use:N \g__study_field_id_count_int ) \iow_newline:
                /V ~ /Off \iow_newline:
                /AS ~ /Off \iow_newline:
                /AP ~ << \iow_newline:
                  /D ~ << ~
                    /Yes ~ \pdf_object_ref:n { yes } ~
                    /Off ~ \pdf_object_ref:n { off } ~ >> \iow_newline:
                  /N ~ << ~
                    /Yes ~ \pdf_object_ref:n { yes } ~
                    /Off ~ \pdf_object_ref:n { off } ~ >> \iow_newline:
                  >>
              }
            \hfill
          }
        \tl_if_empty:nF { #1 }
          {
            \enskip
            #1
          }
        \__study_field_add_to_aux_file:x { \__study_pdf_annotation_last: }
        \int_gincr:N \g__study_field_id_count_int
      \group_end:
    }

  \cs_new_protected:Nn \__study_radio_field:n
    {
      \group_begin:
        \tl_set:Nn \l__study_radio_id_tl
          { study_field_id_ \int_use:N \g__study_field_id_count_int }
        \pdf_object_new:nn { \l__study_radio_id_tl } { dict }
        \dim_set:Nn \l_tmpa_dim { \box_ht:N \strutbox }
        \clist_clear:N \l__study_radio_refs_clist
        \int_zero:N \l__study_radio_count_int
        \clist_set:Nn \l__study_radio_obj_clist { #1 }
        \mode_leave_vertical:
        \clist_map_inline:Nn \l__study_radio_obj_clist
          {
            \hbox_to_wd:nn
              { \l_tmpa_dim }
              {
                \vrule width 0pt height 0.9 \l_tmpa_dim depth  0.1 \l_tmpa_dim
                \__study_pdf_annotation:nnnx
                  { \dim_use:N \l_tmpa_dim }
                  { \dim_eval:n { 0.9 \l_tmpa_dim } }
                  { \dim_eval:n { 0.1 \l_tmpa_dim } }
                  {
                    /Subtype ~ /Widget \iow_newline:
                    /Parent ~ \pdf_object_ref:n { \l__study_radio_id_tl } \iow_newline:
                    /FT ~ /Btn \iow_newline:
                    /F ~ 4 \iow_newline:
                    /AS ~ /Off \iow_newline:
                    /AP ~ << \iow_newline:
                      /D ~ << ~
                        /Yes \int_use:N \l__study_radio_count_int \c_space_tl \pdf_object_ref:n { yes } ~
                        /Off ~ \pdf_object_ref:n { off } ~ >> \iow_newline:
                      /N ~ << ~
                        /Yes \int_use:N \l__study_radio_count_int \c_space_tl \pdf_object_ref:n { yes } ~
                        /Off ~ \pdf_object_ref:n { off } ~ >> \iow_newline:
                      >>
                  }
                \hfill
              }
            \clist_put_right:Nx \l__study_radio_refs_clist
              { \__study_pdf_annotation_last: }
            \int_incr:N \l__study_radio_count_int
            \c_space_tl ##1 \enskip
          }
        \unskip
        \pdf_object_write:nx
          { \l__study_radio_id_tl }
          {
            /Kids ~ [ ~ \clist_use:Nn \l__study_radio_refs_clist { ~ } ~ ] \iow_newline:
            /FT ~ /Btn \iow_newline:
            /Ff ~ 49152 \iow_newline:
            /T ~ ( \l__study_radio_id_tl ) \iow_newline:
            /V ~ /Off
          }
        \__study_field_add_to_aux_file:x { \__study_pdf_annotation_last: }
        \int_gincr:N \g__study_field_id_count_int
      \group_end:
    }

  \cs_new_protected:Nn \__study_text_field:n
    {
      \group_begin:
        \keys_set:nn { study }
          {
            multiline = false,
            width     = 100bp ,
            height    = \box_ht:N \strutbox ,
            depth     = \box_dp:N \strutbox
          }
        \tl_if_empty:nF { #1 }
          {
            \keys_set:nn { study } { #1 }
          }
        \__study_text_field_ap:nn
          { \l__study_field_wd_dim }
          { \l__study_field_ht_dim + \l__study_field_dp_dim - \lineskip }
        \mode_leave_vertical:
        \hbox_to_wd:nn
          { \l__study_field_wd_dim }
          {
            \vrule width 0pt height \l__study_field_ht_dim depth \l__study_field_dp_dim
            \__study_pdf_annotation:nnnx
              { \dim_use:N \l__study_field_wd_dim }
              { \dim_eval:n { \l__study_field_ht_dim - 0.5 \lineskip } }
              { \dim_eval:n { \l__study_field_dp_dim - 0.5 \lineskip } }
              {
                /Subtype ~ /Widget \iow_newline:
                /FT ~ /Tx \iow_newline:
                /F ~ 4 \iow_newline:
                \bool_if:NT \l__study_field_multiline_bool
                  {
                    /Ff ~ 4096 \iow_newline:
                  }
                /T ~ ( study_field_id_ \int_use:N \g__study_field_id_count_int ) \iow_newline:
                /MK ~ << ~ /BG ~ [ ~ 0.02 ~ 0.14 ~ 0 ~ 0 ~ ] ~ >> \iow_newline:
                /AP ~ << ~ /N ~  \pdf_object_last: \c_space_tl >>
              }
            \hfill
          }
        \__study_field_add_to_aux_file:x { \__study_pdf_annotation_last: }
        \int_gincr:N \g__study_field_id_count_int
      \group_end:
    }

  % End PDF form code

  \bool_new:N \g__study_skip_after_text_field_bool
  \bool_new:N \g__study_item_patched_bool
  \bool_new:N \g__study_skip_next_text_field_bool
  \int_new:N \g__study_field_name_int

  \cs_new_protected:Nn \__study_insert_text_field:
    {
      \bool_if:NTF \g__study_skip_next_text_field_bool
        {
          \bool_gset_false:N \g__study_skip_next_text_field_bool
        }
        {
          \par
          \__study_text_field:n
            {
              multiline , width = \linewidth ,
              depth = \dim_eval:n { \studyitemsep - 0.9 \box_ht:N \strutbox }
            }
          \skip_vertical:n { 1mm plus 1.5cm }
        }
    }

  \cs_set_eq:NN \__study_unpatched_item \item

  \cs_new_protected:Nn \__study_patch_item:
    {
      \bool_if:NF \g__study_item_patched_bool
        {
          \xpretocmd \item
            {
              \legacy_if:nTF { @newlist }
                {
                  \bool_gset_false:N \g__study_skip_next_text_field_bool
                }
                {
                  \__study_insert_text_field:
                }
                \bool_gset_false:N \g__study_skip_after_text_field_bool
            }
            { }
            { }
          \bool_gset_true:N \g__study_item_patched_bool
        }
    }

  \NewDocumentCommand \insaftertextfield { }
    {
      \bool_if:NF \g__study_skip_after_text_field_bool
        {
          \__study_insert_text_field:
          \bool_gset_true:N \g__study_skip_after_text_field_bool
          \bool_gset_true:N \g__study_skip_next_text_field_bool
        }
    }

  \NewDocumentCommand \instextfield { }
    {
      \__study_insert_text_field:
    }

  \NewDocumentCommand \patchitem { }
    {
      \__study_patch_item:
    }

  \NewDocumentCommand \unpatchitem { }
    {
      \cs_set_eq:NN \item \__study_unpatched_item
      \bool_gset_false:N \g__study_item_patched_bool
    }

  \NewDocumentCommand \skipnexttextfield { }
    {
      \bool_gset_true:N \g__study_skip_next_text_field_bool
    }

  \RenewDocumentCommand \gap { O { 3cm } }
    {
      \bool_if:NTF \g__study_skip_next_text_field_bool
        {
          \bool_gset_false:N \g__study_skip_next_text_field_bool
        }
        {
          \enskip
          \__study_text_field:n { width = #1 }
          \enskip
        }
    }

  \RenewDocumentCommand \truefalse { }
    {
      \__study_radio_field:n { True, False }
    }

  \RenewDocumentCommand \checkbox { o }
    {
      \IfNoValueTF { #1 }
        {
          \__study_checkbox_field:n { }
        }
        {
          \__study_checkbox_field:n { #1 }
        }
    }

  \RenewDocumentCommand \addanswerspace { }
    {
      \bool_set_false:N \g__study_skip_next_text_field_bool
      \__study_insert_text_field:
    }

  \ExplSyntaxOff

  \setlist[enumerate]{itemsep=0pt plus 0.5cm, before=\unpatchitem\patchitem,
    after=\insaftertextfield}
  \setlist[enumerate,1]{resume}
  \setlist[itemize]{before=\unpatchitem, after=\patchitem}
  \setlist[description]{before=\unpatchitem, after=\patchitem,
    font=\normalfont\sbfseries}

  \let\skipanswerspace\skipnexttextfield
  \let\skipafterenumspace\skipnexttextfield

\fi

\providecommand\patchitem{}
\providecommand\unpatchitem{}

\providecommand\instextfield{}
\providecommand\skipnexttextfield{\skipanswerspace}

