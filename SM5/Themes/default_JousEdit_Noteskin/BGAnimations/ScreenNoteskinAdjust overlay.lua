local t = Def.ActorFrame {
	
	-- hold body
	Def.Sprite {
		--Texture=( THEME:GetPathB("_noteskinstuff/hold",holdbody) );
		Name="Hold Body";
		InitCommand=cmd(y,SCREEN_CENTER_Y-64;x,SCREEN_CENTER_X+140);
	};
	
	-- hold bottom
	Def.Sprite {
		--Texture=( THEME:GetPathB("_noteskinstuff/hold",holdend) );
		Name="Hold End";
		InitCommand=cmd(y,SCREEN_CENTER_Y+32;x,SCREEN_CENTER_X+140);
	};
	
	-- roll body
	Def.Sprite {
		--Texture=( THEME:GetPathB("_noteskinstuff/hold",holdbody) );
		Name="Roll Body";
		InitCommand=cmd(y,SCREEN_CENTER_Y-64;x,SCREEN_CENTER_X+220);
	};
	
	-- roll bottom
	Def.Sprite {
		--Texture=( THEME:GetPathB("_noteskinstuff/hold",holdend) );
		Name="Roll End";
		InitCommand=cmd(y,SCREEN_CENTER_Y+32;x,SCREEN_CENTER_X+220);
	};
	
	--noteskin part
	--Def.ActorFrame {
	--	Name="Noteskin Container";
	--	InitCommand=cmd(zoom,slim);
		--for holds
		Def.Sprite {
			--Texture=( THEME:GetPathB("_noteskinstuff/bottom",ntype) );
			Name="Noteskin Bottom1";
			InitCommand=cmd(y,SCREEN_CENTER_Y-128;x,SCREEN_CENTER_X+140);
		};
		
		Def.Sprite {
			Name="Bottom Overlay1";
			InitCommand=cmd(y,SCREEN_CENTER_Y-128;x,SCREEN_CENTER_X+140;fadebottom,1.6);
		};
		
		Def.Sprite {
			--Texture=( THEME:GetPathB("_noteskinstuff/hold",ntype) );
			Name="Noteskin Hold1";
			InitCommand=cmd(y,SCREEN_CENTER_Y-128;x,SCREEN_CENTER_X+140);
		};
	
		--for rolls
		Def.Sprite {
			--Texture=( THEME:GetPathB("_noteskinstuff/bottom",ntype) );
			Name="Noteskin Bottom2";
			InitCommand=cmd(y,SCREEN_CENTER_Y-128;x,SCREEN_CENTER_X+220);
		};
	
		Def.Sprite {
			Name="Bottom Overlay2";
			InitCommand=cmd(y,SCREEN_CENTER_Y-128;x,SCREEN_CENTER_X+220;fadebottom,0.8);
		};
		
		Def.Sprite {
			--Texture=( THEME:GetPathB("_noteskinstuff/hold",ntype) );
			Name="Noteskin Hold2";
			InitCommand=cmd(y,SCREEN_CENTER_Y-128;x,SCREEN_CENTER_X+220);
		};
	--};
};


-- update function to change it actively
local function Update(self)

	local holdbody = self:GetChild("Hold Body");
	local holdend = self:GetChild("Hold End");
	local rollbody = self:GetChild("Roll Body");
	local rollend = self:GetChild("Roll End");
	local ntypeb1 = self:GetChild("Noteskin Bottom1");
	local ntypeo1 = self:GetChild("Bottom Overlay1");
	local ntypeh1 = self:GetChild("Noteskin Hold1");
	local ntypeb2 = self:GetChild("Noteskin Bottom2");
	local ntypeo2 = self:GetChild("Bottom Overlay2");
	local ntypeh2 = self:GetChild("Noteskin Hold2");
		
	if GetUserPrefB("Slimmode") == true then
		ntypeb1:zoomy("0.5");
		ntypeo1:zoomy("0.5");
		ntypeh1:zoomy("0.5");
		ntypeb2:zoomy("0.5");
		ntypeo2:zoomy("0.5");
		ntypeh2:zoomy("0.5");
	else
		ntypeb1:zoomy("1");
		ntypeo1:zoomy("1");
		ntypeh1:zoomy("1");
		ntypeb2:zoomy("1");
		ntypeo2:zoomy("1");
		ntypeh2:zoomy("1");
	end;
	
	if GetUserPrefB("ColourHoldAndRollHeads") == true then
		ntypeo1:diffuse("0","1","0","1");		
		ntypeo2:diffuse("1","0","1","1");
		ntypeb1:diffuse("1","1","0","1");
		ntypeb2:diffuse("0","0","1","1");
	else
		ntypeo1:diffuse("0","0","0","0");
		ntypeo2:diffuse("0","0","0","0");
		ntypeb1:diffuse("1","0","0","1");
		ntypeb2:diffuse("0","0","1","1");
	end;
						
	if GetUserPref("NoteskinType") == "5" then
		ntypeb1:Load( THEME:GetPathB("_noteskinstuff/bottom","part bar") );
		ntypeo1:Load( THEME:GetPathB("_noteskinstuff/bottom","part bar") );
		ntypeh1:Load( THEME:GetPathB("_noteskinstuff/hold","part bar") );
		ntypeb2:Load( THEME:GetPathB("_noteskinstuff/bottom","part bar") );
		ntypeo2:Load( THEME:GetPathB("_noteskinstuff/bottom","part bar") );
		ntypeh2:Load( THEME:GetPathB("_noteskinstuff/hold","part bar") );
		holdbody:zoomx("0.9");
		holdend:zoomx("0.9");
		rollbody:zoomx("0.9");
		rollend:zoomx("0.9");
		if GetUserPrefB("HoldBody") == true then
			if GetUserPrefB("HoldEnd") == true then
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body ITG","itgarrow") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom ITG","Bar") );
			else
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body ITG","itgarrow") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom ITG","Bar") );
			end;
		else
			if GetUserPrefB("HoldEnd") == true then
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body DDR","Bar") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom DDR","Bar") );
			else
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body DDR","Bar") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom DDR","Bar") );
			end;
		end;
		if GetUserPrefB("RollBody") == true then
			if GetUserPrefB("RollEnd") == true then
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body ITG","itgarrow") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom ITG","itgarrow") );
			else
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body ITG","itgarrow") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom ITG","itgarrow") );
			end;
		else
			if GetUserPrefB("RollEnd") == true then
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body DDR","Bar") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom DDR","Bar") );
			else
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body DDR","Bar") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom DDR","Bar") );
			end;
		end;
	elseif GetUserPref("NoteskinType") == "4" then
		ntypeb1:Load( THEME:GetPathB("_noteskinstuff/bottom","part circle") );
		ntypeo1:Load( THEME:GetPathB("_noteskinstuff/bottom","part circle") );
		ntypeh1:Load( THEME:GetPathB("_noteskinstuff/hold","part circle") );
		ntypeb2:Load( THEME:GetPathB("_noteskinstuff/bottom","part circle") );
		ntypeo2:Load( THEME:GetPathB("_noteskinstuff/bottom","part circle") );
		ntypeh2:Load( THEME:GetPathB("_noteskinstuff/hold","part circle") );
		holdbody:zoomx("0.8");
		holdend:zoomx("0.8");
		rollbody:zoomx("0.8");
		rollend:zoomx("0.8");
		if GetUserPrefB("HoldBody") == true then
			if GetUserPrefB("HoldEnd") == true then
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body ITG","itgarrow") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom ITG","Circle") );
			else
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body ITG","itgarrow") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom ITG","Circle") );
			end;
		else
			if GetUserPrefB("HoldEnd") == true then
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body DDR","Circle") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom DDR","Circle") );
			else
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body DDR","Circle") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom DDR","Circle") );
			end;
		end;
		if GetUserPrefB("RollBody") == true then
			if GetUserPrefB("RollEnd") == true then
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body ITG","itgarrow") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom ITG","itgarrow") );
			else
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body ITG","itgarrow") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom ITG","itgarrow") );
			end;
		else
			if GetUserPrefB("RollEnd") == true then
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body DDR","Circle") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom DDR","Circle") );
			else
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body DDR","Circle") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom DDR","Circle") );
			end;
		end;
	elseif GetUserPref("NoteskinType") == "3" then
		ntypeb1:Load( THEME:GetPathB("_noteskinstuff/bottom","part ITGC") );
		ntypeo1:Load( THEME:GetPathB("_noteskinstuff/bottom","part ITGC") );
		ntypeh1:Load( THEME:GetPathB("_noteskinstuff/hold","part ITGC") );
		ntypeb2:Load( THEME:GetPathB("_noteskinstuff/bottom","part ITGC") );
		ntypeo2:Load( THEME:GetPathB("_noteskinstuff/bottom","part ITGC") );
		ntypeh2:Load( THEME:GetPathB("_noteskinstuff/hold","part ITGC") );
		holdbody:zoomx("1");
		holdend:zoomx("1");
		rollbody:zoomx("1");
		rollend:zoomx("1");
		if GetUserPrefB("HoldBody") == true then
			if GetUserPrefB("HoldEnd") == true then
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body ITG","itgarrow") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom ITG","itgarrow1") );
			else
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body ITG","itgarrow") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom ITG","itgarrow2") );
				holdbody:SetAllStateDelays(1.1);
				holdend:SetAllStateDelays(1.1);
			end;
		else
			if GetUserPrefB("HoldEnd") == true then
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body DDR","ddrarrow2") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom DDR","ddrarrow2") );
			else
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body DDR","ddrarrow1") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom DDR","itgarrow") );
				holdbody:SetAllStateDelays(1.1);
				holdend:SetAllStateDelays(1.1);
			end;
		end;
		if GetUserPrefB("RollBody") == true then
			if GetUserPrefB("RollEnd") == true then
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body ITG","itgarrow") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom ITG","itgarrow") );
			else
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body ITG","itgarrow") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom ITG","itgarrow") );
			end;
		else
			if GetUserPrefB("RollEnd") == true then
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body DDR","ddrarrow2") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom DDR","ddrarrow2") );
			else
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body DDR","ddrarrow1") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom DDR","itgarrow") );
				rollbody:SetAllStateDelays(1.1);
				rollend:SetAllStateDelays(1.1);
			end;
		end;
	elseif GetUserPref("NoteskinType") == "2" then
		ntypeb1:Load( THEME:GetPathB("_noteskinstuff/bottom","part ITGM") );
		ntypeo1:Load( THEME:GetPathB("_noteskinstuff/bottom","part ITGM") );
		ntypeh1:Load( THEME:GetPathB("_noteskinstuff/hold","part ITGM") );
		ntypeb2:Load( THEME:GetPathB("_noteskinstuff/bottom","part ITGM") );
		ntypeo2:Load( THEME:GetPathB("_noteskinstuff/bottom","part ITGM") );
		ntypeh2:Load( THEME:GetPathB("_noteskinstuff/hold","part ITGM") );
		holdbody:zoomx("1");
		holdend:zoomx("1");
		rollbody:zoomx("1");
		rollend:zoomx("1");
		if GetUserPrefB("HoldBody") == true then
			if GetUserPrefB("HoldEnd") == true then
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body ITG","itgarrow") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom ITG","itgarrow1") );
			else
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body ITG","itgarrow") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom ITG","itgarrow2") );
				holdbody:SetAllStateDelays(1.1);
				holdend:SetAllStateDelays(1.1);
			end;
		else
			if GetUserPrefB("HoldEnd") == true then
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body DDR","ddrarrow2") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom DDR","ddrarrow2") );
			else
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body DDR","ddrarrow1") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom DDR","itgarrow") );
				holdbody:SetAllStateDelays(1.1);
				holdend:SetAllStateDelays(1.1);
			end;
		end;
		if GetUserPrefB("RollBody") == true then
			if GetUserPrefB("RollEnd") == true then
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body ITG","itgarrow") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom ITG","itgarrow") );
			else
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body ITG","itgarrow") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom ITG","itgarrow") );
			end;
		else
			if GetUserPrefB("RollEnd") == true then
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body DDR","ddrarrow2") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom DDR","ddrarrow2") );
			else
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body DDR","ddrarrow1") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom DDR","itgarrow") );
				rollbody:SetAllStateDelays(1.1);
				rollend:SetAllStateDelays(1.1);
			end;
		end;
	else
		ntypeb1:Load( THEME:GetPathB("_noteskinstuff/bottom","part DDR") );
		ntypeo1:Load( THEME:GetPathB("_noteskinstuff/bottom","part DDR") );
		ntypeh1:Load( THEME:GetPathB("_noteskinstuff/hold","part DDR") );
		ntypeb2:Load( THEME:GetPathB("_noteskinstuff/bottom","part DDR") );
		ntypeo2:Load( THEME:GetPathB("_noteskinstuff/bottom","part DDR") );
		ntypeh2:Load( THEME:GetPathB("_noteskinstuff/hold","part DDR") );
		holdbody:zoomx("1");
		holdend:zoomx("1");
		rollbody:zoomx("1");
		rollend:zoomx("1");
		if GetUserPrefB("HoldBody") == true then
			if GetUserPrefB("HoldEnd") == true then
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body ITG","itgarrow") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom ITG","itgarrow1") );
			else
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body ITG","itgarrow") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom ITG","ddrarrow") );
				holdbody:SetAllStateDelays(1.1);
				holdend:SetAllStateDelays(1.1);
			end;
		else
			if GetUserPrefB("HoldEnd") == true then
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body DDR","ddrarrow2") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom DDR","ddrarrow2") );
			else
				holdbody:Load( THEME:GetPathB("_noteskinstuff/hold/body DDR","ddrarrow3") );
				holdend:Load( THEME:GetPathB("_noteskinstuff/hold/bottom DDR","ddrarrow1") );
				holdbody:SetAllStateDelays(1.1);
				holdend:SetAllStateDelays(1.1);
			end;
		end;
		if GetUserPrefB("RollBody") == true then
			if GetUserPrefB("RollEnd") == true then
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body ITG","itgarrow") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom ITG","itgarrow") );
			else
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body ITG","itgarrow") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom ITG","itgarrow") );
			end;
		else
		if GetUserPrefB("RollEnd") == true then
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body DDR","ddrarrow2") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom DDR","ddrarrow2") );
			else
				rollbody:Load( THEME:GetPathB("_noteskinstuff/roll/body DDR","ddrarrow3") );
				rollend:Load( THEME:GetPathB("_noteskinstuff/roll/bottom DDR","ddrarrow1") );
				rollbody:SetAllStateDelays(1.1);
				rollend:SetAllStateDelays(1.1);
			end;
		end;
	end;	
	
end;

t.InitCommand=cmd(SetUpdateFunction,Update);

return t;