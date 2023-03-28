extends GutTest

var ArchiveScene = TypeUnit.type("ArchiveScene")
var ArchiveModel = TypeUnit.type("ArchiveModel")
var FuncGraphNode = TypeUnit.type("FuncGraphNode")
var FuncGraph = TypeUnit.type("FuncGraph")
var Function = TypeUnit.type("Function")
var HyperFunction = TypeUnit.type("HyperFunction")

func __buildReturnFunction():
	var node = FuncGraphNode.new()
	node.setFunc("SceneOperFuncSet", "popScene")

	var graph = FuncGraph.new()
	graph.addNode(node)
	graph.construct()

	var function = Function.new()
	function.setGraph(graph)
	
	var hyper = HyperFunction.new()
	hyper.addFunction(function)

	return hyper

func test_buildArchiveScript():
	var archive = ArchiveScene.instance()
	archive.setSceneName("archive_menu")

	var archive_model = ArchiveModel.new()
	archive_model.setReturnFunction(__buildReturnFunction())
		
	archive.setModel(archive_model)

	var script_tree = archive.pack()
	script_tree.exportAsJson("res://test/scripts/archive_menu.json")

	pass_test("Archive script generate success!")

