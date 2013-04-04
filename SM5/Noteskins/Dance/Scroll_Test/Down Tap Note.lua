local t = Def.ActorFrame {
	Def.ActorFrame {
	InitCommand=cmd(rotationz,180);
	Def.ActorFrame {
		InitCommand=cmd(x,14;y,-14;rotationz,-70);
		Def.Sprite {
			Texture=("scroller");
			InitCommand=cmd(zoomy,0.5;effectclock,"beat";stretchtexcoords,8,48;texcoordvelocity,0,1);
		};
	};
	Def.ActorFrame {
		InitCommand=cmd(x,-14;y,-14;rotationz,70);
		Def.Sprite {
			Texture=("scroller");
			InitCommand=cmd(zoomy,0.5;effectclock,"beat";stretchtexcoords,8,48;texcoordvelocity,0,1);
		};
	};
	Def.Sprite {
		Texture=("scroller");
		InitCommand=cmd(effectclock,"beat";stretchtexcoords,8,48;texcoordvelocity,0,1);
	};
	LoadActor("outside.png")..{};
	};
};

return t;