-- StepMania 5 Default Theme Preferences Handler
local function OptionNameString(str)
	return THEME:GetString('OptionNames',str)
end

-- Example usage of new system (not fully implemented yet)
local Prefs =
{
	AutoSetStyle =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	GameplayShowStepsDisplay = 
	{
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	GameplayShowScore =
	{
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	ShowLotsaOptions =
	{
		Default = true,
		Choices = { OptionNameString('Many'), OptionNameString('Few') },
		Values = { true, false }
	},
	LongFail =
	{
		Default = false,
		Choices = { OptionNameString('Short'), OptionNameString('Long') },
		Values = { false, true }
	},
	NotePosition =
	{
		Default = true,
		Choices = { OptionNameString('Normal'), OptionNameString('Lower') },
		Values = { true, false }
	},
	ComboOnRolls =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	FlashyCombo =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	ComboUnderField =
	{
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	FancyUIBG =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	TimingDisplay =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	GameplayFooter =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},

	--[[
	ProtimingP1,
	ProtimingP2,

	UserPrefScoringMode = 'DDR Extreme'
	--]]
}

ThemePrefs.InitAll(Prefs)

function InitUserPrefs()
	local Prefs = {
		UserPrefScoringMode = 'DDR Extreme',
        UserPrefSoundPack   = 'default',
		UserPrefProtimingP1 = false,
		UserPrefProtimingP2 = false,
	}
	for k, v in pairs(Prefs) do
		-- kind of xxx
		local GetPref = type(v) == "boolean" and GetUserPrefB or GetUserPref
		if GetPref(k) == nil then
			SetUserPref(k, v)
		end
	end

	-- screen filter
	setenv("ScreenFilterP1",0)
	setenv("ScreenFilterP2",0)
end

function GetProTiming(pn)
	local pname = ToEnumShortString(pn)
	if GetUserPref("ProTiming"..pname) then
		return GetUserPrefB("ProTiming"..pname)
	else
		SetUserPref("ProTiming"..pname,false)
		return false
	end
end

--[[ option rows ]]

-- screen filter
function OptionRowScreenFilter()
	local t = {
		Name="ScreenFilter",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { THEME:GetString('OptionNames','Off'), '0.1', '0.2', '0.3', '0.4', '0.5', '0.6', '0.7', '0.8', '0.9', '1.0', },
		LoadSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			local filterValue = getenv("ScreenFilter"..pName)
			if filterValue ~= nil then
				local val = scale(tonumber(filterValue),0,1,1,#list )
				list[val] = true
			else
				setenv("ScreenFilter"..pName,0)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = scale(i,1,#list,0,1)
						setenv("ScreenFilter"..pName,val)
						found = true
					end
				end
			end
		end,
	};
	setmetatable(t, t)
	return t
end

-- protiming
function OptionRowProTiming()
	local t = {
		Name = "ProTiming",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = {
			THEME:GetString('OptionNames','Off'),
			THEME:GetString('OptionNames','On')
		},
		LoadSelections = function(self, list, pn)
			if GetUserPrefB("UserPrefProtiming" .. ToEnumShortString(pn)) then
				local bShow = GetUserPrefB("UserPrefProtiming" .. ToEnumShortString(pn))
				if bShow then
					list[2] = true
				else
					list[1] = true
				end
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local bSave = list[2] and true or false
			SetUserPref("UserPrefProtiming" .. ToEnumShortString(pn), bSave)
		end
	}
	setmetatable(t, t)
	return t
end

--[[ end option rows ]]
-- Jousway's silly edits
local tChoices = {};
for i=1,20  do
tChoices[i] = ((i-1)*50)+50;
end;

function SpeedDisplay()
	local t = {
		Name = "SpeedDisplay";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = false;
		ExportOnChange = true;
		Choices = { 'Constant Mod','Multiplication Mod','Average Mod','Maximum Mod' };
		LoadSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			if ReadPrefFromFile("SpeedDisplay"..pName) ~= nil then
			if GetUserPref("SpeedDisplay"..pName) == "4" then
					list[4] = true;
				elseif GetUserPref("SpeedDisplay"..pName) == "3" then
					list[3] = true;
				elseif GetUserPref("SpeedDisplay"..pName) == "2" then
					list[2] = true;
				else
					list[1] = true;
				end;
			else
				WritePrefToFile("SpeedDisplay"..pName,"1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local val;
			local pName = ToEnumShortString(pn)
			if list[4] then
				val = "4";
			elseif list[3] then
				val = "3";
			elseif list[2] then
				val = "2";
			else
				val = "1";
			end;
			WritePrefToFile("SpeedDisplay"..pName,val);
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" } );
			--THEME:ReloadMetrics();
		end;
	};
	setmetatable( t, t );
	return t;
end	
	
function SpeedMod()
	local t = {
		Name = "SpeedMod";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = false;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			if ReadPrefFromFile("SpeedMod"..pName) ~= nil then
				local loadval = GetUserPrefN("SpeedMod"..pName)+1;
				list[loadval] = true;
			else
				WritePrefToFile("SpeedMod"..pName,"1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						local pName = ToEnumShortString(pn)
						WritePrefToFile("SpeedMod"..pName,val);
						found = true
					end
				end
			end
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" } );
			--THEME:ReloadMetrics();
		end;
	};
	setmetatable( t, t );
	return t;
end;
