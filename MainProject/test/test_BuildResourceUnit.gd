extends GutTest

var ResourceUnit = TypeUnit.type("ResourceUnit")

func before_all():
	CardCache.initScript()
	GlobalSetting.initScript()

func test_buildResourceUnit():
	var resource_unit = ResourceUnit.new()

	resource_unit.addTexture("main_menu", "main_menu", "title", "res://asserts/main_menu/title.png")
	resource_unit.addTexture("main_menu", "main_menu", "background", "res://asserts/main_menu/bg2.jpg")

	resource_unit.addTexture("main_menu", "StartButton", "texture_normal", "res://asserts/main_menu/main_menu_btn.png")
	resource_unit.addTexture("main_menu", "StartButton", "texture_hover", "res://asserts/main_menu/main_menu_btn_hover.png")
	resource_unit.addFont("main_menu", "StartButtonText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 60)
	resource_unit.addColorByName("main_menu", "StartButtonText", "font_color", "#d1992d")
	resource_unit.addText("main_menu", "StartButtonText", "font_text", "新的旅途")
	
	resource_unit.addTexture("main_menu", "ContinueButton", "texture_normal", "res://asserts/main_menu/main_menu_btn.png")
	resource_unit.addTexture("main_menu", "ContinueButton", "texture_hover", "res://asserts/main_menu/main_menu_btn_hover.png")
	resource_unit.addFont("main_menu", "ContinueButtonText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 60)
	resource_unit.addColorByName("main_menu", "ContinueButtonText", "font_color", "#d1992d")
	resource_unit.addText("main_menu", "ContinueButtonText", "font_text", "继续旅途")

	resource_unit.addTexture("main_menu", "SettingButton", "texture_normal", "res://asserts/main_menu/main_menu_btn.png")
	resource_unit.addTexture("main_menu", "SettingButton", "texture_hover", "res://asserts/main_menu/main_menu_btn_hover.png")
	resource_unit.addFont("main_menu", "SettingButtonText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 60)
	resource_unit.addColorByName("main_menu", "SettingButtonText", "font_color", "#d1992d")
	resource_unit.addText("main_menu", "SettingButtonText", "font_text", "新的旅途")
	
	resource_unit.addTexture("main_menu", "ContinueButton", "texture_normal", "res://asserts/main_menu/main_menu_btn.png")
	resource_unit.addTexture("main_menu", "ContinueButton", "texture_hover", "res://asserts/main_menu/main_menu_btn_hover.png")
	resource_unit.addFont("main_menu", "ContinueButtonText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 60)
	resource_unit.addColorByName("main_menu", "ContinueButtonText", "font_color", "#d1992d")
	resource_unit.addText("main_menu", "ContinueButtonText", "font_text", "游戏设置")

	resource_unit.addTexture("main_menu", "SettingButton", "texture_normal", "res://asserts/main_menu/main_menu_btn.png")
	resource_unit.addTexture("main_menu", "SettingButton", "texture_hover", "res://asserts/main_menu/main_menu_btn_hover.png")
	resource_unit.addFont("main_menu", "SettingButtonText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 60)
	resource_unit.addColorByName("main_menu", "SettingButtonText", "font_color", "#d1992d")
	resource_unit.addText("main_menu", "SettingButtonText", "font_text", "新的旅途")
	
	resource_unit.addTexture("main_menu", "ExitButton", "texture_normal", "res://asserts/main_menu/main_menu_btn.png")
	resource_unit.addTexture("main_menu", "ExitButton", "texture_hover", "res://asserts/main_menu/main_menu_btn_hover.png")
	resource_unit.addFont("main_menu", "ExitButtonText", "font", "res://asserts/ttf/SourceHanSansSC-Bold.otf", 60)
	resource_unit.addColorByName("main_menu", "ExitButtonText", "font_color", "#d1992d")
	resource_unit.addText("main_menu", "ExitButtonText", "font_text", "离开游戏")

	resource_unit.addTexture("global", "avator", "main_character", "res://asserts/avator/white_hair.png")
	resource_unit.addTexture("global", "avator", "enemy_character", "res://asserts/avator/purple_hair.png")
	resource_unit.addTexture("global", "component", "underline", "res://asserts/global_component/underline.png")
	resource_unit.addTexture("global", "avator", "attack_card", "res://asserts/avator/knight.png")

	var script_tree = resource_unit.pack()
	script_tree.exportAsJson("res://test/scripts/resource_unit.json")

	pass_test("Create Resource Unit success")
