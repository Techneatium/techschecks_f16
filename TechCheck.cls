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
\LoadClass[10pt,usenames,dvipsnames,twoside]{book}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{TechCheck}[2022/06/24]

%-----------------------------------------------------------------
% GENERAL PACKAGES
%-----------------------------------------------------------------
\RequirePackage{geometry}
\RequirePackage[]{datetime2} % change date format
\DTMnewstyle{yymmdd}{ % create new date style
	\renewcommand*\DTMdisplaydate[4]{%
		\DTMtwodigits{##1}\DTMtwodigits{##2}\DTMtwodigits{##3}% 
	}
	\renewcommand*{\DTMDisplaydate}{\DTMdisplaydate}%
}{}{}{}
\DTMsetstyle{yymmdd} % set new style as default
\RequirePackage[shortlabels]{enumitem} % pause/resume lists
\RequirePackage{multicol} % multi column format
\RequirePackage{graphicx} % used for figures
\graphicspath{{images/}} % put figures inside folder 'images'  in same folder as .tex
\RequirePackage{subcaption} % used for subfigures
\RequirePackage[dvipsnames]{xcolor} %colors, dvips -> extra premade colors
\RequirePackage[explicit]{titlesec} % formating of titles
\RequirePackage{siunitx} % SI units
\RequirePackage{tikz} % shapes, figures
\RequirePackage{tikzpagenodes} % points for tikz
\usetikzlibrary{calc} % used for hyperlinked nodes
\RequirePackage[hidelinks]{hyperref} % used for hyperlinked nodes
\RequirePackage{cleveref} % better referencing
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
\RequirePackage{xkeyval} % allows defining keys for macros

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O P T I O N S   S T A R T
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-----------------------------------------------------------------
% FONT OPTIONS
%-----------------------------------------------------------------
% Declare toggles for each font option
\newtoggle{fontHelvet}
\newtoggle{loadfontspec}
\newtoggle{fontJost}
\newtoggle{fontSpartan}
\newtoggle{fontMetropolis}
\newtoggle{fontInter}

% Default pdflatex helvetica clone
\DeclareOption{fontHelvet}{
  	\toggletrue{fontHelvet}
}

% Futura Clone -- pointy 
\DeclareOption{fontJost}{
	\toggletrue{loadfontspec}
	\toggletrue{fontJost}
	% toggle other fonts false
	\togglefalse{fontSpartan}
	\togglefalse{fontMetropolis}
	\togglefalse{fontInter}
}

% Futura DemiBold Clone
\DeclareOption{fontSpartan}{
	\toggletrue{loadfontspec}
	\toggletrue{fontSpartan}
	% toggle other fonts false
	\togglefalse{fontJost}
	\togglefalse{fontMetropolis}
	\togglefalse{fontInter}
}

% Gotham Clone 
\DeclareOption{fontMetropolis}{
	\toggletrue{loadfontspec}
	\toggletrue{fontMetropolis}
	% toggle other fonts false
	\togglefalse{fontJost}
	\togglefalse{fontSpartan}
	\togglefalse{fontInter}
}

% Helvetica clone
\DeclareOption{fontInter}{
	\toggletrue{loadfontspec}
	\toggletrue{fontInter}
	% toggle other fonts false
	\togglefalse{fontJost}
	\togglefalse{fontSpartan}
	\togglefalse{fontMetropolis}
}

%-----------------------------------------------------------------
% GEOMETRY OPTIONS
%-----------------------------------------------------------------
% if print will add corner rounding and tabs
\newtoggle{print}

% Basic paper geometry
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

% Nominal A5 paper size -- 210x148mm
\DeclareOption{a5}{
	\setlength\paperh{210mm}
	\setlength\paperw{148mm}
	\setlength\inmar{10mm}
	\setlength\outmar{10mm}
	\setlength{\chevin}{\outmar-33mm}
	\setlength\tabdepth{8mm}
}

% A5 paper with 8mm extra for tabs -- 210x(148+8)mm
\DeclareOption{a5print}{ 
	\setlength\paperh{210mm}
	\setlength\paperw{156mm}
	\setlength\inmar{16mm}
	\setlength\outmar{12mm}
	\setlength\chevin{\outmar-35mm}
	\setlength\tabdepth{8mm}
	\toggletrue{print}
}

% A5 paper with 9.5mm extra for 4x3 aspect -- 210x(148+9.5)mm
\DeclareOption{4x3print}{ 
	\setlength\paperh{210mm}
	\setlength\paperw{157.5mm}
	\setlength\inmar{16mm}
	\setlength\outmar{13.5mm}
	\setlength\chevin{\outmar-36.5mm}
	\setlength\tabdepth{9.5mm}
	\toggletrue{print}
}


% Nominal A4 paper size -- 297x210mm
\DeclareOption{a4}{
	\setlength\paperh{297mm}
	\setlength\paperw{210mm}
	\setlength\inmar{14mm}
	\setlength\outmar{14mm}
	\setlength{\chevin}{\outmar-31mm}
	\setlength\tabdepth{8mm}
}

% A4 paper with offset margins for printing -- 297x210mm
\DeclareOption{a4print}{
	\setlength\paperh{297mm}
	\setlength\paperw{210mm}
	\setlength\inmar{16mm}
	\setlength\outmar{12mm}
	\setlength{\chevin}{\outmar-29mm}
	\setlength\tabdepth{8mm}
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

% Thumbnar on/off
\newtoggle{autothumbnar}
\toggletrue{autothumbnar}
\DeclareOption{manthumbnar}{
	\togglefalse{autothumbnar}
}

%-----------------------------------------------------------------
% PROCESS OPTIONS
%-----------------------------------------------------------------
\ExecuteOptions{fontSpartan, a5print, colorful}
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O P T I O N S   E N D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GLOBAL FORMATTING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-----------------------------------------------------------------
% APPLY PAGE GEOMETRY
%-----------------------------------------------------------------
\geometry{
	paperheight=\paperh,
	paperwidth=\paperw,
	margin=1mm,
	top=\topmar,
	bottom=\botmar,
	headsep=5mm,
	headheight=5mm,
	footskip=\footmar,
	inner=\inmar,
	outer=\outmar,
	centering
}

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
		BoldFeatures={LetterSpace=5.0}
	]{Spartan MB}
	\newfontfamily\tightfont{Spartan MB-Bold}[Path=./fonts/, Ligatures=TeX, BoldFeatures={LetterSpace=0.0}] % used for `---` in page numbering
	\newfontfamily\titlefont{Spartan MB-Bold}[Path=./fonts/, Ligatures=TeX, LetterSpace=4.0]
}{}

\iftoggle{fontMetropolis}{
	\setmainfont[
		Path=./fonts/,
		Ligatures=TeX,
		UprightFont=*-Regular,
		ItalicFont=*-Regular Italic,
		BoldFont=*-Semi Bold,
		BoldFeatures={LetterSpace=3.0}
	]{Metropolis}
	\newfontfamily\tightfont{Metropolis-Bold}[Path=./fonts/, Ligatures=TeX, BoldFeatures={LetterSpace=0.0}] % used for `---` in page numbering
	\newfontfamily\titlefont{Metropolis-Bold}[Path=./fonts/, Ligatures=TeX, LetterSpace=4.0]
}{}

\iftoggle{fontInter}{
	\setmainfont[
		Path=./fonts/,
		Ligatures=TeX,
		UprightFont=*-Regular,
		BoldFont=*-Bold,
		ItalicFont=Jost-Italic,
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

% Set number of tabs in preable
\newcommand{\settabnumber}[1]{
	\setcounter{tabnumber}{#1}
	\setlength\tabwidth{\textheight/\thetabnumber}
}

%-----------------------------------------------------------------
% HEADER/FOOT FORMATTING
%-----------------------------------------------------------------
% remove header and foot
\pagestyle{empty}
% fancy header with section title in hatching
\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ -- #1}{}}
\fancypagestyle{superempty}{
	% clear defaults
	\fancyhf{}
	\fancyhead[LE,LO]{
		\iftoggle{hatch}{
		\Hatch
		}{}
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
	\fancyhead[LE,LO]{
		\iftoggle{hatch}{
		\Hatch
		}{}
	}
	\fancyhead[RO]{
		\iftoggle{autothumbnar}{
			\thumbnar
		}{}
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
	\fancyfoot[LE, RO]{{\tightfont\quad\textbf{\thepage}\quad}}% LE,RO or C
	% Version nbumber in footer
	\fancyfoot[RE, LO]{{\titlefont\textbf{REV: \today}}}
	% Aircraft name in footer
	\fancyfoot[C]{{\titlefont\textbf{\aircraftshort}}}
	% Header
	\fancyhead[RO]{
		\colorbox{color1}{
			\textcolor{white}{\titlefont\Large\textbf{\rightmark}}
		}
		\iftoggle{autothumbnar}{
			\thumbnar
		}{}
	}
	\fancyhead[RE]{
		\colorbox{color1}{
			\textcolor{white}{\titlefont\Large\textbf{\rightmark}}
		}
  	}
	\fancyhead[LE,LO]{
		\iftoggle{hatch}{
			\Hatch
		}{}
		\colorbox{color1}{
			\textcolor{white}{\titlefont\Large\textbf{\leftmark}}
		}
  	}
	\renewcommand{\headrulewidth}{0pt} % header rule width
	\renewcommand{\footrulewidth}{0pt} % footer rule width
}
\pagestyle{body}

%-----------------------------------------------------------------
% ENUMITEM FORMATTING
%-----------------------------------------------------------------
% spacing within lists
\setlist[enumerate, 1]{itemsep=1pt, parsep=0pt, label=(\alph*)}
\setlist[enumerate, 2]{itemsep=1pt, parsep=0pt}
\setlist[itemize, 1]{itemsep=1pt, parsep=0pt, label=\textbf{\textbullet}}
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

% formatting of subsection [full width]
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

% 1st number is weird, 2nd is spacing before, 3rd is spacing after subsection title
\titlespacing*{\chapter}{0pt}{50pt}{40pt}
\titlespacing{\section}{0pt}{5pt}{2pt}
\titlespacing{\subsection}{0pt}{2pt}{2pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CUSTOM COMMANDS / ENVIRONEMNTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-----------------------------------------------------------------
% CUSTOM MINIPAGE ENVIRONMENTS
%-----------------------------------------------------------------
\newenvironment{tableminipage}{% begdef
	\begin{minipage}[t]{\linewidth}
	\vspace{-7pt}
}{% enddef
	\end{minipage}
}

%-----------------------------------------------------------------
% CUSTOM TABLE ENVIRONMENTS
%-----------------------------------------------------------------
\newenvironment{listtable}{% begdef
	\newenvironment{subenumerate}[1][]{% begdef
		\begin{tableminipage}
			\begin{enumerate}[##1]
	}{% enddef
			\end{enumerate}
		\end{tableminipage}
	}

	\newenvironment{subitemize}[1][]{% begdef
		\begin{tableminipage}
			\begin{itemize}[##1]
	}{% enddef
			\end{itemize}
		\end{tableminipage}
	}
	\begin{center}
		\begin{tabular}{l p{3cm} | p{8cm}}
			\toprule
}{% enddef
			\bottomrule
		\end{tabular}
	\end{center}
}

\newenvironment{listlongtable}{% begdef
	\newenvironment{subenumerate}[1][]{% begdef
		\begin{tableminipage}
			\begin{enumerate}[##1]
	}{% enddef
			\end{enumerate}
		\end{tableminipage}
	}

	\newenvironment{subitemize}[1][]{% begdef
		\begin{tableminipage}
			\begin{itemize}[##1]
	}{% enddef
			\end{itemize}
		\end{tableminipage}
	}
	\begin{center}
		\begin{longtable}{l p{3cm} | p{8cm}}
			\toprule
}{% enddef
			\bottomrule
		\end{longtable}
	\end{center}
}

%-----------------------------------------------------------------
% TABLE ENVIRONMENTS WITH ENUMITEM-LIKE BEHAVIOR
%-----------------------------------------------------------------

% Counter for use in tablenumitems
\newcounter{tablenumi}
\setcounter{tablenumi}{1} % set to one to prevent edge case error
\newcounter{tablenumistart} % used to check if first line to prevent

% Key to start an enumerate at a given number
\define@key{tablenumitem}{start}{
	\setcounter{tablenumi}{#1}
	\setcounter{tablenumistart}{\value{tablenumi}}
}

% Key to resume an enumerate at previous number
\define@key{tablenumitem}{resume}[]{
	\setcounter{tablenumistart}{\value{tablenumi}}
}

% tablenumerate -- creates table that behaves like enumerate
\newenvironment{tablenumerate}[1][start=1]{% begdef
	\setkeys{tablenumitem}{#1}
	% Define command equiv to `item`
	% arg 1 - typeset in blue in 2. column
	% arg 2 - typeset normally in 3. column
	\newcommand{\blueitem}[2]{
		% Create midrule unless first row
		\ifnum\value{tablenumi}>\value{tablenumistart}
			\midrule
		\else
		\fi
		\arabic{tablenumi}. & \blue{##1} & ##2 
		\stepcounter{tablenumi} \\
	}
	% Define command equiv to `item`
	% arg 1 - typeset in dblue in 2. column
	% arg 2 - typeset normally in 3. column
	\newcommand{\dblueitem}[2]{
		\ifnum\value{tablenumi}>1
			\midrule
		\else
		\fi
		\arabic{tablenumi}. & \dblue{##1} & ##2 
		\stepcounter{tablenumi} \\
	}
	% Uses custom longtable style
	\begin{listlongtable}
}{% enddef
	\end{listlongtable}
}

% tableitemize -- creates table that behaves like itemize
\newenvironment{tableitemize}{% begdef
	\setcounter{tablenumi}{1}
	% Define command equiv to `item`
	% arg 1 - typeset in blue in 2. column
	% arg 2 - typeset normally in 3. column
	\newcommand{\blueitem}[2]{
		% Create midrule unless first row
		\ifnum\value{tablenumi}>1
			\midrule
		\else
		\fi
		\textbf{\textbullet} & \blue{##1} & ##2
		\stepcounter{tablenumi} \\
	}
	% Define command equiv to `item`
	% arg 1 - typeset in dblue in 2. column
	% arg 2 - typeset normally in 3. column
	\newcommand{\dblueitem}[2]{
		\ifnum\value{tablenumi}>1
			\midrule
		\else
		\fi
		\textbf{\textbullet} & \dblue{##1} & ##2
		\stepcounter{tablenumi} \\
	}
	% Uses custom longtable style
	\begin{listlongtable}
}{% enddef
	\end{listlongtable}
}

% SHORT VERSIONS

% shortablenumerate -- creates table that behaves like enumerate
\newenvironment{shortablenumerate}[1][start=1]{% begdef
	\setkeys{tablenumitem}{#1}
	% Define command equiv to `item`
	% arg 1 - typeset in blue in 2. column
	% arg 2 - typeset normally in 3. column
	\newcommand{\blueitem}[2]{
		% Create midrule unless first row
		\ifnum\value{tablenumi}>\value{tablenumistart}
			\midrule
		\else
		\fi
		\arabic{tablenumi}. & \blue{##1} & ##2 
		\stepcounter{tablenumi} \\
	}
	% Define command equiv to `item`
	% arg 1 - typeset in dblue in 2. column
	% arg 2 - typeset normally in 3. column
	\newcommand{\dblueitem}[2]{
		\ifnum\value{tablenumi}>1
			\midrule
		\else
		\fi
		\arabic{tablenumi}. & \dblue{##1} & ##2 
		\stepcounter{tablenumi} \\
	}
	% Uses custom table style
	\begin{listtable}
}{% enddef
	\end{listtable}
}

% shortableitemize -- creates table that behaves like itemize
\newenvironment{shortableitemize}{% begdef
	\setcounter{tablenumi}{1}
	% Define command equiv to `item`
	% arg 1 - typeset in blue in 2. column
	% arg 2 - typeset normally in 3. column
	\newcommand{\blueitem}[2]{
		% Create midrule unless first row
		\ifnum\value{tablenumi}>1
			\midrule
		\else
		\fi
		\textbf{\textbullet} & \blue{##1} & ##2
		\stepcounter{tablenumi} \\
	}
	% Define command equiv to `item`
	% arg 1 - typeset in dblue in 2. column
	% arg 2 - typeset normally in 3. column
	\newcommand{\dblueitem}[2]{
		\ifnum\value{tablenumi}>1
			\midrule
		\else
		\fi
		\textbf{\textbullet} & \dblue{##1} & ##2
		\stepcounter{tablenumi} \\
	}
	% Uses custom table style
	\begin{listtable}
}{% enddef
	\end{listtable}
}

%-----------------------------------------------------------------
% LOW LEVEL CUSTOM ENUMITEM ENVIRONMENTS
%-----------------------------------------------------------------
\newenvironment{innerchecklistenumerate}[1][]{% begdef
	\begin{enumerate}[itemsep=4pt, #1]
}{% enddef
	\end{enumerate}
}

\newenvironment{innerchecklistitemize}[1][]{% begdef
	\begin{itemize}[#1]
}{% enddef
	\end{itemize}
}

\newenvironment{outerchecklistenumerate}{% begdef
	\begin{enumerate}[leftmargin=0.1\textwidth, rightmargin=0.1\textwidth, itemsep=4pt, label=\textbf{\arabic*.}]
}{% begdef
	\end{enumerate}
}

\newenvironment{outerchecklistitemize}{% begdef
	\begin{itemize}[leftmargin=0.1\textwidth, rightmargin=0.1\textwidth, itemsep=4pt, label=\textbf{\textbullet}]
}{% begdef
	\end{itemize}
}

%-----------------------------------------------------------------
% HIGH-LEVEL CUSTOM ENUMITEM ENVIRONMENTS
%-----------------------------------------------------------------
% SHORT VERSIONS
\newenvironment{checklistenumerate}{% begdef
	\newenvironment{subenumerate}[1][]{% begdef
		\begin{innerchecklistenumerate}[##1]
	}{% enddef
		\end{innerchecklistenumerate}
	}
	\newenvironment{subitemize}[1][]{% begdef
		\begin{innerchecklistitemize}[##1]
	}{% enddef
		\end{innerchecklistitemize}
	}
	\newcommand{\blueitem}[2]{
		\item \blue{##1} {##2}
	}
	\newcommand{\dblueitem}[2]{
		\item \dblue{##1} {##2}
	}
	\begin{outerchecklistenumerate}
}{% enddef
	\end{outerchecklistenumerate}
}

\newenvironment{checklistitemize}{% begdef
	\newenvironment{subenumerate}[1][]{% begdef
		\begin{innerchecklistenumerate}[##1]
	}{% enddef
		\end{innerchecklistenumerate}
	}
	\newenvironment{subitemize}[1][]{% begdef
		\begin{innerchecklistitemize}[##1]
	}{% enddef
		\end{innerchecklistitemize}
	}
	\newcommand{\blueitem}[2]{
		\item \blue{##1} ##2
	}
	\newcommand{\dblueitem}[2]{
		\item \dblue{##1} ##2
	}
	\begin{outerchecklistitemize}
}{% enddef
	\end{outerchecklistitemize}
}

% LONG VERSIONS -- No difference to short versions
% Just to keep track if switching from longtablenumitem
\newenvironment{longchecklistenumerate}{% begdef
	\begin{checklistenumerate}
}{% enddef
	\end{checklistenumerate}
}

\newenvironment{longchecklistitemize}{% begdef
	\begin{checklistitemize}
}{% enddef
	\end{checklistitemize}
}

%-----------------------------------------------------------------
% CUSTOM COMMANDS
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TIKZPICTURE COMMANDS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
	([xshift=#1*2*5mm,yshift=2mm]current page text area.north west) --
	([xshift=#1*2*5mm+20mm,yshift=20mm+2mm]current page text area.north west) --
	([xshift=#1*2*5mm+25mm,yshift=20mm+2mm]current page text area.north west) --
	([xshift=#1*2*5mm+5mm,yshift=2mm]current page text area.north west) --
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
		minimum height=10mm
	]()at ([yshift=\paperheight/2]current page.center) {};
	\end{tikzpicture}
}

%-----------------------------------------------------------------
% ROUNDING
%-----------------------------------------------------------------
% variables for controlling rounding diameters in each corner
\newlength{\nwround}
\newlength{\neround}
\newlength{\seround}
\newlength{\swround}
\setlength\nwround{10mm}
\setlength\neround{10mm}
\setlength\seround{10mm}
\setlength\swround{10mm}

% thumbtab for Section page
\newcommand{\thumbtab}[2]{
	\iftoggle{print}{
		\begin{tikzpicture}[remember picture, overlay]
		% north west corner
		\fill[white]
			([xshift=-\inmar, yshift=\topmar]current page text area.north west) --
			([xshift=-\inmar, yshift=\topmar-10mm]current page text area.north west)
			[rounded corners=\nwround] --
			([xshift=-\inmar, yshift=\topmar]current page text area.north west) --
			([xshift=-\inmar+10mm, yshift=\topmar]current page text area.north west)
			[sharp corners] --
			cycle;
		% north east corner
		\fill[white]
			([xshift=\outmar, yshift=-#2*\tabwidth-5mm]current page text area.north east)
			[rounded corners=4mm] --
			([xshift=\outmar, yshift=-#2*\tabwidth]current page text area.north east)
			[rounded corners=3mm] --
			([xshift=\outmar-\tabdepth, yshift=-#2*\tabwidth]current page text area.north east)
			[rounded corners=\neround] --
			([xshift=\outmar-\tabdepth, yshift=\topmar]current page text area.north east) --
			([xshift=\outmar-\tabdepth-10mm, yshift=\topmar]current page text area.north east)
			[sharp corners]--
			([xshift=\outmar, yshift=\topmar]current page text area.north east)--
			cycle;
		\draw[color1]
			([xshift=-\inmar, yshift=\topmar]current page text area.north west)
      [rounded corners=\swround] --
			([xshift=-\inmar, yshift=-\botmar]current page text area.south west)
      [rounded corners=\seround] --
			([xshift=\outmar, yshift=-\botmar]current page text area.south east)
			[rounded corners=4mm] --
			([xshift=\outmar, yshift=-#2*\tabwidth]current page text area.north east)
			[rounded corners=3mm] --
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
		(sectionnode) at ([xshift=1\outmar-\tabdepth, yshift=-#2*\tabwidth]current page text area.north east){
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
\setlength\chevout{\outmar-12mm}
\setlength\chevpoint{\outmar-5mm}
% chevron height is set by tabwidth so it lines up

% creates hyperlinked white chevron with section name
\newcommand{\thumbfront}[2]{
	\begin{tikzpicture}[remember picture,overlay]
	%white chevrons
	\fill[white]
		([xshift=\chevin,
		yshift=-(#2+0.5)*\tabwidth+(\tabwidth/2-2.5mm)
		]current page text area.north east) --
		([xshift=\chevout,
		yshift=-(#2+0.5)*\tabwidth+(\tabwidth/2-2.5mm)
		]current page text area.north east) --
		([xshift=\chevpoint,
		yshift=-(#2+0.5)*\tabwidth
		]current page text area.north east) --
		([xshift=\chevout,
		yshift=-(#2+0.5)*\tabwidth-(\tabwidth/2-2.5mm)
		]current page text area.north east) --
		([
		xshift=\chevin,
		yshift=-(#2+0.5)*\tabwidth-(\tabwidth/2-2.5mm)
		]current page text area.north east) --
		cycle;
	% hyperlinked node for each section
	% uses a number (thumbtab:#2) as label
	\node[
		rectangle,
		anchor=west,
		rotate=0,
		minimum width=20mm,
		minimum height=\tabwidth-5mm,
		hyperref node=thumbtab:#2
	](Procedure) at ([xshift=\chevin, yshift=-(#2+0.5)*\tabwidth]current page text area.north east) {
		\textbf{#1}
	};
	\end{tikzpicture}
}
