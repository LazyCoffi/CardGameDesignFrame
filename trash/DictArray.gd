extends Node
class_name DictArray

var ScriptTree = TypeUnit.type("ScriptTree")

class ArrayNode:
	var param_name
	var param
	var order

	var param_type

	func _init():
		param_name = ""
		param = null
		order = 0
	
	func copy():
		var ret = ArrayNode.new()
		ret.param_name = param_name
		ret.param = param.copy()
		ret.order = order
		ret.param_type = param_type
	
	func setParamType(param_type_):
		param_type = param_type_
	
	# param_name
	func getParamName():
		return param_name
	
	func setParamName(param_name_):
		param_name = param_name_
	
	# param
	func getParam():
		return param
	
	func setParam(param_):
		param = param_

	# order
	func getOrder():
		return order
	
	func setOrder(order_):
		order = order_
		
	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("param_name", param_name)
		script_tree.addObject("param", param)
		script_tree.addAttr("order", order)

		return script_tree
	
	func loadScript(script_tree):
		param_name = script_tree.getStr("param_name")
		param = script_tree.getObject("param", param_type)
		order = script_tree.getInt("order")

var table		# ArrayNode_Dict
var arr			# ArrayNode_Array

var param_type

func _init():
	table = {}
	arr = []

func copy():
	var ret = TypeUnit.type("DictArray").new()
	ret.table = {}
	for key in table.keys():
		ret.table[key] = table[key].copy()
	ret.arr = []
	for node in arr:
		ret.arr.append(node.copy())
	
	ret.param_type = param_type
	
	return ret

func setParamType(param_type_):
	param_type = param_type_

func has(param_name):
	return table.has(param_name)

func get(param_name):
	return table[param_name].getParam()

func getAt(index):
	return arr[index].getParam()

func size():
	return arr.size()

func front():
	return arr.front().getParam()

func back():
	return arr.back().getParam()

func pop_front():
	return arr.pop_front().getParam()

func pop_back():
	return arr.pop_back().getParam()

func values():
	var ret = []
	for node in arr:
		ret.append(node.getParam())
	
	return ret

func keys():
	return table.keys()

func getSortedValues(order_filter):
	var new_arr = arr.duplicate()
	for node in new_arr:
		node.setOrder(order_filter.exec(node.param))
	
	new_arr.sort_custom(self, "__comp_asc")

	var ret = []
	for node in new_arr:
		ret.append(node.getParam())
		node.setOrder(null)
	
	return ret

func getRawArray():
	var ret = []
	for node in arr:
		ret.append([node.getParamName(), node.getParam()])
	
	return ret

func loadFromDict(param_dict):
	for param_name in param_dict:
		append(param_name, param_dict[param_name])
	
func loadFromArray(param_arr):
	for raw_node in param_arr:
		append(raw_node[0], raw_node[1])

func append(param_name, param):
	var node = __genNode(param_name, param)
	arr.append(node)
	table[param_name] = node 

func append_array(dict_array):
	var raw_arr = dict_array.getRawArray()
	for raw_node in raw_arr:
		append(raw_node[0], raw_node[1])

func push_back(param_name, param):
	append(param_name, param)

func push_front(param_name, param):
	var node = __genNode(param_name, param)
	arr.push_front(node)
	table[param_name] = node

func set(param_name, param):
	var node = __genNode(param_name, param)
	table[param_name] = node
	for node_ in arr:
		if node_.param_name == param_name:
			node_.param = param
			break

func del(param_name):
	table.erase(param_name)
	for node in arr:
		if node.param_name == param_name:
			arr.erase(node)
			return node

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObjectDict("table", table)
	script_tree.addObjectArray("arr", arr)

	return script_tree

func loadScript(script_tree):
	table = script_tree.getTypeObjectDict("table", ArrayNode, param_type)
	arr = script_tree.getTypeObjectArray("arr", ArrayNode, param_type)

func __comp_asc(a, b):
	return a.order < b.order

func __genNode(param_name, param):
	var node = ArrayNode.new()
	node.setParamName(param_name)
	node.setParam(param)
	node.setParamType(param_type)

	return node
