extends GutTest

var SwitchTargetTable = TypeUnit.type("SwitchTargetTable")
var SettingTable = TypeUnit.type("SettingTable")
var Filter = TypeUnit.type("Filter")
var PollingBucket = TypeUnit.type("PollingBucket")
var BattleCharacterCard = TypeUnit.type("BattleCharacterCard")
var FunctionalGraph = TypeUnit.type("FunctionalGraph")
var Category = TypeUnit.type("Category")

var MainMenuScene = TypeUnit.type("MainMenuScene")
var MainMenuModel = TypeUnit.type("MainMenuModel")

var LinearBattleScene = TypeUnit.type("LinearBattleScene")
var LinearBattleModel = TypeUnit.type("LinearBattleModel")

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

	# setting
	var setting = SettingTable.new()
	setting.setAttr("hand_cards_upper", 10)
	setting.setAttr("hand_card_rect_size", [90, 160])
	setting.setAttr("character_card_rect_size", [90, 160])

	linear_battle_model.setSetting(setting)
	
	# order_bucket
	var order_bucket = PollingBucket.new()
	order_bucket.setParamType(BattleCharacterCard)

	var init_filter = Filter.new()
	var init_graph = FunctionalGraph.new()
	var init_func = Function.new()

	var init_category = Category.new()
	init_category.setCategory(["FunctionSet", "ArrayOperFunctionSet"])
	init_func.setCategory(init_category)
	init_func.setFuncName("randomShuffle")
	init_func.initDefaultParams()
	var init_node = init_graph.genNode(init_func)
	init_graph.setRoot(init_node)
	init_filter.setGraph(init_graph)

	var init_filter = Filter.new()
	var init_graph = FunctionalGraph.new()
	var init_func = Function.new()

	var regular_category = Category.new()
	regular_category.setCategory(["FunctionSet", "BaseFunctionSet"])
	regular_func.setCategory(regular_category)
	regular_func.setFuncName("returnVal")
	regular_func.initDefaultParams()
	var regular_node = regular_graph.genNode(regular_func)
	regular_graph.setRoot(regular_node)
	regular_filter.setGraph(regular_graph)

	order_bucket.setInitShuffleFilter(init_filter)
	order_bucket.setRegularShuffleFilter(regular_filter)

	linear_battle_model.setOrderBucket(order_bucket)

	# character_deal_filter

	var character_deal_filter = Filter.new()

	pass_test("pass")

func test_duplicateTest():
	pass_test("Duplicate Test")
