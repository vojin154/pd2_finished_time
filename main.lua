if not FinishedTime then
    _G.FinishedTime = _G.FinishedTime or {}
    FinishedTime._path = ModPath
    FinishedTime._save = (SavePath .. "FinishedTime.txt")
    FinishedTime._heists = {}
    FinishedTime._improved_time = false


	function FinishedTime:Load()
		local file = io.open(self._save, "r")

		if file then
			self._heists = json.decode(file:read("*all"))
			file:close()
		end

        self._heists = self._heists or {}
	end

	function FinishedTime:Save()
		local file = io.open(self._save, "w+")

		if file then
			file:write(json.encode(self._heists))
			file:close()
		end
	end

    function FinishedTime:Reset()
        self._heists = {}
        local file = io.open(self._save, "w+")

        if file then
            file:write(json.encode({}))
            file:close()
        end
    end


    function FinishedTime:ResetJobById(id)
        if not id then
            return
        end

        self._heists[id] = nil
        self:Save()
    end


	function FinishedTime:ImproveJobsTime(id, new_time)
		self._heists[id] = new_time
		self._improved_time = true
		self:Save()
	end


	function FinishedTime:GetJobTimeById(id)
		if (not id) then
			return nil
		end

		return self._heists[id]
	end


	local seconds_per_minute = 60
	local seconds_per_hour = (seconds_per_minute * 60)
	-- If that is ever needed :skull:
	local seconds_per_day = (seconds_per_hour * 24)

	local function plural(value, word)
		return (word .. ((value == 1) and "" or "S"))
	end

    function FinishedTime:Convert(job)
        local heist_time = self._heists[job]

		if (not heist_time) then
			return "HAVEN'T FINISHED YET!"
		end


		local seconds = math.floor(heist_time % 60)
		local minutes = math.floor((heist_time / seconds_per_minute) % 60)
		local hours = math.floor((heist_time / seconds_per_hour) % 24)
		local days = math.floor(heist_time / seconds_per_day)


		if (heist_time < seconds_per_minute) then
			return string.format("%d %s", heist_time, plural(heist_time, "SECOND"))
		end

		if (heist_time < seconds_per_hour) then
			return string.format("%02d:%02d %s", minutes, seconds, plural(minutes, "MINUTE"))
		end

		if (heist_time < seconds_per_day) then
			return string.format("%02d:%02d:%02d %s", hours, minutes, seconds, plural(hours, "HOUR"))
		end

		return string.format("%d:%02d:%02d:%02d %s", days, hours, minutes, seconds, plural(days, "DAY"))
    end
end


FinishedTime:Load()


local required = {}
if RequiredScript and (not required[RequiredScript]) then
	local fname = (FinishedTime._path .. RequiredScript:gsub(".+/(.+)", "hooks/%1.lua"))

	if io.file_is_readable(fname) then
		dofile(fname)
	end

	required[RequiredScript] = true
end