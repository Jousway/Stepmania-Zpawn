local t = Def.ActorFrame {};

local function Update(self)
	if GAMESTATE:IsHumanPlayer(PLAYER_1) then

		local displayp1 = GetUserPref("SpeedDisplayP1");
		
		local speedp1;
		if GetUserPrefN("SpeedModP1") ~= nil then
			speedp1 = (GetUserPrefN("SpeedModP1")+1)*50;
		else
			speedp1 = 100;
		end;
		
		local CXmodp1 = string.format("%0.0f",GAMESTATE:GetPlayerState(PLAYER_1):GetSongPosition():GetCurBPS()*60);
		local optionsp1 = GAMESTATE:GetPlayerState(PLAYER_1):GetPlayerOptionsString("ModsLevel_Preferred");
		if displayp1 == "4" then
			GAMESTATE:GetPlayerState(PLAYER_1):SetPlayerOptions('ModsLevel_Preferred', optionsp1 .. "," .. 750/CXmodp1 .. "x");
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
		
		local CXmodp2 = string.format("%0.0f",GAMESTATE:GetPlayerState(PLAYER_2):GetSongPosition():GetCurBPS()*60);
		local optionsp2 = GAMESTATE:GetPlayerState(PLAYER_2):GetPlayerOptionsString("ModsLevel_Preferred");
		if displayp2 == "4" then
			GAMESTATE:GetPlayerState(PLAYER_2):SetPlayerOptions('ModsLevel_Preferred', optionsp2 .. "," .. 750/CXmodp2 .. "x");
		end;
	end;
end;

t.InitCommand=cmd(SetUpdateFunction,Update);

return t; 