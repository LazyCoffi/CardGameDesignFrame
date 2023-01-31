extends Node
class_name ParamList

var ScriptTree = TypeUnit.type("ScriptTree")
var NullPack = TypeUnit.type("NullPack")

var list

class ParamNode:
	var type
	var val

	func getType():
		return type
	
	func setType(type_):
		type = type_

	func getVal():
		return val
	
	func setVal(val_):
		val = val_
		
	func copy():
		var ret = ParamNode.new()
		ret.type = type
		ret.val = val.copy()

		return ret
	
	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("type", type)
		script_tree.addObject("val", val)

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
		ret.list.append(node.copy())
	
	return ret

func resize(size):
	if size > list.size():
		while size > 0:
			list.append(__genNullNode())
			size -= 1
	else:
		list.resize(size)

func hasParam(index):
	Exception.assert(index < list.size())
	return list[index].getType() != "NullPack"

func getParam(index):
	Exception.assert(index < list.size())
	var param_node = list[index]
	if param_node.getType() == "Integer" or param_node.getType() == "Float" or param_node.getType() == "StringPack":
		return param_node.getVal().getVal()
	
	return param_node.getVal()

func addParam(param_type, param):
	var val = __getVal(param_type, param)
	var param_node = __genParamNode(param_type, val)
	list.append(param_node)

func addGap():
	list.append(__genNullNode())

func setParam(index, param_type, param):
	Exception.assert(index < list.size())
	var val = __getVal(param_type, param)
	var param_node = __genParamNode(param_type, val)
	list[index] = param_node

func delParam(index):
	Exception.assert(index < list.size())
	list[index] = __genNullNode()

func removeParam(index):
	list.remove(index)

func __genParamNode(type, val):
	var param_node = ParamNode.new()
	param_node.setType(type)
	param_node.setVal(val)

	return param_node

func __genNullNode():
	var null_node = ParamNode.new()
	null_node.setType("NullPack")
	null_node.setVal(NullPack.new())

	return null_node

func __getVal(param_type, param):
	var val	
	if param_type == "Integer" or param_type == "Float" or param_type == "StringPack":
		val = TypeUnit.type(param_type).new()	
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
