--If a Command has "NOTESKIN:GetMetricA" in it, that means it gets the command from the metrics.ini, else use cmd(); to define command.
--If you dont know how "NOTESKIN:GetMetricA" works here is an explanation.
--NOTESKIN:GetMetricA("The [Group] in the metrics.ini", "The actual Command to fallback on in the metrics.ini");

local num;
local reversed;
local revposs;
local diff;
local psize;
local qsize;
local songinfo;

if GAMESTATE:IsHumanPlayer(PLAYER_1) then
	songinfo = GAMESTATE:GetPlayerState(PLAYER_1):GetPlayerOptionsString("ModsLevel_Preferred");
else
	songinfo = GAMESTATE:GetPlayerState(PLAYER_2):GetPlayerOptionsString("ModsLevel_Preferred");
end

if string.find(songinfo, "Reverse") then
reversed = -1;
revposs = 26;
else
reversed = 1;
revposs = 0;
end;--]]

if GAMESTATE:GetCurrentGame():GetName() == "pump" then 
	psize = 0.75;
	qsize = 48;
	if Var "Button" == "UpLeft" or Var "Button" == "UpRight" then
		num = 1;
		diff = "0.5,0.5,0.6,1";
	else
		num = 2;
		diff = "0.2,0.2,0.3,1";
	end;
elseif GAMESTATE:GetCurrentStyle():GetName() == "single" then 
	psize = 1;
	qsize = 64;
	if Var "Button" == "Left" or Var "Button" == "Right" then
		num = 1;
		diff = "0.5,0.5,0.6,1";
	else
		num = 2;
		diff = "0.2,0.2,0.3,1";
	end;
else
	psize = 1;
	qsize = 64;
	if Var "Button" == "UpLeft" or Var "Button" == "UpRight" then
		num = 1;
		diff = "0.5,0.5,0.6,1";
	else
		num = 2;
		diff = "0.2,0.2,0.3,1";
	end;
end;

local t = Def.ActorFrame {
	Def.Sprite {
		Texture=NOTESKIN:GetPath("_Back", num );
		InitCommand=cmd(zoomy,1000;zoomx,psize);
		PressCommand=cmd(diffuse,1,1,1,1);
	};
	
	Def.Quad{
		InitCommand=cmd(zoomto,qsize,2000;diffuse,1,1,1,0);
		PressCommand=cmd(diffuse,0.8,0.8,1,0.3);
		LiftCommand=cmd(diffuse,1,1,1,0);
	};
	
		Def.Sprite {
		Texture=NOTESKIN:GetPath("_Down2", "Go Receptor" );
		InitCommand=cmd(zoomy,reversed;zoomx,psize);
	};

	Def.Sprite {
		Texture=NOTESKIN:GetPath("_Down1", "Go Receptor" );
		InitCommand=cmd(diffuse,color(diff);y,revposs;zoomx,psize);
		PressCommand=cmd(y,revposs+2);
		LiftCommand=cmd(y,revposs);
	};
};
return t;