local t = Def.ActorFrame {
	Name="Clock";
	LoadActor("BLACK") .. {
		InitCommand=cmd(y,SCREEN_CENTER_Y;x,SCREEN_CENTER_X);
	};
	LoadActor("Clock 4") .. {
		InitCommand=cmd(y,SCREEN_CENTER_Y;x,SCREEN_CENTER_X);
	};
	LoadActor("Clock 3") .. {
		Name="three";
		InitCommand=cmd(y,SCREEN_CENTER_Y;x,SCREEN_CENTER_X;rotationz,rot3);
	};
	LoadActor("Clock 2") .. {
		Name="two";
		InitCommand=cmd(y,SCREEN_CENTER_Y;x,SCREEN_CENTER_X;rotationz,rot2);
	};
	Def.ActorFrame {
		Name="one";
		InitCommand=cmd(y,SCREEN_CENTER_Y;x,SCREEN_CENTER_X;rotationz,rot1);
		LoadActor("Clock 1") .. {
			Name="zero";
			--InitCommand=cmd(queuecommand,"KawaiiAnimu");
			KawaiiAnimuCommand=cmd(linear,0;addrotationz,-6;linear,1;addrotationz,6;queuecommand,"KawaiiAnimu");
		};
	};
	LoadActor("Clock 0") .. {
		InitCommand=cmd(y,SCREEN_CENTER_Y;x,SCREEN_CENTER_X);
	};
};


local function Update(self)
	local clock = self:GetChild("Clock");

	local AMPMSYS;
	if Hour() >= 12 then AMPMSYS = Hour()-12; --Thanks Daisu !!
	else AMPMSYS = Hour(); end;
	
	local rot1 = self:GetChild("one"):rotationz(Second()*6);
	local rot2 = self:GetChild("two"):rotationz((Minute()*6)+(Second()/10));
	local rot3 = self:GetChild("three"):rotationz((AMPMSYS*30)+(Minute()/2)+(Second()/120));
	
end;

t.InitCommand=cmd(SetUpdateFunction,Update);

return t;
