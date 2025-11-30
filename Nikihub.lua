-- Nikihub | made by niki
local savedCFrame, returnCFrame, spam, flying = nil, nil, false, false
local plr = game.Players.LocalPlayer

-- GUI setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "Nikihub"
local frame = Instance.new("Frame", gui)
frame.Size, frame.Position, frame.BackgroundColor3, frame.Draggable, frame.Active =
    UDim2.new(0, 250, 0, 420), UDim2.new(0, 30, 0, 100), Color3.fromRGB(25, 25, 25), true, true
Instance.new("UIListLayout", frame).Padding = UDim.new(0, 2)

-- Wrapping GUI elements
local function Wrap(elem)
    local c = Instance.new("Frame")
    c.Size = UDim2.new(1, 0, 0, elem.Size.Y.Offset)
    c.BackgroundTransparency = 1
    elem.Position = UDim2.new(0, 5, 0, 0)
    elem.Size = UDim2.new(1, -10, 1, 0)
    elem.Parent = c
    return c
end

-- Title label
local function Title(txt)
    local l = Instance.new("TextLabel")
    l.Text, l.TextSize, l.Font, l.TextXAlignment, l.BackgroundTransparency, l.TextColor3 =
        txt, 13, Enum.Font.GothamBold, Enum.TextXAlignment.Left, 1, Color3.new(1, 1, 1)
    l.Size = UDim2.new(1, 0, 0, 20)
    Wrap(l).Parent = frame
end

-- Buttons
local function Btn(txt, cb)
    local b = Instance.new("TextButton")
    b.Text, b.TextSize, b.Font, b.TextColor3 =
        txt, 12, Enum.Font.Gotham, Color3.new(1, 1, 1)
    b.BackgroundColor3, b.BorderSizePixel, b.AutoButtonColor =
        Color3.fromRGB(40, 40, 40), 0, true
    b.Size = UDim2.new(1, 0, 0, 28)
    b.MouseButton1Click:Connect(cb)
    Wrap(b).Parent = frame
end

-- === Teleport ===
Title("Teleport")
Btn("📍 Save Position", function()
    local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if h then savedCFrame = h.CFrame end
end)

Btn("🚀 Teleport to Saved", function()
    local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if h and savedCFrame then h.CFrame = savedCFrame end
end)

Btn("🏠 Enter Base", function()
    local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if h then h.CFrame = h.CFrame * CFrame.new(0, 0, -3) end
end)

-- === Combat ===
Title("Combat")
Btn("🛡️ Anti-Hit", function()
    local h = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
    if h then h.Name = "NoHit" end
end)

Btn("✈️ Fly", function()
    local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if not h then return end
    flying = not flying
    if flying then
        local f = Instance.new("BodyVelocity", h)
        f.Name = "FlyForce"
        f.Velocity, f.MaxForce = Vector3.new(0, 50, 0), Vector3.new(0, math.huge, 0)
    else
        local f = h:FindFirstChild("FlyForce")
        if f then f:Destroy() end
    end
end)

-- === Spam ===
Title("Spam")
Btn("📡 Spam Teleport", function()
    if not savedCFrame then return end
    spam = true
    local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if h then returnCFrame = h.CFrame end

    task.spawn(function()
        while spam do
            local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
            if h then
                h.CFrame = savedCFrame
                task.wait(0.025)
                h.CFrame = returnCFrame
            end
            task.wait(0.025)
        end
    end)
end)

Btn("🔁 Spam x100", function()
    if not savedCFrame then return end
    local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if h then returnCFrame = h.CFrame end
    task.spawn(function()
        for i = 1, 100 do
            local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
            if h then
                h.CFrame = savedCFrame
                task.wait(0.025)
                h.CFrame = returnCFrame
            end
            task.wait(0.025)
        end
    end)
end)

Btn("❌ Stop Spam", function()
    spam = false
    local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if h and returnCFrame then h.CFrame = returnCFrame end
end)

-- === Utility ===
Title("Utility")
Btn("🕒 Anti-AFK", function()
    local vu = game:GetService("VirtualUser")
    plr.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
end)

-- === Footer Credit ===
local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1, 0, 0, 20)
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.new(1, 1, 1)
credit.Text = "Made by niki"
credit.Font = Enum.Font.Gotham
credit.TextSize = 12
credit.TextXAlignment = Enum.TextXAlignment.Center
