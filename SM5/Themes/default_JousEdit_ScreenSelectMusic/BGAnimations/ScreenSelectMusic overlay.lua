--I'ma call it the fuck you people with fucking huge cdtitles script, With Love - Jousway
--Update, Added a BAD NPS system
local t = Def.ActorFrame {
	
	--NPS Calculator/Display
	LoadFont("Common Normal") .. {
		Text="NPS";
		InitCommand=cmd(x,SCREEN_CENTER_X-94;y,SCREEN_CENTER_Y-56;zoom,0.75;diffuse,1,1,1,1;strokecolor,Color("Outline"));
	};
	LoadFont("Common Normal") .. {
		Name="P1NPS";
		InitCommand=cmd(x,SCREEN_CENTER_X-62;y,SCREEN_CENTER_Y-56;zoom,0.75;diffuse,color("#ef403d");strokecolor,Color("Outline"));
	};
	LoadFont("Common Normal") .. {
		Name="P2NPS";
		InitCommand=cmd(y,SCREEN_CENTER_Y-56;zoom,0.75;diffuse,color("#0089cf");strokecolor,Color("Outline"));
	};

	--CDTitle Resizer/Container
	Def.ActorFrame{
		Name="CDTContainer";
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-96;zoomy,0;sleep,0.5;decelerate,0.25;zoomy,1);
		OffCommand=cmd(bouncebegin,0.15;zoomx,0);
		LoadActor(THEME:GetPathG("CDTitle", "Con")) .. {
			InitCommand=cmd(diffuse,Color("Orange"));
		};
		LoadFont("Common Normal") .. {
			Text="Author";
			InitCommand=cmd(zoom,0.7;y,-36;diffuse,1,1,1,1;shadowlength,1); -- strokecolor,Color("Black")
		};
		Def.Sprite {
			Name="CDTitle";
			InitCommand=cmd(y,19);
			--OnCommand=cmd(draworder,106;shadowlength,1;zoom,0.75;diffusealpha,1;zoom,0;bounceend,0.35;zoom,0.75;spin;effectmagnitude,0,180,0);
		};
	};
};

local function Update(self)
	local song = GAMESTATE:GetCurrentSong();
	
	--cdtitle
	local cdtitle = self:GetChild("CDTContainer"):GetChild("CDTitle");
	local height = cdtitle:GetHeight();
	local width = cdtitle:GetWidth();
	
	if song then
		if song:HasCDTitle() then
			cdtitle:visible(true);
			cdtitle:Load(song:GetCDTitlePath());
		else
			cdtitle:visible(false);
		end;
	else
		cdtitle:visible(false);
	end;
	
	if height >= 60 and width >= 80 then
		if height*(80/60) >= width then
		cdtitle:zoom(60/height);
		else
		cdtitle:zoom(80/width);
		end;
	elseif height >= 60 then
		cdtitle:zoom(60/height);
	elseif width >= 80 then
		cdtitle:zoom(80/width);
	else 
		cdtitle:zoom(1);
	end;
	
	--nps
	local P1NPS = self:GetChild("P1NPS");
	local P2NPS = self:GetChild("P2NPS");
		
	if GAMESTATE:IsHumanPlayer(PLAYER_1) then
		if song then
			local ChartLenghtInSec = song:GetStepsSeconds();
			local Getp1Radar = GAMESTATE:GetCurrentSteps(PLAYER_1):GetRadarValues(PLAYER_1);
			local P1Taps = Getp1Radar:GetValue('RadarCategory_TapsAndHolds')+Getp1Radar:GetValue('RadarCategory_Jumps')+Getp1Radar:GetValue('RadarCategory_Hands');
			P1NPS:settext(string.format("%0.0f",P1Taps/ChartLenghtInSec));
		else
			P1NPS:settext("0");
		end;		
		P2NPS:x(SCREEN_CENTER_X-40);
	else
		P2NPS:x(SCREEN_CENTER_X-62);
	end;
	
	if GAMESTATE:IsHumanPlayer(PLAYER_2) then
		if song then
			local ChartLenghtInSec = song:GetStepsSeconds();
			local Getp2Radar = GAMESTATE:GetCurrentSteps(PLAYER_2):GetRadarValues(PLAYER_2);
			local P2Taps = Getp2Radar:GetValue('RadarCategory_TapsAndHolds')+Getp2Radar:GetValue('RadarCategory_Jumps')+Getp2Radar:GetValue('RadarCategory_Hands');
			P2NPS:settext(string.format("%0.0f",P2Taps/ChartLenghtInSec));
		else
			P2NPS:settext("0");
		end;
	end;
end;

t.InitCommand=cmd(SetUpdateFunction,Update);
return t
