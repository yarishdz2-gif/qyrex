local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local lp = Players.LocalPlayer
local genv = getgenv()

if genv.__LUAU_UNIVERSAL_STOP then pcall(genv.__LUAU_UNIVERSAL_STOP) end

local GAME_SCRIPTS = {
	["Rivals"] = "https://raw.githubusercontent.com/yarishdz2-gif/qyrex/refs/heads/main/rivals.lua",
	["Oculta tu base y roba"] = "https://raw.githubusercontent.com/yarishdz2-gif/qyrex/refs/heads/main/qyrex.lua",
	["Steal an egg"] = "https://raw.githubusercontent.com/yarishdz2-gif/qyrex/refs/heads/main/qyerxx.lua",
	["Arsenal"] = "https://raw.githubusercontent.com/yarishdz2-gif/qyrex/refs/heads/main/arsenal.lua",
}

local GAME_ORDER = {
	"Rivals",
	"Oculta tu base y roba",
	"Steal an egg",
	"Arsenal",
}

local MacLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/yarishdz2-gif/qyrex/refs/heads/main/library.lua"))()
if not MacLib then
	warn("[Luauvanguard] MacLib fail")
	return
end

local Window = MacLib:Window({
	Title = "Luauvanguard Universal",
	Subtitle = "Script Loader",
	Size = UDim2.fromOffset(420, 320),
	AcrylicBlur = true,
})

local tabGroup = Window:TabGroup()
local TabGames = tabGroup:Tab({ Name = "Games" })
local TabInfo = tabGroup:Tab({ Name = "Info" })

local section = TabGames:Section({ Side = "Left" })
local statusLabel

local function setStatus(msg)
	pcall(function()
		if Window.Notify then
			Window:Notify({
				Title = "Luauvanguard",
				Description = tostring(msg),
				Lifetime = 3,
			})
		end
	end)
	print("[Luauvanguard]", msg)
end

local function runScript(url, gameName)
	if type(url) ~= "string" or url == "" then
		setStatus("Sin script: " .. tostring(gameName))
		return
	end
	setStatus("Cargando " .. gameName .. "...")
	task.spawn(function()
		local ok, body = pcall(function()
			return game:HttpGet(url)
		end)
		if not ok then
			setStatus("HttpGet fail: " .. tostring(body))
			return
		end
		local chunk, err = loadstring(body)
		if not chunk then
			setStatus("Loadstring: " .. tostring(err))
			return
		end
		local ok2, err2 = pcall(chunk)
		if ok2 then
			setStatus(gameName .. " · OK")
		else
			setStatus("Error: " .. tostring(err2))
		end
	end)
end

for _, name in ipairs(GAME_ORDER) do
	local url = GAME_SCRIPTS[name]
	section:Button({
		Name = name,
		Callback = function()
			runScript(url, name)
		end,
	})
end

section:Button({
	Name = "Cerrar Loader",
	Callback = function()
		if genv.__LUAU_UNIVERSAL_STOP then
			genv.__LUAU_UNIVERSAL_STOP()
		end
	end,
})

local infoSec = TabInfo:Section({ Side = "Left" })
infoSec:Button({
	Name = "Rivals",
	Callback = function()
		setStatus("rivals.lua")
	end,
})
infoSec:Button({
	Name = "Oculta tu base · qyrex.lua",
	Callback = function()
		setStatus("qyrex.lua")
	end,
})
infoSec:Button({
	Name = "Steal an egg · qyerxx.lua",
	Callback = function()
		setStatus("qyerxx.lua")
	end,
})
infoSec:Button({
	Name = "Arsenal · arsenal.lua",
	Callback = function()
		setStatus("arsenal.lua")
	end,
})

genv.__LUAU_UNIVERSAL_STOP = function()
	pcall(function()
		if Window.Unload then Window:Unload() end
	end)
	genv.__LUAU_UNIVERSAL_STOP = nil
end

pcall(function() TabGames:Select() end)
print("[Luauvanguard Universal] cargado")
