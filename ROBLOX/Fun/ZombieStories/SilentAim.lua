getgenv().ene2 = true

local Camera = Workspace.CurrentCamera
local Zombies = workspace.Zombies;
local Player = game.Players.LocalPlayer;
local Mouse = Player:GetMouse()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

--get closest zombie
local function gcz()
    local Closest = false
    local target = nil
    local last_dist = 90000
    local player_pos = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame.Position
    for i, v in pairs(Zombies:GetDescendants()) do
        if v.Name == "HP" then
            local tar = v.Parent:FindFirstChild("Head") or v.Parent:FindFirstChild("HumanoidRootPart") 
            if tar == nil then continue end 
            local dist_between = (player_pos - tar.Position).Magnitude
            if dist_between < last_dist then
                target = tar
                last_dist = dist_between
            end
        end
    end
    return target
end

--hook ray
local mt = getrawmetatable(game)
setreadonly(mt, false) 
local namecall = mt.__namecall
mt.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = {...}
    if tostring(method) == "FindPartOnRayWithIgnoreList" and getgenv().ene2 then
        if _G.ztarget ~= nil and type(_G.ztarget) ~= "boolean" then
           local rayy = Ray.new(workspace.CurrentCamera.CFrame.Position,  (_G.ztarget.Position + Vector3.new(0,(workspace.CurrentCamera.CFrame.Position-_G.ztarget.Position).Magnitude/500,0) - workspace.CurrentCamera.CFrame.Position).unit * 5000)  
           if type(rayy) == type(args[2]) then
            args[2] = rayy 
           end
        end
    end 
    return namecall(unpack(args))
end)
setreadonly(mt, true) 


pcall(function()
    RunService:BindToRenderStep("SilentAim",1,function()
        if UserInputService:IsMouseButtonPressed(0) and Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health > 0 then
            _G.ztarget = gcz()
            wait()
        end
    end)
end)


-- silent aim toggle
UserInputService.InputBegan:Connect(function(key, stuffhappening)
    if key.KeyCode == Enum.KeyCode["X"] and not stuffhappening then 
        getgenv().ene2 = not getgenv().ene2
        print(getgenv().ene2)x
    end
end)