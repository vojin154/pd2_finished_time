local created_text = false -- I have no choice :(

Hooks:PostHook(StageEndScreenGui, "select_tab", "select_tab_finishedtime", function(self, selected_item, no_sound)
	if (self._selected_item ~= 2) or (not FinishedTime._improved_time) or (created_text) then
		return
	end


    local panel = self._items[self._selected_item]._panel

	if (not alive(panel)) then
		return
	end

    local ingame_time_panel = panel:child(0)
    local ingame_time_text = ingame_time_panel:child(1)


    local finished_time_panel = ingame_time_panel:text({
        blend_mode = "normal",
		name = "time_improved",
        text = "- TIME IMPROVED!!",
        font_size = tweak_data.menu.pd2_small_font_size,
        font = tweak_data.menu.pd2_small_font,
        color = Color("FF8C00")
    })

    local _, _, w, _ = ingame_time_text:text_rect()
    finished_time_panel:set_world_position((ingame_time_text:world_x() + w + 5), ingame_time_text:world_y())
	created_text = true
end)