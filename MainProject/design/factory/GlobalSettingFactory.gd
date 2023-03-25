extends "res://design/factory/Factory.gd"
class_name GlobalSettingFactory

func _init():
	entity_type = "GlobalSetting"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addFuncMember("setInitSceneName", [
		{"name" : "init_scene_name", "type" : "String", "param_type" : "val"},
	])
	addFuncMember("setScreenSize", [
		{"name" : "x", "type" : "int", "param_type" : "val"},
		{"name" : "y", "type" : "int", "param_type" : "val"}
	])

func initOverviewList():
	addAttrOverview("init_scene_name", "getInitSceneName")
	addAttrArrayOverview("screen_size", "getScreenSize")

