    local function DisableAntiCheat()
        for _, v in pairs(getgc(true)) do
            if typeof(v) == "table" then
                if rawget(v, "Detect") then
                    rawset(v, "Detect", function() return false end)
                end
                if rawget(v, "Check") then
                    rawset(v, "Check", function() return false end)
                end
            end
        end
    end
    
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    -- Replace with the username you want to kick
    local blockedUser = "BlacklistPlaceholder"
    
    if LocalPlayer.Name == blockedUser then
        LocalPlayer:Kick("Access denied.")
    end
    
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    
    local Window = Rayfield:CreateWindow({
       Name = "fluxus | by bilsr/leyax | .gg/VTWCBfCGw2 | 2.0.0",
       Icon = 0,
       LoadingTitle = "bilsr hub",
       LoadingSubtitle = "LOADING",
       Theme = "Bloom",
       DisableRayfieldPrompts = false,
       DisableBuildWarnings = false,
       ConfigurationSaving = {
          Enabled = true,
          FolderName = nil,
          FileName = "bilsr hub thingy"
       },
       Discord = {
          Enabled = true,
          Invite = "VTWCBfCGw2",
          RememberJoins = true
       },
       KeySystem = true,
       KeySettings = {
          Title = "vBiLsR hub v2 /fluxus",
          Subtitle = "by bilsr",
          Note = "123",
          FileName = "Key1234436",
          SaveKey = false,
          GrabKeyFromSite = false,
          Key = {"bilsr123"}
       }
    })
    
    local Tab = Window:CreateTab("📜 | PLACEHOLDER", nil)
    
    local debugLabel, debugButton
    
    -- Create the toggle
    Tab:CreateToggle({
        Name = "Enable Debug/Beta/Alpha Testing Shit",
        CurrentValue = false,
        Callback = function(enabled)
            if enabled then
                -- Create debug UI elements if they don't exist yet
                if not debugLabel then
                    debugLabel = Tab:CreateLabel("⚠️ DEBUG MODE ENABLED - Features in development")
                else
                    debugLabel:SetVisible(true)
                end
    
                if not debugButton then
                    debugButton = Tab:CreateButton({
                        Name = "Test Feature (WIP)",
                        Callback = function()
                            print("Debug feature triggered!")
                            Rayfield:Notify({
                                Title = "Debug",
                                Content = "This feature is a work in progress.",
                                Duration = 3
                            })
                        end
                    })
                else
                    debugButton:SetVisible(true)
                end
    
            else
                -- Hide debug UI elements when toggle is off
                if debugLabel then debugLabel:SetVisible(false) end
                if debugButton then debugButton:SetVisible(false) end
            end
        end
    })
    
    Tab:CreateInput({
        Name = "Execute Code",
        PlaceholderText = "Enter Lua code here...",
        RemoveTextAfterFocusLost = false,
        Flag = "MiniTerminal",
        Callback = function(code)
            local success, result = pcall(loadstring(code))
            print("[MiniTerm]", success and result or "Error: "..tostring(result))
        end
    })
    
    Tab:CreateInput({
        Name = "Load Script by URL",
        PlaceholderText = "Paste Pastebin or GitHub URL...",
        RemoveTextAfterFocusLost = true,
        Flag = "DynamicScriptLoader",
        Callback = function(url)
            pcall(function()
                loadstring(game:HttpGet(url))()
            end)
        end
    })
    
    local MusicTab = Window:CreateTab("🎵 | Music Player", nil)
    
    local playingSound = nil
    
    MusicTab:CreateInput({
        Name = "Enter Music ID or URL",
        PlaceholderText = "e.g. 1837635128 or rbxassetid://1837635128",
        RemoveTextAfterFocusLost = false,
        Callback = function(input)
            local soundId = input
            if tonumber(input) then
                soundId = "rbxassetid://" .. input
            end
    
            -- Stop and destroy existing sound
            if playingSound then
                playingSound:Stop()
                playingSound:Destroy()
            end
    
            local sound = Instance.new("Sound")
            sound.SoundId = soundId
            sound.Volume = 1
            sound.Looped = true
            sound.Parent = workspace
            sound:Play()
            playingSound = sound
    
            Rayfield:Notify({
                Title = "Music Playing",
                Content = "Now playing ID: " .. input,
                Duration = 4
            })
        end
    })
    
    local PictureTab = Window:CreateTab("🖼️ | Picture Viewer", nil)
    
    PictureTab:CreateInput({
        Name = "Insert Image ID",
        PlaceholderText = "e.g., 123456789",
        RemoveTextAfterFocusLost = true,
        Callback = function(imgId)
            local imageGui = Instance.new("ScreenGui")
            imageGui.Name = "PictureViewer"
            imageGui.ResetOnSpawn = false
            imageGui.Parent = game:GetService("CoreGui")
    
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(0, 250, 0, 250)
            frame.Position = UDim2.new(0.5, -125, 0.5, -125)
            frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            frame.BorderSizePixel = 0
            frame.Active = true
            frame.Draggable = true
            frame.Parent = imageGui
    
            local imageLabel = Instance.new("ImageLabel")
            imageLabel.Size = UDim2.new(1, 0, 1, 0)
            imageLabel.Position = UDim2.new(0, 0, 0, 0)
            imageLabel.Image = "rbxassetid://" .. imgId
            imageLabel.BackgroundTransparency = 1
            imageLabel.ScaleType = Enum.ScaleType.Fit
            imageLabel.Parent = frame
    
            Rayfield:Notify({
                Title = "Image Loaded!",
                Content = "Draggable image window created.",
                Duration = 3
            })
        end
    })
    
    
    
    
    MusicTab:CreateButton({
        Name = "🛑 Stop Music",
        Callback = function()
            if playingSound then
                playingSound:Stop()
                playingSound:Destroy()
                playingSound = nil
                Rayfield:Notify({
                    Title = "Music Stopped",
                    Content = "The music has been stopped.",
                    Duration = 3
                })
            else
                Rayfield:Notify({
                    Title = "No Music Playing",
                    Content = "You need to play something first.",
                    Duration = 3
                })
            end
        end
    })
    
    
    
    Tab:CreateButton({
        Name = "Rejoin Server",
        Callback = function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
        end
    })
    
    Tab:CreateButton({
        Name = "Server Hop",
        Callback = function()
            local HttpService = game:GetService("HttpService")
            local Servers = game.HttpGet and HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"))
            for _, v in pairs(Servers.data) do
                if v.playing < v.maxPlayers then
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id)
                    break
                end
            end
        end
    })
    
    
    local Tab = Window:CreateTab("🏠 | HOME", nil)
    
    -- System Info Section
    local HttpService = game:GetService("HttpService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    local executorName = identifyexecutor and identifyexecutor() or "Unknown"
    
    -- Safety Meter
    local safetyLevel = "⚠️ Unknown"
    local trustedExecutors = {
        ["Synapse X"] = true,
        ["ScriptWare"] = true,
        ["Fluxus"] = true,
        ["KRNL"] = true,
        ["Solara"] = true,
        ["Ronix"] = true,
        ["Xeno"] = true,
        ["Swift"] = true,
        ["Arceus X"] = false,
        ["Electron"] = false
    }
    
    if trustedExecutors[executorName] == true then
        safetyLevel = "✅ Safe"
    elseif trustedExecutors[executorName] == false then
        safetyLevel = "❌ Unsafe"
    end
    
    -- System Data
    local systemInfo = {
        executor = executorName,
        username = LocalPlayer.Name,
        userId = tostring(LocalPlayer.UserId),
        accountAge = tostring(LocalPlayer.AccountAge) .. " days",
        gameName = "Loading...",
        gameId = tostring(game.PlaceId),
        ip = "Loading...",
        country = "Loading...",
        city = "Loading...", -- Added city field
        safety = safetyLevel
    }
    
    -- Get game name
    local successName, resultName = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    end)
    if successName and resultName then
        systemInfo.gameName = resultName.Name
    end
    
    Tab:CreateSection("Pardon.")
    Tab:CreateLabel("im very sorry guys...", nil, Color3.fromRGB(255, 255, 255), false)
    Tab:CreateLabel("there are now 2 versions of the executor bloom and amethyst", nil, Color3.fromRGB(255, 255, 255), false)
    Tab:CreateLabel("...", nil, Color3.fromRGB(255, 255, 255), false)
    Tab:CreateLabel("there was a error that a lot of scripts suddenly didnt work anymore", nil, Color3.fromRGB(255, 255, 255), false)
    Tab:CreateLabel("so now there are some scripts that are just forever gone, some that are only on amethyst, some that are only on bloom, etc...", nil, Color3.fromRGB(255, 255, 255), false)
    Tab:CreateButton({
       Name = "nil",
       Callback = function()
           loadstring(game:HttpGet("https://raw.githubusercontent.com/Bilsurrr/Fluxus/refs/heads/main/fluxus", true))()
       end,
    })

    Tab:CreateSection("YOUR INFO")
    
    -- Create Labels
    local executorLabel = Tab:CreateLabel("Executor: " .. systemInfo.executor)
    local safetyLabel = Tab:CreateLabel("Executor Status: " .. systemInfo.safety)
    local usernameLabel = Tab:CreateLabel("Username: " .. systemInfo.username .. " (" .. systemInfo.userId .. ")")
    local accountAgeLabel = Tab:CreateLabel("Account Age: " .. systemInfo.accountAge)
    local gameLabel = Tab:CreateLabel("Game: " .. systemInfo.gameName .. " (" .. systemInfo.gameId .. ")")
    local ipLabel = Tab:CreateLabel("IP: " .. systemInfo.ip)
    local countryLabel = Tab:CreateLabel("Region: " .. systemInfo.country)
    local cityLabel = Tab:CreateLabel("City: " .. systemInfo.city) -- city label
    
    -- Fetch IP, Region, City
    task.spawn(function()
        local success, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet("https://ipwho.is/"))
        end)
    
        if success and result and result.success then
            systemInfo.ip = result.ip or "N/A"
            systemInfo.country = result.country or "N/A"
            systemInfo.city = result.city or "N/A"  -- fetch city
    
            ipLabel:Set("IP: " .. systemInfo.ip)
            countryLabel:Set("Region: " .. systemInfo.country)
            cityLabel:Set("City: " .. systemInfo.city) -- update city label
        else
            ipLabel:Set("IP: Failed to load")
            countryLabel:Set("Region: Failed to load")
            cityLabel:Set("City: Failed to load")
        end
    end)
    
    Tab:CreateSection("Copy")
    
    -- Open Website Button
    Tab:CreateButton({
        Name = "Copy TEST",
        Callback = function()
            local url = "Test.V2" -- change this to your link
            setclipboard(url)
            print("Website URL copied to clipboard! Paste it in your browser.")
            Rayfield:Notify({
                Title = "Copied!",
                Content = "Copied the text.",
                Duration = 3,
            })
        end,
    })
    
    Tab:CreateSection("MAIN")
    
    Tab:CreateButton({
       Name = "CLOSE FLUXUS HUB COMPLETELY",
       Callback = function()
          Rayfield:Destroy()
       end,
    })
    
    Tab:CreateSection("INFO")
    Tab:CreateLabel("made by @bilsr on discord, for bugs or suggestions, feel free to add, i accept every Friend request i get", nil, Color3.fromRGB(255, 255, 255), false)
    Tab:CreateLabel("if some of the scripts dont work i cant do anything, i didnt make most of them", nil, Color3.fromRGB(255, 255, 255), false)
    Tab:CreateLabel("tested by @leyax_taxbills123 on discord", nil, Color3.fromRGB(255, 255, 255), false)
    Tab:CreateLabel("Executors you should be using: XENO, RONIX, SOLARA", nil, Color3.fromRGB(255, 255, 255), false)
    Tab:CreateLabel("working on whiteliste stuff notifications and shit", nil, Color3.fromRGB(255, 255, 255), false)
    Tab:CreateLabel("code for alpha version is bilsrwashere2", nil, Color3.fromRGB(255, 255, 255), false)
    Tab:CreateLabel("Arrayfield (beta rayfield V3 DROPPED)", nil, Color3.fromRGB(255, 255, 255), false)
    Tab:CreateLabel("discord earliest beta-alpha_.gBuild below", nil, Color3.fromRGB(255, 255, 255), false)
    Tab:CreateLabel("bloom or amethyst?", nil, Color3.fromRGB(255, 255, 255), false)
    
    Tab:CreateButton({
       Name = "discord prototype",
       Callback = function()
           loadstring(game:HttpGet("https://raw.githubusercontent.com/Bilsurrr/bilsr-hub-rayfield/refs/heads/main/raas"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "arrayfield",
       Callback = function()
           loadstring(game:HttpGet("https://raw.githubusercontent.com/Bilsurrr/bilsr-hub-rayfield/refs/heads/main/arrayfield"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "CHECK YOUR EXECUTOR (UNC CHECK)",
       Callback = function()
           loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/UNC%20Checker.txt"))()
       end,
    })
    
    Tab:CreateLabel("HUGE NEWSSSS.... , WE MADE THE NEW FLUENT PORT", nil, Color3.fromRGB(255, 255, 255), false)
    
    Tab:CreateButton({
       Name = "NEW FLUENT PORT (buggy and incompleted as hell)",
       Callback = function()
           loadstring(game:HttpGet("https://raw.githubusercontent.com/Bilsurrr/bilsr-hub-rayfield/refs/heads/main/fluent%20(%20not%20complete)", true))()
       end,
    })
    
    Tab:CreateButton({
       Name = "NEW LUNA PORT (buggy as healllllllll also inompleted )",
       Callback = function()
           loadstring(game:HttpGet("https://raw.githubusercontent.com/Bilsurrr/bilsr-hub-rayfield/refs/heads/main/asdsdgasdf", true))()
       end,
    })
    
    Tab:CreateSection("LATEST CHANGE")
    Tab:CreateLabel("Added the fluent port", nil, Color3.fromRGB(255, 255, 255), false)
    
    Tab:CreateSection("COMMING SOON")
    Tab:CreateLabel("More fluent port updates, also require executor and gearer and more", nil, Color3.fromRGB(255, 255, 255), false)
    Tab:CreateLabel("luna sirius,  more ports", nil, Color3.fromRGB(255, 255, 255), false)
    
    
    -- GAMES TAB --
    local Tab = Window:CreateTab("🎮 | GAMES", nil)
    Tab:CreateSection("MAIN")
    
    -- Fun and Sussy stuff back
    Tab:CreateButton({
       Name = "FUNKY FRIDAY AUTOPLAY",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/Nadir3709/ScriptHub/main/Loader"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "BABFT",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/wisl884/wisl-i-Universal-Project1/refs/heads/main/Build%20A%20Boat%20For%20Treasure", true))()
       end,
    })
    
    Tab:CreateButton({
       Name = "Blox Fruits Script",
       Callback = function()
          loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Blox%20Fruits%20Hub.txt"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "MM2 Script",
       Callback = function()
          loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Murder%20Myster%202%20Hub.txt"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "Fisch Hub",
       Callback = function()
          loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Fisch%20Hub%20-%20Annie%20Hub.txt"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "Da Hood - Sylex",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/bbbbbbbbbbbbbb121/Roblox/refs/heads/main/Sylex", true))()
       end,
    })
    
    Tab:CreateButton({
       Name = "Ink Game (Luarmor)",
       Callback = function()
          loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/284c7c5eb4a430a82162018c617e9aa0.lua"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "Ink Game (Alt)",
       Callback = function()
          loadstring(game:HttpGet('https://raw.githubusercontent.com/DarkClpher/RBX-Scripts/refs/heads/main/Ink%20Game/Main.luau'))()
       end,
    })
    
    
    Tab:CreateButton({
       Name = "BROOKHAVEN",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/kigredns/testUIDK/refs/heads/main/panel.lua"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "DEAD RAILS",
       Callback = function()
          loadstring(game:HttpGet('https://raw.githubusercontent.com/m00ndiety/Keyless-auto-bonds/refs/heads/main/obfuscated%20(6).txt'))()
       end,
    })
    
    Tab:CreateButton({
       Name = "SPELLING BEE - AUTO",
       Callback = function()
    local MarketplaceService = game:GetService("MarketplaceService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Remotes = ReplicatedStorage:WaitForChild("Remotes")
    local SubmitAnswer = Remotes:WaitForChild("SubmitAnswer")
    
    game.DescendantAdded:Connect(function(obj)
      if obj:IsA("Sound") then
         task.defer(function()
            for attempt = 1, 10 do
               local soundId = obj.SoundId
               local assetId = soundId:match("%d+")
    
               if assetId then
                  local success, info = pcall(function()
                     return MarketplaceService:GetProductInfo(tonumber(assetId))
                  end)
    
                  if success and info and info.Name then
                     local name = info.Name
                     name = name:match("^(.-)%s*%(%d+%)$") or name
    
                     local args1 = { "Type", name }
                     SubmitAnswer:FireServer(unpack(args1))
    
                     task.wait(0.1)
    
                     local args2 = { "Submit", name }
                     SubmitAnswer:FireServer(unpack(args2))
                  end
                  break
               end
            end
         end)
      end
    end)   
          end,
    })
    
    Tab:CreateButton({
       Name = "EVADE",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/wisl884/wisl-i-Universal-Project1/refs/heads/main/Evade", true ))()
       end,
    })
    
    Tab:CreateButton({
       Name = "TSB",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/wisl884/wisl-i-Universal-Project1/refs/heads/main/TSB", true ))()
       end,
    })
    
    Tab:CreateButton({
       Name = "GROW A GARDEN",
       Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Garden/Garden-V1.lua", true))()
          end,
    })
    
    Tab:CreateButton({
       Name = "GROW A GARDEN - 2",
       Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Kenniel123/Grow-a-garden/refs/heads/main/Grow%20A%20Garden"))()
          end,
    })
    
    Tab:CreateButton({
       Name = "STEAL A BRAINROT",
       Callback = function()
    loadstring(game:HttpGet("https://pastefy.app/Zk7UIkDN/raw"))()
       end,
    })
    
    -- HUBS TAB --
    local Tab = Window:CreateTab("📜 | HUBS", nil)
    Tab:CreateSection("MAIN")
    
    Tab:CreateButton({
       Name = "WISL",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/wisl884/wisl-i-Universal-Project1/main/Wisl'i%20Universal%20Project.lua", true))()
       end,
    })
    
    Tab:CreateButton({
       Name = "WISL OLD",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/Bilsurrr/bilsr-hub-rayfield/refs/heads/main/skiubiditoi%20wertlsdfsdgsd", true))()
       end,
    })
    
    Tab:CreateButton({
       Name = "Sigma-Spy",
       Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/depthso/Sigma-Spy/refs/heads/main/Main.lua"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "GHOSTHUB (will log ur ip and stuff)",
       Callback = function()
          loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub'))()
       end,
    })
    
    Tab:CreateButton({
       Name = "Sirius Hub",
       Callback = function()
          loadstring(game:HttpGet('https://sirius.menu/script'))()
       end,
    })
    
    Tab:CreateButton({
       Name = "XVC Hub",
       Callback = function()
          loadstring(game:HttpGet("https://pastebin.com/raw/Piw5bqGq"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "Owl Hub (Aimbot)",
       Callback = function()
          loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/OwlHub.txt"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "N3xxGUI",
       Callback = function()
          loadstring(game:HttpGet("https://github.com/Vint4ge-swag/N3xxThis/raw/refs/heads/main/AnyGameScript", true))()
       end,
    })
    
    
    Tab:CreateButton({
       Name = "SKIBIDI HUB",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/aemos2/Skibidihub/refs/heads/main/SkibidiHUB.txt"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "CRYPTON X",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/thesigmacorex/Crypton/main/Free"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "bilsr executor",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/Bilsurrr/bilsr-hub-rayfield/refs/heads/main/skiubiditoi%20wertlsdfsdgsd"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "SystemBroken",
       Callback = function()
          loadstring(game:HttpGet('https://raw.githubusercontent.com/H20CalibreYT/SystemBroken/main/script'))()
       end,
    })
    
    Tab:CreateButton({
       Name = "ORCA TING",
       Callback = function()
          loadstring(
            game:HttpGetAsync("https://raw.githubusercontent.com/richie0866/orca/master/public/snapshot.lua"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "COOLGUI",
       Callback = function()
          loadstring(game:GetObjects("rbxassetid://9827584846")[1].Source)()
       end,
    })
    
    Tab:CreateButton({
       Name = "MoonUI",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/IlikeyocutgHAH/MoonUI-v13-102-SCRIPTS/main/MoonUI%20v13!"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "Shadow Hub",
       Callback = function()
          loadstring(game:HttpGet(('https://pastebin.com/raw/tuDMk1pr'),true))()
       end,
    })
    
    Tab:CreateButton({
       Name = "BYPASSER",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/AnnaRoblox/AnnaBypasser/refs/heads/main/AnnaBypasser.lua",true))()
       end,
    })
    
    Tab:CreateButton({
       Name = "KaterHub",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/KATERGaming/Roblox/main/KaterHub.Lua"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "DA HUB (KEY)",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/dazaims/DA_Hub/main/DA_Hub", true))()
       end,
    })
    
    Tab:CreateButton({
       Name = "HOLF HUB",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/Podroka626/Scripts/main/Universal"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "better c00lgui (wip)",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/Bilsurrr/bilsr-hub-rayfield/refs/heads/main/coogui!!.lua", true))()
       end,
    })
    
    Tab:CreateButton({
       Name = "STALKIE - code is pizza",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/0riginalWarrior/Stalkie/refs/heads/main/roblox.lua"))()
       end,
    })
    
    -- ETC TAB --
    local Tab = Window:CreateTab("➕ | ETC", nil)
    Tab:CreateSection("MAIN")
    
    Tab:CreateButton({
       Name = "PIANO AUTOPLAY",
       Callback = function()
          pcall(function()
             loadstring(game:HttpGet("https://raw.githubusercontent.com/hellohellohell012321/TALENTLESS/main/TALENTLESS", true))()
          end) 
       end,
    })
    
    Tab:CreateButton({
       Name = "PIANO AUTOPLAY 2.0",
       Callback = function()
          pcall(function()
             loadstring(game:HttpGet("https://raw.githubusercontent.com/JxcExploit/Sad/main/NoKey"))()
          end)
       end,
    })

    Tab:CreateButton({
       Name = "SimpleSpy",
       Callback = function()
          pcall(function()
             loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/refs/heads/main/SimpleSpySource.lua"))()
          end)
       end,
    })

    Tab:CreateButton({
       Name = "TP TOOL",
       Callback = function()
          pcall(function()
             local Tele = Instance.new("Tool", game.Players.LocalPlayer.Backpack)
             Tele.RequiresHandle = false
             Tele.RobloxLocked = true
             Tele.Name = "TPTool"
             Tele.ToolTip = "Teleport Tool"
             Tele.Equipped:Connect(function(Mouse)
                Mouse.Button1Down:Connect(function()
                   if Mouse.Target then
                      game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name).HumanoidRootPart.CFrame = (CFrame.new(Mouse.Hit.x, Mouse.Hit.y + 5, Mouse.Hit.z))
                   end
                end)
             end)
          end) 
       end,
    })
    
    Tab:CreateButton({
       Name = "ANTI VC BAN",
       Callback = function()
          pcall(function()
             game:GetService("VoiceChatService"):joinVoice()
          end) 
       end,
    })
    
    
    Tab:CreateToggle({
        Name = "Anti-AFK",
        CurrentValue = false,
        Flag = "AntiAFK",
        Callback = function(value)
            if value then
                local vu = game:GetService("VirtualUser")
                game:GetService("Players").LocalPlayer.Idled:Connect(function()
                    vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                    task.wait(1)
                    vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                end)
            end
        end
    })
    
    
    local Button = Tab:CreateButton({
       Name = "TP (CTRL + CLICK TO USE)",
       Callback = function()
       pcall(function()
    loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Click%20Teleport.txt"))()
    end) 
        end,
    })
    
    Tab:CreateButton({
       Name = "dex explorer lul",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
       end,
    })
    
    local Button = Tab:CreateButton({
       Name = "AIMBOT (WILL CRASH ROBLOX DONT USE, WORKING ON IT)",
       Callback = function()
       pcall(function()
    loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/WRD%20Aimbot.txt"))()
    end)
       end,
    })
    
    Rayfield:Notify({
       Title = "was bilsr here??",
       Content = "i guess he was ",
       Duration = 6.5,
       Image = nil,
    })
    local Tab = Window:CreateTab("😏 | SUSSY STUFF", nil) -- Title, Image
    local Section = Tab:CreateSection("MAIN")
    local Button = Tab:CreateButton({
       Name = "JERK OFF R15",
       Callback = function()
    loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "BTOOLS",
       Callback = function()
          pcall(function()
             loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/BTools.txt"))()
          end) 
       end,
    })
    
    Tab:CreateButton({
       Name = "Octo Spy",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Octo-Spy/refs/heads/main/Main.lua"))()
       end,
    })
    
    
    Tab:CreateButton({
       Name = "INFINITE YIELD",
       Callback = function()
          pcall(function()
             loadstring(game:HttpGet("https://rawscripts.net/raw/Infinite-Yield_500"))()
          end) 
       end,
    })
    
    Tab:CreateButton({
       Name = "TP (CTRL + CLICK TO USE)",
       Callback = function()
          pcall(function()
             loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Click%20Teleport.txt"))()
          end) 
       end,
    })
    
    Tab:CreateButton({
       Name = "DEX EXPLORER",
       Callback = function()
          pcall(function()
             loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
          end) 
       end,
    })
    
    Tab:CreateButton({
       Name = "server crasher (only works if game has hd admin)",
       Callback = function()
          pcall(function()
             local ReplicatedStorage = game:GetService("ReplicatedStorage")
             local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
             RequestCommand:InvokeServer(";m loading server recker")
          end)
       end,
    })
    
    Tab:CreateButton({
       Name = "Airhub (AIMBOT)",
       Callback = function()
          pcall(function()
             loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/AirHub/refs/heads/main/AirHub.lua"))()
          end)
       end,
    })
    
    local Tab = Window:CreateTab("🥳 | FUN", nil)
    Tab:CreateSection("MAIN")
    
    
    local teleportName = ""
    
    Tab:CreateInput({
        Name = "Enter Player Name to TP",
        PlaceholderText = "Type player name here...",
        RemoveTextAfterFocusLost = false,
        Callback = function(text)
            teleportName = text
        end,
    })
    
    Tab:CreateButton({
        Name = "Teleport to Player",
        Callback = function()
            local plr = game.Players.LocalPlayer
            local target = game.Players:FindFirstChild(teleportName)
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    plr.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                end)
            else
                Rayfield:Notify({
                    Title = "Error",
                    Content = "Player not found or no character!",
                    Duration = 3,
                })
            end
        end,
    })
    
    local WalkSpeed = 16
    local InfiniteJump = false
    
    Tab:CreateSlider({
       Name = "WalkSpeed",
       Range = {16, 250},
       Increment = 1,
       Suffix = "speed",
       CurrentValue = WalkSpeed,
       Flag = "WalkSpeed",
       Callback = function(val)
           WalkSpeed = val
           pcall(function()
               game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeed
           end)
       end
    })
    
    Tab:CreateToggle({
       Name = "Infinite Jump",
       CurrentValue = false,
       Flag = "InfiniteJump",
       Callback = function(value)
           InfiniteJump = value
       end
    })
    
    Tab:CreateButton({
       Name = "JERK OFF R15",
       Callback = function()
           loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
       end,
    })
    
    game:GetService("UserInputService").JumpRequest:Connect(function()
       if InfiniteJump then
           pcall(function()
               local plr = game.Players.LocalPlayer
               if plr.Character then
                   plr.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
               end
           end)
       end
    end)
    
    -- SUSS
    
    
    local Tab = Window:CreateTab("🤘| require & backdoors", nil) -- Title, Image
    local Button = Tab:CreateButton({
       Name = "lalol backdoor",
       Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Its-LALOL/LALOL-Hub/main/Backdoor-Scanner/script"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "Yet Another Backdoor",
       Callback = function()
          loadstring(game:HttpGet("https://pastefy.app/iPp0a0Nx/raw"))()
       end,
    })
    
    
    Tab:CreateButton({
       Name = "Project Backdoored",
       Callback = function()
          loadstring(game:HttpGet('https://raw.githubusercontent.com/gojohdkaisenkt/gojohdkaisenkt-update/refs/heads/main/Project%20backdoored'))()
       end,
    })
    
    Tab:CreateButton({
       Name = "SOME BACKDOOR IDK",
       Callback = function()
          loadstring(game:HttpGet('https://raw.githubusercontent.com/gojohdkaisenkt/Gojokaisenkt-hub/refs/heads/main/1x4%20by%20gojohdkaisenkt%20new'))()
       end,
    })
    
    Tab:CreateButton({
       Name = "Backdoor Legacy",
       Callback = function()
          loadstring(game:HttpGet('https://raw.githubusercontent.com/IvanTheProtogen/BackdoorLegacy/main/main.lua'))()
       end,
    })
    
    
    local settingsTab = Window:CreateTab("⚙️ | Settings", nil)
    
    -- Manual Save Config button (optional, since Rayfield auto-saves too)
    settingsTab:CreateButton({
        Name = "Save Config",
        Callback = function()
            Rayfield:SaveConfiguration()
            Rayfield:Notify({
                Title = "Config",
                Content = "Configuration saved successfully!",
                Duration = 3
            })
        end
    })
    
    -- Manual Load Config button (optional)
    settingsTab:CreateButton({
        Name = "Load Config",
        Callback = function()
            Rayfield:LoadConfiguration()
            -- After loading config, update theme color manually from saved color
            local savedColor = Rayfield:GetFlag("ThemeColorPickerFlag")
            if savedColor then
                Window:ChangeThemeColor(savedColor)
            end
    
            Rayfield:Notify({
                Title = "Config",
                Content = "Configuration loaded successfully!",
                Duration = 3
            })
        end
    })
    
    
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
