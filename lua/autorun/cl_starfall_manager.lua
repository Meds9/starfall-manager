-- cl_starfall_manager.lua (Client-Side)
net.Receive("SF_Manager_Update", function()
    local scripts = net.ReadTable()
    SF_Manager_OpenUI(scripts)
end)

net.Receive("SF_Manager_View", function()
    local code = net.ReadString()
    SF_Manager_ShowCode(code)
end)

function SF_Manager_OpenUI(scripts)
    local frame = vgui.Create("DFrame")
    frame:SetSize(500, 400)
    frame:SetTitle("Starfall Script Manager")
    frame:Center()
    frame:MakePopup()

    local list = vgui.Create("DListView", frame)
    list:SetSize(480, 300)
    list:SetPos(10, 30)
    list:AddColumn("Owner")
    list:AddColumn("Entity")
    list:AddColumn("Actions")

    for instance, data in pairs(scripts) do
        local line = list:AddLine(data.owner:Nick(), tostring(data.entity))
        
        local btnView = vgui.Create("DButton", frame)
        btnView:SetText("View")
        btnView:SetSize(50, 20)
        btnView.DoClick = function()
            net.Start("SF_Manager_View")
            net.WriteEntity(data.entity)
            net.SendToServer()
        end

        local btnRemove = vgui.Create("DButton", frame)
        btnRemove:SetText("Remove")
        btnRemove:SetSize(50, 20)
        btnRemove.DoClick = function()
            net.Start("SF_Manager_Remove")
            net.WriteEntity(data.entity)
            net.SendToServer()
        end
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
    textEntry:SetSize(580, 350)
    textEntry:SetPos(10, 30)
    textEntry:SetText(code)
    textEntry:SetEditable(false)
end
