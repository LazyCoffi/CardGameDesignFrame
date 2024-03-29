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
	resource_unit.addFont("linear_battle", "linear_battle", "view_attr_font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("linear_battle", "linear_battle", "view_attr_font_color", "#1c1914")
	resource_unit.addFont("linear_battle", "linear_battle", "view_introduction_font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("linear_battle", "linear_battle", "view_introduction_font_color", "#1c1914")

	resource_unit.addTexture("linear_battle", "linear_battle", "attr_next_button", "res://asserts/linear_battle/LinearBattleAttrNextButton.png")
	resource_unit.addTexture("linear_battle", "linear_battle", "attr_pre_button", "res://asserts/linear_battle/LinearBattleAttrPreButton.png")
	resource_unit.addTexture("linear_battle", "linear_battle", "view_attr_entry", "res://asserts/linear_battle/LinearBattleEntry.png")
	resource_unit.addTexture("linear_battle", "linear_battle", "view_frame", "res://asserts/linear_battle/ViewFrame.png")
	resource_unit.addTexture("linear_battle", "linear_battle", "attr_frame", "res://asserts/linear_battle/LinearBattleAttrFrame.png")
	resource_unit.addTexture("linear_battle", "linear_battle", "introduction_frame", "res://asserts/linear_battle/LinearBattleAttrFrame.png")
	resource_unit.addTexture("linear_battle", "linear_battle", "character_card_frame", "res://asserts/linear_battle/CharacterCard.png")
	resource_unit.addTexture("linear_battle", "linear_battle", "hand_card_frame", "res://asserts/linear_battle/HandCardFrame.png")
	resource_unit.addTexture("linear_battle", "linear_battle", "background", "res://asserts/linear_battle/bg2.jpg")
	resource_unit.addTexture("linear_battle", "linear_battle", "next_round_button", "res://asserts/linear_battle/next_round_btn.png")
	resource_unit.addTexture("linear_battle", "linear_battle", "next_round_button_hover", "res://asserts/linear_battle/next_round_btn_hover.png")
	resource_unit.addTexture("linear_battle", "linear_battle", "sub_menu_entry_btn", "res://asserts/linear_battle/SubMenuButton.png")
	resource_unit.addFont("linear_battle", "NextRoundButtonText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 40)
	resource_unit.addColorByName("linear_battle", "NextRoundButtonText", "font_color", "#2E2E2E")	
	resource_unit.addText("linear_battle", "NextRoundButtonText", "font_text", "结束回合")
	resource_unit.addTexture("linear_battle", "linear_battle", "action_character_mark", "res://asserts/linear_battle/LinearBattleActionCharacterMark.png")
	resource_unit.addTexture("linear_battle", "linear_battle", "chosen_hand_card_mark", "res://asserts/linear_battle/LinearBattleChosenHandCardMark.png")

	# global
	resource_unit.addTexture("global", "avator", "main_character", "res://asserts/avator/white_hair.png")
	resource_unit.addTexture("global", "avator", "enemy_character", "res://asserts/avator/purple_hair.png")
	resource_unit.addTexture("global", "avator", "attack_card", "res://asserts/avator/knight.png")
	resource_unit.addTexture("global", "avator", "crop_card", "res://asserts/avator/crop.png")
	resource_unit.addTexture("global", "avator", "stab_card", "res://asserts/avator/stab.png")
	resource_unit.addTexture("global", "avator", "knight_character", "res://asserts/avator/white_knight.png")
	resource_unit.addTexture("global", "avator", "robber_character", "res://asserts/avator/robber.png")
	resource_unit.addTexture("global", "avator", "slash_card", "res://asserts/avator/slash.png")
	resource_unit.addTexture("global", "avator", "shield_card", "res://asserts/avator/shield.png")

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

	# archive_scene
	resource_unit.addTexture("archive_menu", "archive_menu", "background", "res://asserts/archive_menu/archive_background1.jpg")
	resource_unit.addTexture("archive_menu", "archive_menu", "menu_rect", "res://asserts/archive_menu/ArchiveFrame.png")

	resource_unit.addTexture("archive_menu", "LoadButton", "texture_normal", "res://asserts/archive_menu/ArchiveLoadButton.png")
	resource_unit.addTexture("archive_menu", "LoadButton", "texture_hover", "res://asserts/archive_menu/ArchiveLoadButtonHover.png")
	resource_unit.addFont("archive_menu", "LoadText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("archive_menu", "LoadText", "font_color", "#1c1914")

	resource_unit.addTexture("archive_menu", "DeleteButton", "texture_normal", "res://asserts/archive_menu/ArchiveDeleteButton.png")
	resource_unit.addTexture("archive_menu", "DeleteButton", "texture_hover", "res://asserts/archive_menu/archive_delete_button_hover.png")
	resource_unit.addFont("archive_menu", "DeleteText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("archive_menu", "DeleteText", "font_color", "#1c1914")

	resource_unit.addTexture("archive_menu", "BackButton", "texture_normal", "res://asserts/archive_menu/ArchiveReturnButton.png")
	resource_unit.addTexture("archive_menu", "BackButton", "texture_hover", "res://asserts/archive_menu/archive_back_button_hover.png")
	resource_unit.addFont("archive_menu", "BackText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("archive_menu", "BackText", "font_color", "#1c1914")

	resource_unit.addTexture("archive_menu", "NextButton", "texture_normal", "res://asserts/archive_menu/ArchiveNextButton.png")
	resource_unit.addTexture("archive_menu", "PreviousButton", "texture_normal", "res://asserts/archive_menu/ArchivePreviousButton.png")

	resource_unit.addTexture("archive_menu", "ArchiveCard", "active_card", "res://asserts/archive_menu/ArchiveFullCard.png")
	resource_unit.addTexture("archive_menu", "ArchiveCard", "empty_card", "res://asserts/archive_menu/ArchiveCard.png")

	resource_unit.addFont("archive_menu", "CardText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 32)
	resource_unit.addColorByName("archive_menu", "CardText", "font_color", "#1c1914")

	resource_unit.addFont("archive_menu", "CreateText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("archive_menu", "CreateText", "font_color", "#1c1914")

	resource_unit.addFont("archive_menu", "UpdateText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("archive_menu", "UpdateText", "font_color", "#1c1914")

	resource_unit.addFont("archive_menu", "CreateTimeText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("archive_menu", "CreateTimeText", "font_color", "#1c1914")

	resource_unit.addFont("archive_menu", "UpdateTimeText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("archive_menu", "UpdateTimeText", "font_color", "#1c1914")

	# MapCanvas

	resource_unit.addColorByName("MapCanvas", "MapCanvas", "map_line_color", "#6f695d")

	# explore_map

	resource_unit.addTexture("explore_map", "explore_map", "sub_menu_button", "res://asserts/explore_map/SubMenuButton.png")

	resource_unit.addTexture("explore_map", "explore_map", "background", "res://asserts/explore_map/bg.jpg")
	resource_unit.addTexture("explore_map", "explore_map", "map_node", "res://asserts/explore_map/MapNode.png")
	resource_unit.addTexture("explore_map", "explore_map", "disable_map_node", "res://asserts/explore_map/ExploreMapDisable.png")

	# setting

	resource_unit.addTexture("setting", "setting", "setting_frame", "res://asserts/setting/setting_frame.png")
	resource_unit.addFont("setting", "BgmText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 24)
	resource_unit.addColorByName("setting", "BgmText", "font_color", "#1c1914")
	resource_unit.addFont("setting", "SoundText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 24)
	resource_unit.addColorByName("setting", "SoundText", "font_color", "#1c1914")
	resource_unit.addTexture("setting", "ReturnButton", "texture", "res://asserts/setting/SettingReturnButton.png")
	resource_unit.addFont("setting", "ReturnText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 24)
	resource_unit.addColorByName("setting", "ReturnText", "font_color", "#1c1914")
	resource_unit.addTexture("setting", "BgmVolume", "texture", "res://asserts/setting/SettingVolume.png")
	resource_unit.addTexture("setting", "SoundVolume", "texture", "res://asserts/setting/SettingVolume.png")
	resource_unit.addTexture("setting", "SoundVolumeMark", "texture", "res://asserts/setting/SettingVolumeMark.png")

	# test_dialog
	resource_unit.addTexture("test_dialog", "test_dialog", "dialog_frame", "res://asserts/test_dialog/DialogFrame.png")
	resource_unit.addFont("test_dialog", "test_dialog", "title_font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 48)
	resource_unit.addColorByName("test_dialog", "test_dialog", "title_font_color", "#1c1914")
	resource_unit.addTexture("test_dialog", "test_dialog", "dialog_pic", "res://asserts/test_dialog/pic.jpg")
	resource_unit.addFont("test_dialog", "test_dialog", "info_font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 24)
	resource_unit.addColorByName("test_dialog", "test_dialog", "info_font_color", "#1c1914")
	resource_unit.addFont("test_dialog", "test_dialog", "option_font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 24)
	resource_unit.addColorByName("test_dialog", "test_dialog", "option_font_color", "#1c1914")
	resource_unit.addTexture("test_dialog", "test_dialog", "option_button", "res://asserts/test_dialog/DialogOptionButton.png")

	# victory_dialog
	resource_unit.addTexture("victory_dialog", "victory_dialog", "dialog_frame", "res://asserts/test_dialog/DialogFrame.png")
	resource_unit.addFont("victory_dialog", "victory_dialog", "title_font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 48)
	resource_unit.addColorByName("victory_dialog", "victory_dialog", "title_font_color", "#1c1914")
	resource_unit.addTexture("victory_dialog", "victory_dialog", "dialog_pic", "res://asserts/test_dialog/pic.jpg")
	resource_unit.addFont("victory_dialog", "victory_dialog", "info_font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 24)
	resource_unit.addColorByName("victory_dialog", "victory_dialog", "info_font_color", "#1c1914")
	resource_unit.addFont("victory_dialog", "victory_dialog", "option_font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 24)
	resource_unit.addColorByName("victory_dialog", "victory_dialog", "option_font_color", "#1c1914")
	resource_unit.addTexture("victory_dialog", "victory_dialog", "option_button", "res://asserts/test_dialog/DialogOptionButton.png")

	# fail_dialog
	resource_unit.addTexture("fail_dialog", "fail_dialog", "dialog_frame", "res://asserts/test_dialog/DialogFrame.png")
	resource_unit.addFont("fail_dialog", "fail_dialog", "title_font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 48)
	resource_unit.addColorByName("fail_dialog", "fail_dialog", "title_font_color", "#1c1914")
	resource_unit.addTexture("fail_dialog", "fail_dialog", "dialog_pic", "res://asserts/test_dialog/pic.jpg")
	resource_unit.addFont("fail_dialog", "fail_dialog", "info_font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 24)
	resource_unit.addColorByName("fail_dialog", "fail_dialog", "info_font_color", "#1c1914")
	resource_unit.addFont("fail_dialog", "fail_dialog", "option_font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 24)
	resource_unit.addColorByName("fail_dialog", "fail_dialog", "option_font_color", "#1c1914")
	resource_unit.addTexture("fail_dialog", "fail_dialog", "option_button", "res://asserts/test_dialog/DialogOptionButton.png")
	
	# demo1
	resource_unit.addFont("demo1", "demo1", "view_attr_font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("demo1", "demo1", "view_attr_font_color", "#1c1914")
	resource_unit.addFont("demo1", "demo1", "view_introduction_font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 18)
	resource_unit.addColorByName("demo1", "demo1", "view_introduction_font_color", "#1c1914")

	resource_unit.addTexture("demo1", "demo1", "attr_next_button", "res://asserts/demo1/LinearBattleAttrNextButton.png")
	resource_unit.addTexture("demo1", "demo1", "attr_pre_button", "res://asserts/demo1/LinearBattleAttrPreButton.png")
	resource_unit.addTexture("demo1", "demo1", "view_attr_entry", "res://asserts/demo1/LinearBattleEntry.png")
	resource_unit.addTexture("demo1", "demo1", "view_frame", "res://asserts/demo1/ViewFrame.png")
	resource_unit.addTexture("demo1", "demo1", "attr_frame", "res://asserts/demo1/LinearBattleAttrFrame.png")
	resource_unit.addTexture("demo1", "demo1", "introduction_frame", "res://asserts/demo1/LinearBattleAttrFrame.png")
	resource_unit.addTexture("demo1", "demo1", "character_card_frame", "res://asserts/demo1/CharacterCard.png")
	resource_unit.addTexture("demo1", "demo1", "hand_card_frame", "res://asserts/demo1/HandCardFrame.png")
	resource_unit.addTexture("demo1", "demo1", "background", "res://asserts/demo1/bg2.jpg")
	resource_unit.addTexture("demo1", "demo1", "next_round_button", "res://asserts/demo1/next_round_btn.png")
	resource_unit.addTexture("demo1", "demo1", "next_round_button_hover", "res://asserts/demo1/next_round_btn_hover.png")
	resource_unit.addTexture("demo1", "demo1", "sub_menu_entry_btn", "res://asserts/demo1/SubMenuButton.png")
	resource_unit.addFont("demo1", "NextRoundButtonText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 40)
	resource_unit.addColorByName("demo1", "NextRoundButtonText", "font_color", "#2E2E2E")	
	resource_unit.addText("demo1", "NextRoundButtonText", "font_text", "结束回合")
	resource_unit.addTexture("demo1", "demo1", "action_character_mark", "res://asserts/demo1/LinearBattleActionCharacterMark.png")
	resource_unit.addTexture("demo1", "demo1", "chosen_hand_card_mark", "res://asserts/demo1/LinearBattleChosenHandCardMark.png")

	# export
	var script_tree = resource_unit.pack()
	script_tree.exportAsJson("res://test/scripts/resource_unit.json")

	pass_test("Create Resource Unit success")


	
