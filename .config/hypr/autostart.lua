hl.on("hyprland.start", function ()
    -- Authentication
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    -- Waybar
    hl.exec_cmd("qs -c noctalia-shell")
end)