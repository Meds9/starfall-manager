-- (Replacing your initial cl_starfall_manager.lua with enhanced version)
net.Receive(SF_MANAGER_NET.UPDATE, function()
    local scripts = net.ReadTable()
    SF_Manager_OpenUI(scripts)
end)

net.Receive(SF_MANAGER_NET.VIEW, function()
    local code = net.ReadString()
    SF_Manager_ShowCode(code)
end)

function SF_Manager_OpenUI(scripts)
    local frame = vgui.Create("DFrame")
    frame:SetSize(600, 400)
    frame:SetTitle("Starfall Script Manager")
    frame:Center()
    frame:MakePopup()

    local list = vgui.Create("DListView", frame)
    list:Dock(FILL)
    list:DockMargin(5, 5, 5, 5)
    list:AddColumn("Owner")
    list:AddColumn("Entity ID")
    list:AddColumn("Actions")

    for instance, data in pairs(scripts) do
        local line = list:AddLine(
            IsValid(data.owner) and data.owner:Nick() or "Unknown",
            tostring(data.entity:EntIndex())
        )
        
        local panel = vgui.Create("DPanel")
        panel:SetSize(200, 20)
        
        local btnView = vgui.Create("DButton", panel)
        btnView:SetText("View")
        btnView:SetSize(50, 20)
        btnView:SetPos(0, 0)
        btnView.DoClick = function()
            net.Start(SF_MANAGER_NET.VIEW)
            net.WriteEntity(data.entity)
            net.SendToServer()
        end

        local btnRemove = vgui.Create("DButton", panel)
        btnRemove:SetText("Remove")
        btnRemove:SetSize(50, 20)
        btnRemove:SetPos(55, 0)
        btnRemove.DoClick = function()
            net.Start(SF_MANAGER_NET.REMOVE)
            net.WriteEntity(data.entity)
            net.SendToServer()
            frame:Close()
        end

        local btnRemoveAll = vgui.Create("DButton", panel)
        btnRemoveAll:SetText("Remove All")
        btnRemoveAll:SetSize(70, 20)
        btnRemoveAll:SetPos(110, 0)
        btnRemoveAll.DoClick = function()
            net.Start(SF_MANAGER_NET.REMOVE_ALL)
            net.WriteEntity(data.owner)
            net.SendToServer()
            frame:Close()
        end

        line:SetColumnText(3, "")
        line.Columns[3].Paint = function() end
        line.Columns[3].Value = panel
    end
end

function SF_Manager_ShowCode(code)
    local frame = vgui.Create("DFrame")
    frame:SetSize(600, 400)
    frame:SetTitle("Starfall Code Viewer")
    frame:Center()
    frame:MakePopup()

    local textEntry = vgui.Create("DTextEntry", frame)
    textEntry:SetMultiline(true)
    textEntry:Dock(FILL)
    textEntry:DockMargin(5, 5, 5, 5)
    textEntry:SetText(code)
    
    local btnCopy = vgui.Create("DButton", frame)
    btnCopy:SetText("Copy to Clipboard")
    btnCopy:Dock(BOTTOM)
    btnCopy:DockMargin(5, 0, 5, 5)
    btnCopy.DoClick = function()
        SetClipboardText(code)
    end
end