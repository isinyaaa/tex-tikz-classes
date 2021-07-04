% IMTexam class is a exam typesetting class for LaTeX
%Copyright (C) 2020 - Isabella Basso do Amaral
%
%This program is free software: you can redistribute it and/or modify
%it under the terms of the GNU General Public License as published by
%the Free Software Foundation, either version 3 of the License, or
%(at your option) any later version.
%
%This program is distributed in the hope that it will be useful,
%but WITHOUT ANY WARRANTY; without even the implied warranty of
%MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%GNU General Public License for more details.
%
%You should have received a copy of the GNU General Public License
%along with this program.  If not, see <https://www.gnu.org/licenses/>.

% standard class definitions
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Iart}[2021/02/11 Isabella's book class is a fully customized article class for typesetting guides and documentations.]

% declare class options and toggles
\RequirePackage{etoolbox}
\newtoggle{engl}
\DeclareOption{english}{\global\settoggle{engl}{true}}
\newtoggle{dark}
\DeclareOption{dark}{\global\settoggle{dark}{true}}
\newtoggle{idx}
\DeclareOption{index}{\global\settoggle{idx}{true}}

% whatever is not recognized can be passed to the book class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

% now we load it
\LoadClass[a4paper, 11pt]{book}

% must have packages
\RequirePackage[top=0.8in, bottom=0.9in, left=1in, right=1in]{geometry} % margins
\RequirePackage[T1]{fontenc} % for font encoding
\RequirePackage{lmodern} % latin modern font
\RequirePackage[useregional]{datetime2} % for getting our local timezone
\RequirePackage{hyphenat} % for non-english hyphenation (e.g. abraca-/ndabra)
\RequirePackage[skip=0.5em,indent=3ex]{parskip} % for non-standard paragraph indentation
\RequirePackage{graphicx,float} % for inserting images
\RequirePackage{imakeidx} % index package

\iftoggle{idx}{
	\makeindex[intoc=false]
	\AtEndDocument{
		\phantomsection % assuming you have hyperref loaded, otherwise omit
		\addcontentsline{toc}{chapter}{\large\bfseries \iftoggle{engl}{Index}{Índice remissivo}}
%	\dottedcontents{index}{}{}{}
		\printindex}}{} % auto index

\RequirePackage{iftex} % check whether we're using pdftex or xelatex (or other)

\ifXeTeX
	\RequirePackage[stretch=10,shrink=10]{microtype} % the microtype package helps with some typesetting issues
	\AtBeginEnvironment{verbatim}{\microtypesetup{activate=false}} % we don't want it here
	\RequirePackage{polyglossia} % babel, but for xelatex
	%	\RequirePackage{fontspec}
	%	\newfontfamily\titlefont{utopia}
	%	
	\iftoggle{engl}{
		\setdefaultlanguage[]{english}
%		\PolyglossiaSetup{english}{indentfirst=false}
	}{
		\setdefaultlanguage[variant=brazilian]{portuguese}
%		\PolyglossiaSetup{portuguese}{indentfirst=false}
	}
\else
	\RequirePackage[utf8]{inputenc} % necessary for pdftex
	\RequirePackage[activate={true,nocompatibility},stretch=10,shrink=10,kerning=true,tracking=true]{microtype} % same stuff
	
	% below are some of the recommended settings for pdflatex
	\SetTracking{encoding={*}, shape=sc}{40}
	\SetExtraKerning[unit=space]
	{encoding={*}, family={bch}, series={*}, size={footnotesize,small,normalsize}}
	{\textendash={400,400}, % en-dash, add more space around it
		"28={ ,150}, % left bracket, add space from right
		"29={150, }, % right bracket, add space from left
		\textquotedblleft={ ,150}, % left quotation mark, space from right
		\textquotedblright={150, }} % right quotation mark, space from left
	\SetExtraKerning[unit=space]
	{encoding={*}, family={bch}, series={*}, size={footnotesize,small,normalsize}}
	{\textemdash={400,400}, % en-dash, add more space around it
		"28={ ,150}, % left bracket, add space from right
		"29={150, }, % right bracket, add space from left
		\textquotedblleft={ ,150}, % left quotation mark, space from right
		\textquotedblright={150, }} % right quotation mark, space from left
	\pretocmd{\tableofcontents}{\microtypesetup{protrusion=false}}{}{}
	\apptocmd{\tableofcontents}{\microtypesetup{protrusion=true}}{}{}
	\pretocmd{\listoffigures}{\microtypesetup{protrusion=false}}{}{}
	\apptocmd{\listoffigures}{\microtypesetup{protrusion=true}}{}{}
	\pretocmd{\listoftables}{\microtypesetup{protrusion=false}}{}{}
	\apptocmd{\listoftables}{\microtypesetup{protrusion=true}}{}{}
	
	% finally, babel
	\iftoggle{engl}{
		\RequirePackage[brazilian]{babel}
	}
	{
		\RequirePackage[english]{babel}
	}
\fi

\RequirePackage{relsize} % relative font sizing

% define a command for making parts of section titles smaller which doesn't affect the toc
\DeclareRobustCommand{\comment}[1]{\smaller[1]#1}

% for coloring our document
\RequirePackage{xcolor}

% set default colors for dark and normal themes
\iftoggle{dark}{
	\definecolor{papercolor}{HTML}{282828}
	\definecolor{textcolor}{HTML}{eeeeee} %{D8F5FF}
	\definecolor{theme}{HTML}{39AFEA}
	\definecolor{term}{HTML}{39EAAF}
	\definecolor{termref}{HTML}{9438EB}
	\definecolor{correct}{HTML}{EAAF39}
	\definecolor{not}{HTML}{EA3939}
}{
	\definecolor{papercolor}{HTML}{ffffff}
	\definecolor{textcolor}{HTML}{000000}
	\definecolor{theme}{HTML}{383e79}
	\definecolor{term}{HTML}{009b8e}
	\definecolor{termref}{HTML}{008080}
	\definecolor{correct}{HTML}{383e79}
	\definecolor{not}{HTML}{f68052}
}

% set commands for custom colors
\newcommand{\themecolor}[1]{\definecolor{theme}{HTML}{#1}}
\newcommand{\termcolor}[1]{\definecolor{term}{HTML}{#1}}
\newcommand{\termrefcolor}[1]{\definecolor{termref}{HTML}{#1}}
\newcommand{\correctcolor}[1]{\definecolor{correct}{HTML}{#1}}
\newcommand{\notcolor}[1]{\definecolor{not}{HTML}{#1}}

% change default font and page colors
\RequirePackage[pagecolor={papercolor}]{pagecolor}
\color{textcolor}

\usepackage{ccicons} % Creative Commons icons
\usepackage{scrextend} % KOMA-Script extension

% rules for figures etc.
\newcommand\figureruletop{%
	\noindent{\bf%
		\def\stuff{\makebox[0.4em][c]{/}}%
		\tiny\color{theme}%
		\stuff\leaders\hbox{\stuff}\hfill \hfil%
	}\par
}
\newcommand\figurerulebottom{%
	\noindent{\bf%
		\def\stuff{\makebox[0.4em][c]{/}}%
		\tiny\color{theme}%
		\stuff\leaders\hbox{\stuff}\hfill \hfil%
	}\par
}

\newenvironment{ruledfig}[1][1]{\figureruletop\par\noindent
	\begin{minipage}{#1\linewidth}
%\begin{figure}
			\centering}{%\end{figure}
		\end{minipage}
\figurerulebottom}

% %todo for text
\newcommand\TODO[1]{%
	\figureruletop
	
	\noindent%
	\texttt{\textcolor{lightgray}{/*}}\hfill%
	\textbf{\textcolor{theme}{TODO}}: #1%
	\hfill\texttt{\textcolor{lightgray}{*/}}%
	
	\figurerulebottom
}


\newcommand\note[1]{%
	\figureruletop
	
	\noindent%
%	\texttt{\textcolor{lightgray}{/*}}\hfill%
	\textbf{\textcolor{theme}{Note}}: #1%
%	\hfill\texttt{\textcolor{lightgray}{*/}}%
	
	\figurerulebottom
}


% make a new index category
\newcommand\defcategory[1]{%
	\filbreak%
	\outline{1}{#1}%
	\section{#1}%
	\nopagebreak[4]%
}

% define/highlight an indexed term
\newcommand\term[2][]{%
	\termnoindex[#1]{#2}%
	\index{#2}%
}
% define a non-indexed term
\newcommand\termnoindex[2][]{%
	\textit{\textbf{\textcolor{term}{#2}}}\label{\if\relax\detokenize{#1}\relax term:#2\else term:#1\fi}%
}

% define a reference indexed term
\newcommand\refterm[2][]{%
	\reftermnoindex[#1]{#2}%
	\index{#2}%
}
% define a reference non-indexed term
\newcommand\reftermnoindex[2][]{%
	\def\lab{\if\relax\detokenize{#1}\relax term:#2\else term:#1\fi}%
	\@ifundefined{r@\lab}{%
		% \textcolor{red}{\textit{#2}\textsuperscript{??}}%
		\message{APD Warning: Ref to undefined term \lab, ignoring.}%
		#2%
	}{%
		\textcolor{termref}{\textit{\hyperref[\lab]{#2}}}%
	}%
}

% or keyword (to help with typesetting)
\newcommand\ort{%
	\textbf{\textcolor{correct}{\iftoggle{engl}{or}{ou} }}
}
% not keyword
\newcommand\nott{%
	\textbf{\textcolor{not}{\iftoggle{engl}{NOT}{NÃO} }}
}
% avoid keyword
\newcommand\avdt{%
	\textit{\textcolor{not}{\iftoggle{engl}{Avoid:}{Evite:} }}
}

% lecture code
\def\@lcode{\relax}
\newcommand{\lcode}[1]{\gdef\@lcode{#1}}
% lecture name
\def\@lecture{\relax}
\newcommand{\lecture}[1]{\gdef\@lecture{#1}}
% keywords
\def\@keywords{\relax}
\newcommand{\keywords}[1]{\gdef\@keywords{#1}}
% subtitle
\def\@subtitle{}
\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}}
% email typesetting
\newcommand{\email}[1]{\ <\href{mailto:#1}{\nolinkurl{#1}}>}

% for making colortables breakable
\RequirePackage{tcolorbox}
\tcbuselibrary{breakable}

% to get an empty title page
\RequirePackage{titling,ifthen}

\renewcommand{\maketitle}{
	\startcontents % for the complete TOC
	\begin{titlingpage}
		\begin{center}
			\LARGE{\@title} %\\\hrulefill
			\\[0.5cm] %\baselineskip
			\ifthenelse{\equal{\@subtitle}{}}{}{\normalsize{\@subtitle} \\[0.5cm]} %\vfill
%			\begin{flushleft}
				\footnotesize{%
					\@author \\ 
				\@date} \\[1cm]
%			\end{flushleft}
		
		\begin{tcolorbox}[width=1\linewidth,
			colframe=theme,
			colback=papercolor,
			coltext=theme,
			halign=left,
			opacityback=1,
			arc=0mm,
			breakable]
			\vspace{0.2cm}% TODO use title in tcolorbox
			{\huge \iftoggle{engl}{Outline}{Visão geral}}\\[0.5cm]%
			\printcontents{l}{-1}[0]{} % make smaller toc
		\end{tcolorbox}
		\end{center}
	\end{titlingpage}
}

\RequirePackage{navigator} % allows for custom bookmarks etc
\pdfdef\term#1{#1}
\pdfdef\termnoindex#1{#1}
\pdfdef\refterm#1{#1}
\pdfdef\reftermnoindex#1{#1}
%\pdfdef\ce#1{#1}
%\pdfdef\ldots{...}
%\pdfdef\textit#1{-#1-}
%\pdfdef\mbox#1{#1}
%\pdfdef\ref#1{#1}
%\pdfdef\index#1{}
%\pdfdef\beta{beta}
%\pdfdef\textbf#1{*#1*}


% change sections numerals
\renewcommand{\thechapter}{\arabic{chapter}} 
\renewcommand{\thesection}{\Roman{section}}
\renewcommand{\thesubsection}{\alph{subsection}}

\RequirePackage{titlesec} % titling customization
\RequirePackage{titletoc} % custom toc entries

% break label text before touching page number
%\contentsmargin[30pt]{0em}

% set toc part entry style (line with "page")
\titlecontents{part}[0pt]{\vspace{0.2cm}}{}{\Large\bfseries\thepart}{}
[\iftoggle{engl}{\rule{0.89\textwidth}{0.8pt}}{\rule{0.864\textwidth}{0.8pt}}\ \strut\hfill\raisebox{-4pt}{\large \iftoggle{engl}{Page}{Página}}\ \rule{0.034\textwidth}{0.8pt}]

% change default TOC title
%\addto\captionsportuguese{% Replace "english" with the language you use
%	\renewcommand{\contentsname}%
%	{Sumário resumido}%
%}

% set toc chap entry style
\titlecontents{chapter} %section
[0em] %left
{\vspace{0.5em}} %above code
{\large\bfseries \iftoggle{engl}{Chapter}{Capítulo} \thecontentslabel \hspace{0.2pt} -- \hspace{0.2pt}} %numbered entry format
{} %numberless entry format
{\hfill\large\bfseries\thecontentspage} % filler page format
[\vspace{1pt}] % below code

% set toc section entry style
\titlecontents{section}[1.2em]{}{\thecontentslabel. \hspace{0.2pt}}
{}{\titlerule*[1pc]{.}\thecontentspage}[\vspace{1pt}]

% set toc subsection entry style
\titlecontents{subsection}[2.4em]{}{\thecontentslabel. \hspace{0.2pt}}
{\thesubsection}{\titlerule*[1pc]{.}\thecontentspage}[\vspace{0pt}]
%}

% have we passed part one?
\newtoggle{afterpartone}
\global\settoggle{afterpartone}{false}

% have we passed chapter one?
\newtoggle{afterchapone}
\global\settoggle{afterchapone}{false}

% part title formating
\titleformat{\part}[display]
{\centering\color{theme}\Huge}
{\partname\ \thepart}
{0.3em}
{\thispagestyle{empty}%\startcontents[parts]
}

% to vary colors based on chapter
% TODO make this color vary more flexibly
\definecolorseries{seriesc}{rgb}{last}{theme}[rgb]{0.918,0.224,0.56}
\resetcolorseries[5]{seriesc}

% before every part command do...
\pretocmd{\part}{
	\startcontents[parts] % start a new toc
	\global\settoggle{afterpartone}{true} % mark that we've passed the first part
	\global\settoggle{afterchapone}{false} % mark that we've not passed the first chapter
	\resetcolorseries[5]{seriesc} % reset the color series
}{}{}


% for making the custom section titles
\RequirePackage{tikz}
\usetikzlibrary{positioning,calc,backgrounds,arrows.meta,fadings,through}

% chapter title formating
\titleformat{\chapter}
{\color{currcolor}\huge}
{\hspace{-0.4in}\makebox[0pt][l]{\tikz[baseline=(text.base),fadingnode/.style={rectangle, right color=papercolor,shading=axis,shading angle=90, anchor=south west, minimum width={\linewidth + 0.4in}}]{
			\coordinate (A) at (0, 0);
			\coordinate (B) at (1\linewidth, 1.5\baselineskip);
			\path[use as bounding box] (A) rectangle (B);
			\node[fadingnode, minimum height=1pt,left color=currcolor!95!papercolor] at (A) {};
			\node[fadingnode,left color=currcolor!5!papercolor,minimum height=1.5\baselineskip] at ($ (A)+(0,1pt) $) {};
			\node[anchor=south west, text=currcolor](text) at (A) {\huge\thechapter |};
	}}
	\hspace{0.2in}}
{0.3em}
{\vspace{5pt}
	%\startcontents[chapters]
}

\titlespacing*{\chapter}{0in}{0pt}{10pt}

% make a colored list based on current chapter color
\RequirePackage{enumitem}
\newlist{citemize}{itemize}{1}
\setlist[citemize]{label=\textcolor{theme}{\textbullet}}

\pretocmd{\chapter}{
	\iftoggle{afterchapone}
	{\colorlet{currcolor}{seriesc!!+} % go to next color and save it to currcolor
		\setlist[citemize]{label=\textcolor{currcolor}{\textbullet}} % update citemize color
	}
	{\settoggle{afterchapone}{true}
		\colorlet{currcolor}{seriesc!!} % keep current color (first)
		\iftoggle{afterpartone}{ % if we've passed part one (not in preface anymore)...
			% then make a new toc
			\begin{tcolorbox}[width=1\linewidth,colframe=theme,colback=papercolor,coltext=theme,halign=left,opacityback=1,arc=0mm,breakable]
				\vspace{0.2cm}{\huge \iftoggle{engl}{Partial contents}{Sumário parcial}\\\iftoggle{engl}{\rule{0.888\textwidth}{0.8pt}}{\rule{0.86\textwidth}{0.8pt}}\ \strut\hfill\raisebox{-4pt}{\large \iftoggle{engl}{Page}{Página}}\ \rule{0.034\textwidth}{0.8pt}}\\[0.1cm]\printcontents[parts]{l}{0}[2]{}
			\end{tcolorbox}
			%\printcontents[parts]{l}{0}[1]{}
		}{}}
}{}{}

% section title formating
\titleformat{\section}
{\LARGE}
{\makebox[0pt][l]{\tikz[overlay,remember picture, baseline=(text.base),blocknode/.style={minimum width={0.3in},anchor=south west}]{
			\path (0,0) node[fill=currcolor!30!papercolor, text=textcolor,anchor=south west,name=textn,opacity=0] {\LARGE\thesection};
			\path let \p1=(textn.west), \p2=(textn.east), \n1={\x2 - \x1} in (-\n1 + 2pt, 0) coordinate (A);
			\coordinate (B) at (0.2in, 1.5\baselineskip);
			\path[use as bounding box] (A) rectangle (B);
			\node[anchor=south west, fill=currcolor!30!papercolor, text=textcolor](text) at (A) {\LARGE\thesection};
	}}
}
{0.3em}
{}

\titlespacing*{\section}{0in}{10pt}{5pt}

% subsection title formating
\titleformat{\subsection}
{\large}
{\makebox[0pt][l]{\tikz[overlay,remember picture, baseline=(text.base),blocknode/.style={minimum width={0.3in},anchor=south west}]{
			\path (0,0) node[fill=currcolor!30!papercolor, text=textcolor,anchor=south west,name=textn,opacity=0] {\LARGE\thesection};
			\path let \p1=(textn.west), \p2=(textn.east), \n1={\x2 - \x1} in (-\n1 + 2pt, 0) coordinate (A);
			\coordinate (B) at (0.2in, 1.5\baselineskip);
			\path[use as bounding box] (A) rectangle (B);
			%			\node[blocknode, minimum height=1pt,left color=theme!95!papercolor, right color=papercolor,shading=axis,shading angle=90] at (A) {};
			%			\node[blocknode,fill=theme!30!papercolor,minimum height=1.2\baselineskip] at ($ (A)+(0,0.5pt) $) {};
			\node[anchor=south west, fill=currcolor!30!papercolor, text=textcolor](text) at (A) {\large\thesubsection};
	}}
}
{0.3em}
{}

\titlespacing*{\subsection}{20pt}{10pt}{5pt}


\RequirePackage{fancyhdr} % header / footer
\RequirePackage{lastpage} % get a \LastPage value

% change header/footer{
\pagestyle{fancyplain}
\fancyhf{}
\fancyfoot[LE, RO]{\iftoggle{engl}{Page \thepage\ of \pageref{LastPage}}{Página \thepage\ de \pageref{LastPage}}}
\renewcommand{\headrulewidth}{0pt} % set a .5pt line straight through
\renewcommand{\footrulewidth}{0pt}


% setup hyperref (for some reason I couldn't get it to work setting it BEFORE titletoc)
% TODO report bug
\RequirePackage{hyperref}
\hypersetup{hidelinks,
	colorlinks=true,urlcolor=termref,linkcolor=theme}
\RequirePackage[all]{hypcap} % links take you BELOW captions
