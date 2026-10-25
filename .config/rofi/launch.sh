#!/usr/bin/env bash

# Paths
JSON_FILE="$HOME/.config/noctalia/colors.json"
ROFI_COLORS="$HOME/.config/rofi/colors.rasi"

# Default color palette
bg="#1e1e2e"
bg_input="#313244"
border="#585b70"
accent="#89b4fa"
fg="#cdd6f4"
fg_dim="#a6adc8"
text_on_accent="#1e1e2e"

if command -v jq &> /dev/null; then
    jq_installed=true
else
    jq_installed=false
fi

if [[ -f "$JSON_FILE" ]]; then
    json_file_exists=true
else
    json_file_exists=false
fi

if [[ "$jq_installed" == true && "$json_file_exists" == true ]]; then
    if bg=$(jq -er '.mSurface' "$JSON_FILE") &&
       bg_input=$(jq -er '.mSurfaceVariant' "$JSON_FILE") &&
       border=$(jq -er '.mOutline' "$JSON_FILE") &&
       accent=$(jq -er '.mPrimary' "$JSON_FILE") &&
       fg=$(jq -er '.mOnSurface' "$JSON_FILE") &&
       fg_dim=$(jq -er '.mOnSurfaceVariant' "$JSON_FILE") &&
       text_on_accent=$(jq -er '.mOnPrimary' "$JSON_FILE"); then
        :
    else
        notify-send "Warning: Invalid colorscheme"
        notify-send "Info: Falling back to default colorscheme"
    fi
else
    if [[ "$jq_installed" == false ]]; then
        notify-send "Warning: Jq not installed"
    fi
    if [[ "$json_file_exists" == false ]]; then
        notify-send "Warning: $JSON_FILE does not exist"
    fi
    notify-send "Info: Falling back to default colorscheme"
fi

# Generate the rasi color block
cat << EOF > "$ROFI_COLORS"
* {
    bg-col:          $bg;
    bg-col-light:    $bg_input;
    border-col:      $border;
    accent-col:      $accent;
    fg-col:          $fg;
    fg-col-dim:      $fg_dim;
    fg-on-accent:    $text_on_accent;
}
EOF

# Launch Rofi in drun mode
rofi -show drun
