extends Node
class_name LocalFunction

var FunctionalGraph = load("res://class/functionalSystem/FunctionalGraph.gd")
var ScriptTree = load("res://class/entity/ScriptTree.gd")

var func_name
var graphs
var param_map
var ret_map

func _init():
	graphs = []

func setParamMap(map):
	var params_type = getParamsType()
	Exception.assert(__verifyMap(map, params_type.size()))
	param_map = map

func setRetMap(map):
	Exception.assert(__verifyMap(map, graphs.size()))
	ret_map = map

func exec(params_):
	var params = params_.duplicate()
	var ret_arr = []

	for index in range(params.size()):
		__swap(index, param_map[index], params)

	for graph in graphs:
		var graph_type = graph.getParamsType()
		var graph_params = []
		for index in range(graph_type.size()):
			graph_params.append(params.pop_front())
		ret_arr.append(graph.exec(graph_params))

	for index in range(ret_arr.size()):
		__swap(index, ret_map[index], ret_arr)
	
	return ret_arr

func setFuncName(func_name_):
	Exception.assert(TypeUnit.isType(func_name_, "String"))
	func_name = func_name_

func setGraphs(graphs_):
	graphs = graphs_

func getGraphs():
	return graphs

func getParamsType():
	var params_type = []
	for graph in graphs:
		params_type.append_array(graph.getParamsType())
	
	for index in range(param_map.size()):
		__swap(index, param_map[index], params_type)
	
	return params_type 

func getRetType():
	var ret_type = []

	for graph in graphs:
		ret_type.append(graphs.getRetType())
	
	for index in range(ret_type.size()):
		__swap(index, ret_map[index], ret_type)
	
	return ret_type

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("func_name", func_name)
	script_tree.addObjectArray("graphs", graphs)

	return script_tree

func loadScript(script_tree):
	func_name = script_tree.getAttr("func_name")
	graphs = script_tree.getObjectArray("graphs", FunctionalGraph)

func __swap(first, second, arr):
	var tmp = arr[first]
	arr[first] = arr[second]
	arr[second] = tmp

func __verifyMap(map, size):
	if map.size() != size:
		return false

	var arr = []
	arr.resize(map.size())

	for index in map.size():
		if map[index] > arr.size():
			return false
		if arr[map[index]] == null:
			arr[map[index]] = map[index]
		else:
			return false
	
	return true
