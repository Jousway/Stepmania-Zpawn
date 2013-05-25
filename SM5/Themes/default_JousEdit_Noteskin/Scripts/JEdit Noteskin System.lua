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

function HoldNRoll(Part)
	local t = {
		Name = Part;
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = { 'DDR','ITG' };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile(Part) ~= nil then
				if GetUserPrefB(Part) then
					list[2] = true;
				else
					list[1] = true;
				end;
			else
				WritePrefToFile(Part,false);
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
			WritePrefToFile(Part,val);
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
				
function NoteskinColour(Note,Colour)
	local t = {
		Name = "NoteskinColour"..Note..Colour;
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = tChoices;
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NoteskinColour"..Note..Colour) ~= nil then
				if GetUserPref("Use10sinsteadof1s") == "1" then	
					if GetUserPrefN("NoteskinColour"..Note..Colour) < 26 then
						local loadval = GetUserPrefN("NoteskinColour"..Note..Colour)+1;
						list[loadval] = true;
					else
						WritePrefToFile("NoteskinColour"..Note..Colour,string.format('%.0f',GetUserPrefN("NoteskinColour"..Note..Colour)+1/10));
						list[1] = true;
					end;
				else
					local loadval = GetUserPrefN("NoteskinColour"..Note..Colour)+1;
					list[loadval] = true;
				end;
			else
				WritePrefToFile("NoteskinColour"..Note..Colour,"1");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = i-1;
						WritePrefToFile("NoteskinColour"..Note..Colour,val);
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


--because metrics.ini sucks
function HoldBody() return HoldNRoll("HoldBody"); end;
function HoldEnd() return HoldNRoll("HoldEnd"); end;
function RollBody() return HoldNRoll("RollBody"); end;
function RollEnd() return HoldNRoll("RollEnd"); end;

function NoteskinColour4Red() return NoteskinColour("4","Red"); end;
function NoteskinColour4Green() return NoteskinColour("4","Green") end;
function NoteskinColour4Blue() return NoteskinColour("4","Blue") end;
function NoteskinColour8Red() return NoteskinColour("8","Red"); end;
function NoteskinColour8Green() return NoteskinColour("8","Green") end;
function NoteskinColour8Blue() return NoteskinColour("8","Blue") end;
function NoteskinColour12Red() return NoteskinColour("12","Red"); end;
function NoteskinColour12Green() return NoteskinColour("12","Green") end;
function NoteskinColour12Blue() return NoteskinColour("12","Blue") end;
function NoteskinColour16Red() return NoteskinColour("16","Red"); end;
function NoteskinColour16Green() return NoteskinColour("16","Green") end;
function NoteskinColour16Blue() return NoteskinColour("16","Blue") end;
function NoteskinColour24Red() return NoteskinColour("24","Red"); end;
function NoteskinColour24Green() return NoteskinColour("24","Green") end;
function NoteskinColour24Blue() return NoteskinColour("24","Blue") end;
function NoteskinColour32Red() return NoteskinColour("32","Red"); end;
function NoteskinColour32Green() return NoteskinColour("32","Green") end;
function NoteskinColour32Blue() return NoteskinColour("32","Blue") end;
function NoteskinColour48Red() return NoteskinColour("48","Red"); end;
function NoteskinColour48Green() return NoteskinColour("48","Green") end;
function NoteskinColour48Blue() return NoteskinColour("48","Blue") end;
function NoteskinColour64Red() return NoteskinColour("64","Red"); end;
function NoteskinColour64Green() return NoteskinColour("64","Green") end;
function NoteskinColour64Blue() return NoteskinColour("64","Blue") end;
function NoteskinColour192Red() return NoteskinColour("192","Red"); end;
function NoteskinColour192Green() return NoteskinColour("192","Green") end;
function NoteskinColour192Blue() return NoteskinColour("192","Blue") end;