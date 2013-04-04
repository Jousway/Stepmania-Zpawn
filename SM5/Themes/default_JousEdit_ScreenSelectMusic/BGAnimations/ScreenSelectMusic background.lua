return Def.ActorFrame {
	Def.Sprite {
	CurrentSongChangedMessageCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;finishtweening;sleep,0.32;queuecommand,"ModifySongBackground");
	ModifySongBackgroundCommand=function(self)
	
		if GAMESTATE:GetCurrentSong() then
			if GAMESTATE:GetCurrentSong():GetBackgroundPath() then
				self:visible(true);
				self:LoadBackground(GAMESTATE:GetCurrentSong():GetBackgroundPath());
				self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
			else
				self:visible(false);
			end;
		else
			self:visible(false);
		end;
	end;
	
	};

};