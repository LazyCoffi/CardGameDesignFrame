extends Node
class_name DictMap 

var ScriptTree = TypeUnit.type("ScriptTree")

var map

func _init():
	map = []

func copy():
	var ret = TypeUnit.type("DictMap").new()
	ret.map = map.duplicate(true)

	return ret

func getMap():
	return map.duplicate()

func addAttr(index, param_name):
	map[index] = param_name

func resizeMap(size):
	map.resize(size)

func setMap(map_):
	map = map_

func trans(params):
	var ret = {}
	for index in range(map.size()):
		ret[map[index]] = params[index] 
	
	return ret

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("map", map)

	return script_tree

func loadScript(script_tree):
	map = script_tree.getStrArray("map")
