--V3
return Def.ActorFrame {
	
	--No Background Image
	Def.ActorFrame {
		LoadActor(THEME:GetPathB("ScreenWithMenuElements","background/Default"));
		LoadFont("Common Normal") .. {
			OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,4;diffuse,1,1,1,1;strokecolor,Color("Black"));
			CurrentSongChangedMessageCommand=function(self)
				if GAMESTATE:GetCurrentSong() then
					if GAMESTATE:GetCurrentSong():GetBackgroundPath() then
						self:settext("");
					else
						self:settext("No Background");
					end;
				else
					self:settext("");
				end;
			end;
		};
	};
	
	--Load Song Background
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