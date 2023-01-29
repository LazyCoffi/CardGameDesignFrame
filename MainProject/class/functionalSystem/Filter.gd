extends Node
class_name Filter

var FunctionalGraph = TypeUnit.type("FunctionalGraph")
var ScriptTree = TypeUnit.type("ScriptTree")
var DictMap = TypeUnit.type("DictMap")

var graph		# FunctionalGraph
var param_map	# DictMap

func _init():
	graph = FunctionalGraph.new()
	param_map = DictMap.new()

func copy():
	var ret = TypeUnit.type("DictMap").new()
	ret.graph = graph.copy()
	ret.param_map = param_map.copy()

	return ret

func exec(params):
	return graph.exec(param_map.trans(params))

func setGraph(graph_):
	graph = graph_

func getGraph():
	return graph

func setParamMap(param_map_):
	param_map = param_map_

func getParamMap():
	return param_map

func getParamsType():
	return graph.getParamsType()

func getParamsNum():
	return graph.getParamsNum()

func getRetType():
	return graph.getRetType()

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObject("graph", graph)
	script_tree.addObject("param_map", param_map)

	return script_tree

func loadScript(script_tree):
	graph = script_tree.getObject("graph", FunctionalGraph)
	param_map = script_tree.getObject("param_map", DictMap)
