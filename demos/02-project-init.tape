# VHS Tape: Initialize New Project
# Shows the project initialization workflow

Output demos/02-project-init.gif

Set Shell "zsh"
Set FontSize 14
Set Width 1400
Set Height 900
Set Padding 20
Set Theme "Catppuccin Mocha"

Type "# Initialize a new project with PSA"
Enter
Sleep 500ms
Enter

Type "cd ~/projects/example-app"
Enter
Sleep 500ms

Type "psa:init example-app"
Enter
Sleep 2s

Screenshot screenshots/project-init.png

Sleep 1s

Type "ls -la"
Enter
Sleep 1s

Type "# PROJECT.json created!"
Enter
Sleep 500ms

Type "cat PROJECT.json"
Enter
Sleep 2s

Screenshot screenshots/project-json.png

Sleep 1s
