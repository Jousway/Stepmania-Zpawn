-- Need to write amod system using timing data, use c550 for now - Jousway

local t = Def.ActorFrame {
	LoadFont("Common Normal") .. {
		Name="SpeedModP1";
		InitCommand=cmd(zoom,0.5;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-173,diffuse,0,0,0,1;strokecolor,Color("Black"));
	};
	LoadFont("Common Normal") .. {
		Name="SpeedModP2";
		InitCommand=cmd(zoom,0.5;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-173,diffuse,0,0,0,1;strokecolor,Color("Black"));
	};
};

local function Update(self)
	local speedmodp1 = self:GetChild("SpeedModP1");
	local speedmodp2 = self:GetChild("SpeedModP2");
	
	local speedp1 = (GetUserPrefN("SpeedModP1")+1)*50;
	local speedp2 = (GetUserPrefN("SpeedModP2")+1)*50;
	local displayp1 = GetUserPref("SpeedDisplayP1");
	local displayp2 = GetUserPref("SpeedDisplayP2");
	
	if GAMESTATE:GetNumPlayersEnabled() == 2 then
		speedmodp1:x(SCREEN_CENTER_X-100);
		speedmodp2:x(SCREEN_CENTER_X+100);
	end;
	
	if GAMESTATE:IsHumanPlayer(PLAYER_1) then
		if displayp1 == "1" then
			speedmodp1:settext( "Actual SpeedMod: C" .. speedp1 );
			GAMESTATE:GetPlayerState(PLAYER_1):SetPlayerOptions('ModsLevel_Preferred', "C" .. speedp1);
		elseif displayp1 == "2" then
			speedmodp1:settext( "Actual SpeedMod: " .. speedp1/100 .. "x" );
			GAMESTATE:GetPlayerState(PLAYER_1):SetPlayerOptions('ModsLevel_Preferred', speedp1/100 .. "x");
		elseif displayp1 == "3" then
			speedmodp1:settext( "Actual SpeedMod: A" .. speedp1 );
			GAMESTATE:GetPlayerState(PLAYER_1):SetPlayerOptions('ModsLevel_Preferred', "C550"); -- c550 for now as fallback because amod nonexistent
		else
			speedmodp1:settext( "Actual SpeedMod: M" .. speedp1 );
			GAMESTATE:GetPlayerState(PLAYER_1):SetPlayerOptions('ModsLevel_Preferred', "M" .. speedp1);
		end;
	end;
	if GAMESTATE:IsHumanPlayer(PLAYER_2) then
		if displayp2 == "1" then
			speedmodp2:settext( "Actual SpeedMod: C" .. speedp2 );
			GAMESTATE:GetPlayerState(PLAYER_2):SetPlayerOptions('ModsLevel_Preferred', "C" .. speedp2);
		elseif displayp2 == "2" then
			speedmodp2:settext( "Actual SpeedMod: " .. speedp2/100 .. "x" );
			GAMESTATE:GetPlayerState(PLAYER_2):SetPlayerOptions('ModsLevel_Preferred', speedp2/100 .. "x");
		elseif displayp2 == "3" then
			speedmodp2:settext( "Actual SpeedMod: A" .. speedp2 );
			GAMESTATE:GetPlayerState(PLAYER_2):SetPlayerOptions('ModsLevel_Preferred', "C550"); -- c550 for now as fallback because amod nonexistent
		else
			speedmodp2:settext( "Actual SpeedMod: M" .. speedp2 );
			GAMESTATE:GetPlayerState(PLAYER_2):SetPlayerOptions('ModsLevel_Preferred', "M" .. speedp2);
		end;
	end;
end;

t.InitCommand=cmd(SetUpdateFunction,Update);

return t;