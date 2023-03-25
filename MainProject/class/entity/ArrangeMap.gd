extends Node
class_name ArrangeMap 

var ScriptTree = TypeUnit.type("ScriptTree")

var map

func _init():
	map = []

func copy():
	var ret = TypeUnit.type("ArrangeMap").new()
	ret.map = map.duplicate(true)
	
	return ret

func setMap(map_):
	map = map_

func initMap(siz):
	map.resize(siz)
	for index in range(siz):
		map[index] = index

func setMapIndex(index, param_index):
	map[index] = param_index

func getMap():
	return map.duplicate()

func trans(params):
	var ret = []
	ret.resize(map.size())
	for index in range(map.size()):
		ret[index] = params[map[index]] 
	
	return ret

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("map", map)

	return script_tree

func loadScript(script_tree):
	map = script_tree.getIntArray("map")
