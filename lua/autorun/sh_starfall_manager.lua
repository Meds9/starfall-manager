AddCSLuaFile("autorun/cl_starfall_manager.lua")
AddCSLuaFile("autorun/sv_starfall_manager.lua")

-- Networking messages
SF_MANAGER_NET = {
    UPDATE = "SF_Manager_Update",
    VIEW = "SF_Manager_View",
    REMOVE = "SF_Manager_Remove",
    REMOVE_ALL = "SF_Manager_RemoveAll"
}

-- Permission check (shared)
function SF_Manager_CanManage(ply)
    return ply:IsAdmin() or ply:IsSuperAdmin() -- Add more ranks if needed
end

if SERVER then
    util.AddNetworkString(SF_MANAGER_NET.UPDATE)
    util.AddNetworkString(SF_MANAGER_NET.VIEW)
    util.AddNetworkString(SF_MANAGER_NET.REMOVE)
    util.AddNetworkString(SF_MANAGER_NET.REMOVE_ALL)
end