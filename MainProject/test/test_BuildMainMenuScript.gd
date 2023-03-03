extends GutTest

var MainMenuScene = TypeUnit.type("MainMenuScene")
var MainMenuModel = TypeUnit.type("MainMenuModel")
var TargetPack = TypeUnit.type("TargetPack")

func test_buildMainMenuScript():
	var main_menu = MainMenuScene.instance()
	main_menu.setSceneName("main_menu")

	var switch_target_table = SwitchTargetTable.new()

	var start_pack = TargetPack.new()
	start_pack.setTargetName("StartButton")
	start_pack.setSceneType("LinearBattleScene")
	start_pack.setSceneName("linear_battle")
	start_pack.setSwitchType("switch")
	switch_target_table.addTarget(start_pack)

	var continue_pack = TargetPack.new()
	continue_pack.setTargetName("ContinueButton")
	continue_pack.setSceneType("ArchiveScene")
	continue_pack.setSceneName("archive_menu")
	continue_pack.setSceneName("push")
	switch_target_table.addTarget(continue_pack)

	var setting_pack = TargetPack.new()
	setting_pack.setTargetName("SettingButton")
	setting_pack.setSceneType("LinearBattleScene")
	setting_pack.setSceneName("linear_battle")
	setting_pack.setSwitchType("switch")
	switch_target_table.addTarget(setting_pack)
	
	main_menu.setSwitchTargetTable(switch_target_table)

	var main_menu_model = MainMenuModel.new()
	
	main_menu.setModel(main_menu_model)

	var script_tree = main_menu.pack()
	script_tree.exportAsJson("res://test/scripts/main_menu.json")

	pass_test("MainMenu script generate success!")

