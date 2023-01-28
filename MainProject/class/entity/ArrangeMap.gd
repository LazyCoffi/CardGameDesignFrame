extends Node
class_name ArrangeMap 

var map

func _init():
	map = []

func resizeMap(size):
	map.resize(size)

func setMap(map_):
	map = map_

func isFilled():
	var val = []
	val.resize(map.size())
	for index in map:
		if val[index] != null:
			return false
		val[index] = index
	
	return true

func setIndex(from, to):
	map[from] = to

func trans(params):
	var ret = []
	ret.resize(map.size())
	for index in range(map.size()):
		ret[map[index]] = params[index] 
	
	return ret
