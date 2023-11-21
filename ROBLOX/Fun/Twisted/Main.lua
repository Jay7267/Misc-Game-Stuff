--Game: Twisted [BETA] | Script Author: Arifexta#4901
repeat wait() until game:IsLoaded()

local UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))()
local Notification = loadstring(game:HttpGet("https://api.irisapp.ca/Scripts/IrisBetterNotifications.lua"))()
local MainUI = UILibrary.Load("-")
local FirstPage = MainUI.AddPage("Home")
local InfoPage = MainUI.AddPage("Storm Info")
local FirstLabel = FirstPage.AddLabel("Section 1")

SpawnNames = (function(xpath)
    local spawns = {}
    for _, v in pairs(xpath:GetChildren()) do
        --print(v)
        table.insert(spawns, v.Name)
    end
    return spawns
end)

local FirstButton = FirstPage.AddButton("Secret Safe Area", function()
    ssppos = game:GetService("Workspace").playerRelated.emsShop["softwood_4"].stump.Position
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(ssppos)
end)

local TPLabel = FirstPage.AddLabel("Teleports")
local SpawnDropdown = FirstPage.AddDropdown("Spawn Locations", SpawnNames(game:GetService("Workspace").playerRelated.townSpawns), function(Value)
    game:GetService("ReplicatedStorage").events.playerHometown:FireServer(Value)
end)

local RouteDropdown = FirstPage.AddDropdown("Route Locations", SpawnNames(game:GetService("Workspace").radar.detectors.routeDetectors), function(Value)
    for i, v in pairs(game:GetService("Workspace").radar.detectors.routeDetectors:GetDescendants()) do
        if v.Name == Value then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
        end
    end
end)

local storms = game:GetService("Workspace").stormRelated.storms
local StormDropdown = FirstPage.AddDropdown("Storm Locations", SpawnNames(storms), function(Value)
    for i, v in pairs(storms:GetChildren()) do
        if v.Name == Value then
            center = storms[tostring(v)].center
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(center.Position + Vector3.new(25,-50,25))
        end
    end
end)

--page 2
local StormDropdown2 = InfoPage.AddDropdown("Select Storm", SpawnNames(storms), function(Value)
    for i, v in pairs(storms:GetChildren()) do
        if v.Name == Value then
            data = storms[tostring(v)].config
            local fd = {}
            for j, v2 in pairs(data:GetChildren()) do
                local info = v2.Name .. " : " .. v2.Value .. "\n"
                table.insert(fd, tostring(info))
            end
            fc = ''
            for x, c in pairs(fd) do
                fc = fc .. c
            end
            print(fc)
        end
    end
    Notification.WallNotification("Storm Data: " .. Value, fc, {
        Duration = 3,
        TitleSettings = {
            Enabled = true
        }
    });
end)