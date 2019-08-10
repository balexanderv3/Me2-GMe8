--[[ @ 2paCheat 1.0 - 2019
	
	MENU MODULE

	Features:
	- Apex Roleplay Essentials (ESP)
	- Clockwork Essentials (ESP)
	- Bunnyhop
	- Aimbot

	WIP:
	- Tables for fucking CheckedBox
	- Hooks for the cheat modules
	- Whitelist thingy for ESP
	- optimization niggering

	
	]] 




-- Colors

custom1_chen = Color(51, 122, 204);
red_chen = Color(255,0,0,255);
blue_chen = Color(0,0,255,255);
white_chen = Color(255,255,255,255);

-- Prints

if _G.CAC then
chat.AddText( red_chen, "[2paCheat] ", chatcolor1, "CAC Anti-Cheat detected.")
end

chat.AddText( custom1_chen, "[2paCheat] ", white_chen, "2paCheat loaded.")
chat.AddText( custom1_chen, "[2paCheat] ", white_chen, "Type '2pc_Menu' in your Console to open the cheat.")
chat.AddText( custom1_chen, "[2paCheat] ", white_chen, "Aimkey for the Aimbot is LEFT_ALT.")


if _G["MH_FontCreate"] != true then
surface.CreateFont("MH_Text", {font = "Tahoma", extended = true, size = 12})
surface.CreateFont("MH_Button", {font = "Tahoma", extended = true, size = 13, bold = true, shadow = true, weight = 800})
surface.CreateFont("MH_Percent", {font = "Tahoma", extended = true, size = 13, outline = true})
end
_G["MH_FontCreate"] = true

surface.CreateFont("SkeetFontTest", {font = "badcache", extended = true, size = 45, antialias = true})
MH = {}

function Hex2Num(hexnum) if type(hexnum) == "number" then hexnum = hexnum..""; end hexnum = string.TrimLeft(hexnum, "0"); nDigits = string.len(hexnum); nTotal = 0; while nDigits > 0 do sIn = string.upper(string.Left(hexnum, 1)); if sIn > "9" then if sIn == "A" then nFactor = 10; elseif sIn == "B" then nFactor = 11; elseif sIn == "C" then nFactor = 12; elseif sIn == "D" then nFactor = 13; elseif sIn == "E" then nFactor = 14; elseif sIn == "F" then nFactor = 15; end else nFactor = tonumber(sIn); end nTotal = nTotal + nFactor * math.pow(16, nDigits - 1); hexnum = string.TrimLeft(hexnum, sIn); nDigits = nDigits - 1; end sTotal = nTotal..""; return sTotal; end
function ChinaHex(hexnum,halpha)
	if halpha == nil then halpha = 255 end
	local hred = Hex2Num(string.sub(hexnum, 1, 2))
	local hgreen = Hex2Num(string.sub(hexnum, 3, 4))
	local hblue = Hex2Num(string.sub(hexnum, 5, 6))
	return Color(hred,hgreen,hblue,tonumber(halpha))
end

function ChinaGradient(start,finish,current,total)
	local hsred = start.r
	local hsgreen = start.g
	local hsblue = start.b
	
	local hfred = finish.r
	local hfgreen = finish.g
	local hfblue = finish.b
	local result = Color(Lerp(current/total,hsred,hfred),Lerp(current/total,hsgreen,hfgreen),Lerp(current/total,hsblue,hfblue), 255)
	return result
end

MH.OPEN = false

MH.Theme = {}

MH.Theme["bar_up"] =		ChinaHex("9AC527")
MH.Theme["bar_dn"] =		ChinaHex("689304")
MH.Theme["background"] =	Color(24,24,24,255)
MH.Theme["check_bg_up"] =	ChinaHex("4C4C4C")
MH.Theme["check_bg_dn"] =	ChinaHex("333333")
MH.Theme["check_on_up"] =	ChinaHex("9AC527")
MH.Theme["check_on_dn"] =	ChinaHex("729D0B")
MH.Theme["text"] =			ChinaHex("CCCCCC")
MH.Theme["text_shadow"] =	ChinaHex("070707")
MH.Theme["bar_empty_up"] =	ChinaHex("343434")
MH.Theme["bar_empty_dn"] =	ChinaHex("444444")
MH.Theme["combo_bg"] =		ChinaHex("232323")
MH.Theme["outline"] =		ChinaHex("000000")
MH.Theme["inline"] =		ChinaHex("303030")
MH.Theme["cursor"] =		ChinaHex("7BC215")


function OpenMenu() -- gui and shit
	if MH.OPEN then return end
	MH.OPEN = true
	//PrintTable(MH.Theme)

	MHMenuFrame = vgui.Create("DFrame")
	MHMenuFrame:SetTitle("")
	MHMenuFrame:ShowCloseButton(false)
	MHMenuFrame:SetSize( 375, 14+(75*4) )
	MHMenuFrame:Center()
	MHMenuFrame:MakePopup()
	MHMenuFrame.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, MH.Theme["outline"])
		draw.RoundedBox(0, 1, 1, w-2, h-2, Color(60,60,60))
		draw.RoundedBox(0, 2, 2, w-4, h-4, Color(40,40,40))
		draw.RoundedBox( 0, 5, 5, w-10, h-10, Color(60,60,60))
		draw.RoundedBox( 0, 6, 6, w-12, h-12, MH.Theme["background"])
	end

	MH.SLIDERS = {}
	MH.COMBOS = {}
	MH.TABS = {}
	MH.TEMPCOMBO = {}
	MH.MASTER = MHMenuFrame
	MH.TEMPSHITFIX = nil
	MH.OURTAB = "YahudMain"
	MH.Menu = {}

	function MH.RefreshTabs()
		for k,v in pairs(MH.TABS) do
			MH.Menu[v].Selected = false
			MH.Menu[v].DownBorder = false
			MH.Menu[v].TopBorder = false
			MH.Menu[v .. "_TLABEL"]:SetTextColor(Color(90,90,90))
			
			if MH.Menu[v] == MH.Menu[MH.OURTAB] then
				MH.TEMPSHITFIX = k
			end
		end
		MH.Menu[MH.OURTAB].Selected = true
		MH.Menu[MH.OURTAB].TopBorder = true
		MH.Menu[MH.OURTAB .. "_TLABEL"]:SetTextColor(Color(255,255,255))
		if MH.TEMPSHITFIX==#MH.TABS then
		else
			MH.Menu[MH.TABS[MH.TEMPSHITFIX+1]].DownBorder = true
		end
		if MH.TEMPSHITFIX==1 then
		else
			MH.Menu[MH.TABS[MH.TEMPSHITFIX-1]].TopBorder = true
		end
	end

	function MH.AddButton(fx,fy,name,text)
		if name==nil then name=math.Rand(0,99999) end
		MH.Menu[name] = vgui.Create("Button", MH.MASTER)
		MH.Menu[name]:SetText("")
		MH.Menu[name]:SetPos(fx, fy)
		MH.Menu[name]:SetSize(155, 25)
		MH.Menu[name].Paint = function( self, w, h )
			draw.RoundedBox(0, 0, 0, w, h, MH.Theme["outline"])
			draw.RoundedBox(0, 1, 1, w-2, h-2, Color(50,50,50))
			draw.RoundedBox(0, 2, 2, w-4, 1, Color(41,41,41))
			draw.RoundedBox(0, 2, 3, w-4, 1, Color(40,40,40))
			draw.RoundedBox(0, 2, 4, w-4, 1, Color(40,40,40))
			draw.RoundedBox(0, 2, 5, w-4, 1, Color(39,39,39))
			draw.RoundedBox(0, 2, 6, w-4, 1, Color(39,39,39))
			draw.RoundedBox(0, 2, 7, w-4, 1, Color(38,38,38))
			draw.RoundedBox(0, 2, 8, w-4, 1, Color(38,38,38))
			draw.RoundedBox(0, 2, 9, w-4, 1, Color(37,37,37))
			draw.RoundedBox(0, 2, 10, w-4, 1, Color(37,37,37))
			draw.RoundedBox(0, 2, 11, w-4, 1, Color(36,36,36))
			draw.RoundedBox(0, 2, 12, w-4, 1, Color(36,36,36))
			draw.RoundedBox(0, 2, 13, w-4, 1, Color(36,36,36))
			draw.RoundedBox(0, 2, 14, w-4, 1, Color(35,35,35))
			draw.RoundedBox(0, 2, 15, w-4, 1, Color(35,35,35))
			draw.RoundedBox(0, 2, 16, w-4, 1, Color(34,34,34))
			draw.RoundedBox(0, 2, 17, w-4, 1, Color(34,34,34))
			draw.RoundedBox(0, 2, 18, w-4, 1, Color(33,33,33))
			draw.RoundedBox(0, 2, 19, w-4, 1, Color(32,32,32))
			draw.RoundedBox(0, 2, 20, w-4, 1, Color(31,31,31))
			draw.RoundedBox(0, 2, 21, w-4, 1, Color(31,31,31))
			draw.RoundedBox(0, 2, 22, w-4, 1, Color(30,30,30))
		end
		MH.Menu[name].DoClick = function()
			if type(MH.Menu[name .. "_BUTTONFUNC"]) == "function" then
				MH.Menu[name .. "_BUTTONFUNC"]()
			end
		end
		
		surface.SetFont("MH_Button")
		local fwi,fhe = surface.GetTextSize(tostring(text))
		MH.Menu[name .. "_BLABEL"] = vgui.Create("DLabel", MH.MASTER)
		MH.Menu[name .. "_BLABEL"]:SetFont("MH_Button")
		MH.Menu[name .. "_BLABEL"]:SetPos(fx+((155/2)-(fwi/2)),fy+2)
		MH.Menu[name .. "_BLABEL"]:SetText(tostring(text))
		MH.Menu[name .. "_BLABEL"]:SetSize(fwi+5,20)
	end


	function MH.AddTab(fx,fy,name,text)
		table.insert(MH.TABS, name)
		
		MH.Menu[name .. "_TAB_PANEL"] = vgui.Create("DPanel", MHMenuFrame)
		MH.Menu[name .. "_TAB_PANEL"]:SetPos( 75, 8 )
		MH.Menu[name .. "_TAB_PANEL"].Paint = function() end
		MH.Menu[name .. "_TAB_PANEL"]:SetSize(375, 14+(75*4))
		
		if name==nil then name=math.Rand(0,99999) end
		MH.Menu[name] = vgui.Create("Button", MH.MASTER)
		MH.Menu[name]:SetText("")
		MH.Menu[name]:SetPos(fx, fy)
		MH.Menu[name].Selected = false
		MH.Menu[name].DownBorder = false
		MH.Menu[name].TopBorder = false
		MH.Menu[name]:SetSize(75, 75)
		MH.Menu[name].Paint = function( self, w, h )
			
			if MH.Menu[name].Selected then
				//draw.RoundedBox(0, 0, 1, w, 1, Color(48+6,48+6,48+6))
			else
				draw.RoundedBox(0, 0, 0, w, h, Color(48+6,48+6,48+6))
				draw.RoundedBox(0, 0, 0, w-1, h, MH.Theme["outline"])
				draw.RoundedBox(0, 0, 0, w-2, h, Color(18,18,18))
				
				if MH.Menu[name].TopBorder then
					draw.RoundedBox(0, 0, 74, w-1, 1, Color(48+6,48+6,48+6))
					draw.RoundedBox(0, 0, 73, w-1, 1, MH.Theme["outline"])
				end
				if MH.Menu[name].DownBorder then
					draw.RoundedBox(0, 0, 0, w-1, 1, Color(48+6,48+6,48+6))
					draw.RoundedBox(0, 0, 1, w-1, 1, MH.Theme["outline"])
				end
			end
		end
		MH.Menu[name].DoClick = function()
			MH.OURTAB = name
			MH.RefreshTabs()
			MH.RefreshTabPanels()
		end
		
		surface.SetFont("SkeetFontTest")
		local fwi,fhe = surface.GetTextSize(tostring(text))
		MH.Menu[name .. "_TLABEL"] = vgui.Create("DLabel", MH.MASTER)
		MH.Menu[name .. "_TLABEL"]:SetFont("SkeetFontTest")
		MH.Menu[name .. "_TLABEL"]:SetPos(fx+16,fy)
		MH.Menu[name .. "_TLABEL"]:SetTextColor(Color(90,90,90))
		MH.Menu[name .. "_TLABEL"]:SetText(tostring(text))
		MH.Menu[name .. "_TLABEL"]:SetSize(75,75)
	end

	function MH.RefreshTabPanels()
		for k,v in pairs(MH.TABS) do
			MH.Menu[v .. "_TAB_PANEL"]:Hide()
			if MH.Menu[v].Selected then
				MH.Menu[v .. "_TAB_PANEL"]:Show()
			end
		end
	end

	function MH.AddCombo(fx,fy,name,text)
		table.insert(MH.COMBOS, name)
		if name==nil then name=math.Rand(0,99999) end
		MH.Menu[name] = vgui.Create("Button", MH.MASTER)
		MH.Menu[name]:SetText("")
		MH.Menu[name]:SetPos(fx, fy)
		MH.Menu[name].Opened = false
		MH.Menu[name].Options = {"Empty"}
		MH.Menu[name .. "_CLABEL"] = vgui.Create("DLabel", MH.MASTER)
		MH.Menu[name].ChosenOption = 1
		MH.Menu[name].RefreshList = function()
			surface.SetFont("MH_Text")
			local fwi,fhe = surface.GetTextSize(MH.Menu[name].Options[MH.Menu[name].ChosenOption])
			MH.Menu[name .. "_CLABEL"]:SetFont("MH_Text")
			MH.Menu[name .. "_CLABEL"]:SetPos(fx+10,fy)
			MH.Menu[name .. "_CLABEL"]:SetText(MH.Menu[name].Options[MH.Menu[name].ChosenOption])
			MH.Menu[name .. "_CLABEL"]:SetSize(fwi+5,20)
		end
		MH.Menu[name].RefreshList()
		MH.Menu[name]:SetSize(155, 20)
		MH.Menu[name].Paint = function( self, w, h )
			draw.RoundedBox(0, 0, 0, w, h, MH.Theme["outline"])
			draw.RoundedBox(0, 1, 1, w-2, h-2, Color(50,50,50))
			draw.RoundedBox(0, 2, 2, w-4, h-4, Color(41,41,41))
			
			draw.RoundedBox(0, 145, 8, 5, 1, Color(152,152,152))
			draw.RoundedBox(0, 146, 9, 3, 1, Color(152,152,152))
			draw.RoundedBox(0, 147, 10, 1, 1, Color(152,152,152))
		end
		hook.Remove("VGUIMousePressed", name .. "_combo")
		hook.Add("VGUIMousePressed", name .. "_combo", function(pnl)
			if MH.Menu[name] then
				MH.Menu[name].StartedHere = false
			end
			if pnl == MH.Menu[name] then MH.Menu[name].StartedHere = true /*print("we clicked combo")*/ end
			for k,vart in pairs(MH.TEMPCOMBO) do
				if pnl == vart then
					MH.Menu[name].StartedHere = true
				end
			end
			
			if MH.Menu[name].StartedHere == false then
				for blag,bleg in pairs(MH.TEMPCOMBO) do
					MH.TEMPCOMBO[blag]:Remove()
				end
				MH.TEMPCOMBO = {}
			end
		end)
		MH.Menu[name].DoClick = function()
			MH.Menu[name].Opened = !MH.Menu[name].Opened
			//print(MH.Menu[name].Opened)
			MH.Menu[name].RefreshList()
			for k,v in pairs(MH.Menu[name].Options) do
				MH.TEMPCOMBO[name .. "_" .. tostring(v)] = vgui.Create("Button", MH.MASTER)
				MH.TEMPCOMBO[name .. "_" .. tostring(v)]:SetText(tostring(v))
				MH.TEMPCOMBO[name .. "_" .. tostring(v)]:SetPos(fx, fy+(k*20))
				MH.TEMPCOMBO[name .. "_" .. tostring(v)].Paint = function( self, w, h )
					draw.RoundedBox(0, 0, 0, w, h, MH.Theme["outline"])
					draw.RoundedBox(0, 1, 1, w-2, h-2, Color(50,50,50))
					draw.RoundedBox(0, 2, 2, w-4, h-4, Color(41,41,41))
				end
				MH.TEMPCOMBO[name .. "_" .. tostring(v)]:SetSize(155, 20)
				MH.TEMPCOMBO[name .. "_" .. tostring(v)].DoClick = function()
					MH.Menu[name].ChosenOption = k
					//print(MH.Menu[name].ChosenOption)
					for blag,bleg in pairs(MH.TEMPCOMBO) do
						MH.TEMPCOMBO[blag]:Remove()
					end
					MH.TEMPCOMBO = {}
					MH.Menu[name].RefreshList()
				end
			end
		end
		
	end

	function MH.AddCheckbox(fx,fy,name,text,onbydefault)
		if name==nil then name=math.Rand(0,99999) end
		MH.Menu[name] = vgui.Create("Button", MH.MASTER)
		MH.Menu[name]:SetText("")
		MH.Menu[name]:SetPos(fx, fy)
		MH.Menu[name]:SetSize(8, 8)
		if type(onbydefault) == "boolean" then
			MH.Menu[name].IsOn = onbydefault
		else
			MH.Menu[name].IsOn = false
		end
		MH.Menu[name].Paint = function( self, w, h )
			draw.RoundedBox(0, 0, 0, 8, h, MH.Theme["outline"])
			if MH.Menu[name].IsOn then
				draw.RoundedBox(0, 1, 1, 8-2, 1, ChinaGradient(MH.Theme["check_on_up"],MH.Theme["check_on_dn"],1,6))
				draw.RoundedBox(0, 1, 2, 8-2, 1, ChinaGradient(MH.Theme["check_on_up"],MH.Theme["check_on_dn"],2,6))
				draw.RoundedBox(0, 1, 3, 8-2, 1, ChinaGradient(MH.Theme["check_on_up"],MH.Theme["check_on_dn"],3,6))
				draw.RoundedBox(0, 1, 4, 8-2, 1, ChinaGradient(MH.Theme["check_on_up"],MH.Theme["check_on_dn"],4,6))
				draw.RoundedBox(0, 1, 5, 8-2, 1, ChinaGradient(MH.Theme["check_on_up"],MH.Theme["check_on_dn"],5,6))
				draw.RoundedBox(0, 1, 6, 8-2, 1, ChinaGradient(MH.Theme["check_on_up"],MH.Theme["check_on_dn"],6,6))
			else
				draw.RoundedBox(0, 1, 1, 8-2, 1, ChinaGradient(MH.Theme["check_bg_up"],MH.Theme["check_bg_dn"],1,6))
				draw.RoundedBox(0, 1, 2, 8-2, 1, ChinaGradient(MH.Theme["check_bg_up"],MH.Theme["check_bg_dn"],2,6))
				draw.RoundedBox(0, 1, 3, 8-2, 1, ChinaGradient(MH.Theme["check_bg_up"],MH.Theme["check_bg_dn"],3,6))
				draw.RoundedBox(0, 1, 4, 8-2, 1, ChinaGradient(MH.Theme["check_bg_up"],MH.Theme["check_bg_dn"],4,6))
				draw.RoundedBox(0, 1, 5, 8-2, 1, ChinaGradient(MH.Theme["check_bg_up"],MH.Theme["check_bg_dn"],5,6))
				draw.RoundedBox(0, 1, 6, 8-2, 1, ChinaGradient(MH.Theme["check_bg_up"],MH.Theme["check_bg_dn"],6,6))
			end
		end
		MH.Menu[name].DoClick = function()
			MH.Menu[name].IsOn = !MH.Menu[name].IsOn
		end
		
		// Shadow
		MH.Menu[name .. "_LABELT"] = vgui.Create("DLabel", MH.MASTER)
		MH.Menu[name .. "_LABELT"]:SetFont("MH_Text")
		MH.Menu[name .. "_LABELT"]:SetPos(fx+21,fy - 6)
		MH.Menu[name .. "_LABELT"]:SetText(tostring(text))
		surface.SetFont("MH_Text")
		local fwi,fhe = surface.GetTextSize(tostring(text))
		local fwio,fheo = MH.Menu[name .. "_LABELT"]:GetSize()
		MH.Menu[name .. "_LABELT"]:SetSize(fwi+5,fheo)
		MH.Menu[name]:SetSize(fwi+32,8)
		MH.Menu[name .. "_LABELT"]:SetTextColor(Color(0,0,0))
		
		// Our label
		MH.Menu[name .. "_LABEL"] = vgui.Create("DLabel", MH.MASTER)
		MH.Menu[name .. "_LABEL"]:SetFont("MH_Text")
		MH.Menu[name .. "_LABEL"]:SetPos(fx+20,fy - 7)
		MH.Menu[name .. "_LABEL"]:SetText(tostring(text))
		surface.SetFont("MH_Text")
		local fwi,fhe = surface.GetTextSize(tostring(text))
		local fwio,fheo = MH.Menu[name .. "_LABEL"]:GetSize()
		MH.Menu[name .. "_LABEL"]:SetSize(fwi+5,fheo)
	end

	function MH.AddSlider(fx,fy,name,ourbase,symbol)
		table.insert(MH.SLIDERS, name)
		if name==nil then name=math.Rand(0,99999) end
		MH.Menu[name] = vgui.Create("DButton", MH.MASTER)
		MH.Menu[name]:SetPos(fx, fy)
		MH.Menu[name]:SetText("")
		MH.Menu[name]:SetSize(157,8)
		MH.Menu[name].OurSymbol = symbol
		MH.Menu[name].OurBase = ourbase
		MH.Menu[name].SliderPos = 0
		MH.Menu[name].SliderPercent = 0
		MH.Menu[name].StartedHere = false
		MH.Menu[name].Paint = function( self, w, h )
			draw.RoundedBox(0, 0, 0, 157, 8, MH.Theme["outline"])
			draw.RoundedBox(0, 1, 1, 155, 1, ChinaGradient(MH.Theme["check_bg_up"],MH.Theme["check_bg_dn"],6,6))
			draw.RoundedBox(0, 1, 2, 155, 1, ChinaGradient(MH.Theme["check_bg_up"],MH.Theme["check_bg_dn"],5,6))
			draw.RoundedBox(0, 1, 3, 155, 1, ChinaGradient(MH.Theme["check_bg_up"],MH.Theme["check_bg_dn"],4,6))
			draw.RoundedBox(0, 1, 4, 155, 1, ChinaGradient(MH.Theme["check_bg_up"],MH.Theme["check_bg_dn"],3,6))
			draw.RoundedBox(0, 1, 5, 155, 1, ChinaGradient(MH.Theme["check_bg_up"],MH.Theme["check_bg_dn"],2,6))
			draw.RoundedBox(0, 1, 6, 155, 1, ChinaGradient(MH.Theme["check_bg_up"],MH.Theme["check_bg_dn"],1,6))
			
			draw.RoundedBox(0, 1, 1, MH.Menu[name].SliderPos, 1, ChinaGradient(MH.Theme["check_on_dn"],MH.Theme["check_on_up"],6,6))
			draw.RoundedBox(0, 1, 2, MH.Menu[name].SliderPos, 1, ChinaGradient(MH.Theme["check_on_dn"],MH.Theme["check_on_up"],5,6))
			draw.RoundedBox(0, 1, 3, MH.Menu[name].SliderPos, 1, ChinaGradient(MH.Theme["check_on_dn"],MH.Theme["check_on_up"],4,6))
			draw.RoundedBox(0, 1, 4, MH.Menu[name].SliderPos, 1, ChinaGradient(MH.Theme["check_on_dn"],MH.Theme["check_on_up"],3,6))
			draw.RoundedBox(0, 1, 5, MH.Menu[name].SliderPos, 1, ChinaGradient(MH.Theme["check_on_dn"],MH.Theme["check_on_up"],2,6))
			draw.RoundedBox(0, 1, 6, MH.Menu[name].SliderPos, 1, ChinaGradient(MH.Theme["check_on_dn"],MH.Theme["check_on_up"],1,6))
		end
		
		hook.Remove("VGUIMousePressed", name .. "_panel")
		hook.Add("VGUIMousePressed", name .. "_panel", function(pnl)
			if !MH.Menu[name] then return end
			if pnl == MH.Menu[name] then
				MH.Menu[name].StartedHere = true
			else
				if MH.Menu[name] then
					MH.Menu[name].StartedHere = false
				end
			end
		end)

		MH.Menu[name].Think = function()
			if input.IsMouseDown(MOUSE_FIRST) and MH.Menu[name].StartedHere == true then
				local fmx, fmy = gui.MousePos()
				local fox, foy = MHMenuFrame:GetPos()+MH.MASTER:GetPos()
				local fsx, fsy = MH.Menu[name]:GetPos()
				if true then
					MH.Menu[name].SliderPos = math.Clamp((fmx-fox)-fsx,0,157)
					if (((fmx-fox)-fsx)/156)*MH.Menu[name].OurBase < 1 then
						MH.Menu[name].SliderPercent = 0
					else 
						MH.Menu[name].OldSliderPercent = MH.Menu[name].SliderPercent
						MH.Menu[name].SliderPercent = math.Clamp(math.Round((((fmx-fox)-fsx)/156)*MH.Menu[name].OurBase), 0, MH.Menu[name].OurBase)
						if MH.Menu[name].SliderPercent != MH.Menu[name].OldSliderPercent then
							if type(MH.Menu[name .. "_SLIDERFUNC"]) == "function" then
								MH.Menu[name .. "_SLIDERFUNC"](tonumber(MH.Menu[name].SliderPercent))
							end
						end
					end
					fmx = (((fmx-fox)-fsx)/156)*MH.Menu[name].OurBase
					//print(MH.Menu[name].SliderPercent)
				end
			end
		end
		
		MH.Menu[name .. "_PCTLABEL"] = vgui.Create("DLabel", MH.MASTER)
		MH.Menu[name .. "_PCTLABEL"]:SetFont("MH_Percent")
		MH.Menu[name .. "_PCTLABEL"]:SetPos(fx-10,fy-5)
		MH.Menu[name .. "_PCTLABEL"]:SetText(tostring(0) .. symbol)
		MH.Menu[name .. "_PCTLABEL"].Think = function()
			local fsx, fsy = MH.Menu[name]:GetPos()
			MH.Menu[name .. "_PCTLABEL"]:SetText(tostring(MH.Menu[name].SliderPercent) .. symbol)
			MH.Menu[name .. "_PCTLABEL"]:SetPos((MH.Menu[name].SliderPos+fsx)-10, fy-5)
		end
		MH.Menu[name .. "_PCTLABEL"]:SetSize(30,30)
		
	end

	function MH.AddBox(fx,fy,sx,sy,name,text)
		if name==nil then name=math.Rand(0,99999) end
		MH.Menu["PANEL_" .. name] = vgui.Create("DPanel", MH.MASTER)
		MH.Menu["PANEL_" .. name]:SetPos(fx, fy)
		MH.Menu["PANEL_" .. name]:SetText("")
		MH.Menu["PANEL_" .. name]:SetSize(sx,sy)
		MH.Menu["PANEL_" .. name].Paint = function( self, w, h )
			draw.RoundedBox(0, 0, 0, sx, sy, MH.Theme["outline"])
			draw.RoundedBox(0, 1, 1, sx-2, sy-2, MH.Theme["inline"])
			draw.RoundedBox(0, 2, 2, sx-4, sy-4, MH.Theme["background"])
		end
		
		surface.SetFont("MH_Text")
		local fwi,fhe = surface.GetTextSize(tostring(text))
		
		if name==nil then name=math.Rand(0,99999) end
		MH.Menu["PANELCV_" .. name] = vgui.Create("DPanel", MH.MASTER)
		MH.Menu["PANELCV_" .. name]:SetPos(fx+14, fy-5)
		MH.Menu["PANELCV_" .. name]:SetText("")
		MH.Menu["PANELCV_" .. name]:SetSize(fwi+7 /*text width*/,10)
		MH.Menu["PANELCV_" .. name].Paint = function( self, w, h )
			draw.RoundedBox(0, 0, 0, sx, sy, MH.Theme["background"])
		end
		
			MH.Menu[name .. "_PLABEL"] = vgui.Create("DLabel", MH.MASTER)
		MH.Menu[name .. "_PLABEL"]:SetFont("MH_Text")
		MH.Menu[name .. "_PLABEL"]:SetPos(fx+18,fy-12)
		MH.Menu[name .. "_PLABEL"]:SetText(tostring(text))
		local fwio,fheo = MH.Menu[name .. "_PLABEL"]:GetSize()
		MH.Menu[name .. "_PLABEL"]:SetSize(fwi+5,fheo)
		
	end

	function MH.ChangeSlider(name,amount)
		MH.Menu[name].SliderPercent = amount
		MH.Menu[name].SliderPos = (amount/MH.Menu[name].OurBase)*156
		MH.Menu[name .. "_PCTLABEL"]:SetText(tostring(MH.Menu[name].SliderPercent) .. MH.Menu[name].OurSymbol)
	end

	-- Tabs
	MH.AddTab(0+7,(0*75)+7,"YahudMain","C")
	MH.AddTab(0+7,(1*75)+7,"YahudOne","H")
	MH.AddTab(0+7,(2*75)+7,"YahudTwo","E")
	MH.AddTab(0+7,(3*75)+7,"YahudThree","N")
	MH.RefreshTabs()

	--c panel
	MH.MASTER = MH.Menu["YahudMain_TAB_PANEL"]

	MH.AddBox(50-20,(100-60)-20,236,275,"SkeetSliderTestOne","Player Essentials")
	MH.AddCheckbox(50,100-60,"SkeetButtonPlayerESP","Activate PlayerESP",false)
	MH.AddCheckbox(50,120-60,"SkeetButtonBoxFrameESP","Activate BoxframeESP",false)

	MH.AddButton(50,200-60,"SkeetButtonClose","Close Menu")

	MH.Menu["SkeetButtonClose_BUTTONFUNC"] = function()
		MHMenuFrame:Close()
		MH.OPEN = false
		for k,v in pairs(MH.SLIDERS) do
			hook.Remove("VGUIMousePressed", v .. "_panel")
		end
		for k,v in pairs(MH.COMBOS) do
			hook.Remove("VGUIMousePressed", v .. "_combo")
		end
	end

	--h panel
	MH.MASTER = MH.Menu["YahudOne_TAB_PANEL"]

	MH.AddBox(50-20,(100-60)-20,236,275,"SkeetSliderTestOne","Clockwork Essentials")
	MH.AddCheckbox(50,100-60,"SkeetButtonCWItemESP","Activate ItemESP",false)
	MH.AddCheckbox(50,120-60,"SkeetButtonCWSalesmanESP","Activate SalesmanESP",false)
	MH.AddCheckbox(50,140-60,"SkeetButtonCWShipmentESP","Activate ShipmentESP",false)
	MH.AddCheckbox(50,160-60,"SkeetButtonCWRadioESP","Activate RadioESP",false)

	--e panel
	MH.MASTER = MH.Menu["YahudTwo_TAB_PANEL"]

	MH.AddBox(50-20,(100-60)-20,236,275,"SkeetSliderTestOne","Apex Essentials")
	MH.AddCheckbox(50,100-60,"SkeetButtonApexItemESP","Activate ItemESP",false)
	MH.AddCheckbox(50,120-60,"SkeetButtonApexTokenESP","Activate TokenESP",false)
	
	--n panel
	MH.MASTER = MH.Menu["YahudThree_TAB_PANEL"]

	MH.AddBox(50-20,(100-60)-20,236,275,"SkeetSliderTestOne","Aimbot and Misc")
	MH.AddCheckbox(50,100-60,"SkeetButtonAimbot","Activate Aimbot",false)
	MH.AddCheckbox(50,120-60,"SkeetButtonIgnoreTeam","Ignore Team",false)
	MH.AddCheckbox(50,140-60,"SkeetButtonBHOP","Activate BHOP",false)

	MH.RefreshTabs()
	MH.RefreshTabPanels()
end






-- Console Commands

concommand.Add( "2pc_Menu", function()
	OpenMenu()
end)

concommand.Add( "2pc_close", function()
	MHMenuFrame:Close()
	MH.OPEN = false
end)
