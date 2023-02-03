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

func isFilled():
	var val = []
	val.resize(map.size())
	for index in map:
		if val[index] != null:
			return false
		val[index] = index
	
	return true

func getMap():
	return map.duplicate()

func resizeMap(size):
	map.resize(size)

func setMap(map_):
	map = map_

func setIndex(from, to):
	map[from] = to

func trans(params):
	var ret = []
	ret.resize(map.size())
	for index in range(map.size()):
		ret[map[index]] = params[index] 
	
	return ret

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("map", map)

	return script_tree

func loadScript(script_tree):
	map = script_tree.getIntArray("map")
