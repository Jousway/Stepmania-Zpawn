local tChoices = {};
for i=1,26  do
tChoices[i] = (i-1)*10;
end;
					
function ThemeColourRed()
	local t = {
		Name = "ThemeColourRed";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("ThemeColourRed") ~= nil then
				local loadval = GetUserPrefN("ThemeColourRed")+1;
				list[loadval] = true;
			else
				WritePrefToFile("ThemeColourRed","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("ThemeColourRed",val);
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

function ThemeColourGreen()
	local t = {
		Name = "ThemeColourGreen";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("ThemeColourGreen") ~= nil then
				local loadval = GetUserPrefN("ThemeColourGreen")+1;
				list[loadval] = true;
			else
				WritePrefToFile("ThemeColourGreen","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("ThemeColourGreen",val);
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

function ThemeColourBlue()
	local t = {
		Name = "ThemeColourBlue";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("ThemeColourBlue") ~= nil then
				local loadval = GetUserPrefN("ThemeColourBlue")+1;
				list[loadval] = true;
			else
				WritePrefToFile("ThemeColourBlue","1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("ThemeColourBlue",val);
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