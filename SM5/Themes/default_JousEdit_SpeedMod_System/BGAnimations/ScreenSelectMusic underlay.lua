local t = Def.ActorFrame {};

local function Update(self)

	local bpmtime = GAMESTATE:GetCurrentSong():GetTimingData():GetBPMsAndTimes();
	local numbbpms = 0; for _ in pairs(bpmtime) do numbbpms = numbbpms + 1 end;
	
	local Btime = {};
	local Bbpm = {};
	local AverageBPM;
	local bpmt1;
	local bpmt2;
	local bpmt3;
	
	for i=1,#bpmtime do
		_, _, Btime[i], Bbpm[i] = string.find(bpmtime[i], "(%d+%p%d+)=(%d+%p%d+)");	
	end;
	
	for v=1,#bpmtime do
		if numbbpms == 1 then
			AverageBPM = Bbpm[1];				
		elseif Btime[v+2] ~= nil then
			bpmt1 = Btime[v+1] - Btime[v];
			bpmt2 = Btime[v+2] - Btime[v+1];
			if bpmt1 > bpmt2 then
				if bpmt3 == nil then
					AverageBPM = Bbpm[v];
					bpmt3 = bpmt1;
				elseif bpmt1 > bpmt3 then 
					AverageBPM = Bbpm[v];
					bpmt3 = bpmt1;
				end;
			else
				if bpmt3 == nil then
					AverageBPM = Bbpm[v+1];
					bpmt3 = bpmt2;
				elseif bpmt2 > bpmt3 then
					AverageBPM = Bbpm[v+1];
					bpmt3 = bpmt2;
				end;
			end;
		elseif Btime[v+1] ~= nil then
			bpmt1 = Btime[v+1] - Btime[v];
			bpmt2 = GAMESTATE:GetCurrentSong():GetLastSecond() - Btime[v+1];
			if bpmt1 > bpmt2 then
				if bpmt3 == nil then
					AverageBPM = Bbpm[v];
					bpmt3 = bpmt1;
				elseif bpmt1 > bpmt3 then 
					AverageBPM = Bbpm[v];
					bpmt3 = bpmt1;
				end;
			else
				if bpmt3 == nil then
					AverageBPM = Bbpm[v+1];
				elseif bpmt2 > bpmt3 then
					bpmt3 = bpmt2;
					AverageBPM = Bbpm[v+1];
					bpmt3 = bpmt2;
				end;
			end;
		end;
	end;
					
	if GAMESTATE:IsHumanPlayer(PLAYER_1) then
	
		local displayp1 = GetUserPref("SpeedDisplayP1");
		
		local speedp1;
		if GetUserPrefN("SpeedModP1") ~= nil then
			speedp1 = (GetUserPrefN("SpeedModP1")+1)*50;
		else
			speedp1 = 100;
		end;
		
		local optionsp1 = GAMESTATE:GetPlayerState(PLAYER_1):GetPlayerOptionsString("ModsLevel_Preferred");
		if displayp1 == "3" then
			GAMESTATE:GetPlayerState(PLAYER_1):SetPlayerOptions('ModsLevel_Preferred', optionsp1 .. "," .. speedp1/AverageBPM .."x");
		end;
	end;
	if GAMESTATE:IsHumanPlayer(PLAYER_2) then
	
		local displayp2 = GetUserPref("SpeedDisplayP2");
		
		local speedp2;
		if GetUserPrefN("SpeedModP2") ~= nil then
			speedp2 = (GetUserPrefN("SpeedModP2")+1)*50;
		else
			speedp2 = 100;
		end;
		
		local optionsp2 = GAMESTATE:GetPlayerState(PLAYER_2):GetPlayerOptionsString("ModsLevel_Preferred");
		if displayp2 == "3" then
			GAMESTATE:GetPlayerState(PLAYER_2):SetPlayerOptions('ModsLevel_Preferred', optionsp2 .. "," .. speedp2/AverageBPM .."x");
		end;
	end;
end;

t.InitCommand=cmd(SetUpdateFunction,Update);

return t;