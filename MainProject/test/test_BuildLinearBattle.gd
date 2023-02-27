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
	pass

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
	init_func.setFuncSetName("BaseFuncSet")
	init_func.setFuncName("returnVal")
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

func __buildOwnCharacterFuncUnit():
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

func __buildOwnTeamFunction():
	var own_team_function = Function.new()
	var graph = FuncGraph.new()

	var node1 = graph.genNode(__buildOwnCharacterFuncUnit())
	var node2 = graph.genNode(__buildOwnCharacterFuncUnit())

	var pack_node = graph.genNode(__buildPackFuncUnit())
	var append_node = graph.genNode(__buildAppendFuncUnit())

	pack_node.connectNode(node1, 0)
	append_node.connectNode(pack_node, 0)
	append_node.connectNode(node2, 1)

	graph.setRoot(append_node)
	own_team_function.setGraph(graph)
	own_team_function.initParamMap()

	return own_team_function

func __buildEnemyTeamFunction():
	var enemy_team_function = Function.new()
	var graph = FuncGraph.new()

	var node1 = graph.genNode(__buildEnemyCharacterFuncUnit())
	var node2 = graph.genNode(__buildEnemyCharacterFuncUnit())

	var pack_node = graph.genNode(__buildPackFuncUnit())
	var append_node = graph.genNode(__buildAppendFuncUnit())

	pack_node.connectNode(node1, 0)
	append_node.connectNode(pack_node, 0)
	append_node.connectNode(node2, 1)

	graph.setRoot(append_node)
	enemy_team_function.setGraph(graph)
	enemy_team_function.initParamMap()

	return enemy_team_function

func __buildIsDeadCondition():
	var is_dead_condition = Function.new()

	var extract_unit = FuncUnit.new()
	extract_unit.setFuncSetName("CardFuncSet")
	extract_unit.setFuncName("extractAttr")
	extract_unit.initDefaultParams()

	var is_le_unit = FuncUnit.new()
	is_le_unit.setFuncSetName("AttrConditionSet")
	is_le_unit.setFuncName("isLessEqualInt")
	is_le_unit.initDefaultParams()
	is_le_unit.setDefaultParam("StringPack", "hp", 1)
	is_le_unit.setDefaultParam("Integer", 0, 2)

	var graph = FuncGraph.new()
	var extract_node = graph.genNode(extract_unit)
	var is_le_node = graph.genNode(is_le_unit)
	is_le_node.connectNode(extract_node, 0)
	graph.setRoot(is_le_node)

	is_dead_condition.setGraph(graph)
	is_dead_condition.initParamMap()

	return is_dead_condition

func __buildDrawNumFunction():
	var draw_num_function = Function.new()

	var const_unit = FuncUnit.new()
	const_unit.setFuncSetName("MathFuncSet")
	const_unit.setFuncName("constVal")
	const_unit.initDefaultParams()
	const_unit.setDefaultParam("Integer", 2, 0)

	var graph = FuncGraph.new()
	var node = graph.genNode(const_unit)
	graph.setRoot(node)

	draw_num_function.setGraph(graph)
	draw_num_function.initParamMap()

	return draw_num_function

func __buildIsBattleOverCondition():
	var is_battle_over_condition = Function.new()

	var own_empty_unit = FuncUnit.new()
	own_empty_unit.setFuncSetName("LinearBattleConditionSet")
	own_empty_unit.setFuncName("isOwnTeamEmpty")
	own_empty_unit.initDefaultParams()

	var enemy_empty_unit = FuncUnit.new()
	enemy_empty_unit.setFuncSetName("LinearBattleConditionSet")
	enemy_empty_unit.setFuncName("isEnemyTeamEmpty")
	enemy_empty_unit.initDefaultParams()

	var or_unit = FuncUnit.new()
	or_unit.setFuncSetName("BaseConditionSet")
	or_unit.setFuncName("orGate")
	or_unit.initDefaultParams()

	var val_unit = FuncUnit.new()
	val_unit.setFuncSetName("BaseFuncSet")
	val_unit.setFuncName("returnVal")
	val_unit.initDefaultParams()

	var graph = FuncGraph.new()
	var own_empty_node = graph.genNode(own_empty_unit)
	var enemy_empty_node = graph.genNode(enemy_empty_unit)
	var or_node = graph.genNode(or_unit)
	or_node.connectNode(own_empty_node, 0)
	or_node.connectNode(enemy_empty_node, 1)

	var val_node = graph.genNode(val_unit)
	own_empty_node.connectNode(val_node, 0)
	enemy_empty_node.connectNode(val_node, 0)

	graph.setRoot(or_node)
	
	is_battle_over_condition.setGraph(graph)
	is_battle_over_condition.initParamMap()

	return is_battle_over_condition

func __buildSwitchTargetTable():
	var switch_target_table = SwitchTargetTable.new()
	switch_target_table.addTarget("BattleOver", "MainMenuScene", "main_menu", "switch")
	switch_target_table.addTarget("OpenSubMenu", "SubMenuScene", "sub_menu", "switch")
	
	return switch_target_table

func test_buildLinearBattleScript():
	var linear_battle = LinearBattleScene.instance()

	linear_battle.setSceneName("linear_battle")
	
	var switch_target_table = __buildSwitchTargetTable()
	linear_battle.setSwitchTargetTable(switch_target_table)
	
	var linear_battle_model = LinearBattleModel.new()

	# setting
	var setting = __buildSetting()
	linear_battle_model.setSetting(setting)
	
	# order_bucket
	var order_bucket = __buildOrderBucket()
	linear_battle_model.setOrderBucket(order_bucket)
	linear_battle_model.setOwnTeamFunction(__buildOwnTeamFunction())
	linear_battle_model.setEnemyTeamFunction(__buildEnemyTeamFunction())
	linear_battle_model.setDrawNumFunction(__buildDrawNumFunction())
	linear_battle_model.setIsDeadCondition(__buildIsDeadCondition())
	linear_battle_model.setIsBattleOverCondition(__buildIsBattleOverCondition())
	linear_battle.setSceneModel(linear_battle_model)

	var script_tree = linear_battle.pack()
	script_tree.exportAsJson("res://test/scripts/linear_battle.json")

	pass_test("Create linear battle script success")
