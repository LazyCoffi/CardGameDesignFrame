extends GutTest

var SubMenuScene = TypeUnit.type("SubMenuScene")
var SubMenuModel = TypeUnit.type("SubMenuModel")

func __buildResumeFunction():
	var switch_node = FuncGraphNode.new()
	switch_node.setFunc("SceneOperFuncSet", "popScene")

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

func __buildExitFunction():
	var switch_node = FuncGraphNode.new()
	switch_node.setFunc("SceneOperFuncSet", "switchScene")

	var string_pack = StringPack.new()
	string_pack.setVal("main_menu")
	switch_node.setDefaultParam("StringPack", string_pack, 1)

	var graph = FuncGraph.new()

	graph.addNode(switch_node)
	graph.construct()

	var function = Function.new()
	function.setGraph(graph)

	var hyper = HyperFunction.new()
	hyper.addFunction(function)

	return hyper

func test_buildSubMenuScript():
	var sub_menu = SubMenuScene.instance()
	sub_menu.setSceneName("sub_menu")

	var sub_menu_model = SubMenuModel.new()
	sub_menu_model.setResumeFunction(__buildResumeFunction())
	sub_menu_model.setSettingFunction(__buildSettingFunction())
	sub_menu_model.setExitFunction(__buildExitFunction())

	sub_menu.setModel(sub_menu_model)

	var script_tree = sub_menu.pack()
	script_tree.exportAsJson("res://test/scripts/sub_menu.json")

	pass_test("SubMenu script generate success!")
