local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
  FOV=90;
  Name="Container";
  InitCommand=cmd(Center);
	Def.Quad {
		InitCommand=cmd(scaletoclipped,SCREEN_WIDTH,SCREEN_HEIGHT);
	};
	Def.ActorFrame {
		InitCommand=cmd(hide_if,hideFancyElements;);
		LoadActor("_checkerboard") .. {
			InitCommand=cmd(rotationy,0;rotationz,0;rotationx,-90/4*3.5;zoomto,SCREEN_WIDTH*2,SCREEN_HEIGHT*2;customtexturerect,0,0,SCREEN_WIDTH*4/256,SCREEN_HEIGHT*4/256);
			OnCommand=cmd(texcoordvelocity,0,0.5;diffusealpha,0.5;fadetop,1);
		};
	};
	LoadActor("_particleLoader") .. {
		InitCommand=cmd(x,-SCREEN_CENTER_X;y,-SCREEN_CENTER_Y;hide_if,hideFancyElements;);
	};	
};

local function Update(self)
	local red = GetUserPrefN("ThemeColourRed")*10/256;
	local green = GetUserPrefN("ThemeColourGreen")*10/256;
	local blue = GetUserPrefN("ThemeColourBlue")*10/256;
	
	self:GetChild("Container"):diffuse(color(string.format("%f, %f, %f, %f", red, green, blue, "1")));

end;

t.InitCommand=cmd(SetUpdateFunction,Update);

return t;
