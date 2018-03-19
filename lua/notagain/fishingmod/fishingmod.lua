local include = includex

if SERVER then

	local function add_dir(dir)
		local files = file.Find("notagain/fishingmod/"..dir.."*", "LUA")
		for _, file_name in pairs(files) do
			AddCSLuaFile("notagain/fishingmod/"..dir .. file_name)
		end
	end

	add_dir("/")
	add_dir("client/")
	add_dir("client/pac_outfits/")
	add_dir("bait/")
	add_dir("fish/")
end

fishing = fishing or {}
		include("notagain/fishingmod/"..dir.."/" .. file_name)

hook.Add("pac_Initialized", "fishingmod", function()
	include("notagain/fishingmod/rod.lua")
	fishing.IncludeAllFiles("bait")
	hook.Remove("pac_Initialized", "fishingmod")
end)