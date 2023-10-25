local function make_fine_text(text)
	local x, y, w, h = text:text_rect()

	text:set_size(w, h)
	text:set_position(math.round(text:x()), math.round(text:y()))
end

Hooks:PostHook(ContractBrokerHeistItem, "init", "FinishedTime", function(self, parent_panel, job_data, idx)
	local padding = 5
	local panel = self._panel
	local contractor = panel:child(3)
	local dlc = panel:child(4)
	--[[local last_icon = icons:child(2)

	if self:is_stealthable() then
		last_icon = icons:child(3)
	end]]

	if dlc:text() == "" then
		padding = 0
	end

	local finished_time = panel:text({
		blend_mode = "normal",
		text = FinishedTime:Convert(job_data.job_id),
		font_size = tweak_data.menu.pd2_small_font_size,
		font = tweak_data.menu.pd2_small_font,
		color = Color("FF8C00")
    })

	make_fine_text(finished_time)
	finished_time:set_position(dlc:right() + padding, contractor:y())

	--local _, _, w, _ = finished_time:text_rect()
	--finished_time:set_world_position(last_icon:world_left() - w - 15, icons:child(1):world_y())
end)