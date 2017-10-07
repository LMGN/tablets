
function lmgnTabs(player)
local Character = player.Character
local Torso = Character:WaitForChild"UpperTorso";
local Tablets = {};
local Commands = {};
local handlers = {};
local tips = {"Tip 1: You can right click a tablet to dismiss it without performing it's action.", "Tip 2: These tips have no specified colour (like the commands). They are random each time.", "Tip 3: l!help and l!tips clear the tabs and stop the music."};

local Rotation = 0;
local RotationIncrease = 0.1;
newline = [[

]]
function Output(Text,Colour,Function)
  print(Text)
 	local part = Instance.new("Part",workspace)
    part.Anchored = true
    part.FormFactor = "Custom"
    part.Size = Vector3.new(2.3,2.3,2.3)
    part.Transparency = 0.5
    part.CanCollide = false
	part.Name = player.UserId.."LMGNTablet"
    part.BrickColor = BrickColor.new(Colour)
    part.CFrame = CFrame.new(Torso.CFrame.p)
    part.TopSurface,part.BottomSurface = 0,0
    local bg = Instance.new("BodyGyro", part)
    bg.maxTorque = Vector3.new(1/0,1/0,1/0)
    local sel = Instance.new('SelectionBox',part)
    sel.Adornee = part
    sel.Color = part.BrickColor
    sel.Transparency = 0.7
    local bg = Instance.new("BillboardGui",part)
    bg.Enabled = true
    bg.Adornee = part
    bg.AlwaysOnTop = true
    bg.Size = UDim2.new(1,0,1,0)
    bg.ExtentsOffset = Vector3.new(0,2,0)
    local text = Instance.new("TextLabel",bg)
    text.Text = Text
    text.Size = UDim2.new(1,0,1,0)
    text.BackgroundTransparency = 1
    text.Font = "Code"
    text.FontSize = "Size14"
    text.TextStrokeTransparency = 0.7
    text.TextStrokeColor3 = Color3.new(0,0,0);
    text.TextColor3 = part.BrickColor.Color
    local point = Instance.new("PointLight",part)
    point.Brightness = 1/0
    point.Color = part.BrickColor.Color
    point.Range = 6
    local click = Instance.new("ClickDetector",part)
    click.MaxActivationDistance = 1/0
    coroutine.resume(coroutine.create(function()
        if Text == "Dismiss" then
            local col = 21
            part.BrickColor = BrickColor.new(col)
            text.TextColor3 = part.BrickColor.Color
            sel.Color = part.BrickColor
        elseif Text ==  "Back" then
            local col = 1010
            part.BrickColor = BrickColor.new(col)
            text.TextColor3 = part.BrickColor.Color
            sel.Color = part.BrickColor
        end
		table.insert(handlers,click.RightMouseClick:connect(function(p)
			pcall(function()
                        coroutine.resume(coroutine.create(function()
							Instance.new("Model", part).Name = "StopUpdate"
                            							part.Name = "DebrisTablet"
			wait()
			wait()
			part:Destroy()
                        end))
                    end)
		end))
        table.insert(handlers,click.MouseClick:connect(function(p)
            if p.Name == player.Name  then
                if Function == nil then
                    pcall(function()
                        coroutine.resume(coroutine.create(function()
							Instance.new("Model", part).Name = "StopUpdate"
                            							part.Name = "DebrisTablet"
			wait()
			wait()
			part:Destroy()
                        end))
                    end)
                else
                    pcall(function()
                        coroutine.resume(coroutine.create(function()
                            							part.Name = "DebrisTablet"
			wait()
			wait()
			part:Destroy()
                            local a,b = coroutine.resume(coroutine.create(function()
                                Function();
                            end))
                            if a then
                                return
                            else
                                Output(b,21)
                            end
                        end))
                    end)
                end
            end
        end))
    end))
    pcall(function()
        table.insert(Tablets,part)
    end)
	return part
end
Output("LMGNTablets loading...", "Really black")

function random(x)
	math.randomseed(math.random(tick()))
	return math.random(x)
end

function textureTablet(tablet,id)
	local texture = Instance.new("Decal",tablet)
	texture.Texture = id
	texture.Transparency = 0.5
	local t1 = texture:Clone()
	t1.Parent = tablet
	t1.Face = "Top"
	t1 = texture:Clone()
	t1.Parent = tablet
	t1.Face = "Back"
	t1 = texture:Clone()
	t1.Parent = tablet
	t1.Face = "Bottom"
	t1 = texture:Clone()
	t1.Parent = tablet
	t1.Face = "Left"
	t1 = texture:Clone()
	t1.Parent = tablet
	t1.Face = "Right"
end

function OnChatted(Message)
	local Command = ""
	for i,v in pairs(Commands)do
		if Message:sub(1,v.Cmd:len()):lower() == v.Cmd and Command == "" then
			Command = v.Cmd
			spawn(function()
				local a,b = pcall(function()
					v.Func(Message:sub(v.Cmd:len()+1):lower())
				end)
				if not a then
					error(b)
				end
			end)
		end
	end
end
local function AddCommand(Command,Description,Example,Color,Function)
	table.insert(Commands,{Cmd=Command,Desc=Description,Example=Example,Func=Function,Color=Color});
end

function UpdateTablets()
	Tablets = {}
	for i,v in pairs(game.Workspace:GetChildren())do
		if v.Name == player.UserId.."LMGNTablet" and v.ClassName == "Part" then		
		table.insert(Tablets,v)
		end
	end
	Rotation = Rotation + RotationIncrease
	for i,v in pairs(Tablets)do
		if not v.Parent then table.remove(Tablets,i) return nil end
		local TorsoPosition = CFrame.new(Torso.CFrame.p);
		local CFR = TorsoPosition * CFrame.Angles(0,math.rad((i*(360/#Tablets)+Rotation)),0)
		CFR = CFR * CFrame.new(0,0,5+(#Tablets))
		local LerpedCFR = v.Position
		LerpedCFR = LerpedCFR:Lerp(CFR.p,.1)
		v.CFrame = CFrame.new(LerpedCFR)
	end
end
function RemoveTablets()
	while #Tablets > 0 do
		wait(0)
		for i,v in pairs(Tablets)do
							v.Name = "DebrisTablet"
			wait()
			wait()
			v:Destroy()
		end
	end
end
AddCommand("l!audio ","Plays an audio!","l!audio 339922286","Deep orange",function(Message)
	pcall(function()
		local audioAsset = game:GetService("MarketplaceService"):GetProductInfo(Message)
		if audioAsset.AssetTypeId == 3 then
			brick = Output("Song Playing: "..audioAsset.Name,"Deep orange")
			local Sound = Instance.new("Sound",brick)
			Sound.SoundId = "rbxassetid://"..Message
			Sound.Volume = 1
			wait(0)
			Sound:Play()
			while wait() do
				if Sound.Playing == false then
				else
					break
				end
			end
			
			spawn(function ()
				while wait() do
					if brick.Name == "DebrisTablet" then
						break
					end 
					pcall(function()
					
    				brick.Transparency = 1 - Sound.PlaybackLoudness / 1000
					brick.PointLight.Brightness = Sound.PlaybackLoudness / 100
					brick.PointLight.Range = Sound.PlaybackLoudness / 50
					if Sound.PlaybackLoudness < 100 then
						brick.BillboardGui.TextLabel.Text = ("Song Playing: "..audioAsset.Name.." 🔈"..math.floor(Sound.TimeLength - Sound.TimePosition).." seconds remain ("..math.floor((Sound.TimePosition / Sound.TimeLength) * 100).."%)")
					elseif Sound.PlaybackLoudness < 500 then
						brick.BillboardGui.TextLabel.Text = ("Song Playing: "..audioAsset.Name.." 🔉"..math.floor(Sound.TimeLength - Sound.TimePosition).." seconds remain ("..math.floor((Sound.TimePosition / Sound.TimeLength) * 100).."%)")
					else
						brick.BillboardGui.TextLabel.Text = ("Song Playing: "..audioAsset.Name.." 🔊 "..math.floor(Sound.TimeLength - Sound.TimePosition).." seconds remain ("..math.floor((Sound.TimePosition / Sound.TimeLength) * 100).."%)")
					end
					if Sound.Playing == false then
						brick:Destroy()
					end
					end)
				end
				
			end)
		else
			Output(audioAsset.Name.." is not an audio.", "Really red")
		end
	end)
end)

AddCommand("l!help","Lists the commands and what they do.","l!help","Really blue",function(Message)
	RemoveTablets()
	for i,v in pairs(Commands) do
		Output(v.Cmd..newline.."    "..v.Desc..newline.."    Example: "..v.Example.." (click to test)",v.Color, function()
				OnChatted(v.Example)
			end)
	end
end)
AddCommand("l!tips","Gives you some tips.","l!tips",Color3.new(random(100) / 100,random(100) / 100,random(100) / 100),function(Message)
	RemoveTablets()
	for i,v in pairs(tips) do
		Output(v, Color3.new(random(100) / 100,random(100) / 100,random(100) / 100))
	end
end)

AddCommand("l!clear","Clear the tablets, and stop all music.","l!clear","Really red",function(Message)
	RemoveTablets()
end)

AddCommand("l!rotspeed","Set the rotation speed multiplier (from 25 to -25)","l!rotspeed 10","Cyan",function(Message)
	pcall(function()
		local a = tonumber(Message)
		if a < -25 then
			Output("Please choose a number from 25 to -25. That number is too low.","Really red")
		elseif a > 25 then
			Output("Please choose a number from 25 to -25. That number is too high.","Really red")
		else
			RotationIncrease = a / 10
			Output("Set the rotation speed to "..Message..", Click this to reset.", "Electric blue",function()
				RotationIncrease = 0.1
				Output("Reset the rotation speed to 1.", "Electric blue")
			end)
		end
	end)
end)

AddCommand("l!models","Searches for a freemodel in the library","l!models cat","Bright blue",function(Message)
	pcall(function()
		RemoveTablets()
		local insertService = game:GetService("InsertService")
		local page = unpack(insertService:GetFreeModels(Message,0))
 
		for i = 1,page.TotalCount do
			local item = page.Results[i]
			textureTablet(Output(i..": "..item.Name.." by "..item.CreatorName..newline.."ID: "..item.AssetId,Color3.new(random(100) / 100,random(100) / 100,random(100) / 100)), "https://www.roblox.com/Thumbs/Asset.ashx?width=110&height=110&assetId="..item.AssetId)
		end
	end)
end)

AddCommand("l!decals","Searches for a decal in the library","l!decals dog","Bright blue",function(Message)
	pcall(function()
		RemoveTablets()
		local insertService = game:GetService("InsertService")
		local page = unpack(insertService:GetFreeDecals(Message,0))
 
		for i = 1,page.TotalCount do
			local item = page.Results[i]
			textureTablet(Output(i..": "..item.Name.." by "..item.CreatorName..newline.."ID: "..item.AssetId,Color3.new(random(100) / 100,random(100) / 100,random(100) / 100)), "https://www.roblox.com/Thumbs/Asset.ashx?width=110&height=110&assetId="..item.AssetId)
		end
	end)
end)


AddCommand("l!saudio","Searches for a audio in the library","l!saudio atrius","Bright blue",function(Message)
	pcall(function()
		RemoveTablets()
		local response = game:GetService("HttpService"):JSONDecode(game:GetService("HttpService"):GetAsync("https://www.classy-studios.com/APIs/CatalogSearch.php?Category=9&Query="..game:GetService("HttpService"):UrlEncode(Message)))
 
		for i,v in pairs(response) do
			local item = v
			Output(i..": "..item.Name.." by "..item.Creator..newline.."ID: "..item.AssetId,Color3.new(random(100) / 100,random(100) / 100,random(100) / 100), function()
				RemoveTablets()
				OnChatted("l!audio "..item.AssetId)
			end)
		end
	end)
end)

AddCommand("l!killscript","Attempts to disconnect all handlers and kill all tablets. the LMGNTablets script.","l!killscript","Really red",function(Message)
	RemoveTablets()
	for i,v in pairs(handlers) do
		v:Disconnect()
	end
	local part = Output("All connections and tablets have been destroyed. You will need to reload the script to get commands back."..newline..newline.."Was that an accedent? Click this to reload the script","Bright red", function()
		lmgnTabs(game.Players.LocalPlayer)
	end)
	for i=1,230 do 
		part.Size = Vector3.new(2.3 - ((i) / 100),2.3 - ((i) / 100),2.3 - ((i) / 100))
		wait(0.01)
	 end
	RemoveTablets()
end)

AddCommand("l!createtabs","Create x amount of tablets","l!createtabs 10","Bright yellow",function(Message)
	pcall(function()
		RemoveTablets()
		for i=1,tonumber(Message) do 
		wait()
		local part = Output("Tablet "..i,Color3.new(random(100) / 100,random(100) / 100,random(100) / 100), function()
		RemoveTablets()
		
	end)
	 end
	end)
end)



table.insert(handlers,player.Chatted:connect(OnChatted))


coroutine.resume(coroutine.create(function()
	table.insert(handlers,game:GetService("RunService").RenderStepped:connect(function()
		UpdateTablets()
	end))
end))
	
RemoveTablets()
Output("LMGNTablets Dev loaded", "Lime green")
Output("Click here to see the commands.", "Really blue", function()
	OnChatted("l!help")
end)
Output("Download this script for free: https://github.com/thelmgn/tablets"..newline.."Scripter? Great, you can add commands and fix glitches at that link.","Black")
local randomtip = tips[ math.random( #tips ) ]
Output("Random "..randomtip..". Click for more tips.", Color3.new(random(100) / 100,random(100) / 100,random(100) / 100), function()
	OnChatted("l!tips")
end)
end
wait(1)
lmgnTabs(game.Players.LocalPlayer)
