extends Node
class_name LocalFunction

var Filter = TypeUnit.type("Filter")
var ScriptTree = TypeUnit.type("ScriptTree")
var ArrangeMap = TypeUnit.type("ArrangeMap")

var func_name			# String
var filters				# FunctionalGraph_Array
var param_map			# ArrangeMap 
var ret_map				# ArrangeMap

func _init():
	func_name = ""
	filters = []
	param_map = ArrangeMap.new()
	ret_map = ArrangeMap.new()

func copy():
	var ret = TypeUnit.type("LocalFunction").new()
	ret.func_name = func_name
	ret.filters = []
	for node in filters:
		ret.filters.append(node.copy())
	
	ret.param_map = param_map.copy()
	ret.ret_map = param_map.copy()

	return ret

func peekParamMap():
	return param_map.getMap()

func setParamMap(map):
	param_map.setMap(map)

func initParamMap():
	var size = getParamsNum()
	var map = []
	for index in size:
		map.append(index)

	param_map.setMap(map)

func peekRetMap():
	return ret_map.getMap()

func setRetMap(map):
	ret_map.setMap(map)

func initRetMap():
	var size = getFiltersNum()
	var map = []
	for index in size:
		map.append(index)

	ret_map.setMap(map)

func exec(params):
	var cur_params = param_map.trans(params)
	var ret = []

	for filter in filters:
		var param_type = filter.getParamsType()
		var filter_params = []
		for _index in range(param_type.size()):
			filter_params.append(cur_params.pop_front()) 
		ret.append(filter.exec(filter_params))

	return ret_map.trans(ret)

# func_name
func getFuncName():
	return func_name

func setFuncName(func_name_):
	func_name = func_name_

func addFilter(filter):
	filters.append(filter)

func removeFilter(index):
	filters.remove(index)

func setFilter(index, filter):
	Exception.assert(index < filters.size(), "Index out of size")
	filters[index] = filter

func getFilters():
	return filters.duplicate()

func getFilter(index):
	Exception.assert(index < filters.size(), "Index out of size")

	return filters[index]

func getParamsType():
	var params_type = []
	for filter in filters:
		params_type.append_array(filter.getParamsType())
	
	return params_type

func getParamsNum():
	var ret = 0

	for filter in filters:
		ret += filter.getParamNum()
	
	return ret

func getFiltersNum():
	return filters.size()

func getRetType():
	var ret_type = []

	for filter in filters:
		ret_type.append(filters.getRetType())
	
	return ret_type

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("func_name", func_name)
	script_tree.addObjectArray("filters", filters)
	script_tree.addObject("param_map", param_map)
	script_tree.addObject("ret_map", ret_map)

	return script_tree

func loadScript(script_tree):
	func_name = script_tree.getStr("func_name")
	filters = script_tree.getObjectArray("filters", Filter)
	param_map = script_tree.getObject("param_map", ArrangeMap)
	ret_map = script_tree.getObject("ret_map", ArrangeMap)
