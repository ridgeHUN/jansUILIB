local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'
local aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/ridgeHUN/clanware/main/aimlock.lua"))()

local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local espLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Sirius/request/library/esp/esp.lua'),true))()

espLib.whitelist = {} -- insert string that is the player's name you want to whitelist (turns esp color to whitelistColor in options)
espLib.blacklist = {} -- insert string that is the player's name you want to blacklist (removes player from esp)
espLib.options = {
    enabled = false,
    scaleFactorX = 4,
    scaleFactorY = 5,
    font = 2,
    fontSize = 13,
    limitDistance = false,
    maxDistance = 1000,
    visibleOnly = false,
    teamCheck = false,
    teamColor = false,
    fillColor = nil,
    whitelistColor = Color3.new(1, 0, 0),
    outOfViewArrows = false,
    outOfViewArrowsFilled = false,
    outOfViewArrowsSize = 25,
    outOfViewArrowsRadius = 100,
    outOfViewArrowsColor = Color3.new(1, 1, 1),
    outOfViewArrowsTransparency = 0.5,
    outOfViewArrowsOutline = false,
    outOfViewArrowsOutlineFilled = false,
    outOfViewArrowsOutlineColor = Color3.new(1, 1, 1),
    outOfViewArrowsOutlineTransparency = 1,
    names = false,
    nameTransparency = 1,
    nameColor = Color3.new(1, 1, 1),
    boxes = false,
    boxesTransparency = 1,
    boxesColor = Color3.new(1, 1, 1),
    boxFill = false,
    boxFillTransparency = 0.5,
    boxFillColor = Color3.new(1, 1, 1),
    healthBars = false,
    healthBarsSize = 1,
    healthBarsTransparency = 1,
    healthBarsColor = Color3.new(0, 1, 0),
    healthText = false,
    healthTextTransparency = 1,
    healthTextSuffix = "%",
    healthTextColor = Color3.new(1, 1, 1),
    distance = false,
    distanceTransparency = 1,
    distanceSuffix = " Studs",
    distanceColor = Color3.new(1, 1, 1),
    tracers = false,
    tracerTransparency = 1,
    tracerColor = Color3.new(1, 1, 1),
    tracerOrigin = "Bottom", -- Available [Mouse, Top, Bottom]
    chams = false,
    chamsFillColor = Color3.new(1, 0, 0),
    chamsFillTransparency = 0.5,
    chamsOutlineColor = Color3.new(),
    chamsOutlineTransparency = 0
}

espLib.Init()

local Groups = {}

local Window = Library:CreateWindow({
	Title = 'clanware',
	Center = true, 
	AutoShow = true,
})

local Tabs = {
	-- Creates a new tab titled Main
	Main = Window:AddTab('aimbot'),
	ESP = Window:AddTab('visuals'), 
	['UI Settings'] = Window:AddTab('settings'),
}

local ESPLeftGroupBox = Tabs.ESP:AddLeftGroupbox('[ esp calibration ]')
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('[ aimbot calibration ]')
local RightGroupBox = Tabs.Main:AddRightGroupbox('[ aim assist calibration ]')
------------------------------------------------------[ AIMBOT SETTINGS BELOW ]------------------------------------------------------

LeftGroupBox:AddToggle("aimbotToggle", {Text = "aimbot"}, {Default = false})

LeftGroupBox:AddInput('aimbotKeybind', {
    Default = 'MouseButton1',
    Numeric = false, -- true / false, only allows numbers
    Finished = false, -- true / false, only calls callback when you press enter

    Text = 'aimbot key',
    Tooltip = 'the key to hold/toggle your aimbot', -- Information shown when you hover over the textbox

    Placeholder = 'MouseButton1', -- placeholder text when the box is empty
    -- MaxLength is also an option which is the max length of the text
})


LeftGroupBox:AddDropdown('aimbotTargetList', {
	Values = { "HumanoidRootPart", "Head","Left Arm","Right Arm","Left Leg","Right Leg" },
	Default = 1, -- number index of the value / string
	Multi = false, -- true / false, allows multiple choices to be selected

	Text = 'aimbot lock part',
	Tooltip = 'parts the aimlock attempts to lock onto, is set to HRP by default', -- Information shown when you hover over the textbox
})

LeftGroupBox:AddDropdown('aimTypeList', {
	Values = { "Hold", "Toggle"},
	Default = 1, -- number index of the value / string
	Multi = false, -- true / false, allows multiple choices to be selected

	Text = 'aimbot type',
	Tooltip = 'hold/toggle', -- Information shown when you hover over the textbox
})

LeftGroupBox:AddSlider('aimbotSmoothness', {
	Text = 'smoothness',

	-- Text, Default, Min, Max, Rounding must be specified.
	-- Rounding is the number of decimal places for precision.

	-- Example:
	-- Rounding 0 - 5
	-- Rounding 1 - 5.1
	-- Rounding 2 - 5.15
	-- Rounding 3 - 5.155

	Default = 100,
	Min = 10,
	Max = 200,
	Rounding = 1,

	Compact = false, -- If set to true, then it will hide the label
})


Options.aimbotKeybind:OnChanged(function()
	local type = "Other"
	aimbot:Set(type, "Keybind", Options.aimbotKeybind.Value)
end)

Options.aimbotSmoothness:OnChanged(function()
	local type = "Aimbot"
	aimbot:Set(type, "Strength", Options.aimbotSmoothness.Value)
end)


Options.aimbotTargetList:OnChanged(function()
	local type = "Aimbot"
	aimbot:Set(type, "TargetPart", Options.aimbotTargetList.Value)
end)

Options.aimTypeList:OnChanged(function()
	local type = "Aimbot"
	aimbot:Set(type, "AimType", Options.aimTypeList.Value)
end)

Options.aimbotTargetList:SetValue('HumanoidRootPart')

LeftGroupBox:AddDivider()

LeftGroupBox:AddLabel('[ aimbot settings ]')

LeftGroupBox:AddToggle('teamCheckToggle', {
	Text = 'team check',
	Default = false, -- Default value (true / false)
	Tooltip = 'enables/disables teamcheck', -- Information shown when you hover over the toggle
})

LeftGroupBox:AddToggle('wallCheckToggle', {
	Text = 'wall check',
	Default = false, -- Default value (true / false)
	Tooltip = 'enables/disables wallcheck', -- Information shown when you hover over the toggle
})

LeftGroupBox:AddToggle('ignoreTransparencyToggle', {
	Text = 'ignore transparent parts',
	Default = false, -- Default value (true / false)
	Tooltip = 'if enabled the aimbot will stick lock onto people behind transparent parts', -- Information shown when you hover over the toggle
})

LeftGroupBox:AddToggle('alwaysOnToggle', {
	Text = 'always on',
	Default = false, -- Default value (true / false)
	Tooltip = 'if on the aimbot will ignore your keybind and lock onto people by itself', -- Information shown when you hover over the toggle
})

LeftGroupBox:AddSlider('maximumDistance', {
	Text = 'maximum distance',

	-- Text, Default, Min, Max, Rounding must be specified.
	-- Rounding is the number of decimal places for precision.

	-- Example:
	-- Rounding 0 - 5
	-- Rounding 1 - 5.1
	-- Rounding 2 - 5.15
	-- Rounding 3 - 5.155

	Default = 300,
	Min = 10,
	Max = 2000,
	Rounding = 0,

	Compact = false, -- If set to true, then it will hide the label
})


Options.maximumDistance:OnChanged(function()
	local type = "Other"
	aimbot:Set(type, "MaximumDistance", Options.maximumDistance.Value)
end)

Toggles.teamCheckToggle:OnChanged(function()
	local type = "Other"
	aimbot:Set(type, "TeamCheck", Toggles.teamCheckToggle.Value)
end)

Toggles.wallCheckToggle:OnChanged(function()
	local type = "Other"
	aimbot:Set(type, "VisibleCheck", Toggles.wallCheckToggle.Value)
end)

Toggles.ignoreTransparencyToggle:OnChanged(function()
	local type = "Other"
	aimbot:Set(type, "IgnoreTransparency", Toggles.ignoreTransparencyToggle.Value)
end)

Toggles.alwaysOnToggle:OnChanged(function()
	local type = "Other"
	aimbot:Set(type, "AlwaysActive", Toggles.alwaysOnToggle.Value)
end)

Toggles.aimbotToggle:OnChanged(function()
	local type = "Aimbot"
	aimbot:Set(type, "Enabled", Toggles.aimbotToggle.Value)
end)

------------------------------------------------------[ FOV SETTINGS BELOW ]------------------------------------------------------

LeftGroupBox:AddDivider()

LeftGroupBox:AddLabel('[ fov settings ]')

LeftGroupBox:AddToggle("fovToggle", {Text = "fov circle"}, {Default = false}, {Tooltip = 'enables/disables fov circle'}):AddColorPicker('fovColor', {
	Default = Color3.new(1, 1, 1), -- Bright green
	Title = 'fov circle color picker', -- Optional. Allows you to have a custom color picker title (when you open it)
})

LeftGroupBox:AddToggle('dynamicFovToggle', {
	Text = 'dynamic fov circle',
	Default = false, -- Default value (true / false)
	Tooltip = 'enables/disables dynamic fov circle', -- Information shown when you hover over the toggle
})

LeftGroupBox:AddSlider('raidusFovSlider', {
	Text = 'fov size',

	-- Text, Default, Min, Max, Rounding must be specified.
	-- Rounding is the number of decimal places for precision.

	-- Example:
	-- Rounding 0 - 5
	-- Rounding 1 - 5.1
	-- Rounding 2 - 5.15
	-- Rounding 3 - 5.155

	Default = 100,
	Min = 10,
	Max = 700,
	Rounding = 0,

	Compact = false, -- If set to true, then it will hide the label
})

LeftGroupBox:AddSlider('transparencyFovSlider', {
	Text = 'fov transparency',

	-- Text, Default, Min, Max, Rounding must be specified.
	-- Rounding is the number of decimal places for precision.

	-- Example:
	-- Rounding 0 - 5
	-- Rounding 1 - 5.1
	-- Rounding 2 - 5.15
	-- Rounding 3 - 5.155

	Default = 1,
	Min = 0,
	Max = 1,
	Rounding = 1,

	Compact = false, -- If set to true, then it will hide the label
})

Toggles.fovToggle:OnChanged(function()
	local type = "FovCircle"
	aimbot:Set(type, "Enabled", Toggles.fovToggle.Value)
end)

Toggles.dynamicFovToggle:OnChanged(function()
	local type = "FovCircle"
	aimbot:Set(type, "Dynamic", Toggles.dynamicFovToggle.Value)
end)

Options.fovColor:OnChanged(function()
	local type = "FovCircle"
	aimbot:Set(type, "Color", Options.fovColor.Value)
end)

Options.raidusFovSlider:OnChanged(function()
	local type = "FovCircle"
	aimbot:Set(type, "Radius", Options.raidusFovSlider.Value)
end)

Options.transparencyFovSlider:OnChanged(function()
	local type = "FovCircle"
	aimbot:Set(type, "Transparency", Options.transparencyFovSlider.Value)
end)

------------------------------------------------------[ AIM ASSIST SETTINGS BELOW ]------------------------------------------------------

RightGroupBox:AddToggle('aimAssistToggle', {
	Text = 'aim assist',
	Default = false, -- Default value (true / false)
	Tooltip = 'enables/disables aim assist [does not work when aimbot is also enabled!]', -- Information shown when you hover over the toggle
})

RightGroupBox:AddToggle('aimAssistShowFov', {
	Text = 'show fov',
	Default = false, -- Default value (true / false)
	Tooltip = 'enables/disables aim assists fov', -- Information shown when you hover over the toggle
})

RightGroupBox:AddSlider('minFovSlider', {
	Text = 'min fov',

	-- Text, Default, Min, Max, Rounding must be specified.
	-- Rounding is the number of decimal places for precision.

	-- Example:
	-- Rounding 0 - 5
	-- Rounding 1 - 5.1
	-- Rounding 2 - 5.15
	-- Rounding 3 - 5.155

	Default = 15,
	Min = 15,
	Max = 50,
	Rounding = 0,

	Compact = false, -- If set to true, then it will hide the label
})


RightGroupBox:AddSlider('maxFovSlider', {
	Text = 'max fov',

	-- Text, Default, Min, Max, Rounding must be specified.
	-- Rounding is the number of decimal places for precision.

	-- Example:
	-- Rounding 0 - 5
	-- Rounding 1 - 5.1
	-- Rounding 2 - 5.15
	-- Rounding 3 - 5.155

	Default = 80,
	Min = 15,
	Max = 100,
	Rounding = 0,

	Compact = false, -- If set to true, then it will hide the label
})

RightGroupBox:AddSlider('aimAssistSmoothness', {
	Text = 'smoothness',

	-- Text, Default, Min, Max, Rounding must be specified.
	-- Rounding is the number of decimal places for precision.

	-- Example:
	-- Rounding 0 - 5
	-- Rounding 1 - 5.1
	-- Rounding 2 - 5.15
	-- Rounding 3 - 5.155

	Default = 60,
	Min = 10,
	Max = 100,
	Rounding = 0,

	Compact = false, -- If set to true, then it will hide the label
})



RightGroupBox:AddToggle('aimAssistDynamicFovToggle', {
	Text = 'aim assist dynamic fov circle',
	Default = false, -- Default value (true / false)
	Tooltip = 'enables/disables aim assists dynamic fov circle', -- Information shown when you hover over the toggle
})

RightGroupBox:AddToggle('aimAssistSlowSens', {
	Text = 'slower sens',
	Default = false, -- Default value (true / false)
	Tooltip = 'enables/disables aim assists slower sens feature', -- Information shown when you hover over the toggle
})

RightGroupBox:AddSlider('aimAssistSlowFactor', {
	Text = 'slower sens factor',

	-- Text, Default, Min, Max, Rounding must be specified.
	-- Rounding is the number of decimal places for precision.

	-- Example:
	-- Rounding 0 - 5
	-- Rounding 1 - 5.1
	-- Rounding 2 - 5.15
	-- Rounding 3 - 5.155

	Default = 1.75,
	Min = 1,
	Max = 10,
	Rounding = 2,

	Compact = false, -- If set to true, then it will hide the label
})

RightGroupBox:AddToggle('aimAssistRequireMovement', {
	Text = 'movement',
	Default = false, -- Default value (true / false)
	Tooltip = 'enables/disables aim assists require movement feature', -- Information shown when you hover over the toggle
})


Toggles.aimAssistToggle:OnChanged(function()
	local type = "AimAssist"
	aimbot:Set(type, "Enabled", Toggles.aimAssistToggle.Value)
end)

Toggles.aimAssistShowFov:OnChanged(function()
	local type = "AimAssist"
	aimbot:Set(type, "ShowFov", Toggles.aimAssistShowFov.Value)
end)

Toggles.aimAssistDynamicFovToggle:OnChanged(function()
	local type = "AimAssist"
	aimbot:Set(type, "DynamicFov", Toggles.aimAssistDynamicFovToggle.Value)
end)

Toggles.aimAssistRequireMovement:OnChanged(function()
	local type = "AimAssist"
	aimbot:Set(type, "SlowSensitivity", Toggles.aimAssistRequireMovement.Value)
end)

Toggles.aimAssistRequireMovement:OnChanged(function()
	local type = "AimAssist"
	aimbot:Set(type, "RequireMovement", Toggles.aimAssistRequireMovement.Value)
end)



Options.minFovSlider:OnChanged(function()
	local type = "AimAssist"
	aimbot:Set(type, "MinFov", Options.minFovSlider.Value)
end)

Options.maxFovSlider:OnChanged(function()
	local type = "AimAssist"
	aimbot:Set(type, "MaxFov", Options.maxFovSlider.Value)
end)

Options.aimAssistSmoothness:OnChanged(function()
	local type = "AimAssist"
	aimbot:Set(type, "Strength", Options.aimAssistSmoothness.Value)
end)

Options.aimAssistSlowFactor:OnChanged(function()
	local type = "AimAssist"
	aimbot:Set(type, "SlowFactor", Options.aimAssistSlowFactor.Value)
end)

------------------------------------------------------[  ESP SETTINGS BELOW  ]------------------------------------------------------
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/ridgeHUN/clanware/main/kiriotesp.lua"))()
ESP:Toggle(true)

ESPLeftGroupBox:AddToggle('espEnabled', {
	Text = 'esp',
	Default = false, -- Default value (true / false)
	Tooltip = 'enables/disables esp', -- Information shown when you hover over the toggle
})


Toggles.espEnabled:OnChanged(function()
	espLib.options.enabled = Toggles.espEnabled.Value
end)

ESPLeftGroupBox:AddToggle('espVisibleOnly', {
	Text = 'visible only',
	Default = false, -- Default value (true / false)
	Tooltip = 'show esp only when player is visible', -- Information shown when you hover over the toggle
})


Toggles.espVisibleOnly:OnChanged(function()
	espLib.options.visibleOnly = Toggles.espVisibleOnly.Value
end)

ESPLeftGroupBox:AddToggle('espTeamCheck', {
	Text = 'team check',
	Default = false, -- Default value (true / false)
	Tooltip = 'enables/disables team check', -- Information shown when you hover over the toggle
})


Toggles.espTeamCheck:OnChanged(function()
	espLib.options.teamCheck = Toggles.espTeamCheck.Value
end)

ESPLeftGroupBox:AddToggle('espTeamColor', {
	Text = 'team color',
	Default = false, -- Default value (true / false)
	Tooltip = 'enables/disables team color', -- Information shown when you hover over the toggle
})


Toggles.espTeamColor:OnChanged(function()
	espLib.options.teamColor = Toggles.espTeamColor.Value
end)

ESPLeftGroupBox:AddDivider()

ESPLeftGroupBox:AddLabel('[ box settings ]')

ESPLeftGroupBox:AddToggle('espBoxes', {
	Text = 'boxes',
	Default = false, -- Default value (true / false)
	Tooltip = 'enables/disables boxes', -- Information shown when you hover over the toggle
})


Toggles.espBoxes:OnChanged(function()
	espLib.options.boxes = Toggles.espBoxes.Value
end)

ESPLeftGroupBox:AddToggle('espHealthBar', {
	Text = 'healthbar',
	Default = false, -- Default value (true / false)
	Tooltip = 'enables/disables healthbar', -- Information shown when you hover over the toggle
})


Toggles.espHealthBar:OnChanged(function()
	espLib.options.healthBars = Toggles.espHealthBar.Value
end)

ESPLeftGroupBox:AddDivider()

ESPLeftGroupBox:AddLabel('[ name settings ]')

ESPLeftGroupBox:AddToggle('espNames', {
	Text = 'names',
	Default = false, -- Default value (true / false)
	Tooltip = 'enables/disables names', -- Information shown when you hover over the toggle
})


Toggles.espNames:OnChanged(function()
	espLib.options.names = Toggles.espNames.Value
end)

ESPLeftGroupBox:AddToggle('espNameHealthText', {
	Text = 'health text',
	Default = false, -- Default value (true / false)
	Tooltip = 'enables/disables health text', -- Information shown when you hover over the toggle
})


Toggles.espNameHealthText:OnChanged(function()
	espLib.options.healthText = Toggles.espNameHealthText.Value
end)

ESPLeftGroupBox:AddDivider()

ESPLeftGroupBox:AddLabel('[ tracer settings ]')

ESPLeftGroupBox:AddToggle('espTracers', {
	Text = 'tracers',
	Default = false, -- Default value (true / false)
	Tooltip = 'enables/disables tracers', -- Information shown when you hover over the toggle
})


Toggles.espTracers:OnChanged(function()
	espLib.options.tracers = Toggles.espTracers.Value
end)


------------------------------------------------------[  SETTINGS BELOW  ]------------------------------------------------------

-- Library functions
-- Sets the watermark visibility
Library:SetWatermarkVisibility(true)

-- Sets the watermark text
Library:SetWatermark("clanware | "..GameName)

Library.KeybindFrame.Visible = true; -- todo: add a function for this

Library:OnUnload(function()
	Library.Unloaded = true
end)

-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' }) 

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- ThemeManager (Allows you to have a menu theme system)

-- Hand the library over to our managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager. 
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings() 

-- Adds our MenuKeybind to the ignore list 
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 

-- use case for doing it this way: 
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs['UI Settings']) 

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config 
-- which has been marked to be one that auto loads!
