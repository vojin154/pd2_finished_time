Hooks:PostHook(StatisticsManager, "stop_session", "stop_session_finishedtime", function(self, data)
    if (not data) or (data.type ~= "victory") or (not self:started_session_from_beginning()) then
		return
	end


	local job_id = managers.job:current_job_id()
    local time = math.round(self._global.session.sessions.time)
	local saved_job_time = FinishedTime:GetJobTimeById(job_id)

	if (not saved_job_time) or (time < saved_job_time) then
		FinishedTime:ImproveJobsTime(job_id, time)
	end
end)