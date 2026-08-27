local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Ghost Hub",
    Icon = "ghost",
    Author = "by .TiM",
    Folder = "MyGhostHub",
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    ToggleKey = Enum.KeyCode.LeftShift,
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    User = {
        Enabled = false,
        Anonymous = false,
        Callback = function()
        end,
    },
})

local Tab = Window:Tab({
    Title = "Lobby",
    Icon = "",
    Locked = false,
})

local Section = Tab:Section({
    Title = "Auto Join & Farm Controls",
    TextXAlignment = "Left",
    TextSize = 16,
})

getgenv().AutoJoinGame = false

local GuiService = game:GetService("GuiService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TARGET_PLACE_ID = 70411440483149

local function selectAndPressEnter(btn)
    if btn and btn:IsA("GuiObject") and btn.Visible and btn.AbsoluteSize.X > 0 then
        GuiService.SelectedObject = btn
        task.wait(0.2)
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
    end
end

Tab:Toggle({
    Title = "Auto Join Room / Farm",
    Description = "",
    Default = false,
    Callback = function(Value)
        getgenv().AutoJoinGame = Value
        if Value then
            WindUI:Notify({
                Title = "Ghost Hub",
                Content = "",
                Duration = 2
            })
        else
            WindUI:Notify({
                Title = "Ghost Hub",
                Content = "",
                Duration = 2
            })
            GuiService.SelectedObject = nil
        end
    end
})

task.spawn(function()
    while true do
        if getgenv().AutoJoinGame then
            pcall(function()
                if game.PlaceId ~= TARGET_PLACE_ID then
                    return 
                end

                local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                if not playerGui then return end

                local lobbyPlayBtn = playerGui:FindFirstChild("LobbyUI") 
                    and playerGui.LobbyUI:FindFirstChild("PlayButton")
                
                local makePartyMain = playerGui:FindFirstChild("MakeParty") 
                    and playerGui.MakeParty:FindFirstChild("Main")
                local partyPlayBtn = makePartyMain and makePartyMain:FindFirstChild("PlayButton")

                if partyPlayBtn and partyPlayBtn.Visible and partyPlayBtn.AbsoluteSize.X > 0 then
                    selectAndPressEnter(partyPlayBtn)
                    task.wait(3)
                    
                elseif lobbyPlayBtn and lobbyPlayBtn.Visible and lobbyPlayBtn.AbsoluteSize.X > 0 then
                    selectAndPressEnter(lobbyPlayBtn)
                    task.wait(2)
                end
            end)
        end
        task.wait(1)
    end
end)
