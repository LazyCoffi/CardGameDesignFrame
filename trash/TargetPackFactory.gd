extends "res://design/factory/Factory.gd"
class_name TargetPackFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity_type = "TargetPack"
	entity = TypeUnit.type(entity_type).new()

func __setMemberList():
	addBaseMember("target_name", "String")
	addBaseMember("scene_type", "String")
	addBaseMember("scene_name", "String")
	addBaseMember("switch_type", "String")

func buildRef(_blueprint):
	return

func build(blueprint):
	entity.setTargetName(blueprint["target_name"])
	entity.setSceneType(blueprint["scene_type"])
	entity.setSceneName(blueprint["scene_name"])
	entity.setSwitchType(blueprint["switch_type"])
