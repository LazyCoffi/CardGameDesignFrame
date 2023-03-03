extends "res://design/factory/Factory.gd"
class_name MainMenuSceneFactory

var MainMenuScene = TypeUnit.type("MainMenuScene")

var entity

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()
	
	entity_type = "MainMenuScene"
	entity = TypeUnit.type(entity_type).instance()

func __setMemberList():
	addBaseMember("scene_name", "StringPack")
	addObjectMember("switch_target_table", "SwitchTargetTable")
	addObjectMember("scene_model", "MainMenuModel")

func buildRef(blueprint):
	entity.setSwtichTargetTable(blueprint["switch_target_table"])
	entity.setModel(blueprint["scene_model"])

func build(blueprint):
	entity.setSceneName(blueprint["scene_name"])

