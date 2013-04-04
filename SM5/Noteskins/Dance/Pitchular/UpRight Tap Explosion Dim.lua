local t = Def.ActorFrame {
	LoadActor( "higher.ogg" )..{
		W3Command=cmd(queuecommand,"Play";sleep,0.5;queuecommand,"Stop");
		W2Command=cmd(queuecommand,"Play";sleep,0.5;queuecommand,"Stop");
		W1Command=cmd(queuecommand,"Play";sleep,0.5;queuecommand,"Stop");
		PlayCommand=cmd(play);
		StopCommand=cmd(Pause);
	};
	LoadActor("Tap Explosion Dim.png")..{
		W5Command=NOTESKIN:GetMetricA("GhostArrowDim", "W5Command");
		W4Command=NOTESKIN:GetMetricA("GhostArrowDim", "W4Command");
		W3Command=NOTESKIN:GetMetricA("GhostArrowDim", "W3Command");
		W2Command=NOTESKIN:GetMetricA("GhostArrowDim", "W2Command");
		W1Command=NOTESKIN:GetMetricA("GhostArrowDim", "W1Command");
		HeldCommand=NOTESKIN:GetMetricA("GhostArrowDim", "HeldCommand");
	};
}
return t;