extends GutTest

var MainMenuScene = TypeUnit.type("MainMenuScene")
var MainMenuModel = TypeUnit.type("MainMenuModel")
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

	var archive_node = FuncGraphNode.new()
	archive_node.setFunc("ArchiveOperFuncSet", "createArchive")

	var archive_graph = FuncGraph.new()

	archive_graph.addNode(archive_node)
	archive_graph.construct()

	var archive_function = Function.new()
	archive_function.setGraph(archive_graph)

	var hyper = HyperFunction.new()
	hyper.addFunction(function)
	hyper.addFunction(archive_function)

	return hyper

func __buildContinueFunction():
	var switch_node = FuncGraphNode.new()
	switch_node.setFunc("SceneOperFuncSet", "pushScene")

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
	switch_node.setFunc("SceneOperFuncSet", "pushScene")

	var string_pack = StringPack.new()
	string_pack.setVal("setting")
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
	var exit_node = FuncGraphNode.new()
	exit_node.setFunc("SceneOperFuncSet", "quitGame")

	var graph = FuncGraph.new()
	graph.addNode(exit_node)
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
