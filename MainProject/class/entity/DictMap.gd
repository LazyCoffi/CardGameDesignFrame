extends Node
class_name DictMap 

var ScriptTree = TypeUnit.type("ScriptTree")

var map

func _init():
	map = {}

func copy():
	var ret = TypeUnit.type("DictMap").new()
	ret.map = map.duplicate(true)

	return ret

func getMap():
	return map

func setMap(map_):
	map = map_

func initMap(request_list):
	for index in range(request_list.size()):
		map[request_list[index]] = index

func setIndex(index, param_index):
	map[index] = param_index

func trans(params):
	var ret = {}
	for key in map.keys():
		ret[key] = params[map[key]]

	return ret

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("map", map)

	return script_tree

func loadScript(script_tree):
	map = script_tree.getIntDict("map")
