local t = Def.ActorFrame {
	Def.Sprite {
		Texture=NOTESKIN:GetPath( '_Center2', 'tap note' );
		Frames = Sprite.LinearFrames( 1, 1 );
	};
	
	Def.Sprite {
		Texture=NOTESKIN:GetPath( '_Center1', 'tap note' );
		InitCommand=cmd(diffuseshift;effectcolor1,color("#FFA500FF");effectcolor2,color("#005AFFFF");effectclock,'beat';effecttiming,1,0,1,0);
		Frames = Sprite.LinearFrames( 1, 1 );
	};
};
return t;
