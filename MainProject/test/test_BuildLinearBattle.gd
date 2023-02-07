extends GutTest

var SwitchTargetTable = TypeUnit.type("SwitchTargetTable")
var SettingTable = TypeUnit.type("SettingTable")
var Function = TypeUnit.type("Function")
var PollingBucket = TypeUnit.type("PollingBucket")
var LinearCharacterCard = TypeUnit.type("LinearCharacterCard")
var FuncGraph = TypeUnit.type("FuncGraph")

var LinearBattleScene = TypeUnit.type("LinearBattleScene")
var LinearBattleModel = TypeUnit.type("LinearBattleModel")

func before_all():
	CardCache.initScript()
	GlobalSetting.initScript()
	ResourceUnit.initScript()

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
	order_bucket.setParamType(LinearCharacterCard)

	var init_function = Function.new()
	var init_graph = FuncGraph.new()
	var init_func = FuncUnit.new()

	init_func.setFuncSetName("ArrayOperFuncSet")
	init_func.setFuncName("randomShuffle")
	init_func.initDefaultParams()
	var init_node = init_graph.genNode(init_func)
	init_graph.setRoot(init_node)
	init_function.setGraph(init_graph)
	init_function.initParamMap()

	var regular_function = Function.new()
	var regular_graph = FuncGraph.new()
	var regular_func = FuncUnit.new()
	regular_func.setFuncSetName("BaseFuncSet")
	regular_func.setFuncName("returnVal")
	regular_func.initDefaultParams()
	var regular_node = regular_graph.genNode(regular_func)
	regular_graph.setRoot(regular_node)
	regular_function.setGraph(regular_graph)
	regular_function.initParamMap()

	order_bucket.setInitShuffleFunction(init_function)
	order_bucket.setRegularShuffleFunction(regular_function)

	return order_bucket

func __buildMainCharacterFuncUnit():
	var card_unit = FuncUnit.new()
	card_unit.setFuncSetName("CardFuncSet")
	card_unit.setFuncName("getCardWithDefaultName")
	card_unit.initDefaultParams()
	card_unit.setDefaultParam("StringPack", "MainCharacterCard", 0)

	return card_unit

func __buildEnemyCharacterFuncUnit():
	var card_unit = FuncUnit.new()
	card_unit.setFuncSetName("CardFuncSet")
	card_unit.setFuncName("getCardWithDefaultName")
	card_unit.initDefaultParams()
	card_unit.setDefaultParam("StringPack", "EnemyCharacterCard", 0)

	return card_unit

func __buildPackFuncUnit():
	var pack_unit = FuncUnit.new()
	pack_unit.setFuncSetName("ArrayOperFuncSet")
	pack_unit.setFuncName("packArray")
	pack_unit.initDefaultParams()

	return pack_unit

func __buildAppendFuncUnit():
	var append_unit = FuncUnit.new()
	append_unit.setFuncSetName("ArrayOperFuncSet")
	append_unit.setFuncName("appendVal")
	append_unit.initDefaultParams()

	return append_unit

func __buildCharacterDealFunction():
	var character_deal_function = Function.new()
	var graph = FuncGraph.new()

	var node1 = graph.genNode(__buildMainCharacterFuncUnit())
	var node2 = graph.genNode(__buildMainCharacterFuncUnit())
	var node3 = graph.genNode(__buildEnemyCharacterFuncUnit())
	var node4 = graph.genNode(__buildEnemyCharacterFuncUnit())

	var pack_node1 = graph.genNode(__buildPackFuncUnit())
	var pack_node2 = graph.genNode(__buildPackFuncUnit())
	var pack_node3 = graph.genNode(__buildPackFuncUnit())

	var append_node1 = graph.genNode(__buildAppendFuncUnit())
	var append_node2 = graph.genNode(__buildAppendFuncUnit())
	var append_node3 = graph.genNode(__buildAppendFuncUnit())

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

	character_deal_function.setGraph(graph)
	character_deal_function.initParamMap()

	return character_deal_function

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

	# character_deal_function
	var character_deal_function = __buildCharacterDealFunction()
	linear_battle_model.setCharacterDealFunction(character_deal_function)

	linear_battle.setSceneModel(linear_battle_model)

	var script_tree = linear_battle.pack()
	script_tree.exportAsJson("res://test/scripts/linear_battle.json")

	pass_test("Create linear battle script success")
