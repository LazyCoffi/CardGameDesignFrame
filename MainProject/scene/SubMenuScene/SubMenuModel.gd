extends Node
class_name SubMenuModel

var param_map

var menu_list

func _init():
	__setParamMap()

func getParam(param_name):
	Logger.assert(param_map.has(param_name), "Map doesn't has param")
	return param_map[param_name]

func pack():
	var script_tree = ScriptTree.new()

	return script_tree

func loadScript(_script_tree):
	pass

func __setParamMap():
	# TODO: 添加所有变量的映射
	pass

func __addMap(param_name, param):
	param_map[param_name] = param

