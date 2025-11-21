#!/bin/bash
# PSA Visual Library - Colors, Charts, Unicode Elements
# Requires Nerd Fonts for best experience

# ============================================================================
# COLOR PALETTE (24-bit RGB)
# ============================================================================

# Reset
RESET='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'
ITALIC='\033[3m'
UNDERLINE='\033[4m'

# Gruvbox-inspired colors (rich, warm palette)
BG_DARK='\033[48;2;40;40;40m'
BG_DARKER='\033[48;2;29;32;33m'

FG_WHITE='\033[38;2;235;219;178m'
FG_GRAY='\033[38;2;146;131;116m'
FG_RED='\033[38;2;251;73;52m'
FG_GREEN='\033[38;2;184;187;38m'
FG_YELLOW='\033[38;2;250;189;47m'
FG_BLUE='\033[38;2;131;165;152m'
FG_PURPLE='\033[38;2;211;134;155m'
FG_AQUA='\033[38;2;142;192;124m'
FG_ORANGE='\033[38;2;254;128;25m'
FG_PINK='\033[38;2;249;145;189m'

# Catppuccin-inspired accent colors (vibrant)
ACCENT_MAUVE='\033[38;2;203;166;247m'
ACCENT_LAVENDER='\033[38;2;180;190;254m'
ACCENT_SAPPHIRE='\033[38;2;116;199;236m'
ACCENT_SKY='\033[38;2;137;220;235m'
ACCENT_TEAL='\033[38;2;148;226;213m'
ACCENT_GREEN='\033[38;2;166;227;161m'
ACCENT_YELLOW='\033[38;2;249;226;175m'
ACCENT_PEACH='\033[38;2;250;179;135m'
ACCENT_MAROON='\033[38;2;235;160;172m'
ACCENT_RED='\033[38;2;243;139;168m'

# Tokyo Night colors (neon, cyberpunk)
NEON_BLUE='\033[38;2;122;162;247m'
NEON_CYAN='\033[38;2;125;207;255m'
NEON_GREEN='\033[38;2;158;206;106m'
NEON_MAGENTA='\033[38;2;187;154;247m'
NEON_ORANGE='\033[38;2;255;158;100m'
NEON_PURPLE='\033[38;2;157;124;216m'

# ============================================================================
# NERD FONT ICONS
# ============================================================================

ICON_PROJECT=""
ICON_FOLDER=""
ICON_FILE=""
ICON_GIT=""
ICON_CHECK="✓"
ICON_CROSS="✗"
ICON_STAR="★"
ICON_ARROW="➜"
ICON_DOT="•"
ICON_DIAMOND="◆"
ICON_CIRCLE="●"
ICON_SQUARE="■"
ICON_TRIANGLE="▲"

ICON_CODE=""
ICON_TERMINAL=""
ICON_BUG=""
ICON_ROCKET=""
ICON_FIRE=""
ICON_LIGHTNING="⚡"
ICON_BRAIN=""
ICON_CPU=""
ICON_CLOCK="󱑆"
ICON_GAUGE="󰓅"

ICON_ACTIVE="󰫢"
ICON_PAUSED="󰏤"
ICON_COMPLETE="󰄬"
ICON_ARCHIVED="󰀨"

ICON_UP="▲"
ICON_DOWN="▼"
ICON_RIGHT="▶"
ICON_LEFT="◀"

# Status indicators with color
STATUS_ACTIVE="${NEON_GREEN}${ICON_ACTIVE}${RESET}"
STATUS_PAUSED="${NEON_ORANGE}${ICON_PAUSED}${RESET}"
STATUS_COMPLETE="${NEON_BLUE}${ICON_COMPLETE}${RESET}"
STATUS_ARCHIVED="${FG_GRAY}${ICON_ARCHIVED}${RESET}"

# ============================================================================
# UNICODE BOX DRAWING (Double-line style)
# ============================================================================

BOX_TL="╔"  # Top-left
BOX_TR="╗"  # Top-right
BOX_BL="╚"  # Bottom-left
BOX_BR="╝"  # Bottom-right
BOX_H="═"   # Horizontal
BOX_V="║"   # Vertical
BOX_VR="╠"  # Vertical-right
BOX_VL="╣"  # Vertical-left
BOX_HU="╩"  # Horizontal-up
BOX_HD="╦"  # Horizontal-down
BOX_PLUS="╬" # Cross

# Single-line style (lighter)
BOX_TL_S="┌"
BOX_TR_S="┐"
BOX_BL_S="└"
BOX_BR_S="┘"
BOX_H_S="─"
BOX_V_S="│"
BOX_VR_S="├"
BOX_VL_S="┤"
BOX_HU_S="┴"
BOX_HD_S="┬"
BOX_PLUS_S="┼"

# Block elements for charts
BLOCK_FULL="█"
BLOCK_SEVEN="▇"
BLOCK_SIX="▆"
BLOCK_FIVE="▅"
BLOCK_FOUR="▄"
BLOCK_THREE="▃"
BLOCK_TWO="▂"
BLOCK_ONE="▁"
BLOCK_EMPTY=" "

# Shade elements
SHADE_LIGHT="░"
SHADE_MEDIUM="▒"
SHADE_DARK="▓"

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

# Print colored text
color_print() {
  local color=$1
  shift
  echo -e "${color}${@}${RESET}"
}

# Print with icon
icon_print() {
  local icon=$1
  local color=$2
  shift 2
  echo -e "${color}${icon}${RESET} ${@}"
}

# ============================================================================
# BOX DRAWING FUNCTIONS
# ============================================================================

# Draw box header
draw_box_header() {
  local width=$1
  local title=$2
  local color=${3:-$ACCENT_LAVENDER}

  local padding=$(( (width - ${#title} - 2) / 2 ))
  local line=$(printf "%${width}s" | tr ' ' "$BOX_H")

  echo -e "${color}${BOX_TL}${line}${BOX_TR}${RESET}"
  printf "${color}${BOX_V}${RESET}"
  printf "%${padding}s" ""
  echo -ne "${BOLD}${color}${title}${RESET}"
  printf "%$((width - padding - ${#title}))s" ""
  echo -e "${color}${BOX_V}${RESET}"
  echo -e "${color}${BOX_VR}${line}${BOX_VL}${RESET}"
}

# Draw box line
draw_box_line() {
  local width=$1
  local content=$2
  local color=${3:-$ACCENT_LAVENDER}

  local content_length=${#content}
  # Strip ANSI codes for length calculation
  local stripped=$(echo -e "$content" | sed 's/\x1b\[[0-9;]*m//g')
  local stripped_length=${#stripped}

  printf "${color}${BOX_V}${RESET} "
  echo -n "$content"
  printf "%$((width - stripped_length - 2))s" ""
  echo -e " ${color}${BOX_V}${RESET}"
}

# Draw box footer
draw_box_footer() {
  local width=$1
  local color=${2:-$ACCENT_LAVENDER}

  local line=$(printf "%${width}s" | tr ' ' "$BOX_H")
  echo -e "${color}${BOX_BL}${line}${BOX_BR}${RESET}"
}

# ============================================================================
# ASCII BAR CHART
# ============================================================================

draw_bar_chart() {
  local data_name=$1
  local labels_name=$2
  local max_width=${3:-50}
  local title=${4:-"Chart"}
  local color=${5:-$NEON_CYAN}

  # Get arrays using eval (bash 3.x compatible)
  eval "local data_array=(\"\${${data_name}[@]}\")"
  eval "local labels_array=(\"\${${labels_name}[@]}\")"

  # Find max value for scaling
  local max_val=0
  for val in "${data_array[@]}"; do
    ((val > max_val)) && max_val=$val
  done

  # Draw title
  echo -e "\n${BOLD}${ACCENT_LAVENDER}${title}${RESET}\n"

  # Draw bars
  for i in "${!data_array[@]}"; do
    local value=${data_array[$i]}
    local label=${labels_array[$i]}
    local bar_width=$(( value * max_width / max_val ))
    local bar=$(printf "%${bar_width}s" | tr ' ' "$BLOCK_FULL")

    printf "  ${FG_GRAY}%-15s${RESET} ${color}${bar}${RESET} ${BOLD}%s${RESET}\n" \
      "$label" "$value"
  done
  echo ""
}

# ============================================================================
# HORIZONTAL BAR WITH GRADIENT
# ============================================================================

draw_progress_bar() {
  local percent=$1
  local width=${2:-50}
  local label=${3:-"Progress"}
  local show_percent=${4:-true}

  local filled=$(( percent * width / 100 ))
  local empty=$(( width - filled ))

  # Gradient colors based on percentage
  local color
  if ((percent >= 80)); then
    color=$NEON_GREEN
  elif ((percent >= 50)); then
    color=$NEON_CYAN
  elif ((percent >= 25)); then
    color=$NEON_ORANGE
  else
    color=$ACCENT_RED
  fi

  printf "  ${FG_GRAY}%-15s${RESET} [" "$label"
  printf "${color}%${filled}s" | tr ' ' "$BLOCK_FULL"
  printf "${DIM}%${empty}s${RESET}" | tr ' ' "$SHADE_LIGHT"
  printf "] "

  if [[ "$show_percent" == "true" ]]; then
    printf "${BOLD}${color}%3d%%${RESET}" "$percent"
  fi
  echo ""
}

# ============================================================================
# SPARKLINE (Inline mini-chart)
# ============================================================================

draw_sparkline() {
  local values_name=$1
  local color=${2:-$NEON_CYAN}

  # Get array using eval (bash 3.x compatible)
  eval "local values_array=(\"\${${values_name}[@]}\")"

  # Find min/max for scaling
  local min=${values_array[0]}
  local max=${values_array[0]}
  for val in "${values_array[@]}"; do
    ((val < min)) && min=$val
    ((val > max)) && max=$val
  done

  local range=$((max - min))
  [[ $range -eq 0 ]] && range=1

  # Map to block characters
  local chars=("$BLOCK_ONE" "$BLOCK_TWO" "$BLOCK_THREE" "$BLOCK_FOUR" "$BLOCK_FIVE" "$BLOCK_SIX" "$BLOCK_SEVEN" "$BLOCK_FULL")

  echo -n "${color}"
  for val in "${values_array[@]}"; do
    local normalized=$(( (val - min) * 7 / range ))
    echo -n "${chars[$normalized]}"
  done
  echo -e "${RESET}"
}

# ============================================================================
# METRIC CARD (Colored box with icon, label, value)
# ============================================================================

draw_metric_card() {
  local icon=$1
  local label=$2
  local value=$3
  local unit=$4
  local color=${5:-$ACCENT_SAPPHIRE}
  local trend=${6:-""}  # optional: ▲ or ▼

  local width=30
  local line=$(printf "%${width}s" | tr ' ' "$BOX_H_S")
  local label_width=$((width-5))
  local value_width=$((width-4))

  echo -e "${color}${BOX_TL_S}${line}${BOX_TR_S}${RESET}"
  printf "${color}${BOX_V_S}${RESET} "
  printf "${color}${BOLD}${icon}${RESET}  ${FG_GRAY}%-${label_width}s${RESET}" "$label"
  echo -e " ${color}${BOX_V_S}${RESET}"

  printf "${color}${BOX_V_S}${RESET}  "
  printf "${BOLD}${color}%-${value_width}s${RESET}" "${value}${unit}"
  if [[ -n "$trend" ]]; then
    echo -ne " ${trend}"
  fi
  echo -e " ${color}${BOX_V_S}${RESET}"
  echo -e "${color}${BOX_BL_S}${line}${BOX_BR_S}${RESET}"
}

# ============================================================================
# STATUS BADGE
# ============================================================================

draw_status_badge() {
  local status=$1

  case "$status" in
    "active")
      echo -e "${NEON_GREEN}${BLOCK_FULL}${RESET} ${BOLD}ACTIVE${RESET}"
      ;;
    "paused")
      echo -e "${NEON_ORANGE}${BLOCK_FULL}${RESET} ${BOLD}PAUSED${RESET}"
      ;;
    "complete")
      echo -e "${NEON_BLUE}${BLOCK_FULL}${RESET} ${BOLD}COMPLETE${RESET}"
      ;;
    "archived")
      echo -e "${FG_GRAY}${BLOCK_FULL}${RESET} ${DIM}ARCHIVED${RESET}"
      ;;
    *)
      echo -e "${FG_GRAY}${BLOCK_FULL}${RESET} ${DIM}UNKNOWN${RESET}"
      ;;
  esac
}

# ============================================================================
# HEADER WITH GRADIENT TEXT (requires lolcat or manual gradient)
# ============================================================================

draw_header() {
  local text=$1
  local use_figlet=${2:-true}

  if command -v figlet &> /dev/null && [[ "$use_figlet" == "true" ]]; then
    if command -v lolcat &> /dev/null; then
      echo "$text" | figlet -f slant | lolcat -f
    else
      echo "$text" | figlet -f slant
    fi
  else
    # Fallback: Simple colored header
    local width=80
    local line=$(printf "%${width}s" | tr ' ' "$BOX_H")
    echo -e "\n${ACCENT_LAVENDER}${BOX_TL}${line}${BOX_TR}${RESET}"

    local padding=$(( (width - ${#text}) / 2 ))
    printf "${ACCENT_LAVENDER}${BOX_V}${RESET}"
    printf "%${padding}s" ""
    printf "${BOLD}${NEON_CYAN}%s${RESET}" "$text"
    printf "%$((width - padding - ${#text}))s" ""
    echo -e "${ACCENT_LAVENDER}${BOX_V}${RESET}"

    echo -e "${ACCENT_LAVENDER}${BOX_BL}${line}${BOX_BR}${RESET}\n"
  fi
}

# ============================================================================
# TABLE WITH COLORS
# ============================================================================

draw_table_header() {
  local headers_name=$1
  local widths_name=$2
  local color=${3:-$ACCENT_LAVENDER}

  # Get arrays using eval (bash 3.x compatible)
  eval "local headers_array=(\"\${${headers_name}[@]}\")"
  eval "local widths_array=(\"\${${widths_name}[@]}\")"

  # Top border
  echo -n "${color}${BOX_TL}${RESET}"
  for i in "${!headers_array[@]}"; do
    local w=${widths_array[$i]}
    printf "${color}%${w}s${RESET}" | tr ' ' "$BOX_H"
    local headers_len=${#headers_array[@]}
    if [[ $i -lt $((headers_len - 1)) ]]; then
      echo -n "${color}${BOX_HD}${RESET}"
    fi
  done
  echo -e "${color}${BOX_TR}${RESET}"

  # Header row
  echo -n "${color}${BOX_V}${RESET}"
  for i in "${!headers_array[@]}"; do
    local w=${widths_array[$i]}
    local w_minus_2=$((w-2))
    printf " ${BOLD}%-${w_minus_2}s${RESET} ${color}${BOX_V}${RESET}" "${headers_array[$i]}"
  done
  echo ""

  # Separator
  echo -n "${color}${BOX_VR}${RESET}"
  for i in "${!headers_array[@]}"; do
    local w=${widths_array[$i]}
    printf "${color}%${w}s${RESET}" | tr ' ' "$BOX_H"
    local headers_len=${#headers_array[@]}
    if [[ $i -lt $((headers_len - 1)) ]]; then
      echo -n "${color}${BOX_PLUS}${RESET}"
    fi
  done
  echo -e "${color}${BOX_VL}${RESET}"
}

draw_table_row() {
  local cols_name=$1
  local widths_name=$2
  local color=${3:-$ACCENT_LAVENDER}

  # Get arrays using eval (bash 3.x compatible)
  eval "local cols_array=(\"\${${cols_name}[@]}\")"
  eval "local widths_array=(\"\${${widths_name}[@]}\")"

  echo -n "${color}${BOX_V}${RESET}"
  for i in "${!cols_array[@]}"; do
    local w=${widths_array[$i]}
    local w_minus_2=$((w-2))
    printf " %-${w_minus_2}s ${color}${BOX_V}${RESET}" "${cols_array[$i]}"
  done
  echo ""
}

draw_table_footer() {
  local widths_name=$1
  local color=${2:-$ACCENT_LAVENDER}

  # Get array using eval (bash 3.x compatible)
  eval "local widths_array=(\"\${${widths_name}[@]}\")"

  echo -n "${color}${BOX_BL}${RESET}"
  for i in "${!widths_array[@]}"; do
    local w=${widths_array[$i]}
    printf "${color}%${w}s${RESET}" | tr ' ' "$BOX_H"
    local widths_len=${#widths_array[@]}
    if [[ $i -lt $((widths_len - 1)) ]]; then
      echo -n "${color}${BOX_HU}${RESET}"
    fi
  done
  echo -e "${color}${BOX_BR}${RESET}"
}

# ============================================================================
# MINI GAUGE (Circular-style indicator)
# ============================================================================

draw_gauge() {
  local value=$1
  local max=$2
  local label=$3
  local color=${4:-$NEON_CYAN}

  local percent=$((value * 100 / max))
  local gauge_char

  if ((percent >= 90)); then
    gauge_char="●"
    color=$ACCENT_RED
  elif ((percent >= 75)); then
    gauge_char="◐"
    color=$NEON_ORANGE
  elif ((percent >= 50)); then
    gauge_char="◑"
    color=$NEON_CYAN
  elif ((percent >= 25)); then
    gauge_char="◔"
    color=$NEON_GREEN
  else
    gauge_char="○"
    color=$FG_GRAY
  fi

  printf "  ${color}${gauge_char}${RESET} ${FG_GRAY}%-20s${RESET} ${BOLD}%s${RESET}/%s ${DIM}(%d%%)${RESET}\n" \
    "$label" "$value" "$max" "$percent"
}

# ============================================================================
# ADVANCED VISUALIZATIONS
# ============================================================================

# Horizontal bar chart with scale
draw_horizontal_bar_chart() {
  local -n data=$1
  local -n labels=$2
  local title=$3
  local max_width=${4:-40}
  local unit=${5:-""}

  # Find max value
  local max_val=0
  for val in "${data[@]}"; do
    ((val > max_val)) && max_val=$val
  done

  echo -e "\n${BOLD}${ACCENT_LAVENDER}$title${RESET}"

  # Draw bars
  for i in "${!data[@]}"; do
    local value=${data[$i]}
    local label=${labels[$i]}
    local bar_width=$(( value * max_width / max_val ))
    local percent=$(( value * 100 / max_val ))
    local bar=$(printf "%${bar_width}s" | tr ' ' "$BLOCK_FULL")
    local empty=$(( max_width - bar_width ))
    local empty_bar=$(printf "%${empty}s" | tr ' ' ' ')

    printf "  [%-8s] ${NEON_CYAN}${bar}${RESET}${empty_bar} %s%s (%d%%)\n" \
      "$label" "$value" "$unit" "$percent"
  done

  # Draw scale
  printf "            ${FG_GRAY}|"
  for ((i=0; i<=max_width; i+=10)); do
    printf "----------|"
  done
  echo -e "${RESET}"
  printf "            ${FG_GRAY}"
  for ((i=0; i<=max_val; i+=$(( max_val / 4 )))); do
    printf "%-10s" "$i$unit"
  done
  echo -e "${RESET}\n"
}

# Vertical bar chart
draw_vertical_bar_chart() {
  local -n data=$1
  local -n labels=$2
  local title=$3
  local max_height=${4:-10}

  # Find max value
  local max_val=0
  for val in "${data[@]}"; do
    ((val > max_val)) && max_val=$val
  done

  echo -e "\n${BOLD}${ACCENT_LAVENDER}$title${RESET}\n"

  # Draw from top to bottom
  for ((row=max_height; row>=0; row--)); do
    local threshold=$(( row * max_val / max_height ))
    printf "${FG_GRAY}%4s ┤${RESET} " "$threshold"

    for i in "${!data[@]}"; do
      local value=${data[$i]}
      local scaled=$(( value * max_height / max_val ))

      if ((scaled >= row)); then
        printf "${NEON_CYAN}█${RESET} "
      else
        printf "  "
      fi
    done
    echo ""
  done

  # X-axis
  printf "${FG_GRAY}   0 └"
  for i in "${!data[@]}"; do
    printf "─┴"
  done
  echo -e "${RESET}"

  # Labels
  printf "      "
  for label in "${labels[@]}"; do
    printf "%-8s" "$label"
  done
  echo -e "\n"
}

# Heatmap for activity
draw_activity_heatmap() {
  local title=$1
  local -n matrix=$2  # 2D array: matrix[row][col]

  echo -e "\n${BOLD}${ACCENT_LAVENDER}$title${RESET}\n"

  local days=("Mon" "Tue" "Wed" "Thu" "Fri" "Sat" "Sun")
  local hours=("00" "03" "06" "09" "12" "15" "18" "21")

  # Header
  printf "     "
  for hour in "${hours[@]}"; do
    printf " %-3s" "$hour"
  done
  echo ""

  printf "    ${FG_GRAY}┌"
  for ((i=0; i<${#hours[@]}; i++)); do
    printf "───┬"
  done
  echo -e "───┐${RESET}"

  # Rows
  for day_idx in "${!days[@]}"; do
    printf "${FG_GRAY}%-3s │${RESET}" "${days[$day_idx]}"

    for hour_idx in "${!hours[@]}"; do
      # Get value (0-4 scale)
      local val=${matrix[$day_idx * ${#hours[@]} + $hour_idx]:-0}

      local char
      case $val in
        0) char="${FG_GRAY}·${RESET}" ;;
        1) char="${NEON_GREEN}${SHADE_LIGHT}${RESET}" ;;
        2) char="${NEON_CYAN}${SHADE_MEDIUM}${RESET}" ;;
        3) char="${NEON_ORANGE}${SHADE_DARK}${RESET}" ;;
        *) char="${NEON_PURPLE}${BLOCK_FULL}${RESET}" ;;
      esac

      printf " %s ${FG_GRAY}│${RESET}" "$char"
    done
    echo ""
  done

  printf "    ${FG_GRAY}└"
  for ((i=0; i<${#hours[@]}; i++)); do
    printf "───┴"
  done
  echo -e "───┘${RESET}"

  echo -e "    ${FG_GRAY}Legend: · None  ${NEON_GREEN}${SHADE_LIGHT}${RESET} Low  ${NEON_CYAN}${SHADE_MEDIUM}${RESET} Med  ${NEON_ORANGE}${SHADE_DARK}${RESET} High  ${NEON_PURPLE}${BLOCK_FULL}${RESET} Peak${RESET}\n"
}

# Multi-line chart
draw_multi_line_chart() {
  local title=$1
  local max_height=${2:-10}
  # Additional data series passed as nameref arrays

  echo -e "\n${BOLD}${ACCENT_LAVENDER}$title${RESET}\n"

  # Example implementation - needs actual data
  local heights=(10 9 8 7 6 5 4 3 2 1 0)

  for height in "${heights[@]}"; do
    local val=$(( height * 10 ))
    printf "${FG_GRAY}%3s ┤${RESET} " "$val"

    # Plot points (simplified)
    for ((i=0; i<12; i++)); do
      # Would plot actual data points here
      printf " "
    done
    echo ""
  done

  printf "${FG_GRAY}  0 └"
  for ((i=0; i<12; i++)); do
    printf "──"
  done
  echo -e "${RESET}\n"
}

# System monitor style dashboard
draw_system_monitor() {
  local cpu=$1
  local mem=$2
  local disk=$3

  local width=70
  local line=$(printf "%${width}s" | tr ' ' "$BOX_H_S")

  echo -e "${ACCENT_LAVENDER}${BOX_TL_S}${line}${BOX_TR_S}${RESET}"

  printf "${ACCENT_LAVENDER}${BOX_V_S}${RESET} ${BOLD}SYSTEM STATUS MONITOR${RESET}"
  printf "%$((width-22))s" ""
  echo -e "${FG_GRAY}■ LIVE ■ $(date +%H:%M:%S)${RESET} ${ACCENT_LAVENDER}${BOX_V_S}${RESET}"

  echo -e "${ACCENT_LAVENDER}${BOX_VR_S}${line}${BOX_VL_S}${RESET}"

  # CPU
  draw_progress_bar $cpu 50 "CPU" false
  printf "  ${FG_GRAY}Temperature: 52°C${RESET}\n"

  # Memory
  draw_progress_bar $mem 50 "Memory" false
  printf "  ${FG_GRAY}Available: 3.2GB${RESET}\n"

  # Disk
  draw_progress_bar $disk 50 "Disk" false
  printf "  ${FG_GRAY}I/O: 125 MB/s${RESET}\n"

  echo -e "${ACCENT_LAVENDER}${BOX_BL_S}${line}${BOX_BR_S}${RESET}\n"
}

# ============================================================================
# EXPORT FUNCTIONS
# ============================================================================

# Make functions available when sourced
export -f color_print
export -f icon_print
export -f draw_box_header
export -f draw_box_line
export -f draw_box_footer
export -f draw_bar_chart
export -f draw_progress_bar
export -f draw_sparkline
export -f draw_metric_card
export -f draw_horizontal_bar_chart
export -f draw_vertical_bar_chart
export -f draw_activity_heatmap
export -f draw_multi_line_chart
export -f draw_system_monitor
export -f draw_status_badge
export -f draw_header
export -f draw_table_header
export -f draw_table_row
export -f draw_table_footer
export -f draw_gauge
