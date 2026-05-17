#!/usr/bin/env python3

import json
import subprocess

with open("/home/d7251/.config/noctalia/colors.json") as f:
    scheme = json.load(f)

# Slice off the leading '#' from the hex color codes
active_color = scheme["mPrimary"][1:]
inactive_color = scheme["mSurface"][1:]

with open("/home/d7251/.config/hypr/dynamic-colors.lua", "r") as f:
    lines = f.readlines()

# Update the color values in the Lua file
lines[0] = f"active_color = \"rgb({active_color})\"\n"
lines[1] = f"inactive_color = \"rgb({inactive_color})\"\n"

with open("/home/d7251/.config/hypr/dynamic-colors.lua", "w") as f:
    f.writelines(lines)

subprocess.run(["hyprctl", "reload"])