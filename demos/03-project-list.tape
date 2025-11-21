# VHS Tape: Project List
# Shows multi-project overview

Output demos/03-project-list.gif

Set Shell "zsh"
Set FontSize 14
Set Width 1400
Set Height 900
Set Padding 20
Set Theme "Catppuccin Mocha"

Type "# View all projects"
Enter
Sleep 500ms

Type "psa list"
Enter
Sleep 3s

Screenshot screenshots/project-list.png

Sleep 2s

Type "# Scan for new projects"
Enter
Sleep 500ms

Type "psa scan"
Enter
Sleep 2s

Screenshot screenshots/project-scan.png

Sleep 1s
