local monitor_profiles = {
    ["Desktop"] = {
        output   = "",
        mode     = "preferred",
        position = "auto",
        scale    = "auto",
    },
    ["Laptop"] = {
        output   = "",
        mode     = "preferred",
        position = "auto",
        scale    = "1.25",
    },
    ["Generic"] = {
        output   = "",
        mode     = "preferred",
        position = "auto",
        scale    = "auto",
    }
}

for _, monitor in ipairs(hl.get_monitors()) do
    if monitor.name == "DP-1" then
        hl.monitor(monitor_profiles["Desktop"])
    elseif monitor.name == "eDP-1" then
        hl.monitor(monitor_profiles["Laptop"])
    else
        hl.monitor(monitor_profiles["Generic"])
    end
end