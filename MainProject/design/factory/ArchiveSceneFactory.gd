extends "res://design/factory/Factory.gd"
class_name ArchiveSceneFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

func __setMemberList():
	addBaseMember("scene_name", "String")
	addObjectMember("switch_target_table", "SwitchTargetTable")
	addObjectMember("scene_model", "ArchiveModel")

	entity_type = "ArchiveScene"
	entity = TypeUnit.type(entity_type).new()

func buildRef(blueprint):
	entity.setSwtichTargetTable(blueprint["switch_target_table"])
	entity.setModel(blueprint["scene_model"])

func build(blueprint):
	entity.setSceneName(blueprint["scene_name"])

