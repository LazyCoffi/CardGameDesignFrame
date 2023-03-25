extends GutTest

var ResourceUnit = TypeUnit.type("ResourceUnit")

func test_buildResourceUnit():
	var resource_unit = ResourceUnit.new()

	# main_menu
	resource_unit.addTexture("main_menu", "main_menu", "title", "res://asserts/main_menu/title1.png")
	resource_unit.addTexture("main_menu", "main_menu", "background", "res://asserts/main_menu/bg3.jpg")

	resource_unit.addTexture("main_menu", "StartButton", "texture_normal", "res://asserts/main_menu/main_menu_btn1.png")
	resource_unit.addTexture("main_menu", "StartButton", "texture_hover", "res://asserts/main_menu/main_menu_btn_hover1.png")
	resource_unit.addFont("main_menu", "StartButtonText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 60)
	resource_unit.addColorByName("main_menu", "StartButtonText", "font_color", "#1c1914")
	resource_unit.addText("main_menu", "StartButtonText", "font_text", "新的旅途")
	
	resource_unit.addTexture("main_menu", "ContinueButton", "texture_normal", "res://asserts/main_menu/main_menu_btn1.png")
	resource_unit.addTexture("main_menu", "ContinueButton", "texture_hover", "res://asserts/main_menu/main_menu_btn_hover1.png")
	resource_unit.addFont("main_menu", "ContinueButtonText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 60)
	resource_unit.addColorByName("main_menu", "ContinueButtonText", "font_color", "#1c1914")
	resource_unit.addText("main_menu", "ContinueButtonText", "font_text", "继续旅途")

	resource_unit.addTexture("main_menu", "SettingButton", "texture_normal", "res://asserts/main_menu/main_menu_btn1.png")
	resource_unit.addTexture("main_menu", "SettingButton", "texture_hover", "res://asserts/main_menu/main_menu_btn_hover1.png")
	resource_unit.addFont("main_menu", "SettingButtonText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 60)
	resource_unit.addColorByName("main_menu", "SettingButtonText", "font_color", "#1c1914")
	resource_unit.addText("main_menu", "SettingButtonText", "font_text", "游戏设置")
	
	resource_unit.addTexture("main_menu", "ExitButton", "texture_normal", "res://asserts/main_menu/main_menu_btn1.png")
	resource_unit.addTexture("main_menu", "ExitButton", "texture_hover", "res://asserts/main_menu/main_menu_btn_hover1.png")
	resource_unit.addFont("main_menu", "ExitButtonText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 60)
	resource_unit.addColorByName("main_menu", "ExitButtonText", "font_color", "#1c1914")	
	resource_unit.addText("main_menu", "ExitButtonText", "font_text", "离开游戏")

	
	# linear_battle
	resource_unit.addTexture("linear_battle", "linear_battle", "character_card_frame", "res://asserts/linear_battle/CharacterCard.png")
	resource_unit.addTexture("linear_battle", "linear_battle", "hand_card_frame", "res://asserts/linear_battle/HandCardFrame.png")
	resource_unit.addTexture("linear_battle", "linear_battle", "background", "res://asserts/linear_battle/bg2.jpg")
	resource_unit.addTexture("linear_battle", "linear_battle", "next_round_button", "res://asserts/linear_battle/next_round_btn.png")
	resource_unit.addTexture("linear_battle", "linear_battle", "next_round_button_hover", "res://asserts/linear_battle/next_round_btn_hover.png")
	resource_unit.addTexture("linear_battle", "linear_battle", "sub_menu_entry_btn", "res://asserts/linear_battle/SubMenuButton.png")
	resource_unit.addFont("linear_battle", "NextRoundButtonText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 40)
	resource_unit.addColorByName("linear_battle", "NextRoundButtonText", "font_color", "#2E2E2E")	
	resource_unit.addText("linear_battle", "NextRoundButtonText", "font_text", "结束回合")

	resource_unit.addTexture("global", "avator", "main_character", "res://asserts/avator/white_hair.png")
	resource_unit.addTexture("global", "avator", "enemy_character", "res://asserts/avator/purple_hair.png")
	resource_unit.addTexture("global", "component", "action_character_mark", "res://asserts/component/underline.png")
	resource_unit.addTexture("global", "component", "chosen_hand_card_mark", "res://asserts/component/underline.png")
	resource_unit.addTexture("global", "avator", "attack_card", "res://asserts/avator/knight.png")

	# sub_menu
	resource_unit.addTexture("sub_menu", "sub_menu", "background_rect", "res://asserts/sub_menu/sub_menu_frame.png")

	resource_unit.addTexture("sub_menu", "ResumeButton", "texture_normal", "res://asserts/sub_menu/sub_menu_btn.png")
	resource_unit.addTexture("sub_menu", "ResumeButton", "texture_hover", "res://asserts/sub_menu/sub_menu_btn_hover.png")
	resource_unit.addFont("sub_menu", "ResumeButtonText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 30)
	resource_unit.addColorByName("sub_menu", "ResumeButtonText", "font_color", "#1c1914")
	resource_unit.addText("sub_menu", "ResumeButtonText", "font_text", "回到游戏")

	resource_unit.addTexture("sub_menu", "SettingButton", "texture_normal", "res://asserts/sub_menu/sub_menu_btn.png")
	resource_unit.addTexture("sub_menu", "SettingButton", "texture_hover", "res://asserts/sub_menu/sub_menu_btn_hover.png")
	resource_unit.addFont("sub_menu", "SettingButtonText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 30)
	resource_unit.addColorByName("sub_menu", "SettingButtonText", "font_color", "#1c1914")
	resource_unit.addText("sub_menu", "SettingButtonText", "font_text", "游戏设置")

	resource_unit.addTexture("sub_menu", "ExitButton", "texture_normal", "res://asserts/sub_menu/sub_menu_btn.png")
	resource_unit.addTexture("sub_menu", "ExitButton", "texture_hover", "res://asserts/sub_menu/sub_menu_btn_hover.png")
	resource_unit.addFont("sub_menu", "ExitButtonText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 30)
	resource_unit.addColorByName("sub_menu", "ExitButtonText", "font_color", "#1c1914")
	resource_unit.addText("sub_menu", "ExitButtonText", "font_text", "回到主菜单")

	resource_unit.addTexture("archive_menu", "archive_menu", "background", "res://asserts/archive_menu/archive_background.jpg")
	resource_unit.addTexture("archive_menu", "archive_menu", "menu_rect", "res://asserts/archive_menu/archive_menu_rect.png")

	resource_unit.addTexture("archive_menu", "LoadButton", "texture_normal", "res://asserts/archive_menu/archive_load_button.png")
	resource_unit.addTexture("archive_menu", "LoadButton", "texture_hover", "res://asserts/archive_menu/archive_load_button_hover.png")
	resource_unit.addFont("archive_menu", "LoadText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("archive_menu", "LoadText", "font_color", "#d1992d")

	resource_unit.addTexture("archive_menu", "DeleteButton", "texture_normal", "res://asserts/archive_menu/archive_delete_button.png")
	resource_unit.addTexture("archive_menu", "DeleteButton", "texture_hover", "res://asserts/archive_menu/archive_delete_button_hover.png")
	resource_unit.addFont("archive_menu", "DeleteText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("archive_menu", "DeleteText", "font_color", "#d1992d")

	resource_unit.addTexture("archive_menu", "BackButton", "texture_normal", "res://asserts/archive_menu/archive_back_button.png")
	resource_unit.addTexture("archive_menu", "BackButton", "texture_hover", "res://asserts/archive_menu/archive_back_button_hover.png")
	resource_unit.addFont("archive_menu", "BackText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("archive_menu", "BackText", "font_color", "#d1992d")

	resource_unit.addTexture("archive_menu", "NextButton", "texture_normal", "res://asserts/archive_menu/archive_next_button.png")
	resource_unit.addTexture("archive_menu", "PreviousButton", "texture_normal", "res://asserts/archive_menu/archive_previous_button.png")

	resource_unit.addTexture("archive_menu", "ArchiveCard", "active_card", "res://asserts/archive_menu/archive_card.png")
	resource_unit.addTexture("archive_menu", "ArchiveCard", "empty_card", "res://asserts/archive_menu/archive_empty_card.png")
	resource_unit.addFont("archive_menu", "CardText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("archive_menu", "CardText", "font_color", "#d1992d")

	resource_unit.addFont("archive_menu", "CreateText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("archive_menu", "CreateText", "font_color", "#d1992d")

	resource_unit.addFont("archive_menu", "UpdateText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("archive_menu", "UpdateText", "font_color", "#d1992d")

	resource_unit.addFont("archive_menu", "CreateTimeText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("archive_menu", "CreateTimeText", "font_color", "#d1992d")

	resource_unit.addFont("archive_menu", "UpdateTimeText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("archive_menu", "UpdateTimeText", "font_color", "#d1992d")

	# MapCanvas

	resource_unit.addColorByName("MapCanvas", "MapCanvas", "map_line_color", "#6f695d")

	# explore_map

	resource_unit.addTexture("explore_map", "explore_map", "background", "res://asserts/explore_map/bg.jpg")
	resource_unit.addTexture("explore_map", "explore_map", "map_node", "res://asserts/explore_map/MapNode.png")
	resource_unit.addTexture("explore_map", "explore_map", "disable_map_node", "res://asserts/explore_map/ExploreMapDisable.png")

	var script_tree = resource_unit.pack()
	script_tree.exportAsJson("res://test/scripts/resource_unit.json")

	pass_test("Create Resource Unit success")
