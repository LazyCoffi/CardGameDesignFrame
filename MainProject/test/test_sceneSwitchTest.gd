extends GutTest

var SwitchTargetTable = TypeUnit.type("SwitchTargetTable")
var SettingTable = TypeUnit.type("SettingTable")
var Filter = TypeUnit.type("Filter")
var PollingBucket = TypeUnit.type("PollingBucket")
var BattleCharacterCard = TypeUnit.type("BattleCharacterCard")
var FunctionalGraph = TypeUnit.type("FunctionalGraph")

var MainMenuScene = TypeUnit.type("MainMenuScene")
var MainMenuModel = TypeUnit.type("MainMenuModel")

var LinearBattleScene = TypeUnit.type("LinearBattleScene")
var LinearBattleModel = TypeUnit.type("LinearBattleModel")

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
	script_tree.exportAsJson("res://scripts/scene/main_menu.json")

	pass_test("Mainmenu script generate success!")

func __buildSetting():
	var setting = SettingTable.new()

	setting.addIndex("hand_cards_upper")
	setting.addIndex("hand_card_rect_size")
	setting.addIndex("character_card_rect_size")

	setting.setAttr("hand_cards_upper", 10)
	setting.setAttr("hand_card_rect_size", [90, 160])
	setting.setAttr("character_card_rect_size", [90, 160])
	
	return setting

func __buildOrderBucket():
	var order_bucket = PollingBucket.new()
	order_bucket.setParamType(BattleCharacterCard)

	var init_filter = Filter.new()
	var init_graph = FunctionalGraph.new()
	var init_func = Function.new()

	init_func.setFuncSetName("ArrayOperFunctionSet")
	init_func.setFuncName("randomShuffle")
	init_func.initDefaultParams()
	var init_node = init_graph.genNode(init_func)
	init_graph.setRoot(init_node)
	init_filter.setGraph(init_graph)
	init_filter.initParamMap()

	var regular_filter = Filter.new()
	var regular_graph = FunctionalGraph.new()
	var regular_func = Function.new()
	regular_func.setFuncSetName("BaseFunctionSet")
	regular_func.setFuncName("returnVal")
	regular_func.initDefaultParams()
	var regular_node = regular_graph.genNode(regular_func)
	regular_graph.setRoot(regular_node)
	regular_filter.setGraph(regular_graph)
	regular_filter.initParamMap()

	order_bucket.setInitShuffleFilter(init_filter)
	order_bucket.setRegularShuffleFilter(regular_filter)

	return order_bucket

func __buildGetCardFunction():
	var card_function = Function.new()
	card_function.setFuncSetName("CardOperFunctionSet")
	card_function.setFuncName("getCardWithDefaultName")
	card_function.initDefaultParams()
	card_function.setDefaultParam(0, "StringPack", "ch")

	return card_function

func __buildPackFunction():
	var pack_function = Function.new()
	pack_function.setFuncSetName("ArrayOperFunctionSet")
	pack_function.setFuncName("packArray")
	pack_function.initDefaultParams()

	return pack_function

func __buildAppendFunction():
	var pack_function = Function.new()
	pack_function.setFuncSetName("ArrayOperFunctionSet")
	pack_function.setFuncName("appendVal")
	pack_function.initDefaultParams()

	return pack_function


func __buildCharacterDealFilter():
	var character_deal_filter = Filter.new()
	var graph = FunctionalGraph.new()

	var node1 = graph.genNode(__buildGetCardFunction())
	var node2 = graph.genNode(__buildGetCardFunction())
	var node3 = graph.genNode(__buildGetCardFunction())
	var node4 = graph.genNode(__buildGetCardFunction())

	var pack_node1 = graph.genNode(__buildPackFunction())
	var pack_node2 = graph.genNode(__buildPackFunction())
	var pack_node3 = graph.genNode(__buildPackFunction())

	var append_node1 = graph.genNode(__buildAppendFunction())
	var append_node2 = graph.genNode(__buildAppendFunction())
	var append_node3 = graph.genNode(__buildAppendFunction())

	pack_node1.connectNode(node1, 0)
	append_node1.connectNode(pack_node1, 0)
	append_node1.connectNode(node2, 1)

	pack_node2.connectNode(node3, 0)
	append_node2.connectNode(pack_node2, 0)
	append_node2.connectNode(node4, 1)

	pack_node3.connectNode(append_node1, 0)
	append_node3.connectNode(pack_node3, 0)
	append_node3.connectNode(append_node2, 1)

	graph.setRoot(append_node3)

	print(graph.getParamsType())
		
	character_deal_filter.setGraph(graph)
	character_deal_filter.setMap([
		"getCardWithDefaultName_10_0",
		"getCardWithDefaultName_5_0",
		"getCardWithDefaultName_6_0",
		"getCardWithDefaultName_9_0"
	])

	return character_deal_filter

func test_buildLinearBattleScript():
	var linear_battle = LinearBattleScene.instance()

	linear_battle.setSceneName("linear_battle")
	
	var switch_target_table = SwitchTargetTable.new()
	linear_battle.setSwitchTargetTable(switch_target_table)
	
	var linear_battle_model = LinearBattleModel.new()

	# setting
	var setting = __buildSetting()
	linear_battle_model.setSetting(setting)
	
	# order_bucket
	var order_bucket = __buildOrderBucket()
	linear_battle_model.setOrderBucket(order_bucket)

	# character_deal_filter
	var character_deal_filter = __buildCharacterDealFilter()
	linear_battle_model.setCharacterDealFilter(character_deal_filter)

	linear_battle.setSceneModel(linear_battle_model)

	var script_tree = linear_battle.pack()
	script_tree.exportAsJson("res://scripts/scene/linear_battle.json")

	pass_test("Create linear battle script success")

func __buildReviseFilter():
	var filter = Filter.new()
	var val_function = Function.new()
	val_function.setFuncSetName("BaseFunctionSet")
	val_function.setFuncName("returnVal")
	val_function.initDefaultParams()

	var graph = FunctionalGraph.new()
	var node = graph.genNode(val_function)
	graph.setRoot(node)
	filter.setGraph(graph)
	filter.setMap([
		"returnVal_0_0"
	])

	return filter

func test_createCardTemplate():
	var card_cache = TypeUnit.type("CardCache").new()
	var card = TypeUnit.type("BattleCharacterCard").new()
	card.setTemplateName("ch")
	card.setCardName("testCard")
	card.setAvatorName("testAvator")
	card.setIntroduction("test")

	var attr = TypeUnit.type("Attr").new()
	card.setCardAttr(attr)

	card_cache.addTemplate("BattleCharacterCard", card, __buildReviseFilter(), ["test", "testCard"])

	var script_tree = card_cache.pack()
	script_tree.exportAsJson("res://scripts/system/card_templates.json")

	pass_test("Create card templates success")

func test_duplicateTest():
	pass_test("Duplicate Test")
