%=================================================================
% MIT LICENSE
%=================================================================
% Copyright (c) 2024 Techneatium
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
\ProvidesClass{TechCheck}[2024/01/23]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PACKAGES -- UTILITY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{multicol} % multi column format
\RequirePackage{graphicx} % used for figures
\graphicspath{{figs/}} % put figures inside folder 'images'  in same folder as .tex
\RequirePackage[dvipsnames]{xcolor} %colors, dvips -> extra premade colors
\RequirePackage{siunitx} % SI units
\RequirePackage{tikz} % shapes, figures
\RequirePackage{tikzpagenodes} % points for tikz
\usetikzlibrary{calc} % used for hyperlinked nodes
\RequirePackage{fancyhdr} % custom header/footer
\RequirePackage{etoolbox} % Boolean and if/else
\RequirePackage{calc} % math inside other commands
\RequirePackage{tcolorbox} % for rounded boxes
\tcbuselibrary{skins, breakable}
\RequirePackage{xkeyval} % allows defining keys for macros

\input{tikzsettings.tex}

\RequirePackage{techcolors}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O P T I O N S   S T A R T
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-----------------------------------------------------------------
% FONT OPTIONS
%-----------------------------------------------------------------
% Declare toggles for each font option
\newtoggle{fontJost}
\newtoggle{fontSpartan}
\newtoggle{fontInter}

% Futura Clone -- pointy 
\DeclareOption{fontJost}{
	\toggletrue{fontJost}
	\togglefalse{fontSpartan}
	\togglefalse{fontInter}
}

% Futura DemiBold Clone
\DeclareOption{fontSpartan}{
	\togglefalse{fontJost}
    \toggletrue{fontSpartan}
	\togglefalse{fontInter}
}

% Helvetica clone
\DeclareOption{fontInter}{
	\togglefalse{fontJost}
	\togglefalse{fontSpartan}
    \toggletrue{fontInter}
}

%-----------------------------------------------------------------
% GEOMETRY OPTIONS
%-----------------------------------------------------------------
% if print will add corner rounding and tabs
\newtoggle{print}

% Basic paper geometry
\newlength{\TC@paperh}
\newlength{\TC@paperw}

% margins, input here as variable for ROUNDING
\newlength{\TC@inmar}
\newlength{\TC@outmar}
\newlength{\TC@topmar}
\newlength{\TC@botmar}
\newlength{\TC@footmar}
\setlength\TC@topmar{12mm}
\setlength\TC@botmar{12mm}
\setlength\TC@footmar{5mm}

% tab dimensions
\newlength{\TC@tabwidth}
\newlength{\TC@tabdepth}

% Number of sections
\newcounter{tabnumber}
\setcounter{tabnumber}{6}

% determines width of tab based on number of tabs
\setlength\TC@tabwidth{\textheight/\thetabnumber}

% Nominal A5 paper size -- 210x148mm
\DeclareOption{a5}{
	\setlength\TC@paperh{210mm}
	\setlength\TC@paperw{148mm}
	\setlength\TC@inmar{10mm}
	\setlength\TC@outmar{10mm}
	\setlength\TC@tabdepth{8mm}
    \togglefalse{print}
}

% A5 paper with 8mm extra for tabs -- 210x(148+8)mm
\DeclareOption{a5print}{ 
	\setlength\TC@paperh{210mm}
	\setlength\TC@paperw{156mm}
	\setlength\TC@inmar{16mm}
	\setlength\TC@outmar{12mm}
	\setlength\TC@tabdepth{8mm}
	\toggletrue{print}
}

% Crown Quatro paper size -- 246x189mm
\DeclareOption{crownquatro}{
	\setlength\TC@paperh{246mm}
	\setlength\TC@paperw{189mm}
	\setlength\TC@inmar{10mm}
	\setlength\TC@outmar{10mm}
	\setlength\TC@tabdepth{8mm}
    \setlength\TC@botmar{20mm}
    \setlength\TC@footmar{10mm}
    \togglefalse{print}
}

% A5 paper with 9.5mm extra for 4x3 aspect -- 210x(148+9.5)mm
\DeclareOption{4x3print}{ 
	\setlength\TC@paperh{210mm}
	\setlength\TC@paperw{157.5mm}
	\setlength\TC@inmar{16mm}
	\setlength\TC@outmar{13.5mm}
	\setlength\TC@tabdepth{9.5mm}
	\toggletrue{print}
}

% Nominal A4 paper size -- 297x210mm
\DeclareOption{a4}{
	\setlength\TC@paperh{297mm}
	\setlength\TC@paperw{210mm}
	\setlength\TC@inmar{14mm}
	\setlength\TC@outmar{14mm}
	\setlength\TC@tabdepth{8mm}
    \togglefalse{print}
}

% A4 paper with offset margins for printing -- 297x210mm
\DeclareOption{a4print}{
	\setlength\TC@paperh{297mm}
	\setlength\TC@paperw{210mm}
	\setlength\TC@inmar{16mm}
	\setlength\TC@outmar{12mm}
	\setlength\TC@tabdepth{8mm}
	\toggletrue{print}
}

\DeclareOption{oneside}{
    \PassOptionsToClass{oneside}{book}
    % book will get oneside option passed automatically but need  
    % to turn off automatic thumbtab on next page after chapter
    \PassOptionsToPackage{autothumbback=false}{techhatchtabs} 
    % changebars are on wrong side otherwise? bug?
    \PassOptionsToPackage{leftbars}{changebar}
}

%-----------------------------------------------------------------
% COLOR OPTIONS
%-----------------------------------------------------------------
% color1 - main color
% color2 - highlight color
% color3 - alternate highlight color

\DeclareOption{colorful}{
	\colorlet{color1}{black}
	\colorlet{color2}{NavyBlue}
	\colorlet{color3}{NavyBlue}
}

\DeclareOption{b/w}{
	\colorlet{color1}{black}
	\colorlet{color2}{black}
	\colorlet{color3}{black}
}

%-----------------------------------------------------------------
% TECHHATCHTABS OPTIONS
%-----------------------------------------------------------------
\DeclareOption{squaretabs}{
    \PassOptionsToPackage{squaretabs}{techhatchtabs}
}

% turns off thumbtab indentation (for cutting out)
\DeclareOption{nothumbtabindent}{
    \PassOptionsToPackage{thumbtabindent=false}{techhatchtabs}
}

% turns off thumbnar 'indentation' by tabwidth
\DeclareOption{nothumbnarindent}{
    \PassOptionsToPackage{thumbnarindent=false}{techhatchtabs}
}

% turns off automatic thumbnar'ing
\DeclareOption{manthumbnar}{
  	\PassOptionsToPackage{autothumbnar=false}{techhatchtabs}
}

% turns off automatic generation of thumbback node on page
% after thumbtab
\DeclareOption{manthumbback}{
    \PassOptionsToPackage{autothumbback=false}{techhatchtabs}
}

% deactivates all page rounding and indentation
\DeclareOption{noround}{
    \PassOptionsToPackage{round=false}{techhatchtabs}
}

% deactivates all hatching
\DeclareOption{nohatch}{
    \PassOptionsToPackage{hatch=false}{techhatchtabs}
}

%-----------------------------------------------------------------
% DEV OPTIONS
%-----------------------------------------------------------------

% Geometry showframe
\DeclareOption{showframe}{
  	\PassOptionsToPackage{showframe}{geometry}
}

%-----------------------------------------------------------------
% PROCESS OPTIONS
%-----------------------------------------------------------------
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ExecuteOptions{fontSpartan, a5print, colorful}
\ProcessOptions*\relax

\LoadClass[10pt,usenames,dvipsnames]{book}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PACKAGES -- FORMATTING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{geometry}

\RequirePackage[]{datetime2} % change date format
\DTMnewstyle{yymmdd}{ % create new date style
	\renewcommand*\DTMdisplaydate[4]{%
		\DTMtwodigits{##1}\DTMtwodigits{##2}\DTMtwodigits{##3}% 
	}
	\renewcommand*{\DTMDisplaydate}{\DTMdisplaydate}%
}{}{}{}
\DTMsetstyle{yymmdd} % set new style as default

\RequirePackage{amsmath} % math stuff (non-numbered align env, etc.)

\RequirePackage{caption} % allows proper captions for non-float figures
\RequirePackage{subcaption} % used for subfigures
\RequirePackage{marginfix} % patches marginpar to prevent page overflow

\RequirePackage[shortlabels]{enumitem} % pause/resume lists
\RequirePackage[explicit]{titlesec} % formating of titles
\RequirePackage{etoc} % formatting of chapter tocs
\RequirePackage[document]{ragged2e} % left ragged text

\RequirePackage[hidelinks]{hyperref} % used for hyperlinked nodes
\RequirePackage{cleveref} % better referencing

\RequirePackage{booktabs} % fancy tables
\RequirePackage{multirow} % more fancy tables
\RequirePackage{longtable} % multi page tables

\RequirePackage[auto]{chappg}

\RequirePackage{luatex85} % required to make changebar work with lualatex
\RequirePackage[pdftex, color]{changebar} % what it says

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GLOBAL FORMATTING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-----------------------------------------------------------------
% APPLY PAGE GEOMETRY
%-----------------------------------------------------------------
\geometry{
	paperheight=\TC@paperh,
	paperwidth=\TC@paperw,
	margin=1mm,
	top=\TC@topmar,
	bottom=\TC@botmar,
	headsep=5mm,
	headheight=5mm,
	footskip=\TC@footmar,
	inner=\TC@inmar,
	outer=\TC@outmar,
	marginparwidth=0mm,
	marginparsep=0mm,
	centering,
}

%-----------------------------------------------------------------
% CUSTOM PACKAGES
%-----------------------------------------------------------------
\iftoggle{print}{
    % if true no action necessary, defaults to printable behavior
}{
    % if false turns of rounding completely
    % leaves 'autothumbback' on!
    \PassOptionsToPackage{
        round=false,
    }{techhatchtabs}
}

\RequirePackage[
    top=\TC@topmar,
    bottom=\TC@botmar,
    inner=\TC@inmar,
    outer=\TC@outmar,
    tabwidth=\TC@tabwidth,
    tabdepth=\TC@tabdepth,
]{techhatchtabs} % custom page hatching 

\RequirePackage{technumitem} % custom enumitem like environments

%-----------------------------------------------------------------
% OPTIONAL PACKAGES
%-----------------------------------------------------------------
\RequirePackage{fontspec}

\iftoggle{fontJost}{
	\setmainfont[
		Path=./fonts/,
		Ligatures=TeX,
		UprightFont=*-Regular,
		ItalicFont=*-Italic,
		BoldFont=*-Bold,
		BoldFeatures={LetterSpace=2.5}
	]{Jost}
	\newfontfamily\tightfont{Jost-Bold}[Path=./fonts/, Ligatures=TeX, BoldFeatures={LetterSpace=0.0}] % used for `---` in page numbering
	\newfontfamily\titlefont{Jost-Bold}[Path=./fonts/, Ligatures=TeX, LetterSpace=4.0]
}{}

\iftoggle{fontSpartan}{
	\setmainfont[
		Path=./fonts/,
		Ligatures=TeX,
		UprightFont=*-Medium,
		LetterSpace=2.0,
		ItalicFont=*-Medium Italic,
		ItalicFeatures={Scale=1.0},
		BoldFont=*-Bold,
		BoldFeatures={LetterSpace=5.0},
	]{Spartan MB}
	\newfontfamily\tightfont{Spartan MB-Bold}[Path=./fonts/, Ligatures=TeX, BoldFeatures={LetterSpace=0.0}] % used for `---` in page numbering
	\newfontfamily\titlefont{Spartan MB-Bold}[Path=./fonts/, Ligatures=TeX, LetterSpace=4.0]
}{}

\iftoggle{fontInter}{
	\setmainfont[
		Path=./fonts/,
		Ligatures=TeX,
		UprightFont=*-Regular,
		BoldFont=*-Bold,
		ItalicFont=Spartan MB-Italic,
	]{Inter}
	\newfontfamily\tightfont{Spartan MB-Bold}[Path=./fonts/, Ligatures=TeX, BoldFeatures={LetterSpace=0.0}] % used for `---` in page numbering
	\newfontfamily\titlefont{Spartan MB-Bold}[Path=./fonts/, Ligatures=TeX, LetterSpace=4.0]
}{}

%-----------------------------------------------------------------
% GLOBAL PARAMETER COMMANDS
%-----------------------------------------------------------------
% Set label for title page
\newcommand*\aircraftlong{FULL A/C NAME}
\newcommand*{\setaircraftlong}[1]{\renewcommand*\aircraftlong{#1}}
% Set label for header
\newcommand*\aircraftshort{F-XX}
\newcommand*{\setaircraftshort}[1]{\renewcommand*\aircraftshort{#1}}

%-----------------------------------------------------------------
% HEADER/FOOT FORMATTING
%-----------------------------------------------------------------
% remove header and foot
\pagestyle{empty}
% fancy header with section title in hatching
\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\quad #1}{}}
\fancypagestyle{superempty}{
	% clear defaults
	\fancyhf{}
	\fancyhead[LO]{
        \hatchodd
    }
    \fancyhead[LE]{
        \hatcheven
    }
}

\fancypagestyle{empty}{
	% clear defaults
	\fancyhf{}
	% page number in footer
	\fancyfoot[LE, RO]{{\tightfont\quad\textbf{\thepage}\quad}}% LE,RO or C
	% Version nbumber in footer
	\fancyfoot[RE, LO]{{\titlefont\textbf{REV: \today}}}
	% Aircraft name in footer
	\fancyfoot[C]{{\titlefont\textbf{\aircraftshort}}}
	\fancyhead[LO]{
        \hatchodd
    }
    \fancyhead[LE]{
        \hatcheven
    }
	\fancyhead[RO]{
        \thumbnar
	}
}

\fancypagestyle{plain}{
	% clear defaults
	\fancyhf{}
	% page number in footer
	\fancyfoot[LE, RO]{{\tightfont\quad\textbf{\thepage}\quad}}% LE,RO or C
	% Version nbumber in footer
	\fancyfoot[RE, LO]{{\titlefont\textbf{REV: \today}}}
	% Aircraft name in footer
	\fancyfoot[C]{{\titlefont\textbf{\aircraftshort}}}
	\fancyhead[LO]{
        \hatchodd
    }
    \fancyhead[LE]{
        \hatcheven
    }
}

\fancypagestyle{body}{
	% clear defaults
	\fancyhf{}
	% page number in footer
	\fancyfoot[LE, RO]{{\tightfont\quad\textbf{\thepage}\quad}}% LE,RO or C
	% Version nbumber in footer
	\fancyfoot[RE, LO]{{\titlefont\textbf{REV: \today}}}
	% Aircraft name in footer
	\fancyfoot[C]{{\titlefont\textbf{\aircraftshort}}}
	% Header
	% rightmark links to current section
	\fancyhead[RO]{%
        \thumbnar%
		\colorbox{color1}{%
			\textcolor{white}{\titlefont\Large\textbf{\hyperlink{section.\thesection}{\rightmark}}}%
		}%
	}
	\fancyhead[RE]{%
		\colorbox{color1}{%
			\textcolor{white}{\titlefont\Large\textbf{\hyperlink{section.\thesection}{\rightmark}}}%
		}%
  	}
	% leftmark links to current chapter
	\fancyhead[LO]{
        % \hatchodd
		\begin{tikzpicture}[
			remember picture,
			overlay,
		]
			\node [
				draw,
                hyperref node=frontpage,
				anchor=north west,
				fill=color1, 
				minimum width=\pagewidth,
				minimum height=10mm,
				line width=0,
			] (blackbox) at (current page.north west) {};
		\end{tikzpicture}
		\begin{tikzpicture}[
			remember picture,
			baseline=(title.base),
			overlay,
		]
			\node [
				anchor=west,
				minimum width=7.5mm,
				minimum height=10mm,
				line width=0,
				xshift=-1mm,
			] (numbox) at (0, 0) {};
			\node [
				draw, 
				color=white, 
				minimum width=7.5mm, 
				fill=\chpcolorhighlight, 
				inner sep=0pt, 
				line width=0.4mm,
				circle, 
				text=\chpcolortext,
				font=\titlefont\Large\bfseries,
			] (chapternum) at (numbox.center) {\thechapter};
			\node [
				anchor=west, 
				minimum height=10mm,
				text=white, 
				line width=0,
				font=\titlefont\Large\bfseries,
				right=0 of numbox,
			] (title) {\hyperlink{chapter.\thechapter}{\leftmark}};
		\end{tikzpicture}
  	}
    \fancyhead[LE]{
        \hatcheven
		\colorbox{color1}{
			\textcolor{white}{\titlefont\Large\textbf{\leftmark}}
		}
  	}
	\renewcommand{\headrulewidth}{0pt} % header rule width
	\renewcommand{\footrulewidth}{0pt} % footer rule width
}
\pagestyle{body}

%-----------------------------------------------------------------
% CAPTION SETUP
%-----------------------------------------------------------------
\DeclareCaptionFont{titlefont}{\titlefont}
\captionsetup{
	hypcap=true,
	figurename=Fig.,
	labelfont={bf},
	font=small,
}

%-----------------------------------------------------------------
% MARGIN FORMATTING / COMMANDS
%-----------------------------------------------------------------
% increases margin width to allow margin figures
\newcommand{\marginfigeometry}{
    \newgeometry{
        includemp,
        inner=\TC@inmar,
        outer=\TC@outmar,
        bottom=\TC@botmar,
        top=\TC@topmar,
        marginparwidth=40mm,
        marginparsep=5mm
    }
}

% relaxes geometry back to global definition
\newcommand{\marginfigrestore}{
    \restoregeometry
}

%-----------------------------------------------------------------
% ENUMITEM FORMATTING
%-----------------------------------------------------------------
% spacing within lists
\setlist[enumerate, 1]{itemsep=4pt, parsep=0pt, label=(\alph*)}
\setlist[enumerate, 2]{itemsep=4pt, parsep=0pt}
\setlist[itemize, 1]{itemsep=4pt, parsep=0pt, label=\textbf{\textbullet}}
\setlist[itemize, 2]{itemsep=1pt, parsep=0pt}

%-----------------------------------------------------------------
% OTHER FORMATTING
%-----------------------------------------------------------------
% indent for paragraph
\setlength{\parindent}{0pt}
% space between paragraphs
\setlength{\parskip}{0.3em}

% space between columns
\setlength{\columnsep}{2mm}
% create lines between columns and define color of columns
\setlength{\columnseprule}{0pt} %set thickness default 1pt
\def\columnseprulecolor{\color{color1}}

%-----------------------------------------------------------------
% CHANGEBAR SETTINGS
%-----------------------------------------------------------------
\cbcolor{color1}
\setlength{\changebarwidth}{2mm}
\setlength{\changebarsep}{2mm}

%-----------------------------------------------------------------
% TOC FORMATTING
%-----------------------------------------------------------------

\etocsettocdepth{3}

% For use with `titletoc` package, matches syntax of `etoc`
% % \printcontents[<name>]{<prefix>}{<start-level>}[<toc-depth>]{<toc-code>]
% \newcommand{\localtableofcontents}{
%     \startcontents[chapters]
%     \printcontents[chapters] % name
%     {} % prefix
%     {1} % start-level
%     {} % toc-code
% }

%-----------------------------------------------------------------
% PART FORMATTING
%-----------------------------------------------------------------

% remove page numbers from part pages
\patchcmd{\part}{\thispagestyle{plain}}{\thispagestyle{superempty}}{}{}

% remove page numbers from TOC entries for part pages
\makeatletter
\renewcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{3em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}
\makeatother

%-----------------------------------------------------------------
% TITLE FORMATTING
%-----------------------------------------------------------------
% \titleformat{<command>}[<shape>]{<format>}{<label>}{<sep>}{<before-code>}[<after-code>]

% formatting of chapter
\titleformat{\chapter}[display] % command
	{\titlefont\huge\bfseries} % format
	{\chaptertitlename\ \thechapter} % label
	{20pt} % sep
	{
		\begin{tikzpicture}[
			remember picture,
			baseline=(title.base),
			overlay,
		]
			% background for alignment
			\node [
				anchor=west,
				minimum width=15mm,
				minimum height=15mm,
				line width=0,
				xshift=-1mm,
			] (numboxbackground) at (0, 0) {};
			\node [
				anchor=west, 
				minimum height=12mm,
				text=white, 
				line width=0,
				font=\titlefont\Huge\bfseries,
				right=0 of numboxbackground,
			] (titlebackground) {#1\quad\null};
			% black fill aligned to right of title
			\node [
				anchor=east,
				minimum width=2\pagewidth,
				minimum height=15mm,
				fill=color1,
				line width=0,
				xshift=-1mm,
			] (fill) at (titlebackground.east) {};
			% main content
			\node [
				anchor=west,
				minimum width=15mm,
				minimum height=15mm,
				line width=0,
				xshift=-1mm,
			] (numbox) at (0, 0) {};
			\node [
				draw, 
				color=white, 
				minimum width=12mm, 
				fill=\chpcolorhighlight, 
				inner sep=0pt, 
				line width=0.6mm,
				circle, 
				text=\chpcolortext,
				font=\titlefont\Huge\bfseries,
			] (chapternum) at (numbox.center) {\thechapter};
			\node [
				anchor=west, 
				minimum height=12mm,
				text=white, 
				line width=0,
				font=\titlefont\Huge\bfseries,
				right=0 of numbox,
			] (title) {#1\quad\null};
		\end{tikzpicture}
	} % before-code
	[] % after code

\titleformat{name=\chapter,numberless}[display]
	{\titlefont\Huge\bfseries} % format
	{} % label
	{0pt} % sep
	{#1} % before-code
	[] % after code

% formatting of section
\titleformat{\section} % command
	{\color{color1}\titlefont\large\bfseries} % format
	{\color{color1}\thesection} % label
	{1em} % sep
	{#1} % before-code
	[{\titlerule[2pt]}] % after-code

% formatting of subsection [full width]
\titleformat{\subsection} % command
	{\normalfont\bfseries} % format
	{\color{color1}} % label
	{0em} % sep
	{\colorbox{color1}{\parbox{\dimexpr\textwidth-2\fboxsep\relax}{\textcolor{white}{\titlefont\thesubsection\quad#1}}}} % before-code

\titleformat{name=\subsection,numberless} % command
	{\normalfont\bfseries} % format
	{\color{color1}} % label
	{0em} % sep
	{\colorbox{color1}{\parbox{\dimexpr\textwidth-2\fboxsep\relax}{\textcolor{white}{#1}}}} % before-code

% formatting of subsubsection [full width]
\titleformat{\subsubsection} % command
	{\normalfont\bfseries} % format
	{\color{color1}} % label
	{0em} % sep
	{\colorbox{color1}{\parbox{\dimexpr\textwidth-2\fboxsep\relax}{\textcolor{white}{\titlefont\thesubsubsection\quad#1}}}} % before-code

\titleformat{name=\subsubsection,numberless} % command
	{\normalfont\bfseries} % format
	{\color{color1}} % label
	{0em} % sep
	{\colorbox{color1}{\parbox{\dimexpr\textwidth-2\fboxsep\relax}{\textcolor{white}{#1}}}} % before-code

% formatting of paragraph
\titleformat{name=\paragraph}[wrap]% command
	{{\color{color2}\titlerule}\bfseries}% format
	{}% label
	{0em}% sep
	{\blue{#1}}% before-code
	[]% after-code

% 1st number is weird, 2nd is spacing before, 3rd is spacing after subsection title
\titlespacing*{\chapter}{0pt}{50pt}{40pt}
\titlespacing{\section}{0pt}{5pt}{2pt}
\titlespacing{\subsection}{0pt}{2pt}{2pt}
\titlespacing{\subsubsection}{0pt}{2pt}{2pt}
\titlespacing{\paragraph}{40mm}{1.5em plus .1ex minus .2ex}{1em}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CUSTOM COMMANDS / ENVIRONEMNTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-----------------------------------------------------------------
% CUSTOM COMMANDS
%-----------------------------------------------------------------
% command to create blue, bold mini-titles
\newcommand{\blue}[1]{%
	\textbf{\textcolor{color2}{#1}}%
}

% command to create bold, white-on-blue, mini titles
\newcommand{\dblue}[1]{%
	\colorbox{color3}{%
		\textbf{\textcolor{white}{#1}}%
	}%
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
		title=\large NOTE,
	]
		{#1}
	\end{tcolorbox}
}

\newcommand{\cautionbox}[1]{
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
		drop shadow=color1!100,
		},
		title=\large CAUTION
	]
		{#1}
	\end{tcolorbox}
}

\newcommand{\marnotebox}[1]{
	\marginpar{
		\begin{tcolorbox}[
			enhanced,
			colback=white,
			colframe=color1,
			left skip=0mm,
			right skip=0mm,
			left=0mm,
			right=0mm,
			boxsep=0mm,
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
			title=\large NOTE,
		]
			{#1}
		\end{tcolorbox}
	}
}

\newcommand{\marcautionbox}[1]{
	\marginpar{
		\begin{tcolorbox}[
			enhanced,
			colback=white,
			colframe=color1,
			left skip=0mm,
			right skip=0mm,
			left=0mm,
			right=0mm,
			boxsep=0mm,
			sharp corners,
			frame hidden,
			colbacktitle=white,
			coltitle=color1,
			fonttitle=\titlefont\bfseries,
			attach boxed title to top center,
			boxed title style={
			sharp corners,
			drop shadow=color1!100,
			},
			title=\large CAUTION
		]
			{#1}
		\end{tcolorbox}
	}
}