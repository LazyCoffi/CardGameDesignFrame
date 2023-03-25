extends Node
class_name ParamNode

var NullPack = TypeUnit.type("NullPack")

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
	param = param_
		
func copy():
	var ret = TypeUnit.type("ParamNode").new()
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
	var type = TypeUnit.type(param_type)
	param = script_tree.getObject("param", type)

