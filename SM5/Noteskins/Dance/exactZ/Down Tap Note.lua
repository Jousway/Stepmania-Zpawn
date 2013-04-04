local colour1;
local colour2;

if GAMESTATE:GetCurrentStyle():GetName() == "single" then 
	if Var "Button" == "Left" or Var "Button" == "Right" then
		colour1 = "#00FF00FF";
		colour2 = "#FF00FFFF";
	else
		colour1 = "#FFA500FF";
		colour2 = "#005AFFFF";
	end;
else
	colour1 = "#FFA500FF";
	colour2 = "#005AFFFF";
end;

local t = Def.ActorFrame {
	Def.Sprite {
		Texture=NOTESKIN:GetPath( '_Down2', 'tap note' );
		Frames = Sprite.LinearFrames( 1, 1 );
	};
	Def.Sprite {
		Texture=NOTESKIN:GetPath( '_Down1', 'tap note' );
		InitCommand=cmd(diffuseshift;effectcolor1,color(colour1);effectcolor2,color(colour2);effectclock,'beat';effecttiming,1,0,1,0);
		Frames = Sprite.LinearFrames( 1, 1 );
	};
};
return t;
