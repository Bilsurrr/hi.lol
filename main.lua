

loadstring(game:HttpGet('https://raw.githubusercontent.com/jalilwas/Sirius-Plugins/refs/heads/main/Rayfield%20Logo%20Remover'))()
    
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
       Name = "fluxus | by bilsr/bitsproxy | .gg/VTWCBfCGw2 | 2.0.3",
       Icon = 0,
       LoadingTitle = "fluxus hub",
       LoadingSubtitle = "LOADING",
       Theme = "Amethyst",
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
          Title = "vBiLsR",
          Subtitle = "by bilsr",
          Note = "123",
          FileName = "Key1234436",
          SaveKey = false,
          GrabKeyFromSite = false,
          Key = {"bilsr123"}
       }
    })
    
    local Tab = Window:CreateTab("🎨 | THENE", nil)
        
    Tab:CreateButton({
    Name = "Default Theme",
    Callback = ChangeTheme("Default")
})

Tab:CreateButton({
    Name = "Amber Glow Theme",
    Callback = ChangeTheme("AmberGlow")
})

Tab:CreateButton({
    Name = "Amethyst (Purple) Theme",
    Callback = ChangeTheme("Amethyst")
})

Tab:CreateButton({
    Name = "Bloom Theme",
    Callback = ChangeTheme("Bloom")
})

Tab:CreateButton({
    Name = "Dark Blue Theme",
    Callback = ChangeTheme("DarkBlue")
})

Tab:CreateButton({
    Name = "Green Theme",
    Callback = ChangeTheme("Green")
})

Tab:CreateButton({
    Name = "Light Theme",
    Callback = ChangeTheme("Light")
})

Tab:CreateButton({
    Name = "Ocean Theme",
    Callback = ChangeTheme("Ocean")
})

Tab:CreateButton({
    Name = "Serenity Theme",
    Callback = ChangeTheme("Serenity")
})  

    local Tab = Window:CreateTab("👑 | NEW COOL STUFF", nil)

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
    
    local MusicTab = Window:CreateTab("🎵 | MUSIC PLAYER", nil)
    
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
       Name = "old version of fluxus (will be updated) (bloom)",
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
    Tab:CreateLabel("Sorry guys, a lot of stuff randomly dissapeared, im sorry i will fix it soon", nil, Color3.fromRGB(255, 255, 255), false)
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
    Tab:CreateLabel("when the wisl luna drops i will add it ofc", nil, Color3.fromRGB(255, 255, 255), false)
    
    
    
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
       Name = "ADOPT ME",
       Callback = function()
          loadstring(game:HttpGet('https://gitfront.io/r/ReQiuYTPL/wFUydaK74uGx/hub/raw/ReQiuYTPLHub.lua'))()
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
       Name = "PRISON LIFE",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/Bilsurrr/Fluxus/refs/heads/main/Prison_Life", true))()
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
       Name = "Bluescreen",
       Callback = function()
          loadstring(game:HttpGet("https://bluescreen.3rr0r.pro/Scripts/Universal"))()
       end,
    })


    Tab:CreateButton({
       Name = "BOLTS HUB V5",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/Bilsurrr/Fluxus/refs/heads/main/bolts%20hub%20v5", true))()
      end,
    })

    Tab:CreateButton({
       Name = "some random hubb idrk",
       Callback = function()
          loadloadstring(game:HttpGet("https://pastefy.app/yfhuik5s/raw"))()
      end,
    })

    Tab:CreateButton({
       Name = "UTG U5 (only works in r6 games)",
       Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/Bilsurrr/Fluxus/refs/heads/main/bolts%20hub%20v5", true))()
      end,
    })
    
    Tab:CreateButton({
       Name = "EZ HUB",
       Callback = function()
          loadstring(game:HttpGet(('https://raw.githubusercontent.com/debug420/Ez-Industries-Launcher-Data/master/Launcher.lua'),true))()
      end,
    })
    
    Tab:CreateButton({
       Name = "Aaryn's Hub V2",
       Callback = function()
          loadstring(game:HttpGet("https://pastebin.com/raw/jE85VHx8", true))()
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
       Name = "cloudhub",
       Callback = function()
    loadstring(game:HttpGet("https://pastefy.app/X6fuVyEZ/raw"))()
       end,
    })

    Tab:CreateButton({
       Name = "vape v4",
       Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
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
       Name = "YARHM (MM2)",
       Callback = function()
          loadstring(game:HttpGet("https://yarhm.mhi.im/scr"))()
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
    
    local Button = Tab:CreateButton({
       Name = "Random Shit ",
       Callback = function()
    loadstring(game:HttpGet("https://pastefy.app/gqxbdtBQ/raw?part=RandomShit_SilentNova"))()
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
       Name = "some fake hacker gui",
       Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/affan761/Blue8x9x10x11-f3x/refs/heads/main/Blue8x9x10x11%20f3x"))()
       end,
    })
    
    Tab:CreateButton({
       Name = "preppyhub",
       Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/PreppyHub/PreppyHub/refs/heads/main/PreppyHub"))()
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
    
    Rayfield:Notify({
       Title = "was bilsr here??",
       Content = "i guess he was ",
       Duration = 6.5,
       Image = nil,
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
             loadstring(game:HttpGet("https://raw.githubusercontent.com/TechHog8984/Dex-Explorer-V3/refs/heads/main/dex.lua"))()
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
    
    Tab:CreateButton({
       Name = "Skinwalker Attack (fe)",
       Callback = function()
          local msg2 = Instance.new("Hint",workspace)
    msg2.Text = "bilsr was here"
    imageOne = "http://www.roblox.com/asset/?id=15431487032" imageTwo = "http://www.roblox.com/asset/?id=15431487032" imageThree = "http://www.roblox.com/asset/?15431487032" imageFour = "http://www.roblox.com/asset/?id=15431487032" imageFive = "http://www.roblox.com/asset/?id=15431487032" imageSix = "http://www.roblox.com/asset/?id=15431487032" imageSeven = "http://www.roblox.com/asset/?id=15431487032" imageEight = "http://www.roblox.com/asset/?id=15431487032" Spooky = Instance.new("Sound", game.Workspace) Spooky.Name = "Spooky" Spooky.SoundId = "rbxassetid://27808972" Spooky.Volume = 1500 Spooky.Looped = true Spooky:Play() Sky = Instance.new("Sky", game.Lighting) Sky.SkyboxBk = imageOne Sky.SkyboxDn = imageOne Sky.SkyboxFt = imageOne Sky.SkyboxLf = imageOne Sky.SkyboxRt = imageOne Sky.SkyboxUp = imageOne while true do     Sky.SkyboxBk = imageOne     Sky.SkyboxDn = imageOne     Sky.SkyboxFt = imageOne     Sky.SkyboxLf = imageOne     Sky.SkyboxRt = imageOne     Sky.SkyboxUp = imageOne     wait(0.25)     Sky.SkyboxBk = imageTwo     Sky.SkyboxDn = imageTwo     Sky.SkyboxFt = imageTwo     Sky.SkyboxLf = imageTwo     Sky.SkyboxRt = imageTwo     Sky.SkyboxUp = imageTwo     wait(0.25)     Sky.SkyboxBk = imageThree     Sky.SkyboxDn = imageThree     Sky.SkyboxFt = imageThree     Sky.SkyboxLf = imageThree     Sky.SkyboxRt = imageThree     Sky.SkyboxUp = imageThree     wait(0.25)     Sky.SkyboxBk = imageFour     Sky.SkyboxDn = imageFour     Sky.SkyboxFt = imageFour     Sky.SkyboxLf = imageFour     Sky.SkyboxRt = imageFour     Sky.SkyboxUp = imageFour     wait(0.25)     Sky.SkyboxBk = imageFive     Sky.SkyboxDn = imageFive     Sky.SkyboxFt = imageFive     Sky.SkyboxLf = imageFive     Sky.SkyboxRt = imageFive     Sky.SkyboxUp = imageFive     wait(0.25)     Sky.SkyboxBk = imageSix     Sky.SkyboxDn = imageSix     Sky.SkyboxFt = imageSix     Sky.SkyboxLf = imageSix     Sky.SkyboxRt = imageSix     Sky.SkyboxUp = imageSix     wait(0.25)     Sky.SkyboxBk = imageSeven     Sky.SkyboxDn = imageSeven     Sky.SkyboxFt = imageSeven     Sky.SkyboxLf = imageSeven     Sky.SkyboxRt = imageSeven     Sky.SkyboxUp = imageSeven     wait(0.25)     Sky.SkyboxBk = imageEight     Sky.SkyboxDn = imageEight     Sky.SkyboxFt = imageEight     Sky.SkyboxLf = imageEight     Sky.SkyboxRt = imageEight     Sky.SkyboxUp = imageEight     wait(0.25) end 
    
    -- NON-FE SCRIPT: Replaces all Decals and Textures with your decal
    local decalId = "rbxassetid://15431487032"
    
    -- Function to replace decals and textures
    local function replaceTextures(instance)
        if instance:IsA("Decal") or instance:IsA("Texture") then
            instance.Texture = decalId
        end
    end
    
    -- Replace all current ones
    for _, v in ipairs(workspace:GetDescendants()) do
        replaceTextures(v)
    end
    
    -- Detect future added decals/textures
    workspace.DescendantAdded:Connect(function(obj)
        replaceTextures(obj)
    end)
    
    -- Optional: Replace in Lighting too (e.g., skyboxes, maybe SurfaceGuis)
    for _, v in ipairs(game:GetService("Lighting"):GetDescendants()) do
        replaceTextures(v)
    end
    
    print("✅ All textures and decals replaced with decal ID: " .. decalId)
    
       end,
    })
    
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
    
    



