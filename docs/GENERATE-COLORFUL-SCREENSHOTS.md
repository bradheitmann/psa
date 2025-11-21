# Generating Colorful Screenshots

## The Problem

**Markdown code blocks are MONOCHROME.** No matter how colorful PSA is in the terminal, GitHub README code blocks render as plain text.

## The Solution

Use **VHS** (terminal recorder) to capture PSA running with ACTUAL COLORS and export as PNG/GIF.

---

## Generate Real Colorful Screenshots

```bash
cd demos
./generate-screenshots.sh
```

This will create:
- `screenshots/dashboard-overview.png` - COLORFUL dashboard
- `screenshots/project-list.png` - COLORFUL interactive list  
- `screenshots/metrics-charts.png` - COLORFUL charts
- Plus animated GIFs

These replace the monochrome code blocks in README with actual terminal output showing:
- 🎨 Catppuccin/Gruvbox/Tokyo Night colors
- 📊 Colored progress bars (green/cyan/orange gradients)
- ⚡ Colored sparklines
- 🌈 Full RGB terminal colors

---

## Alternative: Run PSA and Screenshot

```bash
# 1. Run PSA
psa

# 2. Use macOS screenshot
Cmd+Shift+4

# 3. Save to screenshots/
```

---

## Why Code Blocks Are Monochrome

GitHub markdown renders:
```
████ ACTIVE
```

As monochrome text, even though PSA displays it in vibrant cyan/green.

**Solution:** PNG/GIF images show actual terminal colors.
