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

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{IMTbook}[2020/07/21 Isabella's Maths and Tikz book class template is a fully customized book class for typesetting books and booklets.]

\RequirePackage{etoolbox}
\newtoggle{engl}
\DeclareOption{english}{\global\settoggle{engl}{true}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

\LoadClass[a4paper, 11pt]{book}

\RequirePackage[top=2.3cm, bottom=2.4cm, left=3.2cm, right=4cm]{geometry} % margins
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern} % more adequate font for portuguese language
\RequirePackage[useregional]{datetime2}
\RequirePackage{hyphenat}
\RequirePackage[hidelinks,colorlinks=true,urlcolor=blue,linkcolor=black]{hyperref}
\RequirePackage[all]{hypcap}
\RequirePackage{graphicx, float}

\RequirePackage{iftex}

\ifXeTeX
	\RequirePackage[stretch=10,shrink=10]{microtype}
	\AtBeginEnvironment{verbatim}{\microtypesetup{activate=false}}
	\RequirePackage{polyglossia}
	%	\RequirePackage{fontspec}
	%	\newfontfamily\titlefont{utopia}
	%	
	\iftoggle{engl}{
		\setdefaultlanguage[]{english}
		\PolyglossiaSetup{english}{indentfirst=false}
	}{
		\setdefaultlanguage[variant=brazilian]{portuguese}
		\PolyglossiaSetup{portuguese}{indentfirst=false}
	}
\else
	\RequirePackage[utf8]{inputenc}
	\RequirePackage[activate={true,nocompatibility},stretch=10,shrink=10,kerning=true,tracking=true]{microtype}
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
	%	
	\iftoggle{engl}{
		\RequirePackage[brazilian]{babel}
	}
	{
		\RequirePackage[english]{babel}
	}
\fi

\def\@subtitle{\relax}
\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}}

\renewcommand{\maketitle}{
	\begin{titlepage}
		\begin{center}
			\hrulefill \\[0.4cm]
			\Huge{\textbf{\@title}} \\\hrulefill \\[0.5cm]
			\Large{\@subtitle} \\\vfill
			\begin{flushleft}
				\Large 
				\@author \\ 
				\@date
			\end{flushleft}
		\end{center}
	\end{titlepage}
}

%reset chapter numbering in parts
\@addtoreset{chapter}{part}

% change sections numerals
\renewcommand{\thechapter}{\arabic{chapter}} 
\renewcommand{\thesection}{\Roman{section}}
\renewcommand{\thesubsection}{\alph{subsection}}

%remove numbering from new part page
\renewcommand\part{
	\if@openright
	\cleardoublepage
	\else
	\clearpage
	\fi
	\thispagestyle{empty}%
	\if@twocolumn
	\onecolumn
	\@tempswatrue
	\else
	\@tempswafalse
	\fi
	\null\vfil
	\secdef\@part\@spart
}

%format
\newtoggle{afterpartone}
\pretocmd{\part}
{\global\toggletrue{afterpartone}}
{}{}

\pretocmd{\part}
{\iftoggle{afterpartone}
	{\addtocontents{toc}{\protect\newpage}}% we're after part one
	{}% we're not after part one
}{}{}

\RequirePackage{titlesec} % titling customization
\RequirePackage{titletoc} % custom toc entries

% set toc entry styles{

% break label text before touching page number
\contentsmargin[30pt]{0em}

% set toc part entry style
\titlecontents{part}[1em]{}{}{\huge\bfseries\thepart}{}
[\rule{\textwidth}{0.8pt}\\\strut\hfill\raisebox{-2pt}{\large \iftoggle{engl}{Page}{Página}}]

% set toc part entry style (2)
%\titlecontents{part}[1em]{}{}{\huge\bfseries\thepart}{}
%[\rule{\textwidth-40pt}{0.8pt}\hspace{5pt}\raisebox{-6pt}{\large %Página}]

% set toc chap entry style
\titlecontents{chapter} %section
[1.4em] %left
{\vspace{0.5em}} %above code
{\Large\bfseries \iftoggle{engl}{Chapter}{Capítulo} \thecontentslabel \hspace{0.2pt} - \hspace{0.2pt}} %numbered entry format
{} %numberless entry format
{\hfill\large\bfseries\thecontentspage} % filler page format
[\vspace{3pt}] % below code

% set toc sec entry style
\titlecontents{section}[2.4em]{}{\thecontentslabel. \hspace{0.2pt}}
{}{\titlerule*[1pc]{.}\thecontentspage}[\vspace{3pt}]

% set toc subsec entry style
\titlecontents{subsection}[3.4em]{}{\thecontentslabel. \hspace{0.2pt}}
{\thesubsection}{\titlerule*[1pc]{.}\thecontentspage}[\vspace{3pt}]
%}


% titles formating{
% chap title formating
\titleformat{\chapter}
{\huge}
{Capítulo \thechapter \space --}
{0.3em}
{}

\titlespacing*{\chapter}{0pt}{0pt}{30pt}

% sec title formating
\titleformat{\section}
{\Large}
{\thesection.}
{0.3em}
{}

% subsec title formating
\titleformat{\subsection}
{\large}
{\thesubsection.}
{0.3em}
{}
%}

\RequirePackage{fancyhdr} % header / footer

% change header/footer{
\pagestyle{fancyplain}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt} % set a .5pt line straight through
\renewcommand{\footrulewidth}{0pt}
%}

\RequirePackage[abspage,user,lastpage]{zref} % gets counters

%gets the real page counter number
%\newcounter{realpage}
%\DeclareAssociatedCounters{page}{realpage}
%\AtBeginDocument{\stepcounter{realpage}}

\RequirePackage{relsize} % relative font sizing

% define a command for making parts of section titles smaller which doesn't affect the toc
\DeclareRobustCommand{\commentary}[1]{\smaller[1]#1}

\RequirePackage{lastpage} % get a \LastPage value
\RequirePackage{ifthen} %for if-then-else style commands

\let\@TOC\tableofcontents
\renewcommand\tableofcontents{
	\thispagestyle{empty}
	\fancyhf{}
	\clearpage
	\pagenumbering{roman} % use roman page numbering before document start
	\setcounter{page}{0}
	\fancyfoot[LE, RO]{\thepage} % insert page number in footer
	\begingroup
	\renewcommand\commentary[1]{##1} % redef command for changing section titles during toc making
	\@TOC
	\endgroup
	\newpage
	\fancyfoot[LE, RO]{\thepage \hspace{5pt}/ \pageref{LastPage}} % insert page number in footer
	\pagenumbering{arabic} % reset numbering and make it arabic
	\ifthenelse{\not\isodd{\zref[abspage]{LastPage}}}{\setcounter{page}{0}\thispagestyle{empty}}{} % get blank page for book formatting
}