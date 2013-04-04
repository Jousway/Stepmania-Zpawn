local revposs;
local songinfo;
local psize;

if GAMESTATE:IsHumanPlayer(PLAYER_1) then
	songinfo = GAMESTATE:GetPlayerState(PLAYER_1):GetPlayerOptionsString("ModsLevel_Preferred");
else
	songinfo = GAMESTATE:GetPlayerState(PLAYER_2):GetPlayerOptionsString("ModsLevel_Preferred");
end

if GAMESTATE:GetCurrentGame():GetName() == "pump" then 
psize = 0.75; 
else
psize = 1;
end;

if string.find(songinfo, "Reverse") then
revposs = -16;
else
revposs = 16;
end;

local t = Def.ActorFrame {
	Def.Sprite {
		Texture=NOTESKIN:GetPath( '_Down', 'Explosion' );
		InitCommand=cmd(y,revposs;zoomx,psize);
		W5Command=NOTESKIN:GetMetricA("GhostArrowBright", "W5Command");
		W4Command=NOTESKIN:GetMetricA("GhostArrowBright", "W4Command");
		W3Command=NOTESKIN:GetMetricA("GhostArrowBright", "W3Command");
		W2Command=NOTESKIN:GetMetricA("GhostArrowBright", "W2Command");
		W1Command=NOTESKIN:GetMetricA("GhostArrowBright", "W1Command");
		HeldCommand=NOTESKIN:GetMetricA("GhostArrowBright", "HeldCommand");
		Frames = Sprite.LinearFrames( 1, 1 );
	};
};
return t;
