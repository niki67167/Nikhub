local plr = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local savedCFrame, returnCFrame, spam, flying = nil, nil, false, false

-- INTRO עם טקסט Outline
local intro = Instance.new("ScreenGui", game:GetService("CoreGui"))
intro.Name = "NikiHubIntro"

local label = Instance.new("TextLabel", intro)
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 1
label.Text = "NikiHub"
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Font = Enum.Font.GothamBlack
label.TextScaled = true
label.TextStrokeTransparency = 0
label.TextStrokeColor3 = Color3.new(0, 0, 0)
label.TextTransparency = 1

TweenService:Create(label, TweenInfo.new(0.8), {TextTransparency = 0}):Play()
task.wait(2.2)
TweenService:Create(label, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
task.wait(0.6)
intro:Destroy()

-- GUI ROOT
local screen = Instance.new("ScreenGui", game:GetService("CoreGui"))
screen.Name = "NikihubHUD"

-- Toggle button (Image)
local toggleBtn = Instance.new("ImageButton", screen)
toggleBtn.Size = UDim2.new(0, 140, 0, 40)
toggleBtn.Position = UDim2.new(0, 20, 0, 80)
toggleBtn.BackgroundTransparency = 1
toggleBtn.Image = "rbxassetid://15697920794"

-- Main HUD
local win = Instance.new("Frame", screen)
win.Size = UDim2.new(0, 260, 0, 440)
win.Position = UDim2.new(0, 0, 0, 140)
win.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
win.BackgroundTransparency = 1
win.BorderSizePixel = 0
win.Active = true
win.Draggable = true
win.Visible = false

-- Title
local title = Instance.new("TextLabel", win)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🌟 NikiHub"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

-- Scroll content
local scroll = Instance.new("ScrollingFrame", win)
scroll.Size = UDim2.new(1, 0, 1, -60)
scroll.Position = UDim2.new(0, 0, 0, 30)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 4)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
end)

-- Helpers
local function addHeader(txt)
	local l = Instance.new("TextLabel", scroll)
	l.Size = UDim2.new(1, -10, 0, 24)
	l.Text = txt
	l.Font = Enum.Font.GothamBold
	l.TextSize = 14
	l.TextColor3 = Color3.new(1,1,1)
	l.BackgroundTransparency = 1
	l.TextXAlignment = Enum.TextXAlignment.Left
end

local function addButton(txt, func)
	local b = Instance.new("TextButton", scroll)
	b.Size = UDim2.new(1, -14, 0, 30)
	b.Text = txt
	b.Font = Enum.Font.Gotham
	b.TextSize = 13
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	b.BorderSizePixel = 0
	b.AutoButtonColor = true
	b.MouseButton1Click:Connect(func)
	return b
end

-- Open/Close logic
local function openGUI()
	win.Visible = true
	TweenService:Create(win, TweenInfo.new(0.3), {BackgroundTransparency = 0.25}):Play()
end

local function closeGUI()
	local t = TweenService:Create(win, TweenInfo.new(0.3), {BackgroundTransparency = 1})
	t:Play()
	t.Completed:Wait()
	win.Visible = false
end

local guiOpen = false
toggleBtn.MouseButton1Click:Connect(function()
	guiOpen = not guiOpen
	if guiOpen then openGUI() else closeGUI() end
end)

-- Auto open after intro
task.wait(0.1)
guiOpen = true
openGUI()

-- Sections
addHeader("Teleport")
addButton("📍 Save Position", function()
	local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if hrp then savedCFrame = hrp.CFrame end
end)
addButton("🚀 Teleport to Saved", function()
	local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if hrp and savedCFrame then hrp.CFrame = savedCFrame end
end)
addButton("🏠 Enter Base", function()
	if not savedCFrame then return end
	local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		local original = hrp.CFrame
		hrp.CFrame = savedCFrame
		task.delay(2, function()
			if hrp then hrp.CFrame = original end
		end)
	end
end)

addButton("📍 Save Position", function()
	local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if hrp then savedCFrame = hrp.CFrame end
end)
addButton("🚀 Teleport to Saved", function()
	local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if hrp and savedCFrame then hrp.CFrame = savedCFrame end
end)

	end
end)

-- Combat
addHeader("Combat")
addButton("🛡️ Anti‑Hit", function()
	local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
	if hum then hum.Name = "NoHit" end
end)
addButton("✈️ Fly", function()
	local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	flying = not flying
	if flying then
		local v = Instance.new("BodyVelocity", hrp)
		v.Name = "FlyForce"
		v.Velocity, v.MaxForce = Vector3.new(0,50,0), Vector3.new(0,math.huge,0)
	else
		local v = hrp:FindFirstChild("FlyForce")
		if v then v:Destroy() end
	end
end)
local invisible = false
addButton("👻 Invisible (Toggle)", function()
	invisible = not invisible
	local char = plr.Character
	if not char then return end
	for _, part in pairs(char:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Transparency = invisible and 1 or 0
			part.CanCollide = not invisible
		elseif part:IsA("Decal") then
			part.Transparency = invisible and 1 or 0
		end
	end
end)

local noclipActive = false
addButton("🚪 Noclip (Toggle)", function()
	noclipActive = not noclipActive
	if noclipActive then
		game:GetService("RunService").Stepped:Connect(function()
			if noclipActive and plr.Character then
				for _, part in pairs(plr.Character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end
		end)
	end
end)

-- Footer
local footer = Instance.new("TextLabel", win)
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 1, -20)
footer.BackgroundTransparency = 1
footer.Text = "Made by niki"
footer.Font = Enum.Font.Gotham
footer.TextSize = 12
footer.TextColor3 = Color3.fromRGB(180, 180, 180)
footer.TextXAlignment = Enum.TextXAlignment.Center

-- SPAM
addHeader("Spam")
addButton("📡 Spam Teleport", function()
	if not savedCFrame then return end
	spam = true
	local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if hrp then returnCFrame = hrp.CFrame end
	task.spawn(function()
		while spam do
			local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
			if h then h.CFrame = savedCFrame task.wait(0.025) h.CFrame = returnCFrame end
			task.wait(0.025)
		end
	end)
end)
addButton("🔁 Spam x100", function()
	if not savedCFrame then return end
	local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if hrp then returnCFrame = hrp.CFrame end
	task.spawn(function()
		for i=1,100 do
			local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
			if h then
				h.CFrame = savedCFrame task.wait(0.025) h.CFrame = returnCFrame
			end
			task.wait(0.025)
		end
	end)
end)
addButton("❌ Stop Spam", function() spam = false end)

-- UTILITY
addHeader("Utility")
addButton("🕒 Anti‑AFK", function()
	local vu = game:GetService("VirtualUser")
	plr.Idled:Connect(function()
		vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
		task.wait(1)
		vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
	end)
end)

-- FOOTER
local footer = Instance.new("TextLabel", win)
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 1, -20)
footer.BackgroundTransparency = 1
footer.Text = "Made by niki"
footer.Font = Enum.Font.Gotham
footer.TextSize = 12
footer.TextColor3 = Color3.fromRGB(180, 180, 180)
footer.TextXAlignment = Enum.TextXAlignment.Center

-- SPEED BOOSTS
addHeader("Speed")
addButton("🏃 Speed Boost (Normal)", function()
	local char = plr.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then hum.WalkSpeed = 24 end
end)
addButton("💨 Speed Boost (Exclusive)", function()
	local char = plr.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then hum.WalkSpeed = 80 end
end)

-- DESYNC
addHeader("Desync")
addButton("🌀 Add new desync (no cloner)", function()
	local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	local fakePos = hrp.Position

	local attachment = Instance.new("Attachment", hrp)
	attachment.Position = Vector3.new(0, -1000, 0) -- move you visually away

	task.spawn(function()
		while hrp and hrp.Parent and attachment do
			hrp.Velocity = Vector3.zero
			hrp.CFrame = CFrame.new(fakePos)
			task.wait(0.1)
		end
	end)
end)
