---[[
--- MCT Settings handler. Enables the end user to tweak whether the mod
--- is active, whether the AI uses or ignores the system, and tweaks
--- to the various point limits.
---]]

local mct = get_mct()
local loc_prefix = "mct_ttc_"
local ttc = mct:register_mod("ttc")
ttc:set_title(loc_prefix.."mod_title", true)
ttc:set_author("Drunk Flamingo")
ttc:set_description(loc_prefix.."mod_desc", true)

local enable = ttc:add_new_option("a_enable", "checkbox")
enable:set_default_value(true)
enable:set_text(loc_prefix.."a_enable_txt", true)
enable:set_tooltip_text(loc_prefix.."a_enable_tt", true)

local ai = ttc:add_new_option("c_ai", "checkbox")
ai:set_default_value(true)
ai:set_text(loc_prefix.."c_ai_txt", true)
ai:set_tooltip_text(loc_prefix.."c_ai_tt", true)


ttc:add_new_section("points_allowed", loc_prefix.."points_allowed", true)

local special_points = ttc:add_new_option("b_special_points", "slider")
special_points:set_text(loc_prefix.."b_special_points_txt", true)
special_points:set_tooltip_text(loc_prefix.."b_special_points_tt", true)
special_points:slider_set_min_max(-10, 10)
special_points:set_default_value(0)
special_points:slider_set_step_size(1)


local rare_points = ttc:add_new_option("b_rare_points", "slider")
rare_points:set_text(loc_prefix.."b_rare_points_txt", true)
rare_points:set_tooltip_text(loc_prefix.."b_rare_points_tt", true)
rare_points:slider_set_min_max(-5, 5)
rare_points:set_default_value(0)
rare_points:slider_set_step_size(1)


local options_list = {
    "b_special_points",
    "b_rare_points",
    "c_ai"
} ---@type string[]

enable:add_option_set_callback(
    function(context) 
        ---@type boolean
        local val = context:setting()
        local mod = context:option():get_mod()

        local options = options_list

        for i = 1, #options do
            local option_obj = mod:get_option_by_key(options[i])
            option_obj:set_uic_visibility(val)
        end
    end,
    true
)