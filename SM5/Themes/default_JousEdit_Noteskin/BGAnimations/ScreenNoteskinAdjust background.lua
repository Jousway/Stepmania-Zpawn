local red = math.random(0,100)/100;
local blue = math.random(0,100)/100;
local green = math.random(0,100)/100;

if red > green then
	if red > blue then
		if blue > green then
			green = green/0.5;
		else
			blue = blue/0.5;
		end;
	end;
end;

if green > red then
	if green > blue then
		if blue > red then
			red = red/0.5;
		else
			blue = blue/0.5;
		end;
	end;
end;

if blue > red then
	if blue > green then
		if green > red then
			red = red/0.5;
		else
			green = green/0.5;
		end;
	end;
end;

return Def.ActorFrame {	
	Def.Quad {	
		InitCommand=cmd(stretchto,0,0,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,color(string.format("%f, %f, %f, %f", red, green, blue, "1")));	
	};	
};