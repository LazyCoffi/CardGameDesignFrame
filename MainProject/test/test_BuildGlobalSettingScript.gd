extends GutTest

var GlobalSetting = TypeUnit.type("GlobalSetting")

func test_buildGlobalSettingScript():
	var global_setting = GlobalSetting.new()

	global_setting.setInitSceneName("main_menu")
	global_setting.setScreenSize([1920, 1080])

	var script_tree = global_setting.pack()
	script_tree.exportAsJson("res://test/scripts/global_setting.json")

	pass_test("Create global setting script success!")
