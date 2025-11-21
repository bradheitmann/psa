# VHS Tape: PSA Dashboard Overview
# Records the main dashboard experience

Output demos/01-dashboard-overview.gif

Require echo

Set Shell "zsh"
Set FontSize 14
Set Width 1400
Set Height 900
Set Padding 20
Set Theme "Catppuccin Mocha"

Type "# PSA - Project State Agent"
Enter
Sleep 500ms

Type "# Beautiful terminal dashboard for any project"
Enter
Sleep 500ms
Enter

Type "psa"
Enter
Sleep 3s

# Capture the dashboard
Screenshot screenshots/dashboard-overview.png

Sleep 2s

# Show help
Ctrl+C
Sleep 500ms

Type "psa help"
Enter
Sleep 3s

Screenshot screenshots/help-screen.png

Sleep 1s
