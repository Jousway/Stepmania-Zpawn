local tChoices = {};
for i=1,30  do
tChoices[i] = ((i-1)*50)+50;
end;

function SpeedDisplay()
	local t = {
		Name = "SpeedDisplay";
		LayoutType = "ShowOneInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = false;
		ExportOnChange = true;
		Choices = { 'Constant Mod','Multiplication Mod','Average Mod','ConstantX Mod','Maximum Mod' };
		LoadSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			if ReadPrefFromFile("SpeedDisplay"..pName) ~= nil then
			if GetUserPref("SpeedDisplay"..pName) == "5" then
					list[5] = true;
				elseif GetUserPref("SpeedDisplay"..pName) == "4" then
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
