local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LP = Players.LocalPlayer
local pg = LP:WaitForChild("PlayerGui")
local genv = getgenv()

if genv.__LUAU_UNIVERSAL_STOP then
	pcall(genv.__LUAU_UNIVERSAL_STOP)
end

local DISCORD = "https://discord.gg/pZeYJEJGMj"
local WEBSITE = "https://luaavnr.hopto.org/create"

local GAME_SCRIPTS = {
	{ Name = "Rivals", Url = "https://raw.githubusercontent.com/yarishdz2-gif/qyrex/refs/heads/main/rivals.lua" },
	{ Name = "Oculta tu base y roba", Url = "https://raw.githubusercontent.com/yarishdz2-gif/qyrex/refs/heads/main/qyrex.lua" },
	{ Name = "Steal an egg", Url = "https://raw.githubusercontent.com/yarishdz2-gif/qyrex/refs/heads/main/qyerxx.lua" },
	{ Name = "Arsenal", Url = "https://raw.githubusercontent.com/yarishdz2-gif/qyrex/refs/heads/main/arsenal.lua" },
	{ Name = "Murder vs Sheriff (BIMO)", Url = "https://pastefy.app/mHNf3ubx/raw" },
	{ Name = "Murder vs Sheriff", Url = "https://pastefy.app/P5aoRWKk/raw" },
	{ Name = "[Latam] Murder vs Sheriff", Url = "https://pastefy.app/nqVvGrPn/raw" },
}

local function parentGui(gui)
	local function try(target)
		local ok = pcall(function()
			gui.Parent = target
		end)
		return ok and gui.Parent ~= nil
	end
	if try(pg) then
		return true
	end
	pcall(function()
		if typeof(gethui) == "function" then
			local h = gethui()
			if h and try(h) then
				return true
			end
		end
	end)
	if try(game:GetService("CoreGui")) then
		return true
	end
	return false
end

local function getExecutor()
	local names = {
		"identifyexecutor",
		"getexecutorname",
	}
	for _, n in ipairs(names) do
		local fn = rawget(getfenv and getfenv() or {}, n) or (getgenv and getgenv()[n])
		if type(fn) == "function" then
			local ok, r = pcall(fn)
			if ok and r then
				return tostring(r)
			end
		end
	end
	if syn then
		return "Synapse"
	end
	if fluxus then
		return "Fluxus"
	end
	if delta then
		return "Delta"
	end
	return "Unknown"
end

local function getGameTitle()
	local ok, name = pcall(function()
		return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
	end)
	if ok and name then
		return name
	end
	return "Place " .. tostring(game.PlaceId)
end

local function httpGet(url)
	local ok, body = pcall(function()
		return game:HttpGet(url)
	end)
	if ok and type(body) == "string" and #body > 30 then
		return body
	end
	local req = (syn and syn.request) or (http and http.request) or http_request or request
	if req then
		local ok2, res = pcall(function()
			return req({ Url = url, Method = "GET" })
		end)
		if ok2 and type(res) == "table" then
			local b = res.Body or res.body
			if type(b) == "string" and #b > 30 then
				return b
			end
		end
	end
	return nil, body
end

if pg:FindFirstChild("LuauVanguardLoader") then
	pg.LuauVanguardLoader:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "LuauVanguardLoader"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = 999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
parentGui(gui)

local root = Instance.new("Frame")
root.Name = "Root"
root.AnchorPoint = Vector2.new(0.5, 0.5)
root.Position = UDim2.fromScale(0.5, 0.5)
root.Size = UDim2.fromOffset(600, 380)
root.BackgroundTransparency = 1
root.Parent = gui

local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Position = UDim2.new(0, -25, 0, -25)
shadow.Size = UDim2.new(1, 50, 1, 50)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6014261993"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.55
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(49, 49, 450, 450)
shadow.Parent = root

local panel = Instance.new("CanvasGroup")
panel.Name = "Panel"
panel.Size = UDim2.fromScale(1, 1)
panel.BackgroundColor3 = Color3.fromRGB(20, 16, 20)
panel.BorderSizePixel = 0
panel.Parent = root
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 12)

local function glow(parent, pos, size, rot, trans)
	local img = Instance.new("ImageLabel")
	img.BackgroundTransparency = 1
	img.AnchorPoint = Vector2.new(0.5, 0.5)
	img.Position = pos
	img.Size = size
	img.Image = "rbxassetid://8992230677"
	img.ImageColor3 = Color3.fromRGB(226, 218, 230)
	img.ImageTransparency = trans
	img.Parent = parent
	local g = Instance.new("UIGradient")
	g.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(235, 199, 246))
	g.Rotation = rot
	g.Parent = img
end

glow(panel, UDim2.fromOffset(300, 390), UDim2.fromOffset(500, 180), 270, 0.86)
glow(panel, UDim2.fromOffset(-10, 360), UDim2.fromOffset(130, 60), 90, 0.75)
glow(panel, UDim2.fromOffset(586, 20), UDim2.fromOffset(520, 240), 90, 0.92)
glow(panel, UDim2.fromOffset(10, 0), UDim2.fromOffset(90, 180), 90, 0.78)

-- LEFT
local left = Instance.new("Frame")
left.Size = UDim2.fromOffset(356, 380)
left.BackgroundTransparency = 1
left.Parent = panel

local logo = Instance.new("ImageLabel")
logo.Position = UDim2.fromOffset(28, 24)
logo.Size = UDim2.fromOffset(40, 36)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://103859712365480"
logo.ImageColor3 = Color3.fromRGB(235, 199, 246)
logo.ScaleType = Enum.ScaleType.Fit
logo.Parent = left

local title = Instance.new("TextLabel")
title.Position = UDim2.fromOffset(78, 24)
title.Size = UDim2.fromOffset(240, 24)
title.BackgroundTransparency = 1
title.Text = "Luauvanguard"
title.TextColor3 = Color3.fromRGB(233, 229, 234)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = left

local subtitle = Instance.new("TextLabel")
subtitle.Position = UDim2.fromOffset(78, 48)
subtitle.Size = UDim2.fromOffset(240, 14)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Universal Loader · No key"
subtitle.TextColor3 = Color3.fromRGB(125, 115, 126)
subtitle.TextSize = 12
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = left

local gamesLabel = Instance.new("TextLabel")
gamesLabel.Position = UDim2.fromOffset(28, 78)
gamesLabel.Size = UDim2.fromOffset(200, 14)
gamesLabel.BackgroundTransparency = 1
gamesLabel.Text = "Select a script"
gamesLabel.TextColor3 = Color3.fromRGB(125, 115, 126)
gamesLabel.TextSize = 11
gamesLabel.Font = Enum.Font.Gotham
gamesLabel.TextXAlignment = Enum.TextXAlignment.Left
gamesLabel.Parent = left

local scroll = Instance.new("ScrollingFrame")
scroll.Position = UDim2.fromOffset(28, 98)
scroll.Size = UDim2.fromOffset(300, 220)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = Color3.fromRGB(235, 199, 246)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.Parent = left

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0, 6)
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Parent = scroll

local statusLbl = Instance.new("TextLabel")
statusLbl.Position = UDim2.fromOffset(28, 328)
statusLbl.Size = UDim2.fromOffset(300, 16)
statusLbl.BackgroundTransparency = 1
statusLbl.Text = "Ready"
statusLbl.TextColor3 = Color3.fromRGB(125, 115, 126)
statusLbl.TextSize = 12
statusLbl.Font = Enum.Font.Gotham
statusLbl.TextXAlignment = Enum.TextXAlignment.Left
statusLbl.TextTruncate = Enum.TextTruncate.AtEnd
statusLbl.Parent = left

local tip = Instance.new("TextLabel")
tip.Position = UDim2.fromOffset(28, 350)
tip.Size = UDim2.fromOffset(300, 14)
tip.BackgroundTransparency = 1
tip.Text = "RightCtrl hide · no key required"
tip.TextColor3 = Color3.fromRGB(90, 80, 95)
tip.TextSize = 11
tip.Font = Enum.Font.Gotham
tip.TextXAlignment = Enum.TextXAlignment.Left
tip.Parent = left

local function setStatus(msg, color)
	statusLbl.Text = tostring(msg)
	statusLbl.TextColor3 = color or Color3.fromRGB(125, 115, 126)
	print("[Luauvanguard]", msg)
end

local function runScript(entry)
	setStatus("Loading " .. entry.Name .. "...", Color3.fromRGB(240, 176, 108))
	task.spawn(function()
		local body, err = httpGet(entry.Url)
		if not body then
			setStatus("Http fail: " .. tostring(err), Color3.fromRGB(255, 100, 100))
			return
		end
		local chunk, cerr = loadstring(body)
		if not chunk then
			setStatus("Compile: " .. tostring(cerr), Color3.fromRGB(255, 100, 100))
			return
		end
		local ok, err2 = pcall(chunk)
		if ok then
			setStatus(entry.Name .. " · OK", Color3.fromRGB(120, 255, 160))
		else
			setStatus("Error: " .. tostring(err2), Color3.fromRGB(255, 100, 100))
		end
	end)
end

for i, entry in ipairs(GAME_SCRIPTS) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -4, 0, 36)
	btn.BackgroundColor3 = Color3.fromRGB(28, 22, 28)
	btn.AutoButtonColor = false
	btn.Text = ""
	btn.LayoutOrder = i
	btn.Parent = scroll
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
	local st = Instance.new("UIStroke", btn)
	st.Color = Color3.fromRGB(40, 32, 41)

	local nameLbl = Instance.new("TextLabel")
	nameLbl.Position = UDim2.fromOffset(12, 0)
	nameLbl.Size = UDim2.new(1, -70, 1, 0)
	nameLbl.BackgroundTransparency = 1
	nameLbl.Text = entry.Name
	nameLbl.TextColor3 = Color3.fromRGB(233, 229, 234)
	nameLbl.TextSize = 12
	nameLbl.Font = Enum.Font.GothamMedium
	nameLbl.TextXAlignment = Enum.TextXAlignment.Left
	nameLbl.TextTruncate = Enum.TextTruncate.AtEnd
	nameLbl.Parent = btn

	local go = Instance.new("TextLabel")
	go.AnchorPoint = Vector2.new(1, 0.5)
	go.Position = UDim2.new(1, -12, 0.5, 0)
	go.Size = UDim2.fromOffset(50, 22)
	go.BackgroundColor3 = Color3.fromRGB(235, 199, 246)
	go.BackgroundTransparency = 0.15
	go.Text = "Load"
	go.TextColor3 = Color3.fromRGB(24, 18, 26)
	go.TextSize = 11
	go.Font = Enum.Font.GothamBold
	go.Parent = btn
	Instance.new("UICorner", go).CornerRadius = UDim.new(0, 6)

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(36, 28, 38) }):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(28, 22, 28) }):Play()
	end)
	btn.MouseButton1Click:Connect(function()
		runScript(entry)
	end)
end

-- DIVIDER
local div = Instance.new("Frame")
div.Position = UDim2.fromOffset(356, 28)
div.Size = UDim2.new(0, 1, 1, -56)
div.BackgroundColor3 = Color3.fromRGB(40, 32, 41)
div.BorderSizePixel = 0
div.Parent = panel

-- RIGHT
local right = Instance.new("Frame")
right.Position = UDim2.fromOffset(357, 0)
right.Size = UDim2.fromOffset(243, 380)
right.BackgroundTransparency = 1
right.Parent = panel

local detLbl = Instance.new("TextLabel")
detLbl.Position = UDim2.fromOffset(28, 28)
detLbl.Size = UDim2.fromOffset(184, 14)
detLbl.BackgroundTransparency = 1
detLbl.Text = "Detected game"
detLbl.TextColor3 = Color3.fromRGB(125, 115, 126)
detLbl.TextSize = 11
detLbl.Font = Enum.Font.Gotham
detLbl.TextXAlignment = Enum.TextXAlignment.Left
detLbl.Parent = right

local detCard = Instance.new("Frame")
detCard.Position = UDim2.fromOffset(28, 48)
detCard.Size = UDim2.fromOffset(188, 60)
detCard.BackgroundColor3 = Color3.fromRGB(28, 22, 28)
detCard.BorderSizePixel = 0
detCard.Parent = right
Instance.new("UICorner", detCard).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", detCard).Color = Color3.fromRGB(40, 32, 41)

local detIcon = Instance.new("ImageLabel")
detIcon.Position = UDim2.fromOffset(11, 11)
detIcon.Size = UDim2.fromOffset(38, 38)
detIcon.BackgroundColor3 = Color3.fromRGB(24, 19, 24)
detIcon.BorderSizePixel = 0
detIcon.Image = "rbxassetid://74584987850498"
detIcon.Parent = detCard
Instance.new("UICorner", detIcon).CornerRadius = UDim.new(0, 7)
Instance.new("UIStroke", detIcon).Color = Color3.fromRGB(40, 32, 41)

local detName = Instance.new("TextLabel")
detName.Position = UDim2.fromOffset(58, 14)
detName.Size = UDim2.fromOffset(122, 16)
detName.BackgroundTransparency = 1
detName.Text = getGameTitle()
detName.TextColor3 = Color3.fromRGB(233, 229, 234)
detName.TextSize = 11
detName.Font = Enum.Font.GothamMedium
detName.TextXAlignment = Enum.TextXAlignment.Left
detName.TextTruncate = Enum.TextTruncate.AtEnd
detName.Parent = detCard

local detSub = Instance.new("TextLabel")
detSub.Position = UDim2.fromOffset(58, 32)
detSub.Size = UDim2.fromOffset(122, 13)
detSub.BackgroundTransparency = 1
detSub.Text = "PlaceId " .. tostring(game.PlaceId)
detSub.TextColor3 = Color3.fromRGB(125, 115, 126)
detSub.TextSize = 11
detSub.Font = Enum.Font.Gotham
detSub.TextXAlignment = Enum.TextXAlignment.Left
detSub.TextTruncate = Enum.TextTruncate.AtEnd
detSub.Parent = detCard

local function infoRow(y, leftText, rightText, rightColor)
	local a = Instance.new("TextLabel")
	a.Position = UDim2.fromOffset(28, y)
	a.Size = UDim2.fromOffset(90, 14)
	a.BackgroundTransparency = 1
	a.Text = leftText
	a.TextColor3 = Color3.fromRGB(125, 115, 126)
	a.TextSize = 11
	a.Font = Enum.Font.Gotham
	a.TextXAlignment = Enum.TextXAlignment.Left
	a.Parent = right
	local b = Instance.new("TextLabel")
	b.Position = UDim2.fromOffset(120, y)
	b.Size = UDim2.fromOffset(96, 14)
	b.BackgroundTransparency = 1
	b.Text = rightText
	b.TextColor3 = rightColor or Color3.fromRGB(233, 229, 234)
	b.TextSize = 11
	b.Font = Enum.Font.Gotham
	b.TextXAlignment = Enum.TextXAlignment.Right
	b.TextTruncate = Enum.TextTruncate.AtEnd
	b.Parent = right
	return b
end

infoRow(126, "Executor", getExecutor())
local statusRight = infoRow(148, "Status", "No key needed", Color3.fromRGB(120, 255, 160))

local line = Instance.new("Frame")
line.Position = UDim2.fromOffset(28, 176)
line.Size = UDim2.fromOffset(188, 1)
line.BackgroundColor3 = Color3.fromRGB(40, 32, 41)
line.BorderSizePixel = 0
line.Parent = right

local function sideBtn(y, mainText, subText, cb)
	local b = Instance.new("TextButton")
	b.Position = UDim2.fromOffset(28, y)
	b.Size = UDim2.fromOffset(188, 48)
	b.BackgroundColor3 = Color3.fromRGB(28, 22, 28)
	b.Text = ""
	b.AutoButtonColor = false
	b.Parent = right
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
	Instance.new("UIStroke", b).Color = Color3.fromRGB(40, 32, 41)

	local t1 = Instance.new("TextLabel")
	t1.Position = UDim2.fromOffset(14, 10)
	t1.Size = UDim2.fromOffset(160, 14)
	t1.BackgroundTransparency = 1
	t1.Text = mainText
	t1.TextColor3 = Color3.fromRGB(233, 229, 234)
	t1.TextSize = 12
	t1.Font = Enum.Font.GothamMedium
	t1.TextXAlignment = Enum.TextXAlignment.Left
	t1.Parent = b

	local t2 = Instance.new("TextLabel")
	t2.Position = UDim2.fromOffset(14, 25)
	t2.Size = UDim2.fromOffset(160, 13)
	t2.BackgroundTransparency = 1
	t2.Text = subText
	t2.TextColor3 = Color3.fromRGB(125, 115, 126)
	t2.TextSize = 11
	t2.Font = Enum.Font.Gotham
	t2.TextXAlignment = Enum.TextXAlignment.Left
	t2.TextTruncate = Enum.TextTruncate.AtEnd
	t2.Parent = b

	b.MouseEnter:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(36, 28, 38) }):Play()
	end)
	b.MouseLeave:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(28, 22, 28) }):Play()
	end)
	b.MouseButton1Click:Connect(cb)
	return b
end

sideBtn(190, "Discord", "discord.gg/pZeYJEJGMj", function()
	pcall(function()
		setclipboard(DISCORD)
	end)
	setStatus("Discord copied", Color3.fromRGB(120, 255, 160))
end)

sideBtn(246, "Website", "luaavnr.hopto.org/create", function()
	pcall(function()
		setclipboard(WEBSITE)
	end)
	setStatus("Website copied", Color3.fromRGB(120, 255, 160))
end)

sideBtn(302, "Close Loader", "Unload this UI", function()
	if genv.__LUAU_UNIVERSAL_STOP then
		genv.__LUAU_UNIVERSAL_STOP()
	end
end)

-- drag
do
	local dragging, dragStart, startPos
	local function begin(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		dragging = true
		dragStart = input.Position
		startPos = root.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
	title.InputBegan:Connect(begin)
	logo.InputBegan:Connect(begin)
	left.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			if input.Position.Y < left.AbsolutePosition.Y + 70 then
				begin(input)
			end
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if not dragging then
			return
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			local d = input.Position - dragStart
			root.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
		end
	end)
end

UserInputService.InputBegan:Connect(function(input, gp)
	if gp then
		return
	end
	if input.KeyCode == Enum.KeyCode.RightControl then
		root.Visible = not root.Visible
	end
end)

genv.__LUAU_UNIVERSAL_STOP = function()
	pcall(function()
		gui:Destroy()
	end)
	genv.__LUAU_UNIVERSAL_STOP = nil
end

-- open anim
root.Size = UDim2.fromOffset(600, 0)
panel.GroupTransparency = 1
TweenService:Create(root, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
	Size = UDim2.fromOffset(600, 380),
}):Play()
TweenService:Create(panel, TweenInfo.new(0.35), { GroupTransparency = 0 }):Play()

print("[Luauvanguard Universal] UI loader ready")
