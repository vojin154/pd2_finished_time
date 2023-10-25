Hooks:PostHook(StatisticsManager, "stop_session", "FinishedTime", function(self, data)
    if data and self:started_session_from_beginning() then
        local job_id = managers.job:current_job_id()
        local time = math.round(self._global.session.sessions.time)

        if data.type == "victory" then
            if FinishedTime.heists[job_id] then
                if time < FinishedTime.heists[job_id] then
                    FinishedTime.heists[job_id] = time
                    FinishedTime.values.time_improved = true
                    FinishedTime:Save()
                end
            else
                FinishedTime.heists[job_id] = time
                FinishedTime.values.time_improved = true
                FinishedTime:Save()
            end
        end
    end
end)