extends Node
class_name Function

var FuncGraph = TypeUnit.type("FuncGraph")
var ScriptTree = TypeUnit.type("ScriptTree")
var DictMap = TypeUnit.type("DictMap")

var graph		# FuncGraph
var param_map	# DictMap

func _init():
	graph = null
	param_map = DictMap.new()

func copy():
	var ret = TypeUnit.type("Function").new()
	ret.graph = graph.copy()
	ret.param_map = param_map.copy()

	return ret

func exec(params):
	return graph.exec(param_map.trans(params))

# graph
func getGraph():
	return graph

func setGraph(graph_):
	graph = graph_
	initParamMap()

func getParamsType():
	return graph.getParamsType()

func getParamsNum():
	return graph.getParamsNum()

func getRetType():
	return graph.getRetType()

# param_map
func getParamMap():
	return param_map

func initParamMap():
	param_map.initMap(graph.getParamsType().keys())

func setMap(map):
	param_map.setMap(map)

func getMap():
	return param_map.getMap()

func setMapIndex(index, param_index):
	param_map.setIndex(index, param_index)

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObject("graph", graph)
	script_tree.addObject("param_map", param_map)

	return script_tree

func loadScript(script_tree):
	graph = script_tree.getObject("graph", FuncGraph)
	param_map = script_tree.getObject("param_map", DictMap)
