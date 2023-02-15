extends GutTest

var MainMenuScene = TypeUnit.type("MainMenuScene")

func test_buildMainMenuScript():
	var main_menu = MainMenuScene.instance()
	main_menu.setSceneName("main_menu")

	var switch_target_table = SwitchTargetTable.new()
	switch_target_table.addTarget("StartButton", "LinearBattleScene", "linear_battle")
	switch_target_table.addTarget("ContinueButton", "LinearBattleScene", "linear_battle")
	switch_target_table.addTarget("SettingButton", "LinearBattleScene", "linear_battle")
	
	main_menu.setSwitchTargetTable(switch_target_table)

	var main_menu_model = MainMenuModel.new()
	
	main_menu.setModel(main_menu_model)

	var script_tree = main_menu.pack()
	script_tree.exportAsJson("res://test/scripts/main_menu.json")

	pass_test("Mainmenu script generate success!")

