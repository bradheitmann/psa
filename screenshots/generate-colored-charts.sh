#!/bin/bash
# Generate colored PNG for each chart - EXACT match to README code blocks

cd "$(dirname "$0")"

# Extract chart 1 - Executive Dashboard
cat > chart1.txt << 'EOF'
╔══════════════════════════════════════════════════════════════════════════════╗
║                         PSA - PROJECT STATE AGENT                             ║
╠════════════════════════════════╤═════════════════════════════════════════════╣
║ KEY METRICS                    │ TREND ANALYSIS                              ║
║                                │                                             ║
║  Projects:   7    ↑2 this week │ Activity: ▂▄▅▆▇█▇▆▅▄ ↑ Positive           ║
║  Active:     5    71% portfolio│ Progress: ▄▅▆▇████ Strong Growth           ║
║  Total LOC:  67K  ↑8.2K added  │ Velocity: ▁▂▃▄▅▆▇███ Accelerating          ║
║  Coverage:   82%  ↑3% improved │                                             ║
╠════════════════════════════════╪═════════════════════════════════════════════╣
║ STATUS BREAKDOWN               │ TOP PROJECTS BY LOC                         ║
║                                │                                             ║
║ Active   ████████████████ 71%  │ company-api      ██████████████████ 22K    ║
║ Paused   ███░░░░░░░░░░░░  14%  │ mobile-app       ███████████░░░░░░ 15K     ║
║ Complete ███░░░░░░░░░░░░  14%  │ react-dashboard  █████████░░░░░░░░ 12K     ║
║                                │ flask-api        ██████░░░░░░░░░░░  8.5K    ║
╚════════════════════════════════╧═════════════════════════════════════════════╝
EOF

silicon --output chart1-dashboard.png \
  --theme "Catppuccin-mocha" \
  --font "Hack Nerd Font" \
  --background "#1e1e2e" \
  --no-line-number \
  --no-window-controls \
  chart1.txt

# Extract chart 2 - Token Usage
cat > chart2.txt << 'EOF'
Token Usage by Project (Claude Code)

[flask-api  ] ████████████████████████████████████████ 8.5M tokens (100%)
[react-dash ] ████████████████████                    5.2M tokens (61%)
[mobile-app ] ███████████████░░░░░░░░░░░░░░░░░░░░░░░░ 3.8M tokens (45%)
[rust-cli   ] ██████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ 2.1M tokens (25%)
[python-lib ] █████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ 1.8M tokens (21%)
              |----------|----------|----------|----------|
              0         2M        4M        6M        8M

Total: 21.4M tokens  •  Average: 720 tokens/line  •  Est. Cost: $214
EOF

silicon --output chart2-tokens.png \
  --theme "Catppuccin-mocha" \
  --font "Hack Nerd Font" \
  --background "#1e1e2e" \
  --no-line-number \
  --no-window-controls \
  chart2.txt

# Extract chart 3 - Heatmap
cat > chart3.txt << 'EOF'
Commit Activity Heatmap (Last 7 Days × 8 Time Blocks)

     00  03  06  09  12  15  18  21
    ┌───┬───┬───┬───┬───┬───┬───┬───┐
Mon │ · │ · │ ░ │ ▓ │ █ │ █ │ ▒ │ · │  Peak: 12-15h
Tue │ · │ · │ ▒ │ █ │ █ │ █ │ ▓ │ ░ │  Active all day
Wed │ · │ · │ ░ │ ▓ │ █ │ ▓ │ ▒ │ · │  Standard hours
Thu │ · │ · │ ▒ │ █ │ █ │ █ │ ▓ │ ░ │  High productivity
Fri │ · │ ░ │ ▒ │ ▓ │ █ │ ▒ │ ░ │ · │  Tapering off
Sat │ ░ │ ▒ │ ▓ │ ▒ │ ░ │ · │ · │ · │  Weekend coding
Sun │ ▒ │ ▓ │ ▒ │ ░ │ · │ · │ · │ · │  Light activity
    └───┴───┴───┴───┴───┴───┴───┴───┘

Legend: · None  ░ Low  ▒ Med  ▓ High  █ Peak
EOF

silicon --output chart3-heatmap.png \
  --theme "Catppuccin-mocha" \
  --font "Hack Nerd Font" \
  --background "#1e1e2e" \
  --no-line-number \
  --no-window-controls \
  chart3.txt

# Continue for all charts...
echo "✅ Generated colored charts with silicon"
ls -lh *.png

