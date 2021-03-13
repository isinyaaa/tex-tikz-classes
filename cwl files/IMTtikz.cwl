#include:etoolbox
#include:amsmath
#include:amsfonts
#include:amsthm
#include:amssymb
#include:mathtools
#include:empheq
#include:xfrac
#include:cancel
#include:esdiff
#include:commath
#include:iftex
#include:esvect
#include:siunitx
#include:pgfplots
#include:tikz
#include:environ
#include:xargs
#include:nccmath
#include:xpatch
#include:unicode-math

\oldhat{a}#m
\ihat#m
\jhat#m
\khat#m
\rhat#m
\that#m
\ehat{e_what}#m

\<inner prod>#n

\lightyear
\rpm

\setmyunit{unit}#n

\dotMarkRightAngle[size=#1](a,b,c)#/tikzpicture

\tikzmark{node name}

\begin{multi}[col num][align]#n
\end{multi}#n
\nextcol#/multi

\correctspacing[how much]#n

\begin{tikzscale}[scale]#\tikzpicture
\end{tikzscale}

\begin{tikzoverlay}#\tikzpicture
\begin{tikzoverlay}[options%keyvals]#\tikzpicture
\end{tikzoverlay}

#ifOption:brmaths
	\sen#m
	\arcsen#m
	\tg#m
	\arctg#m
	\cotg#m
	\cossec#m
	\cis#m
#endif

#ifOption:weirdsymbols
	\curvedarrow [color,draw options] (initial node:arc length final node:arc length)#/tikzpicture
	
	\arc{idk}#/tikzpicture
	
	\curly@brace[options](start angle:end angle:radius)#/tikzpicture
#endif

#ifOption:externalize
	\NewEnvironx{name}[args][op args]{begin}{end}%n
#endif

#ifOption:ctikz
	#include:circuitikz
	#include:ctikz-ly
	
	\begin{ctikz}[scale]#\circuitikz
	\end{ctikz}#n
	\parallelsum#m
#endif

#ifOption:enums
	#include:enumitem
	#include:multicol
	
	\Example[text]#n
	
	\Question[title]#n
	\begin{Subquest}#\enumerate
	\end{Subquest}#n
	
	\begin{RomanList}#\enumerate
	\end{RomanList}#n
	
	\begin{romanlistinline}#\enumerate*
	\end{romanlistinline}#n
	
	\begin{unindent}#\enumerate
	\end{unindent}#n
	
	\changelabel{what label}#n

	\topenum[col num][align]#n
	\fixtopalign#n
	
	\un[options]#n
	\en#n
	\vst#n
	\vstst#n
#endif

#ifOption:xkcd
	#include:fontenc
	
	\NewEnvironx{name}[args][op args]{begin}{end}%n
	#keyvals:\node#c,\draw#c,\path#c,\begin{scope}#c,\begin{tikzpicture}#c,\tikz#c
	xkcd
	#endkeyvals

	\begin{xkcdenv}[scale]#\tikzpicture
#endif

#ifOption:python
	#include:listings
#endif

#ifOption:mathematica
	#include:mmacells
#endif

#ifOption:cite
	#include:quoting
#endif