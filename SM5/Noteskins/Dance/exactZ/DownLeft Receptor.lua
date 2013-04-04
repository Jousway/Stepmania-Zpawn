--If a Command has "NOTESKIN:GetMetricA" in it, that means it gets the command from the metrics.ini, else use cmd(); to define command.
--If you dont know how "NOTESKIN:GetMetricA" works here is an explanation.
--NOTESKIN:GetMetricA("The [Group] in the metrics.ini", "The actual Command to fallback on in the metrics.ini");

local herpderp;
local num;
local psize;

if GAMESTATE:GetCurrentGame():GetName() == "pump" then 
	if Var "Button" == "UpLeft" then
		herpderp = -90;
		num = 1;
		psize = 0.75;
	elseif Var "Button" == "UpRight" then
		herpderp = -180;
		num = 1;
		psize = 0.75;
	elseif Var "Button" == "DownRight" then
		herpderp = 90;
		num = 2;	
		psize = 0.75;
	else
		herpderp = 0;
		num = 2;
		psize = 0.75;
	end;
elseif Var "Button" == "UpRight" then
	herpderp = 0;
	num = 1;	
	psize = 1;
else
	herpderp = 90;
	num = 1;
	psize = 1;
end;

local t = Def.ActorFrame {
	Def.Sprite {
		Texture=NOTESKIN:GetPath("_Back", num );
		InitCommand=cmd(rotationz,herpderp;zoomy,1000;zoomx,psize);
	};
	
	Def.Sprite {
		Texture=NOTESKIN:GetPath("_DownLeft", "Go Receptor" );
		InitCommand=cmd(effectclock,"beat");
		NoneCommand=NOTESKIN:GetMetricA("ReceptorArrow", "NoneCommand");
		PressCommand=NOTESKIN:GetMetricA("ReceptorArrow", "PressCommand");
		LiftCommand=NOTESKIN:GetMetricA("ReceptorArrow", "LiftCommand");
		W5Command=NOTESKIN:GetMetricA("ReceptorArrow", "W5Command");
		W4Command=NOTESKIN:GetMetricA("ReceptorArrow", "W4Command");
		W3Command=NOTESKIN:GetMetricA("ReceptorArrow", "W3Command");
		W2Command=NOTESKIN:GetMetricA("ReceptorArrow", "W2Command");
		W1Command=NOTESKIN:GetMetricA("ReceptorArrow", "W1Command");
	};
};
return t;