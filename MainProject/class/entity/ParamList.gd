extends Node
class_name ParamList

var ScriptTree = TypeUnit.type("ScriptTree")
var NullPack = TypeUnit.type("NullPack")

var list

class ParamNode:
	var param_type
	var param

	func _init():
		param_type = ""
		param = null

	func getParamType():
		return param_type
	
	func setParamType(param_type_):
		param_type = param_type_

	func getParam():
		match param_type:
			"Integer":
				return param.getVal()
			"Float":
				return param.getVal()
			"StringPack":
				return param.getVal()
			"NullPack":
				return param.getVal()
			_:
				return param 
	
	func setParam(param_):
		match param_type:
			"Integer":
				param = TypeUnit.type("Integer").new()
				param.setVal(param_)
			"Float":
				param = TypeUnit.type("Float").new()
				param.setVal(param_)
			"StringPack":
				param = TypeUnit.type("StringPack").new()
				param.setVal(param_)
			"NullPack":
				param = TypeUnit.type("NullPack").new()
			_:
				param = param_
		
	func copy():
		var ret = ParamNode.new()
		ret.param_type = param_type
		ret.param = param.copy()

		return ret
	
	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("param_type", param_type)
		script_tree.addObject("param", param)

		return script_tree
	
	func loadScript(script_tree):
		param_type = script_tree.getStr("param_type")
		var type = TypeUnit.type("type")
		param = script_tree.getObject("param", type)

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
			list.append(__nullNode())
			size -= 1
	else:
		list.resize(size)

func hasParam(index):
	Exception.assert(index < list.size())

	return list[index].getType() != "NullPack"

func getParam(index):
	Exception.assert(index < list.size())

	return list[index].getParam()

func addParam(param_type, param):
	var param_node = ParamNode.new()
	param_node.setParamType(param_type)
	param_node.setParam(param)
	list.append(param_node)

func addGap():
	list.append(__nullNode())

func setParam(index, param_type, param):
	Exception.assert(index < list.size())
	var param_node = ParamNode.new()
	param_node.setParamType(param_type)
	param_node.setParam(param)
	list[index] = param_node

func delParam(index):
	Exception.assert(index < list.size())
	list[index] = __nullNode()

func removeParam(index):
	list.remove(index)

func __nullNode():
	var null_node = ParamNode.new()
	null_node.setType("NullPack")
	null_node.setVal(null)

	return null_node

func pack():
	var script_tree = ScriptTree.new()
	
	script_tree.addObjectArray("list", list)

	return script_tree

func loadScript(script_tree):
	script_tree.getObjectArray("list", ParamNode)
