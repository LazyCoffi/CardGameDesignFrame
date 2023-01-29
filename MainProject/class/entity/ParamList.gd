extends Node
class_name ParamList

var ScriptTree = TypeUnit.type("ScriptTree")

var list

class ParamNode:
	var val
	var type

	func getVal():
		return val
	
	func setVal(val_):
		val = val_
	
	func getType():
		return type
	
	func setType(type_):
		type = type_
	
	func copy():
		var ret = ParamNode.new()
		ret.val = val.copy()
		ret.type = type

		return ret
	
	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addObject("val", val)
		script_tree.addAttr("type", type)

		return script_tree
	
	func loadScript(script_tree):
		type = script_tree.getStr("type")
		var param_type = TypeUnit.type("typ")
		val = script_tree.getObject("val", param_type)

func _init():
	list = []
	
func copy():
	var ret = TypeUnit.type("ParamList").new()
	ret.list = []
	for node in list:
		if node == null:
			ret.list.append(null)
		else:
			ret.list.append(node.copy())
	
	return ret

func resize(size):
	list.resize(size)

func getParam(index):
	Exception.assert(index < list.size())
	var param_node = list[index]
	if param_node.getType() == "Integer" or param_node.getType() == "Float" or param_node.getType() == "StringPack":
		return param_node.getVal().getVal()
	
	return param_node.getVal()

func addParam(param_type, param):
	var val = __getVal(param_type, param)
	var param_node = __genParamNode(val, param_type)
	list.append(param_node)

func addGap():
	list.append(null)

func setParam(index, param_type, param):
	Exception.assert(index < list.size())
	var val = __getVal(param_type, param)
	var param_node = __genParamNode(val, param_type)
	list[index] = param_node

func hasParam(index):
	Exception.assert(index < list.size())
	return list[index].getType() != "NullPack"

func __genParamNode(val, type):
	var param_node = ParamNode.new()
	param_node.setVal(val)
	param_node.setType(type)

	return param_node

func __getVal(param_type, param):
	var val	
	if param_type == "Integer" or param_node.getType() == "Float" or param_node.getType() == "StringPack":
		val = TypeUnit.type(param_type)	
		val.setVal(param)
	else:
		val = param

	return val

func pack():
	var script_tree = ScriptTree.new()
	
	script_tree.addObjectArray("list", list)

	return script_tree

func loadScript(script_tree):
	script_tree.getObjectArray("list", ParamNode)
