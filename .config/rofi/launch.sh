#!/usr/bin/env bash

# Paths - Adjust the path to your noctalia folder if necessary
JSON_FILE="$HOME/.config/noctalia/colors.json" 
ROFI_COLORS="$HOME/.config/rofi/colors.rasi"

# Ensure jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required to parse colors.json"
    exit 1
fi

# Extract your specific Material keys from the JSON
bg=$(jq -r '.mSurface' "$JSON_FILE")
bg_input=$(jq -r '.mSurfaceVariant' "$JSON_FILE")
border=$(jq -r '.mOutline' "$JSON_FILE")
accent=$(jq -r '.mPrimary' "$JSON_FILE")
fg=$(jq -r '.mOnSurface' "$JSON_FILE")
fg_dim=$(jq -r '.mOnSurfaceVariant' "$JSON_FILE")
text_on_accent=$(jq -r '.mOnPrimary' "$JSON_FILE")

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