-- ==================================================
-- YOKUDO HUB | NEW PROJECT | UI
-- THEME: CRIMSON BLOOD
-- FEATURES: FLOATING UI + L KEYBIND
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

-- ==================================================
-- CRIMSON THEME
-- ==================================================

local Theme = {
    Background = Color3.fromRGB(10, 3, 6),
    TopBar = Color3.fromRGB(32, 4, 10),
    Sidebar = Color3.fromRGB(18, 3, 8),

    Text = Color3.fromRGB(255, 235, 240),
    SubText = Color3.fromRGB(190, 105, 120),

    Accent = Color3.fromRGB(220, 15, 45),
    AccentBright = Color3.fromRGB(255, 35, 65),
    AccentDark = Color3.fromRGB(100, 5, 20),

    Border = Color3.fromRGB(170, 10, 35),
    BorderDark = Color3.fromRGB(75, 5, 18),
}

-- ==================================================
-- GUI PARENT
-- ==================================================

local GuiParent = Services.CoreGui

pcall(function()
    if type(gethui) == "function" then
        local HUI = gethui()
        if HUI then
            GuiParent = HUI
        end
    end
end)

-- Clean old instances
pcall(function()
    local Old = GuiParent:FindFirstChild("YOKUDO_HUB")
    if Old then
        Old:Destroy()
    end

    local OldToggle = GuiParent:FindFirstChild("ToggleGUI")
    if OldToggle then
        OldToggle:Destroy()
    end
end)

-- ==================================================
-- TOGGLE
-- ==================================================

local ASSET_ID = Settings.AssetID

pcall(function()
    Services.ContentProvider:PreloadAsync({ASSET_ID})
end)

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
Toggle.BackgroundColor3 = Color3.fromRGB(25, 2, 7)
Toggle.BorderSizePixel = 0
Toggle.BackgroundTransparency = 0
Toggle.Image = ASSET_ID
Toggle.ZIndex = 999
Toggle.Parent = ToggleScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = Toggle

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Theme.Accent
ToggleStroke.Thickness = 2
ToggleStroke.Transparency = 0.05
ToggleStroke.Parent = Toggle

local ToggleGlow = Instance.new("UIStroke")
ToggleGlow.Color = Theme.AccentBright
ToggleGlow.Thickness = 5
ToggleGlow.Transparency = 0.75
ToggleGlow.Parent = Toggle

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

Main.Size = UDim2.new(
    0,
    Settings.UI.Width,
    0,
    Settings.UI.Height
)

Main.Position = UDim2.new(
    0.5,
    -Settings.UI.Width / 2,
    0.5,
    -Settings.UI.Height / 2
)

Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Active = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = Main

local MainBorder = Instance.new("UIStroke")
MainBorder.Color = Theme.Border
MainBorder.Thickness = 2
MainBorder.Transparency = 0.05
MainBorder.Parent = Main

-- ==================================================
-- TOP BAR
-- ==================================================

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 58)
TopBar.BackgroundColor3 = Theme.TopBar
TopBar.BorderSizePixel = 0
TopBar.Active = true
TopBar.ZIndex = 20
TopBar.Parent = Main

local TopGradient = Instance.new("UIGradient")

TopGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 5, 20)),
    ColorSequenceKeypoint.new(0.35, Color3.fromRGB(45, 3, 12)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(25, 2, 8)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 2, 5))
})

TopGradient.Parent = TopBar

local TopLine = Instance.new("Frame")
TopLine.Name = "TopLine"
TopLine.Size = UDim2.new(1, 0, 0, 2)
TopLine.Position = UDim2.new(0, 0, 1, -2)
TopLine.BackgroundColor3 = Theme.AccentBright
TopLine.BackgroundTransparency = 0
TopLine.BorderSizePixel = 0
TopLine.ZIndex = 22
TopLine.Parent = TopBar

-- ==================================================
-- TITLE
-- ==================================================

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

local TitleStroke = Instance.new("UIStroke")
TitleStroke.Color = Theme.Accent
TitleStroke.Thickness = 0.6
TitleStroke.Transparency = 0.55
TitleStroke.Parent = Title

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
Sidebar.BackgroundColor3 = Theme.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 5
Sidebar.Parent = Main

local SidebarGradient = Instance.new("UIGradient")

SidebarGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 3, 11)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(18, 2, 8)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 2, 5))
})

SidebarGradient.Rotation = 90
SidebarGradient.Parent = Sidebar

local SidebarLine = Instance.new("Frame")
SidebarLine.Name = "SidebarLine"
SidebarLine.Size = UDim2.new(0, 2, 1, 0)
SidebarLine.Position = UDim2.new(1, -2, 0, 0)
SidebarLine.BackgroundColor3 = Theme.Accent
SidebarLine.BackgroundTransparency = 0
SidebarLine.BorderSizePixel = 0
SidebarLine.ZIndex = 6
SidebarLine.Parent = Sidebar

-- ==================================================
-- TAB SCROLL
-- ==================================================

local TabScroll = Instance.new("ScrollingFrame")
TabScroll.Name = "TabScroll"
TabScroll.Size = UDim2.new(1, 0, 1, 0)
TabScroll.BackgroundTransparency = 1
TabScroll.BorderSizePixel = 0
TabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
TabScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
TabScroll.ScrollingDirection = Enum.ScrollingDirection.Y
TabScroll.ScrollBarThickness = 2
TabScroll.ScrollBarImageColor3 = Theme.Accent
TabScroll.ScrollBarImageTransparency = 0.35
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

Content.BackgroundColor3 = Theme.Background
Content.BorderSizePixel = 0
Content.ZIndex = 5
Content.Parent = Main

local ContentGradient = Instance.new("UIGradient")

ContentGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 3, 7)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 2, 5)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 1, 3))
})

ContentGradient.Rotation = 45
ContentGradient.Parent = Content

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
_G.YOKUDO_Theme = Theme

-- ==================================================
-- DRAG SYSTEM (MAIN)
-- ==================================================

local Dragging = false
local DragStart = nil
local StartPosition = nil
local ActiveTouch = nil

local BasePosition = Main.Position

local function StartDrag(Input)

    if Dragging then
        return
    end

    if Input.UserInputType == Enum.UserInputType.Touch then
        ActiveTouch = Input
    end

    Dragging = true
    DragStart = Input.Position
    StartPosition = Main.Position

    BasePosition = StartPosition
end

local function StopDrag()

    Dragging = false

    if Main then
        BasePosition = Main.Position
    end

    ActiveTouch = nil
    DragStart = nil
    StartPosition = nil
end

TopBar.InputBegan:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

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

        if Input.UserInputType == Enum.UserInputType.MouseButton1
            or Input.UserInputType == Enum.UserInputType.Touch then

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

    if not Dragging then
        return
    end

    if Input.UserInputType == Enum.UserInputType.Touch then

        if ActiveTouch and Input ~= ActiveTouch then
            return
        end

    end

    if not DragStart or not StartPosition then
        return
    end

    if Input.UserInputType ~= Enum.UserInputType.MouseMovement
        and Input.UserInputType ~= Enum.UserInputType.Touch then

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
-- DRAG SYSTEM (TOGGLE)
-- ==================================================

local ToggleDragging = false
local ToggleDragStart = nil
local ToggleStartPos = nil
local ToggleActiveTouch = nil

local function StartToggleDrag(Input)

    if ToggleDragging then
        return
    end

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

    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        StartToggleDrag(Input)

    end

end)

Services.UserInputService.InputChanged:Connect(function(Input)

    if not ToggleDragging then
        return
    end

    if Input.UserInputType == Enum.UserInputType.Touch then

        if ToggleActiveTouch and Input ~= ToggleActiveTouch then
            return
        end

    end

    if not ToggleDragStart or not ToggleStartPos then
        return
    end

    if Input.UserInputType ~= Enum.UserInputType.MouseMovement
        and Input.UserInputType ~= Enum.UserInputType.Touch then

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
-- SMOOTH FLOATING ANIMATION
-- ==================================================

local FLOAT_HEIGHT = 4
local FLOAT_SPEED = 1.35

task.spawn(function()

    while Main and Main.Parent do

        if not Dragging then

            local Time = os.clock()
            local OffsetY =
                math.sin(Time * FLOAT_SPEED) * FLOAT_HEIGHT

            Main.Position = UDim2.new(
                BasePosition.X.Scale,
                BasePosition.X.Offset,

                BasePosition.Y.Scale,
                BasePosition.Y.Offset + OffsetY
            )

        end

        Services.RunService.RenderStepped:Wait()
    end

end)

-- ==================================================
-- TOGGLE UI SHOW/HIDE
-- ==================================================

local isUIVisible = true

local function ToggleUI()

    isUIVisible = not isUIVisible
    ScreenGui.Enabled = isUIVisible

    Services.TweenService:Create(
        Toggle,
        TweenInfo.new(
            0.12,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            Size = UDim2.new(0, 45, 0, 45)
        }
    ):Play()

    task.wait(0.12)

    Services.TweenService:Create(
        Toggle,
        TweenInfo.new(
            0.18,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            Size = UDim2.new(0, 55, 0, 55)
        }
    ):Play()

end

Toggle.MouseButton1Click:Connect(ToggleUI)

-- ==================================================
-- KEYBIND: L
-- ==================================================

Services.UserInputService.InputBegan:Connect(function(Input, GameProcessed)

    if GameProcessed then
        return
    end

    if Input.KeyCode == Enum.KeyCode.L then
        ToggleUI()
    end

end)

-- ==================================================
-- TOGGLE HOVER ANIMATION
-- ==================================================

local NormalSize = UDim2.new(0, 55, 0, 55)
local HoverSize = UDim2.new(0, 62, 0, 62)

Toggle.MouseEnter:Connect(function()

    Services.TweenService:Create(
        Toggle,
        TweenInfo.new(
            0.2,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out
        ),
        {
            Size = HoverSize
        }
    ):Play()

    Services.TweenService:Create(
        ToggleStroke,
        TweenInfo.new(0.2),
        {
            Thickness = 3,
            Color = Theme.AccentBright
        }
    ):Play()

    Services.TweenService:Create(
        ToggleGlow,
        TweenInfo.new(0.2),
        {
            Thickness = 7,
            Transparency = 0.55
        }
    ):Play()

end)

Toggle.MouseLeave:Connect(function()

    Services.TweenService:Create(
        Toggle,
        TweenInfo.new(
            0.2,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out
        ),
        {
            Size = NormalSize
        }
    ):Play()

    Services.TweenService:Create(
        ToggleStroke,
        TweenInfo.new(0.2),
        {
            Thickness = 2,
            Color = Theme.Accent
        }
    ):Play()

    Services.TweenService:Create(
        ToggleGlow,
        TweenInfo.new(0.2),
        {
            Thickness = 5,
            Transparency = 0.75
        }
    ):Play()

end)

-- ==================================================
-- CRIMSON BORDER PULSE
-- ==================================================

task.spawn(function()

    while Main and Main.Parent do

        local PulseIn = Services.TweenService:Create(
            MainBorder,
            TweenInfo.new(
                1.4,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.InOut
            ),
            {
                Transparency = 0.25
            }
        )

        PulseIn:Play()
        PulseIn.Completed:Wait()

        local PulseOut = Services.TweenService:Create(
            MainBorder,
            TweenInfo.new(
                1.4,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.InOut
            ),
            {
                Transparency = 0.05
            }
        )

        PulseOut:Play()
        PulseOut.Completed:Wait()

    end

end)

-- ==================================================
-- DONE
-- ==================================================

print("✅ YOKUDO UI Loaded | CRIMSON + FLOATING + L KEYBIND")
