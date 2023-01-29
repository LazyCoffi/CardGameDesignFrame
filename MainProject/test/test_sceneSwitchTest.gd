extends GutTest

var SwitchTargetTable = load("res://class/entity/SwitchTargetTable.gd")
var SettingTable = load("res://class/entity/SettingTable.gd")
var Filter = load("res://class/functionalSystem/Filter.gd")

var MainMenuScene = load("res://scene/MainMenuScene/MainMenuScene.tscn")
var MainMenuModel = load("res://scene/MainMenuScene/MainMenuModel.gd")

var LinearBattleScene = load("res://scene/LinearBattleScene/LinearBattleScene.tscn")
var LinearBattleModel = load("res://scene/LinearBattleScene/LinearBattleModel.gd")
var LinearBattleService = load("res://scene/LinearBattleScene/LinearBattleService.gd")

func test_buildMainMenuScript():
	var main_menu = MainMenuScene.instance()
	main_menu.setSceneName("main_menu")

	var switch_target_table = SwitchTargetTable.new()
	switch_target_table.addTarget("StartButton", "LinearBattleScene", "linear_battle", "switchSignal")
	switch_target_table.addTarget("ContinueButton", "LinearBattleScene", "linear_battle", "switchSignal")
	switch_target_table.addTarget("SettingButton", "LinearBattleScene", "linear_battle", "switchSignal")
	
	main_menu.setSwitchTargetTable(switch_target_table)

	var main_menu_model = MainMenuModel.new()
	
	main_menu.setModel(main_menu_model)

	var script_tree = main_menu.pack()
	script_tree.exportAsJson("res://test/testFile/main_menu.json")

	pass_test("Mainmenu script generate success!")

func test_buildLinearBattleScript():
	var linear_battle = LinearBattleScene.instance()

	linear_battle.setSceneName("linear_battle")
	
	var switch_target_table = SwitchTargetTable.new()
	linear_battle.setSwitchTargetTable(switch_target_table)
	
	var linear_battle_model = LinearBattleModel.new()

	var setting = SettingTable.new()
	setting.setAttr("hand_cards_upper", 10)
	setting.setAttr("hand_card_rect_size", [90, 160])
	setting.setAttr("character_card_rect_size", [90, 160])

	linear_battle_model.setSetting(setting)
	
	var order_filter = Filter.new()
	# TODO
	pass

	pass_test("pass")

func test_duplicateTest():
	pass_test("Duplicate Test")
