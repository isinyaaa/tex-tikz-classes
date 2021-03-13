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
\ProvidesClass{IMTexam}[2020/07/30 Isabella's Maths and Tikz exam class template is a fully customized exam class for typesetting exams, exercise lists and solutions.]

\RequirePackage{etoolbox,ifthen}
\newtoggle{engl}
\DeclareOption{english}{\global\settoggle{engl}{true}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{exam}}
\ProcessOptions\relax

\LoadClass[a4paper, 11pt, answers]{exam}

\RequirePackage[top=0.6in,left=0.6in,right=0.6in,bottom=0.7in]{geometry}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage[useregional]{datetime2}
\RequirePackage{hyphenat}
\RequirePackage[skip=0.5em,indent=3ex]{parskip}
\RequirePackage{graphicx,float}
\RequirePackage[hidelinks,colorlinks=true,urlcolor=blue,linkcolor=black]{hyperref}
\RequirePackage[all]{hypcap}
\AtBeginDocument{\RequirePackage{footnote}
	\makesavenoteenv{solution}}

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

% Define Class, Exam, Date, etc.
\def\@examname{\relax}
\newcommand{\examname}[1]{\gdef\@examname{#1}}
\def\@USPN{}
\newcommand{\USPN}[1]{\gdef\@USPN{#1}}
\def\@hwtype{}
\newcommand{\hwtype}[1]{\gdef\@hwtype{#1}}
\def\@lcode{}
\newcommand{\lcode}[1]{\gdef\@lcode{#1}}
\def\@lecture{\relax}
\newcommand{\lecture}[1]{\gdef\@lecture{#1}}

\renewcommand{\@title}{{\LARGE
		\ifthenelse{\equal{\@hwtype}{}}{}{\@hwtype{ -- }}%
		\@examname\ (\@lecture\ifthenelse{\equal{\@lcode}{}}{}{{ -- }\@lcode})}
}

\newcommand{\multilinetitle}{\renewcommand{\@title}{{\LARGE
			\@lecture\ifthenelse{\equal{\@lcode}{}}{}{{ -- }\@lcode} \\ \vspace{0.5em} \ifthenelse{\equal{\@hwtype}{}}{}{\@hwtype{ -- }}%
			\@examname}
}}

\renewcommand{\title}[1]{\gdef\@title{#1}}

\renewcommand{\maketitle}{
%	\thispagestyle{empty}
	\begin{center}
		\@title \\ \vspace{1em}
		\ifthenelse{\equal{\@date}{}}
			{}
			{\@date{ / }}%
		\@author%
		\ifthenelse{\equal{\@USPN}{}}
			{}
			{{ -- }\@USPN}
		 \\ \vspace{2ex}
	\end{center}
\par\noindent
}

\appto\maketitle{\@afterindentfalse\@afterheading}{}{}

\renewcommand\partlabel{\makebox[0.7cm][l]{(\alph{partno})}}

\renewcommand{\questionshook}{%
	\setlength{\leftmargin}{0pt}%
	\setlength{\labelwidth}{-\labelsep}%
	\setlength{\topsep}{0.3cm}%
	\setlength{\parskip}{0cm}%
	\setlength{\partopsep}{0cm}
}

\renewcommand{\partshook}{%
	\setlength{\leftmargin}{10pt}%
	\setlength{\labelsep}{0pt}
	\setlength{\labelwidth}{0cm}%
	\setlength{\topsep}{0.1cm}%
	\def\makelabel##1{##1}%
	\setlength{\parskip}{0.1cm}%
}



\RequirePackage{relsize}

\newcommand{\formattitletext}[1]{\textlarger[3]{#1%
%\ifXeTeX
%	\titlefont {#1}
%\else
%	\fontfamily{put}\selectfont{#1}
%\fi
}}

\qformat{
	\begingroup
	\strut\hspace{-4pt}
	\begin{minipage}{\textwidth}
%		\ifnum\value{question}>1
%		{\rule[0.5ex]{\textwidth}{1.2pt}\\[0.5ex]}
%		\else
%		\fi
		\formattitletext{%
			 \ifthenelse{\equal{\thequestiontitle}{\thequestion}}
			 {\iftoggle{engl}{Question}{Questão} \thequestion}{\textsmaller[1]{\MakeUppercase{\iftoggle{engl}{Question}{Questão}} \thequestion}\\[8pt]{\bfseries\thequestiontitle}}
		}
		\strut\newline
		%\formattitletext{\MakeLowercase{\thepoints}}
		\rule[0.5ex]{\textwidth}{1.2pt}
		\\[-1ex]
	\end{minipage}
	\endgroup
}

\counterwithin{equation}{question}
\renewcommand{\theequation}{\thequestion.\arabic{equation}}

\def\@curpage{\iftoggle{engl}{Page \thepage\ of \numpages}{Página \thepage\ de \numpages}}

\pagestyle{headandfoot}
\firstpageheader{}{}{}
\firstpagefooter{}{\ifthenelse{\numpages = 1}{}{\@curpage}}{}
%\firstpagefootrule

%\newtoggle{givecredits}
%\def\@credits{\relax}
\newcommand{\givecredits}{%
		\runningheader{\@examname}
			{\@curpage}
			{\@lecture}
		\runningfooter{\@hwtype}{}{\iftoggle{engl}{By \@author}{Por \@author}}
		\runningfootrule
}

\runningfooter{}{}{}
\runningheader{
	\ifthenelse{\equal{\@hwtype}{}}
	{\@examname{ }}
	{\@hwtype}
}{%
	\ifthenelse{\equal{\@hwtype}{}}
	{}
	{\@examname{ - }}%
	\@curpage}{\@lecture}

\runningheadrule

\newtoggle{useby}

\def\@by{\relax}
\newcommand{\by}[1]{\gdef\@by{#1}\global\toggletrue{useby}}

\def\@sol{%
	\iftoggle{engl}%
	{Solution{\iftoggle{useby}{\ (By \@by)}{}}:}%
	{Resolução{\iftoggle{useby}{\ (Por \@by)}{}}:}%
}

\renewcommand{\solutiontitle}{\noindent\textbf{\@sol}%
	\def\@by{\relax}%
	\renewcommand{\by}[1]{\gdef\@by{##1}\global\toggletrue{useby}}%
	\global\togglefalse{useby}%
	\par\noindent
}


\newcommand{\extra}[1]{
	\bigskip
	\noindent\begingroup
	\vspace{0.5cm}
	\strut\hspace{-4pt}
	\begin{minipage}{\textwidth}
		\formattitletext{\textlarger{\textbf{#1}}}
%		\strut\newline
%		\rule[1.1ex]{\textwidth}{1.2pt}
	\end{minipage}
	\endgroup
	\vspace{-0.5cm}
}


\renewcommand\appendix{
	\bigskip
	\noindent\begingroup
	\vspace{0.5cm}
	\strut\hspace{-4pt}
	\begin{minipage}{\textwidth}
		\formattitletext{{\iftoggle{engl}{Appendix}{Apêndice}}}
		\strut\newline
		\rule[1.1ex]{\textwidth}{1.2pt}
	\end{minipage}
	\endgroup
	\vspace{-0.5cm}
}
