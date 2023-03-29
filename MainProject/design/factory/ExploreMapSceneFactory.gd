extends "res://design/factory/Factory.gd"
class_name ExploreMapSceneFactory

func _init():
	entity_type = "ExploreMapScene"
	entity = TypeUnit.type(entity)

func initMemberList():
	addFuncMember("setSceneName", [
		{"name" : "scene_name", "type" : "String", "param_type" : "val"}
	])
	addObjectMember("scene_model", "ExploreMapModel", "setModel")
	
func initOverviewList():
	addAttrOverview("scene_name", "getSceneName")
