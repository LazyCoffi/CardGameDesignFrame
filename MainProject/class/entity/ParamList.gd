extends Node
class_name ParamList

var ScriptTree = TypeUnit.type("ScriptTree")
var NullPack = TypeUnit.type("NullPack")
var ParamNode = TypeUnit.type("ParamNode")

var list

func _init():
	list = []
	
func copy():
	var ret = TypeUnit.type("ParamList").new()
	ret.list = []
	for node in list:
		ret.list.append(node.copy())
	
	return ret

func setList(list_):
	list = list_

func resize(size):
	if size > list.size():
		while size > 0:
			list.append(__nullNode())
			size -= 1
	else:
		list.resize(size)

func hasParam(index):
	Logger.assert(index < list.size(), "Index is out of list size!")

	return list[index].getParamType() != "NullPack"

func getParam(index):
	Logger.assert(index < list.size(), "Index is out of list size!")

	return list[index].getParam()

func getParamsList():
	var ret = []
	for param in list:
		ret.append(param.getParam())
	
	return ret

func addParam(param_node):
	list.append(param_node)

func addGap():
	list.append(__nullNode())

func setParam(param_type, param, index):
	Logger.assert(index < list.size(), "Index is out of list size!")
	var param_node = ParamNode.new()
	param_node.setParamType(param_type)
	param_node.setParam(param)
	list[index] = param_node

func delParam(index):
	Logger.assert(index < list.size(), "Index is out of list size!")
	list[index] = __nullNode()

func removeParam(index):
	list.remove(index)

func __nullNode():
	var null_node = ParamNode.new()
	null_node.setParamType("NullPack")
	null_node.setParam(NullPack.new())

	return null_node

func pack():
	var script_tree = ScriptTree.new()
	
	script_tree.addObjectArray("list", list)

	return script_tree

func loadScript(script_tree):
	list = script_tree.getObjectArray("list", ParamNode)
