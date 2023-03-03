extends "res://design/factory/Factory.gd"
class_name GlobalSettingFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity_type = "GlobalSetting"
	entity = TypeUnit.type(entity_type).new()

func __setMemberList():
	addBaseMember("init_scene_name", "String")
	addContainerMember("screen_size", "int")

func buildRef(_blueprint):
	return

func build(blueprint):
	entity.setInitSceneName(blueprint["init_scene_name"])
	entity.setScreenSize(blueprint["screen_size"])
