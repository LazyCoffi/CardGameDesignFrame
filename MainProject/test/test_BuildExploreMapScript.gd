extends GutTest

var ExploreMapScene = TypeUnit.type("ExploreMapScene")
var ExploreMapModel = TypeUnit.type("ExploreMapModel")
var MapCanvas = TypeUnit.type("MapCanvas")
var HyperFunction = TypeUnit.type("HyperFunction")
var SwitchTargetTable = TypeUnit.type("SwitchTargetTable")
var FuncGraphNode = TypeUnit.type("FuncGraphNode")
var StringPack = TypeUnit.type("StringPack")
var FuncGraph = TypeUnit.type("FuncGraph")
var Function = TypeUnit.type("Function")

func __buildEffectFunc():
	var switch_node = FuncGraphNode.new()

	switch_node.setFunc("SceneOperFuncSet", "switchScene")

	var string_pack = StringPack.new()
	string_pack.setVal("linear_battle")
	switch_node.setDefaultParam("StringPack", string_pack, 1) 

	var graph = FuncGraph.new()

	graph.addNode(switch_node)
	graph.construct()

	var function = Function.new()
	function.setGraph(graph)
	function.setMapIndex("switchScene_0_0", 0)

	var effect_func = HyperFunction.new()
	effect_func.addFunction(function)
	effect_func.setParamMapIndex(0, 1)

	return effect_func

func __buildDisableFunc():
	var disable_node = FuncGraphNode.new()

	disable_node.setFunc("ExploreMapFuncSet", "disableSelfMapNode")
	
	var graph = FuncGraph.new()
	graph.addNode(disable_node)
	graph.construct()

	var function = Function.new()
	function.setGraph(graph)

	var hyper = HyperFunction.new()
	hyper.addFunction(function)

	return hyper

func __buildExploreMapModel():
	var explore_map_model = ExploreMapModel.new()

	explore_map_model.addMapNode(1, 1, __buildDisableFunc(), true)
	explore_map_model.addMapNode(2, 2, __buildEffectFunc(), true)
	explore_map_model.addMapNode(1, 3, __buildEffectFunc(), false)
	explore_map_model.addMapNode(4, 5, __buildEffectFunc(), false)

	explore_map_model.addMapNodeCh(0, 1)
	explore_map_model.addMapNodeCh(1, 2)
	explore_map_model.addMapNodeCh(1, 3)

	return explore_map_model

func test_buildExploreMapScript():
	var explore_map_scene = ExploreMapScene.instance()
	explore_map_scene.setSceneName("explore_map")
	
	explore_map_scene.setModel(__buildExploreMapModel())

	var script_tree = explore_map_scene.pack()
	script_tree.exportAsJson("res://test/scripts/explore_map.json")

	pass_test("Explore map script generate success!")
