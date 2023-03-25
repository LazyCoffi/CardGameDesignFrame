extends "res://design/factory/Factory.gd"
class_name SubMenuSceneFactory

func _init():
	entity_type = "SubMenuScene"
	entity = TypeUnit.type(entity_type).instance()

func initMemberList():
	addFuncMember("setSceneName", [
		{"name" : "scene_name", "type" : "String", "param_type" : "val"}
	])
	addObjectMember("scene_model", "SubMenuModel", "setModel")

func initOverviewList():
	addAttrOverview("scene_name", "getSceneName")
