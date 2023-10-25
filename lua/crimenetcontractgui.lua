Hooks:PostHook(CrimeNetContractGui, "init", "FinishedTime", function(self, ws, fullscreen_ws, node)
	local job_data = self._node:parameters().menu_component_data
	job_data.job_id = job_data.job_id or "ukrainian_job"

	if job_data.job_id == "safehouse" or job_data.job_id == "chill" or job_data.job_id == "ukrainian_job" then
		return
	end

    local panel = self._contract_panel
	local experience
	local panel_index = 19

	if job_data.one_down == 1 then
		panel_index = panel_index + 1
	end

	if managers.job:is_job_ghostable(job_data.job_id) then
		experience = panel:child(panel_index + 1)
	else
    	experience = panel:child(panel_index)
	end

    local finished_time_panel = panel:text({
		blend_mode = "normal",
		text = "BEST FINISHED TIME: " .. FinishedTime:Convert(job_data.job_id),
		w = tweak_data.gui.crime_net.contract_gui.text_width,
		font_size = tweak_data.menu.pd2_small_font_size,
		font = tweak_data.menu.pd2_small_font,
		color = Color("FF8C00")
    })

    finished_time_panel:set_position(experience:x(), experience:bottom() + tweak_data.gui.crime_net.contract_gui.padding)
    self:make_fine_text(finished_time_panel)
end)