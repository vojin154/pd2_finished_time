
Hooks:PostHook(IngameContractGui, "init", "FinishedTime", function(self, ws, node)
    local panel = self._panel
    local experience = self._experience_title

    local finished_time_panel = panel:text({
		vertical = "top",
		wrap = true,
		align = "left",
		wrap_word = true,
		blend_mode = "add",
		text = "BEST FINISHED TIME: " .. FinishedTime:Convert(managers.job:current_job_id()),
		w = tweak_data.gui.crime_net.contract_gui.text_width,
		font_size = tweak_data.menu.pd2_small_font_size,
		font = tweak_data.menu.pd2_small_font,
		color = Color("FF8C00")
    })

    finished_time_panel:set_position(experience:x() + 10, experience:bottom() + tweak_data.gui.crime_net.contract_gui.padding)
    managers.hud:make_fine_text(finished_time_panel)
end)