extends GutTest

var DialogScene = TypeUnit.type("DialogScene")
var DialogModel = TypeUnit.type("DialogModel")

func __buildSwitchFunction():
	var switch_node = FuncGraphNode.new()
	switch_node.setFunc("SceneOperFuncSet", "switchScene")

	var target_pack = StringPack.new()
	target_pack.setVal("main_menu")

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

	dialog_model.setTitle("战斗失败")
	dialog_model.setInfo("你的团队英勇的战斗，但最终仍被敌人击倒在地，这也意味着你们的旅途和生命都到此位置了")
	
	dialog_model.addOption("返回主菜单", __buildSwitchFunction())

	return dialog_model

func test_buildDialogScene():
	var dialog = DialogScene.instance()

	dialog.setSceneName("fail_dialog")
	dialog.setModel(__buildDialogModel())

	var script_tree = dialog.pack()
	script_tree.exportAsJson("res://test/scripts/fail_dialog.json")

	pass_test("Create victory dialog script success")
