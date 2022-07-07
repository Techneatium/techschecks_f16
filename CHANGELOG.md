# F-16 CHEATSHEET

## CHANGELOG

### Changelog - 2022.07.07 `v0.0.6`

- `TechCheck.cls`
  - Updated to latest version. [See F-14 Cheatsheet for more details](https://github.com/Techneatium/F14_CheatSheet/blob/master/CHANGELOG.md)
  - Changed dating format from `YYYYMMDD` to `YYMMDD`
  - Fixed inconsistent indentation

- `F16_CheatSheet.tex`
  - Continued work on `A-A WEAPONS` chapter, added significant content to `M-61 CANNON`, `AIM-9 SIDEWINDER`, and `AIM-120 AMRAAM` sections
    - Condensed the employment sections and moved the "how to select weapon" steps to the relevant `OVERVIEW` subsections
    - Added image placeholders for eventual schematic diagrams of the individual weapon systems
    - Currently blank sections awaiting symbology and explanations
  - Added many subsection titles to `A-G WEAPONS` chapter

### Changelog - 2022.07.04 `v0.0.5`

- `F16_CheatSheet.tex`
  - Added initial `AIM-9 SIDEWINDER` section (very very WIP)
  - Added `AGM-65 MAVERICK` subsections to `A-G`, just the titles / framework
  - Move post-start `TESTS & CHECKS` into own subsection which is hyperlinked from main `POST-START`. This simplifies checklist for those who seek the minimal number of steps
  - Testing new placeholder figure in `PRE-START`

### Changelog - 2022.06.30 `v0.0.4`

- `TechCheck.cls`
  - Updated to latest version. [See F-14 Cheatsheet for more details](https://github.com/Techneatium/F14_CheatSheet/blob/master/CHANGELOG.md)

- `F16_CheatSheet.tex`
  - Changed to evaluate new placeholder/test figures
  - Added initial `M61 CANNON` section

### Changelog - 2022.06.25 `v0.0.3`

- `TechCheck.cls`
  - Updated to latest version. [See F-14 Cheatsheet for more details](https://github.com/Techneatium/F14_CheatSheet/blob/master/CHANGELOG.md) - adds fonts to the repository

- `F16_CheatSheet.tex`
  - Continued `AIM-120` section
  - Additional placeholder figures added to `START-UP`

### Changelog - 2022.06.21 `v0.0.2`

- `TechCheck.cls`
  - Updated to latest version. [See F-14 Cheatsheet for more details](https://github.com/Techneatium/F14_CheatSheet/blob/master/CHANGELOG.md) - adds keys `resume`, `start=num` to `tablenumerate`

- `F16_CheatSheet.tex`
  - Added (temporary) breaks in tablenumerates using new keys
  - Added more placeholder figures
    - Implemented `subfigure`s
    - experimented with using hyperlinks directly from checklist `blue`-part to relevant diagram in `PRE-START`
  - Began initial `AIM-120` section

### Changelog - 2022.06.19 `v0.0.1`

- `TechCheck.cls`
  - Updated to latest version. [See F-14 Cheatsheet for more details](https://github.com/Techneatium/F14_CheatSheet/blob/master/CHANGELOG.md).

- `F16_CheatSheet.tex`
  - Updated to use new `tablenumerate`, `tableitemize`, `checklistenumerate`, `checklistitemize` from updated `TechCheck.cls`
  - Updated Frontpage, added `appendix`
  - Finished `POST-START`

- Added .pdf to `.gitignore`, pdfs can be added to releases

***

### Changelog - 2022.05.29

- `TechCheck.cls`
  - Updated to latest version. [See F-14 Cheatsheet for more details](https://github.com/Techneatium/F14_CheatSheet/blob/master/CHANGELOG.md).
- `F16_CheatSheet.tex`
  - Implemented new environments
  - Changed font to `Inter`
- `README.md`
  - Moved changelog to dedicated `md` file
  - Wrote provisional `README` intro

### Changelog - 2022.03.05

- Added test versions of PRE-START
  - **Option 1:** Cockpit images in separate column on the right
    - Makes checklist column smaller
  - **Option 2:** Cockpit images in the left (blue) column
    - Makes simple one item rows significantly taller (so does option 1)
    - For more complicated rows would require more complicated cockpit diagrams with multiple, labeled circles

***

### Changelog - 2022.02.26

- Initial Commit
