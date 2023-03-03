extends GutTest

var SwitchTargetTable = TypeUnit.type("SwitchTargetTable")
var Function = TypeUnit.type("Function")
var PollingBucket = TypeUnit.type("PollingBucket")
var LinearCharacterCard = TypeUnit.type("LinearCharacterCard")
var FuncGraph = TypeUnit.type("FuncGraph")
var TargetPack = TypeUnit.type("TargetPack")
var ParamNode = TypeUnit.type("ParamNode")
var ParamList = TypeUnit.type("ParamList")
var FuncGraphNode = TypeUnit.type("FuncGraphNode")
var StringPack = TypeUnit.type("StringPack")

var LinearBattleScene = TypeUnit.type("LinearBattleScene")
var LinearBattleModel = TypeUnit.type("LinearBattleModel")

func before_all():
	pass

func __buildOrderBucket():
	var order_bucket = PollingBucket.new()
	order_bucket.setParamType(LinearCharacterCard)

	var init_param_node = ParamNode.new()
	init_param_node.setParamType("NullPack")
	init_param_node.setParam(NullPack.new())

	var init_param_list = ParamList.new()
	init_param_list.addParam(init_param_node)

	var init_func = FuncUnit.new()
	init_func.setFuncSetName("BaseFuncSet")
	init_func.setFuncName("returnVal")
	init_func.setDefaultParams(init_param_list)

	var init_node = FuncGraphNode.new()
	init_node.setFuncUnit(init_func)
	init_node.setChIndexList([null])

	var init_graph = FuncGraph.new()
	init_graph.addNode(init_node)
	init_graph.construct()

	var init_function = Function.new()
	init_function.setGraph(init_graph)
	init_function.setMap(["returnVal_0_0"])

	var regular_param_node = ParamNode.new()
	regular_param_node.setParamType("NullPack")
	regular_param_node.setParam(NullPack.new())

	var regular_param_list = ParamList.new()
	regular_param_list.addParam(regular_param_node)

	var regular_func = FuncUnit.new()
	regular_func.setFuncSetName("BaseFuncSet")
	regular_func.setFuncName("returnVal")
	regular_func.setDefaultParams(regular_param_list)

	var regular_node = FuncGraphNode.new()
	regular_node.setFuncUnit(regular_func)
	regular_node.setChIndexList([null])

	var regular_graph = FuncGraph.new()
	regular_graph.addNode(regular_node)
	regular_graph.construct()

	var regular_function = Function.new()
	regular_function.setGraph(regular_graph)
	regular_function.setMap(["returnVal_0_0"])

	order_bucket.setInitShuffleFunction(init_function)
	order_bucket.setRegularShuffleFunction(regular_function)

	return order_bucket

func __buildOwnCharacterFuncUnit():
	var param_node = ParamNode.new()
	param_node.setParamType("StringPack")
	var string_pack = StringPack.new()
	string_pack.setVal("MainCharacterCard")
	param_node.setParam(string_pack)

	var param_list = ParamList.new()
	param_list.addParam(param_node)

	var card_unit = FuncUnit.new()
	card_unit.setFuncSetName("CardFuncSet")
	card_unit.setFuncName("getCardWithDefaultName")
	card_unit.setDefaultParams(param_list)

	return card_unit

func __buildEnemyCharacterFuncUnit():
	var param_node = ParamNode.new()
	param_node.setParamType("StringPack")
	var string_pack = StringPack.new()
	string_pack.setVal("EnemyCharacterCard")
	param_node.setParam(string_pack)

	var param_list = ParamList.new()
	param_list.addParam(param_node)

	var card_unit = FuncUnit.new()
	card_unit.setFuncSetName("CardFuncSet")
	card_unit.setFuncName("getCardWithDefaultName")
	card_unit.setDefaultParams(param_list)

	return card_unit

func __buildPackFuncUnit():
	var param_node = ParamNode.new()
	param_node.setParamType("NullPack")
	param_node.setParam(NullPack.new())

	var param_list = ParamList.new()
	param_list.addParam(param_node)

	var pack_unit = FuncUnit.new()
	pack_unit.setFuncSetName("ArrayOperFuncSet")
	pack_unit.setFuncName("packArray")
	pack_unit.setDefaultParams(param_list)

	return pack_unit

func __buildAppendFuncUnit():
	var param_node = ParamNode.new()
	param_node.setParamType("NullPack")
	param_node.setParam(NullPack.new())

	var param_node0 = ParamNode.new()
	param_node0.setParamType("NullPack")
	param_node0.setParam(NullPack.new())

	var param_list = ParamList.new()
	param_list.addParam(param_node)
	param_list.addParam(param_node0)

	var append_unit = FuncUnit.new()
	append_unit.setFuncSetName("ArrayOperFuncSet")
	append_unit.setFuncName("appendVal")
	append_unit.setDefaultParams(param_list)

	return append_unit

func __buildOwnTeamFunction():
	var own_team_function = Function.new()
	var graph = FuncGraph.new()

	var node1 = FuncGraphNode.new()
	node1.setFuncUnit(__buildOwnCharacterFuncUnit())
	node1.setChIndexList([null])
	var node2 = FuncGraphNode.new()
	node2.setFuncUnit(__buildOwnCharacterFuncUnit())
	node2.setChIndexList([null])

	var pack_node = FuncGraphNode.new()
	pack_node.setFuncUnit(__buildPackFuncUnit())
	pack_node.setChIndexList([2])

	var append_node = FuncGraphNode.new()
	append_node.setFuncUnit(__buildAppendFuncUnit())
	append_node.setChIndexList([1, 3])

	graph.addNode(append_node)
	graph.addNode(pack_node)
	graph.addNode(node1)
	graph.addNode(node2)
	graph.construct()

	own_team_function.setGraph(graph)
	own_team_function.setMap([])

	return own_team_function

func __buildEnemyTeamFunction():
	var enemy_team_function = Function.new()
	var graph = FuncGraph.new()

	var node1 = FuncGraphNode.new()
	node1.setFuncUnit(__buildEnemyCharacterFuncUnit())
	node1.setChIndexList([null])
	var node2 = FuncGraphNode.new()
	node2.setFuncUnit(__buildEnemyCharacterFuncUnit())
	node2.setChIndexList([null])

	var pack_node = FuncGraphNode.new()
	pack_node.setFuncUnit(__buildPackFuncUnit())
	pack_node.setChIndexList([2])

	var append_node = FuncGraphNode.new()
	append_node.setFuncUnit(__buildAppendFuncUnit())
	append_node.setChIndexList([1, 3])

	graph.addNode(append_node)
	graph.addNode(pack_node)
	graph.addNode(node1)
	graph.addNode(node2)
	graph.construct()

	enemy_team_function.setGraph(graph)
	enemy_team_function.setMap([])

	return enemy_team_function

func __buildIsDeadCondition():

	var extract_param_node = ParamNode.new()
	extract_param_node.setParamType("NullPack")
	extract_param_node.setParam(NullPack.new())

	var extract_param_list = ParamList.new()
	extract_param_list.addParam(extract_param_node)

	var extract_unit = FuncUnit.new()
	extract_unit.setFuncSetName("CardFuncSet")
	extract_unit.setFuncName("extractAttr")
	extract_unit.setDefaultParams(extract_param_list)

	var is_null_param_node = ParamNode.new()
	is_null_param_node.setParamType("NullPack")
	is_null_param_node.setParam(NullPack.new())

	var is_str_param_node = ParamNode.new()
	is_str_param_node.setParamType("StringPack")
	var string_pack = StringPack.new()
	string_pack.setVal("hp")
	is_str_param_node.setParam(string_pack)

	var is_int_param_node = ParamNode.new()
	is_int_param_node.setParamType("Integer")
	var int_pack = Integer.new()
	int_pack.setVal(0)
	is_int_param_node.setParam(int_pack)

	var is_le_param_list = ParamList.new()
	is_le_param_list.addParam(is_null_param_node)
	is_le_param_list.addParam(is_str_param_node)
	is_le_param_list.addParam(is_int_param_node)

	var is_le_unit = FuncUnit.new()
	is_le_unit.setFuncSetName("AttrConditionSet")
	is_le_unit.setFuncName("isLessEqualInt")
	is_le_unit.setDefaultParams(is_le_param_list)

	var is_le_node = FuncGraphNode.new()
	is_le_node.setFuncUnit(is_le_unit)
	is_le_node.setChIndexList([1, null, null])

	var extract_node = FuncGraphNode.new()
	extract_node.setFuncUnit(extract_unit)
	extract_node.setChIndexList([null])

	var graph = FuncGraph.new()
	graph.addNode(is_le_node)
	graph.addNode(extract_node)
	graph.construct()

	var is_dead_condition = Function.new()
	is_dead_condition.setGraph(graph)
	is_dead_condition.setMap(["extractAttr_1_0"])

	return is_dead_condition

func __buildDrawNumFunction():
	var param_node = ParamNode.new()
	param_node.setParamType("Integer")
	var integer = Integer.new()
	integer.setVal(2)
	param_node.setParam(integer)

	var param_list = ParamList.new()
	param_list.addParam(param_node)

	var const_unit = FuncUnit.new()
	const_unit.setFuncSetName("MathFuncSet")
	const_unit.setFuncName("constVal")
	const_unit.setDefaultParams(param_list)

	var node = FuncGraphNode.new()
	node.setFuncUnit(const_unit)
	node.setChIndexList([null])

	var graph = FuncGraph.new()
	graph.addNode(node)
	graph.construct()

	var draw_num_function = Function.new()
	draw_num_function.setGraph(graph)
	draw_num_function.setMap(["constVal_0_0"])

	return draw_num_function

func __buildIsBattleOverCondition():
	var is_battle_over_condition = Function.new()

	var own_empty_param_node = ParamNode.new()
	own_empty_param_node.setParamType("NullPack")
	own_empty_param_node.setParam(NullPack.new())

	var own_empty_param_list = ParamList.new()
	own_empty_param_list.addParam(own_empty_param_node)

	var own_empty_unit = FuncUnit.new()
	own_empty_unit.setFuncSetName("LinearBattleConditionSet")
	own_empty_unit.setFuncName("isOwnTeamEmpty")
	own_empty_unit.setDefaultParams(own_empty_param_list)

	var enemy_empty_param_node = ParamNode.new()
	enemy_empty_param_node.setParamType("NullPack")
	enemy_empty_param_node.setParam(NullPack.new())

	var enemy_empty_param_list = ParamList.new()
	enemy_empty_param_list.addParam(enemy_empty_param_node)

	var enemy_empty_unit = FuncUnit.new()
	enemy_empty_unit.setFuncSetName("LinearBattleConditionSet")
	enemy_empty_unit.setFuncName("isEnemyTeamEmpty")
	enemy_empty_unit.setDefaultParams(enemy_empty_param_list)

	var or_empty_param_node0 = ParamNode.new()
	or_empty_param_node0.setParamType("NullPack")
	or_empty_param_node0.setParam(NullPack.new())

	var or_empty_param_node1 = ParamNode.new()
	or_empty_param_node1.setParamType("NullPack")
	or_empty_param_node1.setParam(NullPack.new())

	var or_empty_param_list = ParamList.new()
	or_empty_param_list.addParam(or_empty_param_node0)
	or_empty_param_list.addParam(or_empty_param_node1)

	var or_unit = FuncUnit.new()
	or_unit.setFuncSetName("BaseConditionSet")
	or_unit.setFuncName("orGate")
	or_unit.setDefaultParams(or_empty_param_list)

	var val_empty_param_node = ParamNode.new()
	val_empty_param_node.setParamType("NullPack")
	val_empty_param_node.setParam(NullPack.new())

	var val_empty_param_list = ParamList.new()
	val_empty_param_list.addParam(val_empty_param_node)
	val_empty_param_list.addParam(val_empty_param_node)

	var val_unit = FuncUnit.new()
	val_unit.setFuncSetName("BaseFuncSet")
	val_unit.setFuncName("returnVal")
	val_unit.setDefaultParams(val_empty_param_list)


	var or_node = FuncGraphNode.new()
	or_node.setFuncUnit(or_unit)
	or_node.setChIndexList([1, 2])

	var own_empty_node = FuncGraphNode.new()
	own_empty_node.setFuncUnit(own_empty_unit)
	own_empty_node.setChIndexList([3])
	
	var enemy_empty_node = FuncGraphNode.new()
	enemy_empty_node.setFuncUnit(enemy_empty_unit)
	enemy_empty_node.setChIndexList([3])

	var val_node = FuncGraphNode.new()
	val_node.setFuncUnit(val_unit)
	val_node.setChIndexList([null])
	
	var graph = FuncGraph.new()
	graph.addNode(or_node)
	graph.addNode(own_empty_node)
	graph.addNode(enemy_empty_node)
	graph.addNode(val_node)
	graph.construct()
	
	is_battle_over_condition.setGraph(graph)
	is_battle_over_condition.setMap(["returnVal_3_0"])

	return is_battle_over_condition

func __buildSwitchTargetTable():
	var switch_target_table = SwitchTargetTable.new()
	var main_menu_pack = TargetPack.new()
	main_menu_pack.setTargetName("BattleOver")
	main_menu_pack.setSceneType("MainMenuScene")
	main_menu_pack.setSceneName("main_menu")
	main_menu_pack.setSwitchType("switch")
	switch_target_table.addTarget(main_menu_pack)

	var sub_menu_pack = TargetPack.new()
	sub_menu_pack.setTargetName("OpenSubMenu")
	sub_menu_pack.setSceneType("SubMenuScene")
	sub_menu_pack.setSceneName("sub_menu")
	sub_menu_pack.setSwitchType("push")
	switch_target_table.addTarget(sub_menu_pack)

	return switch_target_table

func test_buildLinearBattleScript():
	var linear_battle = LinearBattleScene.instance()

	linear_battle.setSceneName("linear_battle")
	
	var switch_target_table = __buildSwitchTargetTable()
	linear_battle.setSwitchTargetTable(switch_target_table)
	
	var linear_battle_model = LinearBattleModel.new()

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
