--[[
    Adjustments to the Ogre Big Names missions ("initiatives") which have
    unit requirements not achievable with the default TTC settings.
]]


-- Update the initiatives table directly with the altered records.
function ttc_update_initiatives()
	if not is_table(initiative_templates) then return end
	for key, value in ipairs(initiative_templates) do
		-- "GROUNDSHAKER" fix
		-- Changes "Win a battle w/ 5 Crushers" to "Win a battle with 5 [Crushers or Mournfangs]".
		if value.initiative_key == "wh3_dlc26_character_initiative_ogr_big_name_groundshaker" then
			initiative_templates[key] =
			{
				["initiative_key"] = "wh3_dlc26_character_initiative_ogr_big_name_groundshaker",
				["event"] = {"CharacterCompletedBattle", "HeroCharacterParticipatedInBattle"},
				["condition"] =
					function(context)
						local character = context:character()		
						local crushers = {
							"wh3_main_ogr_cav_crushers_0","wh3_main_ogr_cav_crushers_1","wh3_twa07_ogr_cav_crushers_ror_0","wh3_main_ogr_cav_mournfang_cavalry_0","wh3_main_ogr_cav_mournfang_cavalry_1","wh3_main_ogr_cav_mournfang_cavalry_2",
						}		
						return character:won_battle() and (cm:count_char_army_has_unit(character, crushers) >= 5
)
					end,
				["grant_immediately"] = true
			}
		
		-- "MOUNTAINEATER" fix
		-- Changes "Win a battle w/ 3 [Stonehorns or Thundertusks]" -> "Win a battle w/ 2 [Stonehorns or Thundertusks]".
		elseif value.initiative_key == "wh3_main_character_initiative_ogr_big_name_mountaineater" then
			initiative_templates[key] =
			{
				["initiative_key"] = "wh3_main_character_initiative_ogr_big_name_mountaineater",
				["event"] = {"CharacterCompletedBattle", "HeroCharacterParticipatedInBattle"},
				["condition"] =
					function(context)
						local character = context:character()		
						local stonehorns_thundertusks = {
							"wh3_main_ogr_mon_stonehorn_0","wh3_main_ogr_mon_stonehorn_1","wh3_twa08_ogr_mon_stonehorn_0_ror","wh3_dlc26_ogr_mon_thundertusk"
						}		
						return character:won_battle() and (cm:count_char_army_has_unit(character, stonehorns_thundertusks) >= 2
)
					end,
				["grant_immediately"] = true
			}
		end
	end
end

-- Run this alteration early on in the game load-up sequence. 
cm:add_loading_game_callback(ttc_update_initiatives)
