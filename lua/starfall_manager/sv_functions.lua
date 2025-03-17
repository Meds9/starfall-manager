-- Additional utility functions if needed
function SF_Manager_GetPlayerScripts(ply)
    local scripts = {}
    for _, ent in pairs(ents.FindByClass("starfall_processor")) do
        if IsValid(ent) and ent:GetOwner() == ply then
            table.insert(scripts, ent)
        end
    end
    return scripts
end

-- Logging function (optional)
function SF_Manager_LogAction(ply, action, target)
    print(string.format("[SF Manager] %s (%s) performed %s on %s",
        ply:Nick(), ply:SteamID(), action, tostring(target)))
end