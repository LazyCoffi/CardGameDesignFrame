extends Node
class_name FunctionalInterface

var ScriptTree = load("res://class/ScriptTree.gd")
var Category = load("res://class/Category.gd")
var FunctionalGraph = load("res://class/FunctionalGraph.gd")

var interface_name
var category
var functional_graph
var params_map
var is_mapped

func _init():
	params_map = []
	is_mapped = false

func exec(params):
	params = __transParams(params)
	Exception.assert(TypeUnit.verifyParamsType(params, getParamsType()))

	return functional_graph.exec(params)

func setFunctionalGraph(functional_graph_):
	TypeUnit.isType(functional_graph_, "FunctionalGraph")

	functional_graph = functional_graph_
	is_mapped = false
	
func setCategory(category_):
	TypeUnit.isType(category_, "Category")

	category = category_
	is_mapped = false

func setParamsMap(params_map_):
	Exception.assert(verifyParamsMap(params_map_))

	is_mapped = true
	params_map = params_map_

func isMapped():
	return is_mapped

func getRetType():
	return InterfaceCategory.getRetType(category, interface_name)

func getParamsType():
	return InterfaceCategory.getParamsType(category, interface_name)

func getParamsNum():
	return getParamsType().size()

func verifyParamsMap(params_map_):
	if not params_map_.size() == getParamsNum():
		return false

	var map = []
	map.resize(params_map_.size())

	for index in params_map_:
		Exception.assert(TypeUnit.isType(index, "int"))
		if index >= map.size() or map[index] != null:
			return false

		map[index] = index
	
	var params_type = getParamsType()
	var f_params_type = functional_graph.getParamsType()

	for index in range(params_type.size()):
		if params_type[index] != f_params_type[params_map_[index]]:
			return false
	
	return true

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("interface_name", interface_name)
	script_tree.addObject("category", category)
	script_tree.addObject("functional_graph", functional_graph)
	script_tree.addAttr("params_map", params_map)
	script_tree.addAttr("is_mapped", is_mapped)

	return script_tree

func loadScript(script_tree):
	interface_name = script_tree.getAttr("interface_name")
	category = script_tree.getObject("category", Category)
	functional_graph = script_tree.getObject("functional_graph", FunctionalGraph)
	params_map = script_tree.getAttr("params_map")
	is_mapped = script_tree.getAttr("is_mapped")

func __transParams(params):
	Exception.assert(isMapped())
	Exception.assert(params.size() == getParamsNum())

	var params_ = []
	params_.resize(params.size())

	for index in range(params.size()):
		params_[index] = params[params_map[index]]
	
	return params_

