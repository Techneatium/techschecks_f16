%=================================================================
% MIT LICENSE
%=================================================================
% Copyright (c) 2022 Techneatium
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%=================================================================

\NeedsTeXFormat{LaTeX2e}
\LoadClass[10pt,usenames,dvipsnames,twoside]{report}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{TechCheck}[2022/02/11]

%-----------------------------------------------------------------
% GENERAL PACKAGES
%-----------------------------------------------------------------
\RequirePackage[yyyymmdd]{datetime} % change date format
\renewcommand{\dateseparator}{} % select date separator character
\RequirePackage[shortlabels]{enumitem} % pause/resume lists
\RequirePackage{multicol} % multi column format
\RequirePackage{graphicx} % used for figures
\graphicspath{{images/}} % put figures inside folder 'images'  in same folder as .tex
\RequirePackage[dvipsnames]{xcolor} %colors, dvips -> extra premade colors
\RequirePackage[explicit]{titlesec} % formating of titles
\RequirePackage{siunitx} % SI units
% \RequirePackage{amsmath}  % math stuff
% \RequirePackage{amsfonts} % more math stuff
% \RequirePackage{mathtools} % even more math stuff
% \RequirePackage{empheq} % Fancy boxed equations
\RequirePackage{tikz} % shapes, figures
\RequirePackage{tikzpagenodes} % points for tikz
\usetikzlibrary{calc} % used for hyperlinked nodes
\RequirePackage[hidelinks]{hyperref} % used for hyperlinked nodes
\RequirePackage{lipsum} % lorem ipsum
\RequirePackage[document]{ragged2e} % left ragged text
\RequirePackage{atbegshi}  % special commands that apply tikz to all pages
\RequirePackage{fancyhdr} % custom header/footer
\RequirePackage{etoolbox} % Boolean and if/else
\RequirePackage{calc} % math inside other commands
\RequirePackage{booktabs} % fancy tables
\RequirePackage{multirow} % more fancy tables
\RequirePackage{longtable} % multi page tables
\RequirePackage{tocloft} % TOC formatting
\RequirePackage{minitoc} % chapter tocs
\RequirePackage[auto]{chappg}
\RequirePackage{tcolorbox} % for rounded boxes
\tcbuselibrary{skins, breakable}
\RequirePackage{luatex85} % required to make changebar work with lualatex
\RequirePackage[pdftex, color, outerbars]{changebar} % what it says

%=================================================================
% O P T I O N S   S T A R T
%=================================================================

%-----------------------------------------------------------------
% FONT OPTIONS
%-----------------------------------------------------------------
\newtoggle{fontHelvet}
\newtoggle{loadfontspec}
\newtoggle{fontJost}
\newtoggle{fontSpartan}
\newtoggle{fontMetropolis}
\newtoggle{fontHelvetica}
\newtoggle{fontInter}



\DeclareOption{fontHelvet}{
  \toggletrue{fontHelvet}
}

\DeclareOption{fontJost}{
  \toggletrue{loadfontspec}
  \toggletrue{fontJost}
  % toggle other fonts false
  \togglefalse{fontSpartan}
  \togglefalse{fontMetropolis}
  \togglefalse{fontHelvetica}
  \togglefalse{fontInter}
}

\DeclareOption{fontSpartan}{
  \toggletrue{loadfontspec}
  \toggletrue{fontSpartan}
  % toggle other fonts false
  \togglefalse{fontJost}
  \togglefalse{fontMetropolis}
  \togglefalse{fontHelvetica}
  \togglefalse{fontInter}
}

\DeclareOption{fontMetropolis}{
  \toggletrue{loadfontspec}
  \toggletrue{fontMetropolis}
  % toggle other fonts false
  \togglefalse{fontJost}
  \togglefalse{fontSpartan}
  \togglefalse{fontHelvetica}
  \togglefalse{fontInter}
}

\DeclareOption{fontHelvetica}{
  \toggletrue{loadfontspec}
  \toggletrue{fontHelvetica}
  % toggle other fonts false
  \togglefalse{fontJost}
  \togglefalse{fontSpartan}
  \togglefalse{fontMetropolis}
  \togglefalse{fontInter}
}

\DeclareOption{fontInter}{
  \toggletrue{loadfontspec}
  \toggletrue{fontInter}
  % toggle other fonts false
  \togglefalse{fontJost}
  \togglefalse{fontSpartan}
  \togglefalse{fontMetropolis}
  \togglefalse{fontHelvetica}
}

%-----------------------------------------------------------------
% GEOMETRY OPTIONS
%-----------------------------------------------------------------
% if print will add corner rounding and tabs
\newtoggle{print}

\newlength{\paperh}
\newlength{\paperw}
% margins, input here as variable for ROUNDING
\newlength{\inmar}
\newlength{\outmar}
\newlength{\topmar}
\newlength{\botmar}
\newlength{\footmar}
\setlength\topmar{1.2cm}
\setlength\botmar{0.8cm}
\setlength\footmar{0.5cm}
% indendtation for chevrons on front page
\newlength{\chevin}
% tab dimensions
\newlength{\tabwidth}
\newlength{\tabdepth}
% Number of sections
\newcounter{tabnumber}
\setcounter{tabnumber}{6}

% determines width of tab based on number of tabs
\setlength\tabwidth{\textheight/\thetabnumber}

\DeclareOption{a5}{
	\setlength\paperh{21cm}
	\setlength\paperw{14.8cm}
	\setlength\inmar{1cm}
	\setlength\outmar{1cm}
	\setlength{\chevin}{\outmar-3.3cm}
	\setlength\tabdepth{0.8cm}
}

\DeclareOption{a5print}{ % a5 paper with 8mm extra for tabs
	\setlength\paperh{21cm}
	\setlength\paperw{15.6cm}
	\setlength\inmar{1.6cm}
	\setlength\outmar{1.2cm}
	\setlength\chevin{\outmar-3.5cm}
	\setlength\tabdepth{0.8cm}
	\toggletrue{print}
}

\DeclareOption{4x3print}{ % a5 paper height with 9.5mm extra for 4x3 aspect
	\setlength\paperh{21cm}
	\setlength\paperw{15.75cm}
	\setlength\inmar{1.6cm}
	\setlength\outmar{1.35cm}
	\setlength\chevin{\outmar-3.65cm}
	\setlength\tabdepth{0.95cm}
	\toggletrue{print}
}

\DeclareOption{a4}{
	\setlength\paperh{29.7cm}
	\setlength\paperw{21cm}
	\setlength\inmar{1.4cm}
	\setlength\outmar{1.4cm}
	\setlength{\chevin}{\outmar-3.1cm}
	\setlength\tabdepth{0.8cm}
}

\DeclareOption{a4print}{
	\setlength\paperh{29.7cm}
	\setlength\paperw{21cm}
	\setlength\inmar{1.6cm}
	\setlength\outmar{1.2cm}
	\setlength{\chevin}{\outmar-2.9cm}
	\setlength\tabdepth{0.8cm}
	\toggletrue{print}
}

%-----------------------------------------------------------------
% COLOR OPTIONS
%-----------------------------------------------------------------
% color1 - main color
% color2 - highlight color
% color3 - alternate highlight color

\DeclareOption{colorful}{
  \colorlet{color1}{black}
  % \definecolor{color1}{HTML}{222222}
  \colorlet{color2}{NavyBlue}
  \colorlet{color3}{NavyBlue}
  \definecolor{color4}{HTML}{FFE534} % bf2042yellow
}

\DeclareOption{b/w}{
  \colorlet{color1}{black}
  \colorlet{color2}{black}
  \colorlet{color3}{black}
  \definecolor{color4}{HTML}{FFE534} % bf2042yellow
}

%-----------------------------------------------------------------
% OTHER FORMATTING OPTIONS
%-----------------------------------------------------------------
% activates white-on-black subsections which span \textwidth
\newtoggle{widesubsec}
\DeclareOption{widesubsec}{
  \toggletrue{widesubsec}
}

%-----------------------------------------------------------------
% DEV OPTIONS
%-----------------------------------------------------------------
% Turn hatching off
\newtoggle{hatch}
\toggletrue{hatch}
\DeclareOption{nohatch}{
  \togglefalse{hatch}
}

% Geometry showframe
\DeclareOption{showframe}{
  \PassOptionsToClass{showframe}{geometry}
}

%-----------------------------------------------------------------
% PROCESS OPTIONS
%-----------------------------------------------------------------
\ExecuteOptions{fontSpartan, widesubsec, a5print, colorful}
\ProcessOptions\relax
%=================================================================
% O P T I O N S   E N D
%=================================================================

%-----------------------------------------------------------------
% OPTIONAL PACKAGES
%-----------------------------------------------------------------
\iftoggle{fontHelvet}{
  \RequirePackage[T1]{fontenc}
  \RequirePackage{helvet}
  \renewcommand{\familydefault}{\sfdefault}
}{}

\iftoggle{loadfontspec}{
  \RequirePackage{fontspec}
}{}

\iftoggle{fontJost}{
  \setmainfont[
  	Ligatures=TeX,
  	UprightFont=*-Regular,
  	ItalicFont=*-Italic,
  	BoldFont=*-Bold,
  	BoldFeatures={LetterSpace=2.5}
  ]{Jost}
  \newfontfamily\tightfont{Jost}[Ligatures=TeX, BoldFeatures={LetterSpace=0.0}] % used for `---` in page numbering
  \newfontfamily\titlefont{Jost-Bold}[Ligatures=TeX, LetterSpace=4.0]
}{}

\iftoggle{fontSpartan}{
  \setmainfont[
  	Ligatures=TeX,
  	Scale=0.85,
  	UprightFont=*-Medium,
  	ItalicFont=Jost-Italic,
  	ItalicFeatures={Scale=1.0},
  	BoldFont=*-Bold,
  	BoldFeatures={LetterSpace=2.5}
  ]{Spartan}
  \newfontfamily\tightfont{Spartan}[Ligatures=TeX, Scale=0.85, BoldFeatures={LetterSpace=0.0}] % used for `---` in page numbering
  \newfontfamily\titlefont{Spartan-Bold}[Ligatures=TeX, Scale=0.85, LetterSpace=4.0]
}{}

\iftoggle{fontMetropolis}{
  \setmainfont[
  	Ligatures=TeX,
  	UprightFont=*-Regular,
  	ItalicFont=*-Regular Italic,
  	BoldFont=*-Semi Bold,
  	BoldFeatures={LetterSpace=3.0}
  ]{Metropolis}
  \newfontfamily\tightfont{Metropolis}[Ligatures=TeX, BoldFeatures={LetterSpace=0.0}] % used for `---` in page numbering
  \newfontfamily\titlefont{Metropolis-Bold}[Ligatures=TeX, LetterSpace=4.0]
}{}

\iftoggle{fontHelvetica}{
  \setmainfont[
    Ligatures=TeX,
    BoldFont=*-Bold,
    ItalicFont=*-Italic,
  ]{Helvetica Neue}
  \newfontfamily\tightfont{Spartan-Bold}[Ligatures=TeX, Scale=0.85, LetterSpace=0.0] % used for `---` in page numbering
  \newfontfamily\titlefont{Spartan-Bold}[Ligatures=TeX, Scale=0.85, LetterSpace=4.0]
}

\iftoggle{fontInter}{
  \setmainfont[
    Ligatures=TeX,
    BoldFont=*-Bold,
    ItalicFont=Jost-Italic,
  ]{Inter}
  \newfontfamily\tightfont{Spartan-Bold}[Ligatures=TeX, Scale=0.85, LetterSpace=0.0] % used for `---` in page numbering
  \newfontfamily\titlefont{Spartan-Bold}[Ligatures=TeX, Scale=0.85, LetterSpace=4.0]
}

\RequirePackage[
	paperheight=\paperh,
	paperwidth=\paperw,
	margin=0.1cm,
	top=\topmar,
	bottom=\botmar,
	headsep=0.5cm,
	headheight=0.5cm,
	footskip=\footmar,
	inner=\inmar,
	outer=\outmar,
	centering
]{geometry}

%-----------------------------------------------------------------
% GLOBAL PARAMETER COMMANDS
%-----------------------------------------------------------------

% Set label for title page
\newcommand*\aircraftlong{F-14A/B AIRCRAFT}
\newcommand*{\setaircraftlong}[1]{\renewcommand*\aircraftlong{#1}}
% Set label for header
\newcommand*\aircraftshort{F-14A/B}
\newcommand*{\setaircraftshort}[1]{\renewcommand*\aircraftshort{#1}}

% Set number of tabs in preable
\newcommand{\settabnumber}[1]{
  \setcounter{tabnumber}{#1}
  \setlength\tabwidth{\textheight/\thetabnumber}
}

%-----------------------------------------------------------------
% HATCHING
%-----------------------------------------------------------------
% creates node option to create hyperref
\tikzset{
	hyperref node/.style={
		alias=sourcenode,
		append after command={
			let     \p1 = (sourcenode.north west),
			\p2=(sourcenode.south east),
			\n1={\x2-\x1},
			\n2={\y1-\y2} in
			node [inner sep=0pt, outer sep=0pt,anchor=north west,at=(\p1)] {\hyperref[#1]{\XeTeXLinkBox{\phantom{\rule{\n1}{\n2}}}}}
			%xelatex needs \XeTeXLinkBox, won't create a link unless it
			%finds text --- rules don't work without \XeTeXLinkBox.
			%Still builds correctly with pdflatex and lualatex
		}
	}
}
% titlepage chevron indentation

% individual parallelogram
\newcommand{\single}[1]{
	\fill[color1]
	([xshift=#1*2*0.5cm,yshift = 0.2cm]current page text area.north west) --
	([xshift=#1*2*0.5cm+2cm,yshift=2cm+0.2cm]current page text area.north west) --
	([xshift=#1*2*0.5cm+2.5cm,yshift=2cm+0.2cm]current page text area.north west) --
	([xshift=#1*2*0.5cm+0.5cm,yshift=0.2cm]current page text area.north west) --
	cycle;
}
% while loop to make many parallelograms
\newcommand\Hatch{
	\begin{tikzpicture}[remember picture,overlay]
	\newcount\foo
	\foo=-3
	\loop
	\single{\the\foo}
	\advance \foo +1
	\ifnum \foo<21
	\repeat
	% makes hatched area hyperlink to front page
	\node[
		rectangle,
		hyperref node=frontpage,
		anchor=north,
		minimum width=\paperwidth,
		minimum height=1cm
	]()at ([yshift=\paperheight/2]current page.center) {};
	\end{tikzpicture}
}

%-----------------------------------------------------------------
% HEADER/FOOT FORMATTING
%-----------------------------------------------------------------
% remove header and foot
\pagestyle{empty}
% fancy header with section title in hatching
\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{\colorbox{color1}{
	% code formatting section titles in header
	\textcolor{white}{\Large\textbf{#1}}
}}{}}
\fancypagestyle{empty}{
	% clear defaults
	\fancyhf{}
	\fancyhead[LE,LO]{
    \iftoggle{hatch}{
      \Hatch
    }{}
  }
}
\fancypagestyle{plain}{
	% clear defaults
	\fancyhf{}
	% page number in footer
	% \fancyfoot[C]{{\tightfont \textbf{--- \thepage \ ---}}}% LE,RO
	\fancyfoot[C]{{\tightfont \textbf{\thepage}}}% LE,RO
	\fancyhead[LE,LO]{
    \iftoggle{hatch}{
      \Hatch
    }{}
  }
}
\fancypagestyle{body}{
	% clear defaults
	\fancyhf{}
	% page number in footer
	% \fancyfoot[C]{{\tightfont \textbf{--- \thepage \ ---}}}% LE,RO
	\fancyfoot[C]{{\tightfont \textbf{\thepage}}}% LE,RO
	% date in top right
	\fancyhead[RE,RO]{\colorbox{color1}{
			\textcolor{white}{\titlefont\Large\textbf{REV: \today}}
	}}
	% extra thing in middle
	\fancyhead[C]{\colorbox{color1}{
			\textcolor{white}{\titlefont\Large\textbf{\aircraftshort}}
	}}
	\fancyhead[LE,LO]{
    \iftoggle{hatch}{
      \Hatch
    }{}
    \titlefont\textbf{\leftmark}
  }
	\renewcommand{\headrulewidth}{0pt} % and the line
}
\pagestyle{body}

%-----------------------------------------------------------------
% OTHER FORMATTING
%-----------------------------------------------------------------
% indent for paragraph
\setlength{\parindent}{0pt}
% space between paragraphs
\setlength{\parskip}{0.3em}

% space between columns
\setlength{\columnsep}{0.2cm}
% create lines between columns and define color of columns
\setlength{\columnseprule}{0pt} %set thickness default 1pt
\def\columnseprulecolor{\color{color1}}

% spacing within lists
\setlist[enumerate, 1]{itemsep=1pt, parsep=0pt, label=(\alph*)}
\setlist[enumerate, 2]{itemsep=1pt, parsep=0pt}
\setlist[itemize, 1]{itemsep=1pt, parsep=0pt, label=\textbf{\textbullet}}
\setlist[itemize, 2]{itemsep=1pt, parsep=0pt}


%-----------------------------------------------------------------
% COMMANDS
%-----------------------------------------------------------------
% command to create blue, bold mini-titles
\newcommand{\blue}[1]{
  \textbf{\textcolor{color2}{#1}}
}

% command to create bold, white-on-blue, mini titles
\newcommand{\dblue}[1]{
	\colorbox{color3}{
		\textbf{\textcolor{white}{#1}}
	}
}

\newcommand{\yellow}[1]{
	\colorbox{color4}{
		\textbf{\textcolor{black}{#1}}
	}
}

\newcommand{\notebox}[1]{
	\begin{tcolorbox}[
		enhanced,
		colback=white,
		colframe=color1,
		sharp corners,
		frame hidden,
		colbacktitle=white,
		coltitle=color1,
    fonttitle=\titlefont\bfseries,
		attach boxed title to top center,
		boxed title style={
		sharp corners,
		% drop shadow=color1!100
		},
		title=\large NOTE
	]
		{#1}
	\end{tcolorbox}
}

\newcommand{\warningbox}[1]{
	\begin{tcolorbox}[
		enhanced,
		colback=white,
		colframe=color1,
		sharp corners,
		frame hidden,
		colbacktitle=white,
		coltitle=color1,
    fonttitle=\titlefont\bfseries,
		attach boxed title to top center,
		boxed title style={
		sharp corners,
		drop shadow=color1!100
		},
		title=\large WARNING
	]
		{#1}
	\end{tcolorbox}
}

%-----------------------------------------------------------------
% CHANGEBAR SETTINGS
%-----------------------------------------------------------------
\cbcolor{color1}
\setlength{\changebarwidth}{2mm}

%-----------------------------------------------------------------
% TOCLOFT FORMATTING
%-----------------------------------------------------------------
% change distance between section number and title
% default: 1.55em
% required for Spartan font: 3.1em w/o chapters
% required for Spartan font: 3.3em w/ chapters
% \setlength{\cftsecnumwidth}{2.325em}
% \setlength{\cftsubsecnumwidth}{3.50em}
\tocloftpagestyle{empty}

%-----------------------------------------------------------------
% MINITOC FORMATTING
%-----------------------------------------------------------------
\mtcsetfont{minitoc}{section}{\normalfont\small}
\mtcsetrules{minitoc}{off}

%-----------------------------------------------------------------
% TITLE FORMATTING
%-----------------------------------------------------------------
% \titleformat{<command>}[<shape>]{<format>}{<label>}{<sep>}{<before-code>}[<after-code>]

% formatting of chapter
\titleformat{\chapter}[display] % command
  {\titlefont\huge\bfseries} % format
  {\chaptertitlename\ \thechapter} % label
  {20pt} % sep
  {\iftoggle{hatch}{\Hatch}{}\Huge #1} % before-code
  [] % after code

% formatting of section
\titleformat{\section} % command
  {\color{color1}\titlefont\large\bfseries} % format
  {\color{color1}\thesection} % label
  {1em} % sep
  {#1} % before-code
  [{\titlerule[1pt]}] % after-code

% formatting of subsection
\titleformat{\subsection} % command
  {\color{white}\titlefont\bfseries} % format
  {\color{color1}\thesubsection} % label
  {1em} % sep
  {\colorbox{color1}{#1}} % before-code
  [] % after-cocde

% formatting of subsection [full width]
\iftoggle{widesubsec}{
  \titleformat{\subsection} % command
    {\normalfont\bfseries} % format
    {\color{color1}} % label
    {0em} % sep
    {\colorbox{black}{\parbox{\dimexpr\textwidth-2\fboxsep\relax}{\textcolor{white}{\titlefont\thesubsection\quad#1}}}} % before-code

  \titleformat{name=\subsection,numberless} % command
    {\normalfont\bfseries} % format
    {\color{color1}} % label
    {0em} % sep
    {\colorbox{black}{\parbox{\dimexpr\textwidth-2\fboxsep\relax}{\textcolor{white}{#1}}}} % before-code
}{}

% 1st number is weird, 2nd is spacing before, 3rd is spacing after subsection title
\titlespacing*{\chapter}{0pt}{50pt}{40pt}
\titlespacing{\section}{0pt}{5pt}{2pt}
\titlespacing{\subsection}{0pt}{2pt}{2pt}

%-----------------------------------------------------------------
% ROUNDING
%-----------------------------------------------------------------
% variables for controlling rounding diameters in each corner
\newlength{\nwround}
\newlength{\neround}
\newlength{\seround}
\newlength{\swround}
\setlength\nwround{1cm}
\setlength\neround{1cm}
\setlength\seround{1cm}
\setlength\swround{1cm}

% thumbtab for Section page
\newcommand{\thumbtab}[2]{
	\iftoggle{print}{
		\begin{tikzpicture}[remember picture, overlay]
		% north west corner
		\fill[white]
			([xshift=-\inmar, yshift=\topmar]current page text area.north west) --
			([xshift=-\inmar, yshift=\topmar-1cm]current page text area.north west)
			[rounded corners=\nwround] --
			([xshift=-\inmar, yshift=\topmar]current page text area.north west) --
			([xshift=-\inmar+1cm, yshift=\topmar]current page text area.north west)
			[sharp corners] --
			cycle;
		% north east corner
		\fill[white]
			([xshift=\outmar, yshift=-#2*\tabwidth-0.5cm]current page text area.north east)
			[rounded corners=0.4cm] --
			([xshift=\outmar, yshift=-#2*\tabwidth]current page text area.north east)
			[rounded corners=0.3cm] --
			([xshift=\outmar-\tabdepth, yshift=-#2*\tabwidth]current page text area.north east)
			[rounded corners=\neround] --
			([xshift=\outmar-\tabdepth, yshift=\topmar]current page text area.north east) --
			([xshift=\outmar-\tabdepth-1cm, yshift=\topmar]current page text area.north east)
			[sharp corners]--
			([xshift=\outmar, yshift=\topmar]current page text area.north east)--
			cycle;
		\draw[color1]
			([xshift=-\inmar, yshift=\topmar]current page text area.north west)
      [rounded corners=\swround] --
			([xshift=-\inmar, yshift=-\botmar]current page text area.south west)
      [rounded corners=\seround] --
			([xshift=\outmar, yshift=-\botmar]current page text area.south east)
			[rounded corners=0.4cm] --
			([xshift=\outmar, yshift=-#2*\tabwidth]current page text area.north east)
			[rounded corners=0.3cm] --
			([xshift=\outmar-\tabdepth, yshift=-#2*\tabwidth]current page text area.north east)
			[rounded corners=\neround] --
			([xshift=\outmar-\tabdepth, yshift=\topmar]current page text area.north east)
      [rounded corners=\nwround]--
			cycle;
		\node[
			rectangle,
			anchor=south west,
			rotate=270,
			minimum height=\tabdepth,
			minimum width=\tabwidth
		]
		(sectionnode) at ([xshift=1\outmar-\tabdepth, yshift=-#2*\tabwidth]current page text area.north east) {
			\small\textbf{#1}
		};
		\end{tikzpicture}
	}{}
	% create label for hyperlinks on front page
	\label{thumbtab:#2}
	% create node on back of page
	\AtBeginShipoutNext{\thumbback{#1}{#2}}
}
% node with section name without border
\newcommand{\thumbback}[2]{
	\iftoggle{print}{
		\begin{tikzpicture}[remember picture, overlay]
		\node[
			rectangle,
			anchor=south east,
			rotate=90,
			minimum height=\tabdepth,
			minimum width=\tabwidth
		]
		(sectionnode) at ([xshift=-1\outmar+\tabdepth, yshift=-#2*\tabwidth]current page text area.north west) {
			\small\textbf{#1}
		};
		\end{tikzpicture}
	}{}
}
% for front page and back page
\newcommand{\thumbwide}{
	\iftoggle{print}{
		\begin{tikzpicture}[remember picture, overlay]
			% north west corner
			\fill[white]
				([xshift=-\inmar, yshift=\topmar]current page text area.north west) --
				([xshift=-\inmar, yshift=\topmar-1cm]current page text area.north west)
				[rounded corners=\nwround] --
				([xshift=-\inmar, yshift=\topmar]current page text area.north west) --
				([xshift=-\inmar+1cm, yshift=\topmar]current page text area.north west)
				[sharp corners] --
				cycle;
			% north east corner
			\fill[white]
				([xshift=\outmar, yshift=\topmar]current page text area.north east) --
				([xshift=\outmar, yshift=\topmar-1cm]current page text area.north east)
				[rounded corners=\neround] --
				([xshift=\outmar, yshift=\topmar]current page text area.north east) --
				([xshift=\outmar-1cm, yshift=\topmar]current page text area.north east)
				[sharp corners] --
				cycle;
			% south east corner
			\fill[white]
				([xshift=\outmar, yshift=-\botmar]current page text area.south east) --
				([xshift=\outmar, yshift=-\botmar+1cm]current page text area.south east)
				[rounded corners=\seround] --
				([xshift=\outmar, yshift=-\botmar]current page text area.south east) --
				([xshift=\outmar-1cm, yshift=-\botmar]current page text area.south east)
				[sharp corners] --
				cycle;
			% frame
			\draw[color1]
				([xshift=-\inmar, yshift=\topmar]current page text area.north west)
        [rounded corners=\swround] --
				([xshift=-\inmar, yshift=-\botmar]current page text area.south west)
        [rounded corners=\seround] --
				([xshift=\outmar, yshift=-\botmar]current page text area.south east)
        [rounded corners=\neround] --
				([xshift=\outmar, yshift=\topmar]current page text area.north east)
        [rounded corners=\nwround] --
				cycle;
		\end{tikzpicture}
	}{}
}
% for all pages that are not front-, back- or section-page
\newcommand{\thumbnar}{
	\iftoggle{print}{
		\begin{tikzpicture}[remember picture, overlay]
		% north west corner
		\fill[white]
			([xshift=-\inmar, yshift=\topmar]current page text area.north west) --
			([xshift=-\inmar, yshift=\topmar-1cm]current page text area.north west)
			[rounded corners=\nwround] --
			([xshift=-\inmar, yshift=\topmar]current page text area.north west) --
			([xshift=-\inmar+1cm, yshift=\topmar]current page text area.north west)
			[sharp corners] --
			cycle;
		% north east corner
		\fill[white]
			([xshift=\outmar, yshift=\topmar]current page text area.north east) --
			([xshift=\outmar, yshift=\topmar-1cm]current page text area.north east) --
			([xshift=\outmar-\tabdepth, yshift=\topmar-1cm]current page text area.north east)
			[rounded corners=\neround] --
			([xshift=\outmar-\tabdepth, yshift=\topmar]current page text area.north east) --
			([xshift=\outmar-\tabdepth-1cm, yshift=\topmar]current page text area.north east)
			[sharp corners] --
			cycle;
		 % frame
		\draw[color1]
			([xshift=-\inmar, yshift=\topmar]current page text area.north west) [rounded corners = \swround] --
			([xshift=-\inmar, yshift=-\botmar]current page text area.south west) [rounded corners = \seround] --
			([xshift=\outmar-\tabdepth, yshift=-\botmar]current page text area.south east) [rounded corners = \neround] --
			([xshift=\outmar-\tabdepth, yshift=\topmar]current page text area.north east) [rounded corners = \nwround]--
			cycle;
		\end{tikzpicture}
	}{}
}

%-----------------------------------------------------------------
% FRONT PAGE
%-----------------------------------------------------------------

\newlength{\chevout} % sets for right side of chevron
\newlength{\chevpoint} % sets point of chevron
\setlength\chevout{\outmar-1.2cm}
\setlength\chevpoint{\outmar-0.5cm}
% chevron height is set by tabwidth so it lines up

% creates hyperlinked white chevron with section name
\newcommand{\thumbfront}[2]{
	\begin{tikzpicture}[remember picture,overlay]
	%white chevrons
	\fill[white]
		([xshift=\chevin,
		yshift=-(#2+0.5)*\tabwidth+(\tabwidth/2-0.25cm)
		]current page text area.north east) --
		([xshift=\chevout,
		yshift=-(#2+0.5)*\tabwidth+(\tabwidth/2-0.25cm)
		]current page text area.north east) --
		([xshift=\chevpoint,
		yshift=-(#2+0.5)*\tabwidth
		]current page text area.north east) --
		([xshift=\chevout,
		yshift=-(#2+0.5)*\tabwidth-(\tabwidth/2-0.25cm)
		]current page text area.north east) --
		([
		xshift=\chevin,
		yshift=-(#2+0.5)*\tabwidth-(\tabwidth/2-0.25cm)
		]current page text area.north east) --
		cycle;
	% hyperlinked node for each section
	% uses a number (thumbtab:#2) as label
	\node[
		rectangle,
		anchor=west,
		rotate=0,
		minimum width=2cm,
		minimum height=\tabwidth-0.5cm,
		hyperref node=thumbtab:#2
	](Procedure) at ([xshift=\chevin, yshift=-(#2+0.5)*\tabwidth]current page text area.north east) {
		\textbf{#1}
	};
	\end{tikzpicture}
}
