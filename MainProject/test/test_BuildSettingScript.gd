extends GutTest

var SettingScene = TypeUnit.type("SettingScene")
var SettingModel = TypeUnit.type("SettingModel")
var FuncGraphNode = TypeUnit.type("FuncGraphNode")
var FuncGraph = TypeUnit.type("FuncGraph")
var Function = TypeUnit.type("Function")
var HyperFunction = TypeUnit.type("HyperFunction")

func __buildReturnFunction():
	var return_node = FuncGraphNode.new()
	return_node.setFunc("SceneOperFuncSet", "popScene")
	
	var graph = FuncGraph.new()
	graph.addNode(return_node)
	graph.construct()

	var function = Function.new()
	function.setGraph(graph)

	var hyper = HyperFunction.new()
	hyper.addFunction(function)

	return hyper

func test_buildSettingScript():
	var setting = SettingScene.instance()
	setting.setSceneName("setting")

	var setting_model = SettingModel.new()

	setting_model.setReturnFunction(__buildReturnFunction())

	setting.setModel(setting_model)

	var script_tree = setting.pack()
	script_tree.exportAsJson("res://test/scripts/setting.json")

	pass_test("Setting script generate success!")
