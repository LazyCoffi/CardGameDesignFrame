extends "res://design/factory/Factory.gd"
class_name MainMenuSceneFactory

var MainMenuScene = TypeUnit.type("MainMenuScene")

func _init():
	entity_type = "MainMenuScene"
	entity = TypeUnit.type(entity_type).instance()

func initMemberList():
	addFuncMember("setSceneName", [
		{"name" : "scene_name", "type" : "String", "param_type" : "val"}
	])
	addObjectMember("scene_model", "MainMenuModel", "setModel")

func initOverviewList():
	addAttrOverview("scene_name", "getSceneName")
