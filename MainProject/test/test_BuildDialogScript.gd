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

func __buildDialogModel():
	var dialog_model = DialogModel.new()

	dialog_model.setTitle("测试事件")
	dialog_model.setInfo("这是一段长文字，用于描述当前Dialog对应的事件，仅作为测试")

	dialog_model.addOption("返回！", __buildPopFunction())
	dialog_model.addOption("返回！", __buildPopFunction())
	dialog_model.addOption("返回！", __buildPopFunction())
	dialog_model.addOption("返回！", __buildPopFunction())

	return dialog_model

func test_buildDialogScene():
	var dialog = DialogScene.instance()

	dialog.setSceneName("test_dialog")
	dialog.setModel(__buildDialogModel())

	var script_tree = dialog.pack()
	script_tree.exportAsJson("res://test/scripts/test_dialog.json")

	pass_test("TestDialog script generate success!")
