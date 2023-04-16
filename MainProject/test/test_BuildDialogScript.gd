extends GutTest

var DialogScene = TypeUnit.type("DialogScene")
var DialogModel = TypeUnit.type("DialogModel")

func __buildPopFunction():
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

func __buildFightFunction():
	var switch_node = FuncGraphNode.new()
	switch_node.setFunc("SceneOperFuncSet", "switchScene")

	var target_pack = StringPack.new()
	target_pack.setVal("demo1")

	switch_node.setDefaultParam("StringPack", target_pack, 1)

	var graph = FuncGraph.new()

	graph.addNode(switch_node)
	graph.construct()

	var function = Function.new()
	function.setGraph(graph)

	var hyper = HyperFunction.new()
	hyper.addFunction(function)

	return hyper

func __buildDialogModel():
	var dialog_model = DialogModel.new()

	dialog_model.setTitle("战斗事件")
	dialog_model.setInfo("你在前往目标的路上遇到了两个山贼！他们警惕着想你走来，你必须立马做出决定。")

	dialog_model.addOption("拔出剑开始战斗", __buildFightFunction())
	dialog_model.addOption("远离麻烦，立马转身逃跑", __buildPopFunction())

	return dialog_model

func test_buildDialogScene():
	var dialog = DialogScene.instance()

	dialog.setSceneName("test_dialog")
	dialog.setModel(__buildDialogModel())

	var script_tree = dialog.pack()
	script_tree.exportAsJson("res://test/scripts/test_dialog.json")

	pass_test("TestDialog script generate success!")
