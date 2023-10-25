
Hooks:PostHook(StageEndScreenGui, "select_tab", "FinishedTime", function(self, selected_item, no_sound)
    if self._selected_item == 2 then
        local panel = self._items[self._selected_item]._panel
        local ingame_time_panel = panel:child(0)
        local ingame_time_text = ingame_time_panel:child(1)
        
       if FinishedTime.values.time_improved then
            local finished_time_panel = ingame_time_panel:text({
                blend_mode = "normal",
                text = "- TIME IMPROVED!!",
                font_size = tweak_data.menu.pd2_small_font_size,
                font = tweak_data.menu.pd2_small_font,
                color = Color("FF8C00")
            })
            
            local _, _, w, _ = ingame_time_text:text_rect()
            finished_time_panel:set_world_position(ingame_time_text:world_x() + w + 5, ingame_time_text:world_y())
        else
            return self._selected_item
        end
    end
    return self._selected_item
end)