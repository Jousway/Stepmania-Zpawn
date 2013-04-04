-- StepMania 5 Default Theme Preferences Handler
local function OptionNameString(str)
	return THEME:GetString('OptionNames',str)
end

-- Example usage of new system (not fully implemented yet)
local Prefs =
{
	AutoSetStyle =
	{
		Default = true,
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
		Default = false,
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
		Default = true,
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
if GetUserPref("Use10sinsteadof1s") == "2" then	
	for i=1,256  do
	tChoices[i] = i-1;
	end;
else
	for i=1,26  do
	tChoices[i] = (i-1)*10;
	end;
end;	

function Use10sinsteadof1s()
	local t = {
		Name = "Use10sinsteadof1s";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = { 'On','Off' };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("Use10sinsteadof1s") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "2" then
					list[2] = true;
				else
					list[1] = true;
				end;
			else
				WritePrefToFile("Use10sinsteadof1s","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local val;
			if list[2] then
				val = "2";
			else
				val = "1";
			end;
			WritePrefToFile("Use10sinsteadof1s",val);
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" } );
			--THEME:ReloadMetrics();
		end;
	};
	setmetatable( t, t );
	return t;
end

function ColourHoldAndRollHeads()
	local t = {
		Name = "ColourHoldAndRollHeads";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = { 'Off','On' };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("ColourHoldAndRollHeads") ~= nil then
				if GetUserPrefB("ColourHoldAndRollHeads") then
					list[2] = true;
				else
					list[1] = true;
				end;
			else
				WritePrefToFile("ColourHoldAndRollHeads",false);
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local val;
			if list[2] then
				val = true;
			else
				val = false;
			end;
			WritePrefToFile("ColourHoldAndRollHeads",val);
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" } );
			--THEME:ReloadMetrics();
		end;
	};
	setmetatable( t, t );
	return t;
end		

function HoldBody()
	local t = {
		Name = "HoldBody";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = { 'DDR','ITG' };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("HoldBody") ~= nil then
				if GetUserPrefB("HoldBody") then
					list[2] = true;
				else
					list[1] = true;
				end;
			else
				WritePrefToFile("HoldBody",false);
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local val;
			if list[2] then
				val = true;
			else
				val = false;
			end;
			WritePrefToFile("HoldBody",val);
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" } );
			--THEME:ReloadMetrics();
		end;
	};
	setmetatable( t, t );
	return t;
end

function HoldEnd()
	local t = {
		Name = "HoldEnd";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = { 'DDR','ITG' };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("HoldEnd") ~= nil then
				if GetUserPrefB("HoldEnd") then
					list[2] = true;
				else
					list[1] = true;
				end;
			else
				WritePrefToFile("HoldEnd",false);
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local val;
			if list[2] then
				val = true;
			else
				val = false;
			end;
			WritePrefToFile("HoldEnd",val);
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" } );
			--THEME:ReloadMetrics();
		end;
	};
	setmetatable( t, t );
	return t;
end

function RollBody()
	local t = {
		Name = "RollBody";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = { 'DDR','ITG' };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("RollBody") ~= nil then
				if GetUserPrefB("RollBody") then
					list[2] = true;
				else
					list[1] = true;
				end;
			else
				WritePrefToFile("RollBody",false);
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local val;
			if list[2] then
				val = true;
			else
				val = false;
			end;
			WritePrefToFile("RollBody",val);
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" } );
			--THEME:ReloadMetrics();
		end;
	};
	setmetatable( t, t );
	return t;
end

function RollEnd()
	local t = {
		Name = "RollEnd";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = { 'DDR','ITG' };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("RollEnd") ~= nil then
				if GetUserPrefB("RollEnd") then
					list[2] = true;
				else
					list[1] = true;
				end;
			else
				WritePrefToFile("RollEnd",false);
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local val;
			if list[2] then
				val = true;
			else
				val = false;
			end;
			WritePrefToFile("RollEnd",val);
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" } );
			--THEME:ReloadMetrics();
		end;
	};
	setmetatable( t, t );
	return t;
end

function Slimmode()
	local t = {
		Name = "Slimmode";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = { 'Off','On' };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("Slimmode") ~= nil then
				if GetUserPrefB("Slimmode") then
					list[2] = true;
				else
					list[1] = true;
				end;
			else
				WritePrefToFile("Slimmode",false);
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local val;
			if list[2] then
				val = true;
			else
				val = false;
			end;
			WritePrefToFile("Slimmode",val);
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" } );
			--THEME:ReloadMetrics();
		end;
	};
	setmetatable( t, t );
	return t;
end

function NoteskinType()
	local t = {
		Name = "NoteskinType";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = { 'DDR','ITGM','ITGC','Cirlcle','Bar' };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinType") ~= nil then
			if GetUserPref("NoteskinType") == "5" then
					list[5] = true;
				elseif GetUserPref("NoteskinType") == "4" then
					list[4] = true;
				elseif GetUserPref("NoteskinType") == "3" then
					list[3] = true;
				elseif GetUserPref("NoteskinType") == "2" then
					list[2] = true;
				else
					list[1] = true;
				end;
			else
				WritePrefToFile("NoteskinType",false);
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local val;
			if list[5] then
				val = "5";
			elseif list[4] then
				val = "4";
			elseif list[3] then
				val = "3";
			elseif list[2] then
				val = "2";
			else
				val = "1";
			end;
			WritePrefToFile("NoteskinType",val);
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" } );
			--THEME:ReloadMetrics();
		end;
	};
	setmetatable( t, t );
	return t;
end	
				
function NoteskinColour4Red()
	local t = {
		Name = "NoteskinColour4Red";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour4Red") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour4Red") < 26 then
						local loadval = GetUserPrefN("NoteskinColour4Red")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour4Red",string.format('%.0f',GetUserPrefN("NoteskinColour4Red")+1/10));
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour4Red")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour4Red","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour4Red",val);
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

function NoteskinColour4Green()
	local t = {
		Name = "NoteskinColour4Green";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour4Green") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour4Green") < 26 then
						local loadval = GetUserPrefN("NoteskinColour4Green")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour4Green","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour4Green")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour4Green","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour4Green",val);
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

function NoteskinColour4Blue()
	local t = {
		Name = "NoteskinColour4Blue";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour4Blue") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour4Blue") < 26 then
						local loadval = GetUserPrefN("NoteskinColour4Blue")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour4Blue","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour4Blue")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour4Blue","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour4Blue",val);
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

function NoteskinColour8Red()
	local t = {
		Name = "NoteskinColour8Red";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour8Red") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour8Red") < 26 then
						local loadval = GetUserPrefN("NoteskinColour8Red")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour8Red","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour8Red")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour8Red","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour8Red",val);
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

function NoteskinColour8Green()
	local t = {
		Name = "NoteskinColour8Green";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour8Green") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour8Green") < 26 then
						local loadval = GetUserPrefN("NoteskinColour8Green")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour8Green","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour8Green")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour8Green","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour8Green",val);
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

function NoteskinColour8Blue()
	local t = {
		Name = "NoteskinColour8Blue";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour8Blue") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour8Blue") < 26 then
						local loadval = GetUserPrefN("NoteskinColour8Blue")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour8Blue","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour8Blue")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour8Blue","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour8Blue",val);
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

function NoteskinColour12Red()
	local t = {
		Name = "NoteskinColour12Red";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour12Red") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour12Red") < 26 then
						local loadval = GetUserPrefN("NoteskinColour12Red")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour12Red","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour12Red")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour12Red","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour12Red",val);
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

function NoteskinColour12Green()
	local t = {
		Name = "NoteskinColour12Green";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour12Green") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour12Green") < 26 then
						local loadval = GetUserPrefN("NoteskinColour12Green")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour12Green","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour12Green")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour12Green","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour12Green",val);
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

function NoteskinColour12Blue()
	local t = {
		Name = "NoteskinColour12Blue";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour12Blue") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour12Blue") < 26 then
						local loadval = GetUserPrefN("NoteskinColour12Blue")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour12Blue","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour12Blue")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour12Blue","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour12Blue",val);
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

function NoteskinColour16Red()
	local t = {
		Name = "NoteskinColour16Red";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour16Red") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour16Red") < 26 then
						local loadval = GetUserPrefN("NoteskinColour16Red")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour16Red","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour16Red")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour16Red","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour16Red",val);
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

function NoteskinColour16Green()
	local t = {
		Name = "NoteskinColour16Green";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour16Green") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour16Green") < 26 then
						local loadval = GetUserPrefN("NoteskinColour16Green")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour16Green","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour16Green")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour16Green","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour16Green",val);
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

function NoteskinColour16Blue()
	local t = {
		Name = "NoteskinColour16Blue";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour16Blue") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour16Blue") < 26 then
						local loadval = GetUserPrefN("NoteskinColour16Blue")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour16Blue","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour16Blue")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour16Blue","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour16Blue",val);
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

function NoteskinColour24Red()
	local t = {
		Name = "NoteskinColour24Red";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour24Red") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour24Red") < 26 then
						local loadval = GetUserPrefN("NoteskinColour24Red")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour24Red","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour24Red")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour24Red","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour24Red",val);
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

function NoteskinColour24Green()
	local t = {
		Name = "NoteskinColour24Green";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour24Green") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour24Green") < 26 then
						local loadval = GetUserPrefN("NoteskinColour24Green")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour24Green","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour24Green")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour24Green","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour24Green",val);
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

function NoteskinColour24Blue()
	local t = {
		Name = "NoteskinColour24Blue";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour24Blue") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour24Blue") < 26 then
						local loadval = GetUserPrefN("NoteskinColour24Blue")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour24Blue","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour24Blue")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour24Blue","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour24Blue",val);
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

function NoteskinColour32Red()
	local t = {
		Name = "NoteskinColour32Red";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour32Red") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour32Red") < 26 then
						local loadval = GetUserPrefN("NoteskinColour32Red")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour32Red","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour32Red")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour32Red","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour32Red",val);
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

function NoteskinColour32Green()
	local t = {
		Name = "NoteskinColour32Green";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour32Green") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour32Green") < 26 then
						local loadval = GetUserPrefN("NoteskinColour32Green")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour32Green","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour32Green")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour32Green","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour32Green",val);
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

function NoteskinColour32Blue()
	local t = {
		Name = "NoteskinColour32Blue";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour32Blue") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour32Blue") < 26 then
						local loadval = GetUserPrefN("NoteskinColour32Blue")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour32Blue","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour32Blue")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour32Blue","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour32Blue",val);
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

function NoteskinColour48Red()
	local t = {
		Name = "NoteskinColour48Red";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour48Red") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour48Red") < 26 then
						local loadval = GetUserPrefN("NoteskinColour48Red")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour48Red","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour48Red")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour48Red","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour48Red",val);
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

function NoteskinColour48Green()
	local t = {
		Name = "NoteskinColour48Green";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour48Green") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour48Green") < 26 then
						local loadval = GetUserPrefN("NoteskinColour48Green")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour48Green","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour48Green")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour48Green","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour48Green",val);
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

function NoteskinColour48Blue()
	local t = {
		Name = "NoteskinColour48Blue";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour48Blue") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour48Blue") < 26 then
						local loadval = GetUserPrefN("NoteskinColour48Blue")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour48Blue","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour48Blue")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour48Blue","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour48Blue",val);
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

function NoteskinColour64Red()
	local t = {
		Name = "NoteskinColour64Red";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour64Red") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour64Red") < 26 then
						local loadval = GetUserPrefN("NoteskinColour64Red")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour64Red","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour64Red")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour64Red","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour64Red",val);
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

function NoteskinColour64Green()
	local t = {
		Name = "NoteskinColour64Green";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour64Green") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour64Green") < 26 then
						local loadval = GetUserPrefN("NoteskinColour64Green")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour64Green","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour64Green")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour64Green","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour64Green",val);
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

function NoteskinColour64Blue()
	local t = {
		Name = "NoteskinColour64Blue";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour64Blue") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour64Blue") < 26 then
						local loadval = GetUserPrefN("NoteskinColour64Blue")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour64Blue","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour64Blue")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour64Blue","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour64Blue",val);
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

function NoteskinColour192Red()
	local t = {
		Name = "NoteskinColour192Red";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour192Red") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour192Red") < 26 then
						local loadval = GetUserPrefN("NoteskinColour192Red")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour192Red","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour192Red")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour192Red","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour192Red",val);
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

function NoteskinColour192Green()
	local t = {
		Name = "NoteskinColour192Green";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour192Green") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour192Green") < 26 then
						local loadval = GetUserPrefN("NoteskinColour192Green")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour192Green","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour192Green")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour192Green","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour192Green",val);
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

function NoteskinColour192Blue()
	local t = {
		Name = "NoteskinColour192Blue";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour192Blue") ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour192Blue") < 26 then
						local loadval = GetUserPrefN("NoteskinColour192Blue")+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour192Blue","1");
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour192Blue")+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour192Blue","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour192Blue",val);
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