function AverageBPM()
	local bpmtime = GAMESTATE:GetCurrentSong():GetTimingData():GetBPMsAndTimes();
	local numbbpms = 0; for _ in pairs(bpmtime) do numbbpms = numbbpms + 1 end;
	
	local Btime = {};
	local Bbpm = {};
	local AverageBPM;
	local bpmt1;
	local bpmt2;
	local bpmt3;
	
	for i=1,#bpmtime do
		_, _, Btime[i], Bbpm[i] = string.find(bpmtime[i], "(%d+%p%d+)=(%d+%p%d+)");	
	end;
	
	for v=1,#bpmtime do
		if numbbpms == 1 then
			AverageBPM = Bbpm[1];				
		elseif Btime[v+2] ~= nil then
			bpmt1 = Btime[v+1] - Btime[v];
			bpmt2 = Btime[v+2] - Btime[v+1];
			if bpmt1 > bpmt2 then
				if bpmt3 == nil then
					AverageBPM = Bbpm[v];
					bpmt3 = bpmt1;
				elseif bpmt1 > bpmt3 then 
					AverageBPM = Bbpm[v];
					bpmt3 = bpmt1;
				end;
			else
				if bpmt3 == nil then
					AverageBPM = Bbpm[v+1];
					bpmt3 = bpmt2;
				elseif bpmt2 > bpmt3 then
					AverageBPM = Bbpm[v+1];
					bpmt3 = bpmt2;
				end;
			end;
		elseif Btime[v+1] ~= nil then
			bpmt1 = Btime[v+1] - Btime[v];
			bpmt2 = GAMESTATE:GetCurrentSong():GetLastSecond() - Btime[v+1];
			if bpmt1 > bpmt2 then
				if bpmt3 == nil then
					AverageBPM = Bbpm[v];
					bpmt3 = bpmt1;
				elseif bpmt1 > bpmt3 then 
					AverageBPM = Bbpm[v];
					bpmt3 = bpmt1;
				end;
			else
				if bpmt3 == nil then
					AverageBPM = Bbpm[v+1];
				elseif bpmt2 > bpmt3 then
					bpmt3 = bpmt2;
					AverageBPM = Bbpm[v+1];
					bpmt3 = bpmt2;
				end;
			end;
		end;
	end;
	return AverageBPM;
end;