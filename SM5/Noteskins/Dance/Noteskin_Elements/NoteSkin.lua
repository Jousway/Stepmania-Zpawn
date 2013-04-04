local ret = ... or {};

ret.RedirTable =
{
	Up = "Down",
	Down = "Down",
	Left = "Down",
	Right = "Down",
	UpLeft = "Down",
	UpRight = "Down",
};

local OldRedir = ret.Redir;
ret.Redir = function(sButton, sElement)
	sButton, sElement = OldRedir(sButton, sElement);
	
	sButton = ret.RedirTable[sButton];

	if not string.find(sElement, "Body") then
	if not string.find(sElement, "Bottomcap") then
		sElement = "Tap Note";
	end
	end
	
	if string.find(sElement, "Body") then
	sElement = "Hold";	
	end
	if string.find(sElement, "Bottomcap") then
	sElement = "Hold";
	end

	return sButton, sElement;
end

local OldFunc = ret.Load;
function ret.Load()
	local t = OldFunc();

	if Var "Element" == "Explosion"	then t.BaseRotationZ = nil; end	
	return t;
end
-- >


ret.PartsToRotate =
{
	["Receptor"] = true,
	["Tap Explosion Bright"] = true,
	["Tap Explosion Dim"] = true,
	["Tap Note"] = true,
	["Tap Fake"] = true,
	["Tap Addition"] = true,
	["Hold Explosion"] = true,
	["Hold Head Active"] = true,
	["Hold Head Inactive"] = true,
	["Roll Explosion"] = true,
	["Roll Head Active"] = true,
	["Roll Head Inactive"] = true,
};
ret.Rotate =
{
	Up = 0,
	Down = 0,
	Left = 0,
	Right = -0,
	UpLeft = 0,
	UpRight = 0,
};

ret.Blank =
{
	["Hold Explosion"] = true,
	["Hold Topcap Active"] = true,
	["Hold Topcap Inactive"] = true,
	["Roll Topcap Active"] = true,
	["Roll Topcap Inactive"] = true,
	["Hold Tail Active"] = true,
	["Hold Tail Inactive"] = true,
	["Roll Tail Active"] = true,
	["Roll Tail Inactive"] = true,
};

return ret;
