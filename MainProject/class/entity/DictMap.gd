extends Node
class_name DictMap 

var map

func _init():
	map = []

func resizeMap(size):
	map.resize(size)

func setMap(map_):
	map = map_

func addAttr(index, param_name):
	map[index] = param_name

func trans(params):
	var ret = {}
	for index in range(map.size()):
		ret[map[index]] = params[index] 
	
	return ret
