local function GetStarfallInstances()
    local scripts = {}
    for _, ent in pairs(ents.FindByClass("starfall_processor")) do
        if IsValid(ent) and ent:GetOwner() then
            scripts[ent] = {
                owner = ent:GetOwner(),
                entity = ent,
                code = ent:GetCode()
            }
        end
    end
    return scripts
end

concommand.Add("sf_manager_open", function(ply)
    if not SF_Manager_CanManage(ply) then return end
    
    local scripts = GetStarfallInstances()
    net.Start(SF_MANAGER_NET.UPDATE)
    net.WriteTable(scripts)
    net.Send(ply)
end)

net.Receive(SF_MANAGER_NET.VIEW, function(len, ply)
    if not SF_Manager_CanManage(ply) then return end
    
    local ent = net.ReadEntity()
    if not IsValid(ent) or ent:GetClass() ~= "starfall_processor" then return end
    
    net.Start(SF_MANAGER_NET.VIEW)
    net.WriteString(ent:GetCode())
    net.Send(ply)
end)

net.Receive(SF_MANAGER_NET.REMOVE, function(len, ply)
    if not SF_Manager_CanManage(ply) then return end
    
    local ent = net.ReadEntity()
    if IsValid(ent) and ent:GetClass() == "starfall_processor" then
        ent:Remove()
    end
end)

net.Receive(SF_MANAGER_NET.REMOVE_ALL, function(len, ply)
    if not SF_Manager_CanManage(ply) then return end
    
    local owner = net.ReadEntity()
    if not IsValid(owner) then return end
    
    for _, ent in pairs(ents.FindByClass("starfall_processor")) do
        if IsValid(ent) and ent:GetOwner() == owner then
            ent:Remove()
        end
    end
end)