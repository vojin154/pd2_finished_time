Hooks:Add("MenuManagerBuildCustomMenus", "FinishedTime", function(menu_manager, nodes)

    local main_menu_id = "FinishedTime"

    MenuHelper:NewMenu(main_menu_id)

    MenuCallbackHandler.ft_reset = function(self, item)
        FinishedTime:Reset()
    end

    local priority = (#FinishedTime:GetExisting() * 2) + 1 -- + 1 bcs of reset all, times 2 to account for dividers

    for i, _ in pairs(FinishedTime:GetExisting()) do
        MenuCallbackHandler["ft_" .. i .. "_reset"] = function(self, item)
            nodes[main_menu_id]._items[1] = nil
            Utils.PrintTable(item._parameters)
            --FinishedTime:ResetJobById(i)
            MenuCallbackHandler["ft_" .. i .. "_reset"] = nil
        end

        MenuHelper:AddButton({
            id = "reset_" .. i,
            title = managers.localization:to_upper_text("heist_" .. i),
            desc = "reset",
            callback = "ft_" .. i .. "_reset",
            menu_id = main_menu_id,
            priority = priority,
            localized = false
        })

        priority = priority - 1

        MenuHelper:AddDivider({
            id = "divider_" .. i,
            size = 4,
            menu_id = main_menu_id,
            priority = priority,
        })

        priority = priority - 1
    end

    MenuHelper:AddDivider({
        id = "divider_reset",
        size = 10,
        menu_id = main_menu_id,
        priority = priority,
    })

    priority = priority - 1

    MenuHelper:AddButton({
        id = "reset_all_times",
        title = "reset",
        desc = "reset",
        callback = "ft_reset",
        menu_id = main_menu_id,
        priority = priority,
        localized = false
    })

    nodes[main_menu_id] = MenuHelper:BuildMenu(main_menu_id, { area_bg = "none" })
    MenuHelper:AddMenuItem(nodes["blt_options"], main_menu_id, "idk", "welp")

    Utils.PrintTable(nodes[main_menu_id]._items)
    Utils.PrintTable(nodes[main_menu_id])

    --[[
    local sub_reminder_menu_id = "OHKO_REMINDER"
    local sub_custom_menu_id = "OHKO_CUSTOM"

    MenuHelper:NewMenu(main_menu_id)
    MenuHelper:NewMenu(sub_reminder_menu_id)
    MenuHelper:NewMenu(sub_custom_menu_id)

    MenuCallbackHandler.callback_ohko_toggle = function(self, item)
        OhkoMenuSettings.settings.enabled = (item:value() == "on" and true or false)
        if alive(OhkoMenuSettings.menu_text) then
            OhkoMenuSettings.menu_text:set_visible(OhkoMenuSettings.settings.enabled and OhkoMenuSettings.settings.reminder)
        end
        OhkoMenuSettings:Save()
        log("[OHKO] [UPDATE] OHKO Toggle is: " .. item:value())
    end

    MenuCallbackHandler.callback_ohko_reminder = function(self, item)
        OhkoMenuSettings.settings.reminder = (item:value() == "on" and true or false)
        if alive(OhkoMenuSettings.menu_text) then
            OhkoMenuSettings.menu_text:set_visible(OhkoMenuSettings.settings.enabled and OhkoMenuSettings.settings.reminder)
        end
        OhkoMenuSettings:Save()
        log("[OHKO] [UPDATE] Reminder Toggle is: " .. item:value())
    end
    
    MenuCallbackHandler.callback_ohko_reminder_colour_r = function(self, item)
        OhkoMenuSettings.settings.reminder_r_value = item:value()
        if alive(OhkoMenuSettings.menu_text) then
            OhkoMenuSettings.menu_text:set_color(Color(OhkoMenuSettings.settings.reminder_r_value, OhkoMenuSettings.settings.reminder_g_value, OhkoMenuSettings.settings.reminder_b_value))
        end
        if alive(OhkoMenuSettings.MenuReadyText) then
            OhkoMenuSettings.MenuReadyText:set_color(Color(OhkoMenuSettings.settings.reminder_r_value, OhkoMenuSettings.settings.reminder_g_value, OhkoMenuSettings.settings.reminder_b_value))
        end
        OhkoMenuSettings:Save()
        log("[OHKO] [UPDATE] Slider Red value: " .. item:value())
    end

    MenuCallbackHandler.callback_ohko_reminder_colour_g = function(self, item)
        OhkoMenuSettings.settings.reminder_g_value = item:value()
        if alive(OhkoMenuSettings.menu_text) then
            OhkoMenuSettings.menu_text:set_color(Color(OhkoMenuSettings.settings.reminder_r_value, OhkoMenuSettings.settings.reminder_g_value, OhkoMenuSettings.settings.reminder_b_value))
        end
        if alive(OhkoMenuSettings.MenuReadyText) then
            OhkoMenuSettings.MenuReadyText:set_color(Color(OhkoMenuSettings.settings.reminder_r_value, OhkoMenuSettings.settings.reminder_g_value, OhkoMenuSettings.settings.reminder_b_value))
        end
        OhkoMenuSettings:Save()
        log("[OHKO] [UPDATE] Slider Green value: " .. item:value())
    end

    MenuCallbackHandler.callback_ohko_reminder_colour_b = function(self, item)
        OhkoMenuSettings.settings.reminder_b_value = item:value()
        if alive(OhkoMenuSettings.menu_text) then
            OhkoMenuSettings.menu_text:set_color(Color(OhkoMenuSettings.settings.reminder_r_value, OhkoMenuSettings.settings.reminder_g_value, OhkoMenuSettings.settings.reminder_b_value))
        end
        if alive(OhkoMenuSettings.MenuReadyText) then
            OhkoMenuSettings.MenuReadyText:set_color(Color(OhkoMenuSettings.settings.reminder_r_value, OhkoMenuSettings.settings.reminder_g_value, OhkoMenuSettings.settings.reminder_b_value))
        end
        OhkoMenuSettings:Save()
        log("[OHKO] [UPDATE] Slider Blue value: " .. item:value())
    end

    MenuCallbackHandler.callback_ohko_reminder_alpha = function(self, item)
        OhkoMenuSettings.settings.alpha_value = item:value()
        if alive(OhkoMenuSettings.menu_text) then
            OhkoMenuSettings.menu_text:set_alpha(OhkoMenuSettings.settings.alpha_value)
        end
        if alive(OhkoMenuSettings.MenuReadyText) then
            OhkoMenuSettings.MenuReadyText:set_alpha(OhkoMenuSettings.settings.alpha_value)
        end
        OhkoMenuSettings:Save()
        log("[OHKO] [UPDATE] Slider Alpha value: " .. item:value())
    end

    MenuCallbackHandler.callback_ohko_instant_custody_toggle = function(self, item)
        OhkoMenuSettings.settings.instant_custody = (item:value() == "on" and true or false)
        OhkoMenuSettings:Save()
        log("[OHKO] [UPDATE] Instant Custody is: " .. item:value())
    end

    MenuCallbackHandler.callback_ohko_reminder_colour_alpha_reset = function(self, item)

        log("[OHKO] [RESET] Pressed Colour And Alpha Reset Button")

        MenuHelper:ResetItemsToDefaultValue(item, {["ohko_reminder_r"] = true}, 0.21)
        MenuHelper:ResetItemsToDefaultValue(item, {["ohko_reminder_g"] = true}, 0.74)
        MenuHelper:ResetItemsToDefaultValue(item, {["ohko_reminder_b"] = true}, 0.47)
        MenuHelper:ResetItemsToDefaultValue(item, {["ohko_reminder_alpha"] = true}, 0.9)

        OhkoMenuSettings:Save()
        
        log("[OHKO] [SAVED] Reminder red value is: " .. tostring(OhkoMenuSettings.settings.reminder_r_value))
        log("[OHKO] [SAVED] Reminder green value is: " .. tostring(OhkoMenuSettings.settings.reminder_g_value))
        log("[OHKO] [SAVED] Reminder blue value is: " .. tostring(OhkoMenuSettings.settings.reminder_b_value))
        log("[OHKO] [SAVED] Reminder alpha value is: " .. tostring(OhkoMenuSettings.settings.alpha_value))
    end


    MenuHelper:AddToggle({
        id = "ohko_toggle",
        title = "ohko_enabled",
        desc = "ohko_enabled_desc",
        callback = "callback_ohko_toggle",
        value = OhkoMenuSettings.settings.enabled,
        menu_id = main_menu_id,
        priority = 10,
    })

    MenuHelper:AddDivider({
        id = "ohko_diving_sub",
        size = 16,
        menu_id = main_menu_id,
        priority = 9
    })

    MenuHelper:AddButton({
        id = "ohko_custom_menu",
        title = "ohko_custom",
        desc = "ohko_custom_desc",
        menu_id = main_menu_id,
        next_node = sub_custom_menu_id,
        priority = 8
    })

    MenuHelper:AddButton({
        id = "ohko_reminder_menu",
        title = "ohko_sub_reminder",
        desc = "ohko_sub_reminder_desc",
        menu_id = main_menu_id,
        next_node = sub_reminder_menu_id,
        priority = 7
    })

    MenuHelper:AddToggle({
        id = "ohko_instant_custody_toggle",
        title = "ohko_instant_custody",
        callback = "callback_ohko_instant_custody_toggle",
        value = OhkoMenuSettings.settings.instant_custody,
        menu_id = sub_custom_menu_id,
        priority = 10
    })

    MenuHelper:AddToggle({
        id = "ohko_reminder_toggle",
        title = "ohko_reminder",
        desc = "ohko_reminder_desc",
        callback = "callback_ohko_reminder",
        value = OhkoMenuSettings.settings.reminder,
        menu_id = sub_reminder_menu_id,
        priority = 11
    })

    MenuHelper:AddDivider({
        id = "ohko_reminder_toggle_divider",
        size = 16,
        menu_id = sub_reminder_menu_id,
        priority = 10
    })

    MenuHelper:AddSlider({
        id = "ohko_reminder_r",
        title = "ohko_reminder_colour_r",
        callback = "callback_ohko_reminder_colour_r",
        value = OhkoMenuSettings.settings.reminder_r_value,
        min = 0,
        max = 1,
        step = 0.1,
        show_value = true,
        menu_id = sub_reminder_menu_id,
        priority = 9
    })

    MenuHelper:AddDivider({
        id = "ohko_reminder_r_divider",
        size = 0.5,
        menu_id = sub_reminder_menu_id,
        priority = 8
    })

    MenuHelper:AddSlider({
        id = "ohko_reminder_g",
        title = "ohko_reminder_colour_g",
        callback = "callback_ohko_reminder_colour_g",
        value = OhkoMenuSettings.settings.reminder_g_value,
        min = 0,
        max = 1,
        step = 0.1,
        show_value = true,
        menu_id = sub_reminder_menu_id,
        priority = 7
    })

    MenuHelper:AddDivider({
        id = "ohko_reminder_g_divider",
        size = 0.5,
        menu_id = sub_reminder_menu_id,
        priority = 6
    })

    MenuHelper:AddSlider({
        id = "ohko_reminder_b",
        title = "ohko_reminder_colour_b",
        callback = "callback_ohko_reminder_colour_b",
        value = OhkoMenuSettings.settings.reminder_b_value,
        min = 0,
        max = 1,
        step = 0.1,
        show_value = true,
        menu_id = sub_reminder_menu_id,
        priority = 5
    })

    MenuHelper:AddDivider({
        id = "ohko_reminder_b_divider",
        size = 16,
        menu_id = sub_reminder_menu_id,
        priority = 4
    })

    MenuHelper:AddSlider({
        id = "ohko_reminder_alpha",
        title = "ohko_reminder_alpha",
        callback = "callback_ohko_reminder_alpha",
        value = OhkoMenuSettings.settings.alpha_value,
        min = 0.1,
        max = 1,
        step = 0.1,
        show_value = true,
        menu_id = sub_reminder_menu_id,
        priority = 3
    })

    MenuHelper:AddDivider({
        id = "ohko_reminder_alpha_divider",
        size = 16,
        menu_id = sub_reminder_menu_id,
        priority = 2
    })

    MenuHelper:AddButton({
        id = "ohko_reminder_colour_alpha_reset",
        title = "ohko_reminder_colour_alpha_reset",
        callback = "callback_ohko_reminder_colour_alpha_reset",
        menu_id = sub_reminder_menu_id,
        priority = 1
    })

    MenuCallbackHandler.OhkoMenuFocus = function(node, focus)
		if focus then
		    OhkoMenuSettings:CreatePanel()
            OhkoMenuSettings:CreateReadyText()
        else
            OhkoMenuSettings:DestroyPanel()
		end
	end

    nodes[main_menu_id] = MenuHelper:BuildMenu(main_menu_id, { area_bg = "none" })
    nodes[sub_custom_menu_id] = MenuHelper:BuildMenu(sub_custom_menu_id, { area_bg = "none" })
    nodes[sub_reminder_menu_id] = MenuHelper:BuildMenu(sub_reminder_menu_id, { area_bg = "none", focus_changed_callback = "OhkoMenuFocus" })
    MenuHelper:AddMenuItem(nodes["blt_options"], main_menu_id, "ohko_menu", "ohko_menu_desc")]]
end)