extends GutTest

var DialogScene = TypeUnit.type("DialogScene")
var DialogModel = TypeUnit.type("DialogModel")

func __buildSwitchFunction():
	var switch_node = FuncGraphNode.new()
	switch_node.setFunc("SceneOperFuncSet", "switchScene")

	var target_pack = StringPack.new()
	target_pack.setVal("explore_map")

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

	dialog_model.setTitle("战斗胜利")
	dialog_model.setInfo("你的团队扫除了最后的障碍，现在可以继续前进了")
	
	dialog_model.addOption("继续前进", __buildSwitchFunction())

	return dialog_model

func test_buildDialogScene():
	var dialog = DialogScene.instance()

	dialog.setSceneName("victory_dialog")
	dialog.setModel(__buildDialogModel())

	var script_tree = dialog.pack()
	script_tree.exportAsJson("res://test/scripts/victory_dialog.json")

	pass_test("Create victory dialog script success")
