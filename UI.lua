-- ==================================================
-- YOKUDO HUB | NEW PROJECT | UI
-- ==================================================

local Services = {
    Players = game:GetService("Players"),
    TweenService = game:GetService("TweenService"),
    UserInputService = game:GetService("UserInputService"),
    RunService = game:GetService("RunService"),
    CoreGui = game:GetService("CoreGui"),
    ContentProvider = game:GetService("ContentProvider"),
}

local Settings = _G.YOKUDO
local Theme = Settings.UI.Theme

-- ==================================================
-- GUI PARENT (gethui if available)
-- ==================================================
local GuiParent = Services.CoreGui

pcall(function()
    if type(gethui) == "function" then
        local HUI = gethui()
        if HUI then GuiParent = HUI end
    end
end)

-- Clean old instances
pcall(function()
    local Old = GuiParent:FindFirstChild("YOKUDO_HUB")
    if Old then Old:Destroy() end

    local OldToggle = GuiParent:FindFirstChild("ToggleGUI")
    if OldToggle then OldToggle:Destroy() end
end)

-- ==================================================
-- TOGGLE (Y icon)
-- ==================================================
local ASSET_ID = Settings.AssetID
Services.ContentProvider:PreloadAsync({ASSET_ID})

local ToggleScreenGui = Instance.new("ScreenGui")
ToggleScreenGui.Name = "ToggleGUI"
ToggleScreenGui.ResetOnSpawn = false
ToggleScreenGui.IgnoreGuiInset = true
ToggleScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ToggleScreenGui.Parent = GuiParent

local Toggle = Instance.new("ImageButton")
Toggle.Name = "Y"
Toggle.Size = UDim2.new(0, 55, 0, 55)
Toggle.Position = UDim2.new(0.02, 0, 0.5, -27.5)
Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Toggle.BorderSizePixel = 0
Toggle.BackgroundTransparency = 0
Toggle.Image = ASSET_ID
Toggle.ZIndex = 999
Toggle.Parent = ToggleScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = Toggle

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(170, 80, 255)
ToggleStroke.Thickness = 1.5
ToggleStroke.Transparency = 0.2
ToggleStroke.Parent = Toggle

-- ==================================================
-- MAIN UI
-- ==================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YOKUDO_HUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = GuiParent

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, Settings.UI.Width, 0, Settings.UI.Height)
Main.Position = UDim2.new(
    0.5,
    -Settings.UI.Width / 2,
    0.5,
    -Settings.UI.Height / 2
)

-- Main itself is transparent so the image can show
Main.BackgroundTransparency = 1
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Active = true
Main.ZIndex = 1
Main.Parent = ScreenGui
-- ==================================================
-- BACKGROUND IMAGE
-- ==================================================

local Background = Instance.new("ImageLabel")
Background.Name = "BackgroundImage"
Background.Size = UDim2.new(1, 0, 1, 0)
Background.Position = UDim2.new(0, 0, 0, 0)

Background.BackgroundTransparency = 1
Background.BorderSizePixel = 0

-- Put it behind every other UI element
Background.ZIndex = 1

-- Your image
local BackgroundAsset = "127094648833500"

-- Normal Roblox asset
Background.Image = "rbxassetid://" .. BackgroundAsset

Background.ImageTransparency = 0
Background.ScaleType = Enum.ScaleType.Crop

Background.Parent = Main

-- ==================================================
-- IMAGE LOAD CHECK
-- ==================================================

task.spawn(function()

    local success = pcall(function()
        Services.ContentProvider:PreloadAsync({
            Background
        })
    end)

    if success and Background.IsLoaded then
        print("✅ YOKUDO Background Loaded")
    else
        warn("⚠️ YOKUDO Background failed to load")

        -- Thumbnail fallback
        Background.Image =
            "rbxthumb://type=Asset&id="
            .. BackgroundAsset
            .. "&w=1000&h=1000"

        task.wait(1)

        if Background.IsLoaded then
            print("✅ YOKUDO Background Loaded using thumbnail")
        else
            warn("❌ Background asset cannot be loaded")
        end
    end

end)

-- ==================================================
-- MAIN BORDER
-- ==================================================
local MainBorder = Instance.new("UIStroke")
MainBorder.Color = Color3.fromRGB(170, 80, 255)
MainBorder.Thickness = 2
MainBorder.Transparency = 0.1
MainBorder.Parent = Main

-- ==================================================
-- TOP BAR
-- ==================================================
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 58)
TopBar.BackgroundColor3 = Theme.TopBar
TopBar.BackgroundTransparency = 0.20
TopBar.BorderSizePixel = 0
TopBar.Active = true
TopBar.ZIndex = 20
TopBar.Parent = Main

local TopGradient = Instance.new("UIGradient")
TopGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(
        0,
        Color3.fromRGB(65, 30, 95)
    ),
    ColorSequenceKeypoint.new(
        1,
        Color3.fromRGB(25, 15, 35)
    )
})
TopGradient.Parent = TopBar

local TopLine = Instance.new("Frame")
TopLine.Name = "TopLine"
TopLine.Size = UDim2.new(1, 0, 0, 2)
TopLine.Position = UDim2.new(0, 0, 1, -2)
TopLine.BackgroundColor3 = Color3.fromRGB(170, 80, 255)
TopLine.BackgroundTransparency = 0.2
TopLine.BorderSizePixel = 0
TopLine.ZIndex = 22
TopLine.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -36, 0, 27)
Title.Position = UDim2.new(0, 18, 0, 7)
Title.BackgroundTransparency = 1
Title.Text = Settings.Name
Title.TextColor3 = Theme.Text
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.ZIndex = 21
Title.Parent = TopBar

local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.new(1, -36, 0, 18)
Subtitle.Position = UDim2.new(0, 18, 0, 32)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = Settings.Version
Subtitle.TextColor3 = Theme.SubText
Subtitle.TextSize = 10
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.ZIndex = 21
Subtitle.Parent = TopBar

-- ==================================================
-- SIDEBAR
-- ==================================================
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(
    0,
    Settings.UI.SidebarWidth,
    1,
    -58
)
Sidebar.Position = UDim2.new(0, 0, 0, 58)

-- Purple-tinted transparent sidebar
Sidebar.BackgroundColor3 = Theme.Sidebar
Sidebar.BackgroundTransparency = 0.65

Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 5
Sidebar.Parent = Main

local SidebarLine = Instance.new("Frame")
SidebarLine.Name = "SidebarLine"
SidebarLine.Size = UDim2.new(0, 2, 1, 0)
SidebarLine.Position = UDim2.new(1, -2, 0, 0)
SidebarLine.BackgroundColor3 = Color3.fromRGB(170, 80, 255)
SidebarLine.BackgroundTransparency = 0.15
SidebarLine.BorderSizePixel = 0
SidebarLine.ZIndex = 6
SidebarLine.Parent = Sidebar

local TabScroll = Instance.new("ScrollingFrame")
TabScroll.Name = "TabScroll"
TabScroll.Size = UDim2.new(1, 0, 1, 0)
TabScroll.BackgroundTransparency = 1
TabScroll.BorderSizePixel = 0
TabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
TabScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
TabScroll.ScrollingDirection = Enum.ScrollingDirection.Y
TabScroll.ScrollBarThickness = 0
TabScroll.ScrollBarImageTransparency = 1
TabScroll.Active = true
TabScroll.ZIndex = 6
TabScroll.Parent = Sidebar

local TabPadding = Instance.new("UIPadding")
TabPadding.PaddingTop = UDim.new(0, 6)
TabPadding.PaddingBottom = UDim.new(0, 6)
TabPadding.PaddingLeft = UDim.new(0, 2)
TabPadding.PaddingRight = UDim.new(0, 2)
TabPadding.Parent = TabScroll

local TabList = Instance.new("UIListLayout")
TabList.Padding = UDim.new(0, 2)
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Parent = TabScroll

-- ==================================================
-- CONTENT
-- ==================================================
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(
    1,
    -Settings.UI.SidebarWidth,
    1,
    -58
)
Content.Position = UDim2.new(
    0,
    Settings.UI.SidebarWidth,
    0,
    58
)

-- Transparent purple-tinted content
Content.BackgroundColor3 = Theme.Background
Content.BackgroundTransparency = 0.65

Content.BorderSizePixel = 0
Content.ZIndex = 5
Content.Parent = Main

-- ==================================================
-- NEON GLITCH FX
-- ==================================================

local NeonFolder = Instance.new("Folder")
NeonFolder.Name = "NeonEffects"
NeonFolder.Parent = Main

-- Animated neon border
local GlowBorder = Instance.new("UIStroke")
GlowBorder.Name = "NeonBorder"
GlowBorder.Thickness = 3
GlowBorder.Transparency = 0.05
GlowBorder.Color = Color3.fromRGB(170, 70, 255)
GlowBorder.Parent = Main

-- Second softer glow
local GlowBorder2 = Instance.new("UIStroke")
GlowBorder2.Name = "NeonGlow"
GlowBorder2.Thickness = 7
GlowBorder2.Transparency = 0.75
GlowBorder2.Color = Color3.fromRGB(80, 180, 255)
GlowBorder2.Parent = Main

-- Neon scanline
local ScanLine = Instance.new("Frame")
ScanLine.Name = "ScanLine"
ScanLine.Size = UDim2.new(1, 0, 0, 2)
ScanLine.Position = UDim2.new(0, 0, 0, 58)
ScanLine.BackgroundColor3 = Color3.fromRGB(210, 100, 255)
ScanLine.BackgroundTransparency = 0.15
ScanLine.BorderSizePixel = 0
ScanLine.ZIndex = 30
ScanLine.Parent = Main

-- Glitch bars
local GlitchBars = {}

for i = 1, 4 do
    local Bar = Instance.new("Frame")
    Bar.Name = "GlitchBar" .. i
    Bar.BackgroundColor3 = Color3.fromRGB(150, 60 + i * 20, 255)
    Bar.BackgroundTransparency = 0.35
    Bar.BorderSizePixel = 0
    Bar.Size = UDim2.new(0, math.random(20, 120), 0, math.random(1, 3))
    Bar.Position = UDim2.new(math.random(), 0, math.random(), 0)
    Bar.ZIndex = 25
    Bar.Visible = false
    Bar.Parent = Main
    table.insert(GlitchBars, Bar)
end

-- Moving background
task.spawn(function()
    local t = 0

    while Main.Parent do
        t += 0.012

        Background.Position = UDim2.new(
            0,
            math.sin(t) * 8,
            0,
            math.cos(t * 0.8) * 6
        )

        Background.Size = UDim2.new(
            1,
            16,
            1,
            12
        )

        task.wait()
    end
end)

-- Shifting neon gradient
task.spawn(function()
    local t = 0

    while Main.Parent do
        t += 0.02

        local r = math.floor(150 + math.sin(t) * 60)
        local g = math.floor(55 + math.sin(t + 2) * 35)
        local b = math.floor(235 + math.sin(t + 4) * 20)

        local NeonColor = Color3.fromRGB(
            math.clamp(r, 0, 255),
            math.clamp(g, 0, 255),
            math.clamp(b, 0, 255)
        )

        GlowBorder.Color = NeonColor
        TopLine.BackgroundColor3 = NeonColor
        SidebarLine.BackgroundColor3 = NeonColor

        task.wait(0.03)
    end
end)

-- Pulsing glow
task.spawn(function()
    while Main.Parent do
        local pulse = (math.sin(os.clock() * 3) + 1) / 2

        GlowBorder.Transparency = 0.02 + pulse * 0.22
        GlowBorder2.Transparency = 0.60 + pulse * 0.25
        TopLine.BackgroundTransparency = 0.08 + pulse * 0.35

        task.wait(0.03)
    end
end)

-- Moving scanline
task.spawn(function()
    while Main.Parent do
        ScanLine.Position = UDim2.new(0, 0, 0, 58)

        local tween = Services.TweenService:Create(
            ScanLine,
            TweenInfo.new(1.8, Enum.EasingStyle.Linear),
            {Position = UDim2.new(0, 0, 1, -2)}
        )

        tween:Play()
        tween.Completed:Wait()
        task.wait(0.1)
    end
end)

-- Random glitch flashes
task.spawn(function()
    while Main.Parent do
        task.wait(math.random(15, 35) / 10)

        for _, Bar in ipairs(GlitchBars) do
            Bar.Visible = false
        end

        local amount = math.random(1, #GlitchBars)

        for i = 1, amount do
            local Bar = GlitchBars[i]

            Bar.Size = UDim2.new(
                0,
                math.random(25, math.max(30, Settings.UI.Width * 0.55)),
                0,
                math.random(1, 3)
            )

            Bar.Position = UDim2.new(
                0,
                math.random(0, math.max(1, Settings.UI.Width - 50)),
                0,
                math.random(58, math.max(59, Settings.UI.Height - 10))
            )

            Bar.Visible = true
        end

        task.wait(math.random(3, 10) / 100)

        for _, Bar in ipairs(GlitchBars) do
            Bar.Visible = false
        end
    end
end)

-- Neon title flicker
task.spawn(function()
    while Main.Parent do
        local pulse = (math.sin(os.clock() * 4) + 1) / 2

        Title.TextTransparency = pulse * 0.12
        Subtitle.TextTransparency = pulse * 0.18

        task.wait(0.04)
    end
end)

-- Glowing toggle button
local ToggleGlow = Instance.new("UIStroke")
ToggleGlow.Name = "NeonGlow"
ToggleGlow.Thickness = 3
ToggleGlow.Transparency = 0.35
ToggleGlow.Color = Color3.fromRGB(170, 70, 255)
ToggleGlow.Parent = Toggle

task.spawn(function()
    while Toggle.Parent do
        local pulse = (math.sin(os.clock() * 4) + 1) / 2

        ToggleGlow.Transparency = 0.15 + pulse * 0.45
        ToggleGlow.Color = Color3.fromRGB(
            150 + math.floor(pulse * 70),
            60 + math.floor(pulse * 40),
            255
        )

        task.wait(0.04)
    end
end)

-- ==================================================
-- KEYBIND: L TOGGLE
-- ==================================================

local NeonToggleKey = Enum.KeyCode.L

Services.UserInputService.InputBegan:Connect(function(Input, GameProcessed)
    if GameProcessed then return end

    if Input.KeyCode == NeonToggleKey then
        isUIVisible = not isUIVisible
        ScreenGui.Enabled = isUIVisible
    end
end)

-- ==================================================
-- EXPORT
-- ==================================================
_G.YOKUDO_Main = Main
_G.YOKUDO_TopBar = TopBar
_G.YOKUDO_Sidebar = Sidebar
_G.YOKUDO_TabScroll = TabScroll
_G.YOKUDO_Content = Content
_G.YOKUDO_ScreenGui = ScreenGui
_G.YOKUDO_Toggle = Toggle
_G.YOKUDO_GuiParent = GuiParent

-- ==================================================
-- DRAG SYSTEM (Main)
-- ==================================================
local Dragging = false
local DragStart = nil
local StartPosition = nil
local ActiveTouch = nil

local function StartDrag(Input)
    if Dragging then return end

    if Input.UserInputType == Enum.UserInputType.Touch then
        ActiveTouch = Input
    end

    Dragging = true
    DragStart = Input.Position
    StartPosition = Main.Position
end

local function StopDrag()
    Dragging = false
    ActiveTouch = nil
    DragStart = nil
    StartPosition = nil
end

TopBar.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or
       Input.UserInputType == Enum.UserInputType.Touch then

        StartDrag(Input)
    end
end)

local function CreateDragZone(Name, Position, Size)
    local Zone = Instance.new("Frame")

    Zone.Name = Name
    Zone.Position = Position
    Zone.Size = Size
    Zone.BackgroundTransparency = 1
    Zone.BorderSizePixel = 0
    Zone.Active = true
    Zone.ZIndex = 50
    Zone.Parent = Main

    Zone.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or
           Input.UserInputType == Enum.UserInputType.Touch then

            StartDrag(Input)
        end
    end)

    return Zone
end

CreateDragZone(
    "DragTop",
    UDim2.new(0, 0, 0, 0),
    UDim2.new(1, 0, 0, 5)
)

CreateDragZone(
    "DragBottom",
    UDim2.new(0, 0, 1, -5),
    UDim2.new(1, 0, 0, 5)
)

CreateDragZone(
    "DragLeft",
    UDim2.new(0, 0, 0, 0),
    UDim2.new(0, 5, 1, 0)
)

CreateDragZone(
    "DragRight",
    UDim2.new(1, -5, 0, 0),
    UDim2.new(0, 5, 1, 0)
)

Services.UserInputService.InputChanged:Connect(function(Input)
    if not Dragging then return end

    if Input.UserInputType == Enum.UserInputType.Touch then
        if ActiveTouch and Input ~= ActiveTouch then
            return
        end
    end

    if not DragStart or not StartPosition then
        return
    end

    if Input.UserInputType ~= Enum.UserInputType.MouseMovement and
       Input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local Delta = Input.Position - DragStart

    Main.Position = UDim2.new(
        StartPosition.X.Scale,
        StartPosition.X.Offset + Delta.X,
        StartPosition.Y.Scale,
        StartPosition.Y.Offset + Delta.Y
    )
end)

Services.UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Touch then

        if ActiveTouch and Input == ActiveTouch then
            StopDrag()
        end

        return
    end

    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
        if Dragging then
            StopDrag()
        end
    end
end)

-- ==================================================
-- DRAG SYSTEM (Toggle)
-- ==================================================
local ToggleDragging = false
local ToggleDragStart = nil
local ToggleStartPos = nil
local ToggleActiveTouch = nil

local function StartToggleDrag(Input)
    if ToggleDragging then return end

    if Input.UserInputType == Enum.UserInputType.Touch then
        ToggleActiveTouch = Input
    end

    ToggleDragging = true
    ToggleDragStart = Input.Position
    ToggleStartPos = Toggle.Position
end

local function StopToggleDrag()
    ToggleDragging = false
    ToggleActiveTouch = nil
    ToggleDragStart = nil
    ToggleStartPos = nil
end

Toggle.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or
       Input.UserInputType == Enum.UserInputType.Touch then

        StartToggleDrag(Input)
    end
end)

Services.UserInputService.InputChanged:Connect(function(Input)
    if not ToggleDragging then return end

    if Input.UserInputType == Enum.UserInputType.Touch then
        if ToggleActiveTouch and Input ~= ToggleActiveTouch then
            return
        end
    end

    if not ToggleDragStart or not ToggleStartPos then
        return
    end

    if Input.UserInputType ~= Enum.UserInputType.MouseMovement and
       Input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local Delta = Input.Position - ToggleDragStart

    Toggle.Position = UDim2.new(
        ToggleStartPos.X.Scale,
        ToggleStartPos.X.Offset + Delta.X,
        ToggleStartPos.Y.Scale,
        ToggleStartPos.Y.Offset + Delta.Y
    )
end)

Services.UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Touch then

        if ToggleActiveTouch and Input == ToggleActiveTouch then
            StopToggleDrag()
        end

        return
    end

    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
        if ToggleDragging then
            StopToggleDrag()
        end
    end
end)

-- ==================================================
-- TOGGLE UI SHOW/HIDE
-- ==================================================
local isUIVisible = true

Toggle.MouseButton1Click:Connect(function()
    isUIVisible = not isUIVisible

    ScreenGui.Enabled = isUIVisible

    Services.TweenService:Create(
        Toggle,
        TweenInfo.new(
            0.1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        ),
        {
            Size = UDim2.new(0, 45, 0, 45)
        }
    ):Play()

    task.wait(0.1)

    Services.TweenService:Create(
        Toggle,
        TweenInfo.new(
            0.1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        ),
        {
            Size = UDim2.new(0, 55, 0, 55)
        }
    ):Play()
end)

print("✅ UI Loaded")
