local t = Def.ActorFrame {
	-- colour Bar and circle parts 
	LoadActor( THEME:GetPathB("","_Themestuff/red.png") ) .. {
		InitCommand=cmd(zoom,0.5;y,SCREEN_CENTER_Y-118;x,SCREEN_CENTER_X);
	};
	LoadActor( THEME:GetPathB("","_Themestuff/green.png") ) .. {
		InitCommand=cmd(zoom,0.5;y,SCREEN_CENTER_Y-60;x,SCREEN_CENTER_X);
	};
	LoadActor( THEME:GetPathB("","_Themestuff/blue.png") ) .. {
		InitCommand=cmd(zoom,0.5;y,SCREEN_CENTER_Y-2;x,SCREEN_CENTER_X);
	};
	LoadActor( THEME:GetPathB("","_Themestuff/dark.png") ) .. {
		InitCommand=cmd(zoom,0.5;y,SCREEN_CENTER_Y+100;x,SCREEN_CENTER_X+180);
	};
	LoadActor( THEME:GetPathB("","_Themestuff/light.png") ) .. {
		Name="light";
		InitCommand=cmd(zoom,0.5;y,SCREEN_CENTER_Y+100;x,SCREEN_CENTER_X+180;diffuse,diffuselight);
	};
	
	-- colour selectors
	LoadActor( THEME:GetPathB("","_Themestuff/Selector.png") ) .. {
		Name="pos1";
		InitCommand=cmd(zoom,0.5;y,SCREEN_CENTER_Y-118;x,posred);
	};
	LoadActor( THEME:GetPathB("","_Themestuff/Selector.png") ) .. {
		Name="pos2";
		InitCommand=cmd(zoom,0.5;y,SCREEN_CENTER_Y-60;x,posgreen);
	};
	LoadActor( THEME:GetPathB("","_Themestuff/Selector.png") ) .. {
		Name="pos3";
		InitCommand=cmd(zoom,0.5;y,SCREEN_CENTER_Y-2;x,posblue);
	};
	LoadActor( THEME:GetPathB("","_Themestuff/Select round.png") ) .. {
		Name="circle";
		InitCommand=cmd(zoom,0.5;y,poscircleY;x,poscircleX);
	};
};
	

-- update function to change it actively
local function Update(self)
	local red = GetUserPrefN("ThemeColourRed")*10/256;
	local green = GetUserPrefN("ThemeColourGreen")*10/256;
	local blue = GetUserPrefN("ThemeColourBlue")*10/256;
	
	local posred = self:GetChild("pos1"):x((SCREEN_CENTER_X-124)+string.format("%f",red)*250);
	local posgreen = self:GetChild("pos2"):x((SCREEN_CENTER_X-124)+string.format("%f",green)*250);
	local posblue = self:GetChild("pos3"):x((SCREEN_CENTER_X-124)+string.format("%f",blue)*250);
	
	if red > green and red > blue then
		local diffuselight = self:GetChild("light"):diffuse(color(string.format("%f, %f, %f, %f", "1", "1", "1", red)));
	elseif green > red and green > blue then
		local diffuselight = self:GetChild("light"):diffuse(color(string.format("%f, %f, %f, %f", "1", "1", "1", green)));
	elseif blue > red and blue > green then
		local diffuselight = self:GetChild("light"):diffuse(color(string.format("%f, %f, %f, %f", "1", "1", "1", blue)));
	elseif blue == red and blue == green then
		local diffuselight = self:GetChild("light"):diffuse(color(string.format("%f, %f, %f, %f", "1", "1", "1", blue)));
	end;
	
	local poscircleY = self:GetChild("circle"):y((SCREEN_CENTER_Y+100)-(string.format("%f",red)*62)+(string.format("%f",green)*32)+(string.format("%f",blue)*32));
	local poscircleX = self:GetChild("circle"):x((SCREEN_CENTER_X+180)-(string.format("%f",green)*54)+(string.format("%f",blue)*54));
	
end;

t.InitCommand=cmd(SetUpdateFunction,Update);

return t;