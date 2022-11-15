extends Node

var resource_setting = {}

func loadGlobalSetting():
	var gs = ResourceTool.parse("res://scripts/global/globalSetting.json")
	resource_setting = gs["resource_setting"]
	
func getRes(index_str):
	var indexs = index_str.split("/")
	var cur_dir = resource_setting
	for index in indexs:
		assert(cur_dir.has(index))
		cur_dir = cur_dir[index]
	
	return cur_dir

