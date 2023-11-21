local UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))()
_G.af = false
local MainUI = UILibrary.Load("-")
local FirstPage = MainUI.AddPage("Home")

local FirstLabel = FirstPage.AddLabel("Section 1")
local function afcheck()
    if _G.af == false then
        return true
    end
end

local function tycoonFinder()
    local a = game:GetService("Workspace").PlayerTycoons:GetDescendants()
    for i, v in pairs(a) do
        if v.Name == 'Owner' then
            if v.Value == game.Players.LocalPlayer then
                local tycoonName = v.Parent.Parent.Name
                return(tostring(tycoonName))
            end
        end
    end
end

local tycoon = tycoonFinder()
local tycoonBuy = game:GetService("Workspace").PlayerTycoons[tycoon].BuyButton
local tycoonButtons = game:GetService("Workspace").PlayerTycoons[tycoon].Buttons
local rebirthPath = game:GetService("Workspace").PlayerTycoons[tycoon].Essentials.RebirthStation.Button
local collectPath = game:GetService("Workspace").PlayerTycoons[tycoon].Essentials.Giver.CollectButton
local deployPath = game:GetService("Workspace").PlayerTycoons[tycoon].Unlocks 

local function tp(cords)
    local tween =  game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.75), {CFrame = CFrame.new(cords)})
    tween:Play()
    tween.Completed:Wait()
end


local function collect()
    tp(collectPath.Position)
    firetouchinterest(collectPath, game.Players.LocalPlayer.Character.HumanoidRootPart, 1)
    firetouchinterest(collectPath, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
end

local function rebirth()
    tp(rebirthPath.Position)
    fireproximityprompt(rebirthPath.RebirthPrompt)
end

local function workers()
    for c5 = 1, 10, 1 do
        local w = 'Worker' .. tostring(c5)
        local bw = 'BunkerWorker' .. tostring(c5)
        tycoonBuy:InvokeServer(w)
        wait(0.05)
    end
    for c = 1, 3, 1 do
        for c2 = 1, 2, 1 do
            local baw = 'Barracks' .. tostring(c) .. 'Worker' .. tostring(c2)
            tycoonBuy:InvokeServer(baw)
            wait(0.05)
        end
    end
    for c6 = 1, 6, 1 do
        local buw = 'BunkerWorker' .. tostring(c6)
        tycoonBuy:InvokeServer(buw)
        wait(0.05)
    end
end

local function buyButtons()
    for i, v in pairs(tycoonButtons:GetChildren()) do
        pcall(function()
            tycoonBuy:InvokeServer(tostring(v.Name))
            wait(0.05)
        end)
    end
end
local function deploySoldiers()
    if deployPath:FindFirstChild('Soldier1') or deployPath:FindFirstChild('Soldier2') or deployPath:FindFirstChild('Soldier3') then
        game:GetService("ReplicatedStorage").Events.Guards.Deploy:FireServer(deployPath.Soldier1)
        game:GetService("ReplicatedStorage").Events.Guards.Deploy:FireServer(deployPath.Soldier2)
        game:GetService("ReplicatedStorage").Events.Guards.Deploy:FireServer(deployPath.Soldier3)
    end
end
--[[
local function round()
    collect()
    workers()
    wait(5)
    collect()
    buyButtons()
    wait(5)
    rebirth()
    wait(1)
end]]

local FirstToggle = FirstPage.AddToggle("Auto-farm", false, function(Value)
    _G.af = not _G.af
    while _G.af == true do
        if afcheck() then break end
        collect()
        workers()
        workers()
        if afcheck() then break end
        wait(5)
        collect()
        buyButtons()
        buyButtons()
       -- deploySoldiers()
        if afcheck() then break end
        wait(15)
        if afcheck() then break end
        rebirth()
        wait(1)
        wait()
    end
end)


local FirstButton = FirstPage.AddButton("workers", function()
    workers()
end)