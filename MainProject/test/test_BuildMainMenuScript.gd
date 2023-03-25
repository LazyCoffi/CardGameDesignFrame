extends GutTest

var MainMenuScene = TypeUnit.type("MainMenuScene")
var MainMenuModel = TypeUnit.type("MainMenuModel")
var TargetPack = TypeUnit.type("TargetPack")
var FuncGraphNode = TypeUnit.type("FuncGraphNode")
var FuncGraph = TypeUnit.type("FuncGraph")
var Function = TypeUnit.type("Function")
var HyperFunction = TypeUnit.type("HyperFunction")

func __buildStartFunction():
	var switch_node = FuncGraphNode.new()
	switch_node.setFunc("SceneOperFuncSet", "switchScene")

	var string_pack = StringPack.new()
	string_pack.setVal("explore_map")
	switch_node.setDefaultParam("StringPack", string_pack, 1)

	var graph = FuncGraph.new()

	graph.addNode(switch_node)
	graph.construct()

	var function = Function.new()
	function.setGraph(graph)

	var hyper = HyperFunction.new()
	hyper.addFunction(function)

	return hyper

func __buildContinueFunction():
	var switch_node = FuncGraphNode.new()
	switch_node.setFunc("SceneOperFuncSet", "switchScene")

	var string_pack = StringPack.new()
	string_pack.setVal("archive_menu")
	switch_node.setDefaultParam("StringPack", string_pack, 1)

	var graph = FuncGraph.new()

	graph.addNode(switch_node)
	graph.construct()

	var function = Function.new()
	function.setGraph(graph)

	var hyper = HyperFunction.new()
	hyper.addFunction(function)

	return hyper

func __buildSettingFunction():
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

	var hyper = HyperFunction.new()
	hyper.addFunction(function)

	return hyper

func __buildExitFunction():
	var switch_node = FuncGraphNode.new()
	switch_node.setFunc("SceneOperFuncSet", "switchScene")

	var string_pack = StringPack.new()
	string_pack.setVal("explore_map")
	switch_node.setDefaultParam("StringPack", string_pack, 1)

	var graph = FuncGraph.new()

	graph.addNode(switch_node)
	graph.construct()

	var function = Function.new()
	function.setGraph(graph)

	var hyper = HyperFunction.new()
	hyper.addFunction(function)

	return hyper

func test_buildMainMenuScript():
	var main_menu = MainMenuScene.instance()
	main_menu.setSceneName("main_menu")

	var model = MainMenuModel.new()

	model.setStartFunction(__buildStartFunction())
	model.setContinueFunction(__buildContinueFunction())
	model.setSettingFunction(__buildSettingFunction())
	model.setExitFunction(__buildExitFunction())

	main_menu.setModel(model)

	var script_tree = main_menu.pack()
	script_tree.exportAsJson("res://test/scripts/main_menu.json")

	pass_test("MainMenu script generate success!")
