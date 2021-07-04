#include:etoolbox
#include:listings
#include:quoting
#include:tikz
#include:environ
#include:xargs

\setmyunit{unit}#n
\tikzmark{node name}

\begin{multi}[col num][align]#n
\end{multi}#n
\nextcol#/multi

\correctspacing[how much]#n