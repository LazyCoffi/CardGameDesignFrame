extends GutTest

var LinearBattleScene = TypeUnit.type("LinearBattleScene")
var LinearBattleModel = TypeUnit.type("LinearBattleModel")
var PollingBucket = TypeUnit.type("PollingBucket")
var LinearCharacterCard = TypeUnit.type("LinearCharacterCard")
var StringPack = TypeUnit.type("StringPack")
var Integer = TypeUnit.type("Integer")

func __buildOrderBucket(): 
	var init_node = FuncGraphNode.new()
	init_node.setFunc("BaseFuncSet", "returnVal")

	var init_graph = FuncGraph.new()

	init_graph.addNode(init_node)
	init_graph.construct()

	var init_function = Function.new()
	init_function.setGraph(init_graph)
	
	var regular_node = FuncGraphNode.new()
	regular_node.setFunc("BaseFuncSet", "returnVal")

	var regular_graph = FuncGraph.new()

	regular_graph.addNode(regular_node)
	regular_graph.construct()

	var regular_function = Function.new()
	regular_function.setGraph(regular_graph) 

	var order_bucket = PollingBucket.new()
	order_bucket.setParamType(LinearCharacterCard)
	order_bucket.setInitShuffleFunction(init_function)
	order_bucket.setRegularShuffleFunction(regular_function)

	return order_bucket

func __buildOwnTeamFunction():
	var ch_node = FuncGraphNode.new()

	var type_pack = StringPack.new()
	type_pack.setVal("KnightCharacterCard")

	var name_pack = StringPack.new()
	name_pack.setVal("骑士")

	ch_node.setFunc("CardFuncSet", "createCard")
	ch_node.setDefaultParam("StringPack", type_pack, 0)
	ch_node.setDefaultParam("StringPack", name_pack, 1)

	var pack_node = FuncGraphNode.new()
	pack_node.setFunc("ArrayOperFuncSet", "packArray")

	var graph = FuncGraph.new()
	graph.addNode(pack_node)
	graph.addNode(ch_node)

	pack_node.setChIndex(1, 0)

	graph.construct()

	var own_team_function = Function.new()
	own_team_function.setGraph(graph)

	return own_team_function

func __buildEnemyTeamFunction():
	var type_pack = StringPack.new()
	type_pack.setVal("RobberCharacterCard")

	var ch1_node = FuncGraphNode.new()
	var name_pack1 = StringPack.new()
	name_pack1.setVal("强盗A")
	ch1_node.setFunc("CardFuncSet", "createCard")
	ch1_node.setDefaultParam("StringPack", type_pack, 0)
	ch1_node.setDefaultParam("StringPack", name_pack1, 1)

	var ch2_node = FuncGraphNode.new()
	var name_pack2 = StringPack.new()
	name_pack2.setVal("强盗B")
	ch2_node.setFunc("CardFuncSet", "createCard")
	ch2_node.setDefaultParam("StringPack", type_pack, 0)
	ch2_node.setDefaultParam("StringPack", name_pack2, 1)

	var pack_node = FuncGraphNode.new()
	pack_node.setFunc("ArrayOperFuncSet", "packArray")

	var array_node = FuncGraphNode.new()
	array_node.setFunc("ArrayOperFuncSet", "appendVal")

	var graph = FuncGraph.new()
	graph.addNode(array_node)
	graph.addNode(pack_node)
	graph.addNode(ch1_node)
	graph.addNode(ch2_node)

	array_node.setChIndex(1, 0)
	array_node.setChIndex(3, 1)
	pack_node.setChIndex(2, 0)

	graph.construct()

	var enemy_team_function = Function.new()
	enemy_team_function.setGraph(graph)

	return enemy_team_function

func __buildIsDeadCondition():
	var extract_node = FuncGraphNode.new()
	extract_node.setFunc("CardFuncSet", "extractAttr")

	var is_le_node = FuncGraphNode.new()
	is_le_node.setFunc("AttrConditionSet", "isLessEqualInt")

	var hp_pack = StringPack.new()
	hp_pack.setVal("健康值")
	is_le_node.setDefaultParam("StringPack", hp_pack, 1)

	var hp_int_pack = Integer.new()
	hp_int_pack.setVal(0)
	is_le_node.setDefaultParam("Integer", hp_int_pack, 2)

	var graph = FuncGraph.new()

	graph.addNode(is_le_node)
	graph.addNode(extract_node)

	is_le_node.setChIndex(1, 0)

	graph.construct()

	var is_dead_condition = Function.new()
	is_dead_condition.setGraph(graph)

	return is_dead_condition

func __buildDrawNumFunction():
	var extract_node = FuncGraphNode.new()
	extract_node.setFunc("CardFuncSet", "extractAttr")

	var get_node = FuncGraphNode.new()
	get_node.setFunc("AttrFuncSet", "getAttrInt")
	var action_pack = StringPack.new()
	action_pack.setVal("手牌上限")
	get_node.setDefaultParam("StringPack", action_pack, 1)

	var graph = FuncGraph.new()
	graph.addNode(get_node)
	graph.addNode(extract_node)

	get_node.setChIndex(1, 0)

	graph.construct()

	var draw_num_function = Function.new()
	draw_num_function.setGraph(graph)

	return draw_num_function

func __buildIsVictoryCondition():
	var victory_node = FuncGraphNode.new()
	victory_node.setFunc("LinearBattleConditionSet", "isEnemyTeamEmpty")
	var string_pack = StringPack.new()
	string_pack.setVal("demo1")
	victory_node.setDefaultParam("StringPack", string_pack, 0)
	
	var graph = FuncGraph.new()
	graph.addNode(victory_node)
	graph.construct()

	var victory_condition = Function.new()
	victory_condition.setGraph(graph)

	return victory_condition

func __buildIsFailCondition():
	var fail_node = FuncGraphNode.new()
	fail_node.setFunc("LinearBattleConditionSet", "isOwnTeamEmpty")
	var string_pack = StringPack.new()
	string_pack.setVal("demo1")
	fail_node.setDefaultParam("StringPack", string_pack, 0)
	
	var graph = FuncGraph.new()
	graph.addNode(fail_node)
	graph.construct()

	var fail_condition = Function.new()
	fail_condition.setGraph(graph)

	return fail_condition

func __buildBeforeRoundFunction():
	var extract_node = FuncGraphNode.new()
	extract_node.setFunc("CardFuncSet", "extractAttr")

	var refill_ap_node = FuncGraphNode.new()
	refill_ap_node.setFunc("AttrFuncSet", "setConst")
	var attr_ap_pack = StringPack.new()
	attr_ap_pack.setVal("行动点")
	refill_ap_node.setDefaultParam("StringPack", attr_ap_pack, 1)
	var attr_ap_int = Integer.new()
	attr_ap_int.setVal(3)
	refill_ap_node.setDefaultParam("Integer", attr_ap_int, 2)
	
	var reset_ps_node = FuncGraphNode.new()	
	reset_ps_node.setFunc("AttrFuncSet", "setAttrZeroInt")
	var attr_ps_pack = StringPack.new()
	attr_ps_pack.setVal("物理护甲")
	reset_ps_node.setDefaultParam("StringPack", attr_ps_pack, 1)

	var graph = FuncGraph.new()
	graph.addNode(refill_ap_node)
	graph.addNode(reset_ps_node)
	graph.addNode(extract_node)

	refill_ap_node.setChIndex(1, 0)
	reset_ps_node.setChIndex(2, 0)

	graph.construct()

	var before_round_function = Function.new()
	before_round_function.setGraph(graph)

	var hyper = HyperFunction.new()
	hyper.addFunction(before_round_function)

	return hyper

func __buildDummyFunction():
	var dummy_node = FuncGraphNode.new()
	dummy_node.setFunc("BaseFuncSet", "dummy")

	var graph = FuncGraph.new()
	graph.addNode(dummy_node)
	graph.construct()

	var dummy_function = Function.new()
	dummy_function.setGraph(graph)

	var hyper = HyperFunction.new()
	hyper.addFunction(dummy_function)

	return hyper

func __buildVictoryFunction():
	var switch_node = FuncGraphNode.new()
	switch_node.setFunc("SceneOperFuncSet", "pushScene")
	var scene_pack = StringPack.new()
	scene_pack.setVal("victory_dialog")
	switch_node.setDefaultParam("StringPack", scene_pack, 1)

	var graph = FuncGraph.new()
	graph.addNode(switch_node)
	graph.construct()

	var victory_function = Function.new()
	victory_function.setGraph(graph)

	var hyper = HyperFunction.new()
	hyper.addFunction(victory_function)

	return hyper 
	
func __buildFailFunction():
	var switch_node = FuncGraphNode.new()
	switch_node.setFunc("SceneOperFuncSet", "pushScene")
	var scene_pack = StringPack.new()
	scene_pack.setVal("fail_dialog")
	switch_node.setDefaultParam("StringPack", scene_pack, 1)

	var graph = FuncGraph.new()
	graph.addNode(switch_node)
	graph.construct()

	var fail_function = Function.new()
	fail_function.setGraph(graph)

	var hyper = HyperFunction.new()
	hyper.addFunction(fail_function)

	return hyper 

func __buildSubMenuFunction():
	var switch_node = FuncGraphNode.new()
	switch_node.setFunc("SceneOperFuncSet", "pushScene")

	var string_pack = StringPack.new()
	string_pack.setVal("sub_menu")
	switch_node.setDefaultParam("StringPack", string_pack, 1)

	var graph = FuncGraph.new()

	graph.addNode(switch_node)
	graph.construct()

	var function = Function.new()
	function.setGraph(graph)

	var hyper = HyperFunction.new()
	hyper.addFunction(function)

	return hyper

func test_buildDemoScript():
	var demo = LinearBattleScene.instance()

	demo.setSceneName("demo1")

	var demo_model = LinearBattleModel.new()

	demo_model.setOrderBucket(__buildOrderBucket())
	demo_model.setOwnTeamFunction(__buildOwnTeamFunction())
	demo_model.setEnemyTeamFunction(__buildEnemyTeamFunction())
	demo_model.setIsDeadCondition(__buildIsDeadCondition())
	demo_model.setDrawNumFunction(__buildDrawNumFunction())
	demo_model.setIsVictoryCondition(__buildIsVictoryCondition())
	demo_model.setIsFailCondition(__buildIsFailCondition())
	demo_model.setBeforeRoundFunction(__buildBeforeRoundFunction())
	demo_model.setAfterRoundFunction(__buildDummyFunction())
	demo_model.setVictoryFunction(__buildVictoryFunction())
	demo_model.setFailFunction(__buildFailFunction())
	demo_model.setSubMenuFunction(__buildSubMenuFunction())

	demo.setModel(demo_model)

	var script_tree = demo.pack()
	script_tree.exportAsJson("res://test/scripts/demo1.json")

	pass_test("Create demo script success")
