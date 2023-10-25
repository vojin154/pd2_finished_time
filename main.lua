if not FinishedTime then
    _G.FinishedTime = _G.FinishedTime or {}
    FinishedTime._path = ModPath
    FinishedTime._data_path = SavePath .. "FinishedTime.txt"
    FinishedTime.heists = {}
    FinishedTime.values = {
        time_improved = false
    }

	function FinishedTime:Load()
		local file = io.open(self._data_path, "r")
		if file then
			self.heists = json.decode(file:read("*all"))
			file:close()
		end
        self.heists = self.heists or {}
	end

	function FinishedTime:Save()
		local file = io.open(self._data_path, "w+")
		if file then
			file:write(json.encode(self.heists))
			file:close()
		end
	end

    function FinishedTime:Reset()
        self.heists = {}
        local file = io.open(self._data_path, "w+")
        if file then
            file:write(json.encode({}))
            file:close()
        end
    end

    function FinishedTime:ResetJobById(id)
        if not id then
            return
        end

        self.heists[id] = nil
        self:Save()
    end

    function FinishedTime:GetExisting()
        return self.heists
    end

    function FinishedTime:Convert(job)
        local minutes = 60
        local hours = minutes * 60
        --if that is ever needed :skull:
        local days = hours * 24

        local time

        if self.heists[job] then
            local found_time = self.heists[job]

            local converted_seconds = math.floor(found_time % 60)
            local converted_minutes = math.floor((found_time / 60) % 60)
            local converted_hours = math.floor((found_time / hours) % 24)
            local converted_days = math.floor(found_time / days)

            if found_time < minutes then

                if found_time == 1 then
                    time = found_time .. " SECOND"
                else
                    time = found_time .. " SECONDS"
                end

            elseif found_time >= minutes and found_time < hours then

                if converted_minutes == 1 then
                    time = string.format("%i:%.2i", converted_minutes, converted_seconds) .. " MINUTE"
                else
                    time = string.format("%.2i:%.2i", converted_minutes, converted_seconds) .. " MINUTES"
                end

            elseif found_time >= hours and found_time < days then

                if converted_hours == 1 then
                    time = string.format("%i:%.2i:%.2i", converted_hours, converted_minutes, converted_seconds) .. " HOUR"
                else
                    time = string.format("%.2i:%.2i:%.2i", converted_hours, converted_minutes, converted_seconds) .. " HOURS"
                end

            elseif found_time >= days then

                if converted_days == 1 then
                    time = string.format("%i:%.2i:%.2i:%.2i", converted_days, converted_hours, converted_minutes, converted_seconds) .. " DAY"
                else
                    time = string.format("%.2i:%.2i:%.2i:%.2i", converted_days, converted_hours, converted_minutes, converted_seconds) .. " DAYS"
                end
            else
                return "ERROR"
            end
        else
            time = "HAVEN'T FINISHED YET!"
        end

        return time
    end
end

FinishedTime:Load()

local required = {}
if RequiredScript and not required[RequiredScript] then
	local fname = FinishedTime._path .. RequiredScript:gsub(".+/(.+)", "lua/%1.lua")
	if io.file_is_readable(fname) then
		dofile(fname)
	end

	required[RequiredScript] = true
end