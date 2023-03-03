extends "res://design/factory/Factory.gd"
class_name LinearBattleSceneFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity_type = "LinearBattleScene"
	entity = TypeUnit.type(entity_type).instance()

func __setMemberList():
	addBaseMember("scene_name", "StringPack")
	addObjectMember("switch_target_table", "SwitchTargetTable")
	addObjectMember("scene_model", "LinearBattleModel")

func buildRef(blueprint):
	entity.setSwitchTargetTable(blueprint["switch_target_table"])
	entity.setSceneModel(blueprint["scene_model"])

func build(blueprint):
	entity.setSceneName(blueprint["scene_name"])
