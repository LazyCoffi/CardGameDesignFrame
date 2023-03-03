extends "res://design/factory/Factory.gd"
class_name SwitchTargetTableFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity_type = "SwitchTargetTable"
	entity = TypeUnit.type(entity_type).new()

func __setMemberList():
	addObjectContainerMember("table", "TargetPack")

func buildRef(blueprint):
	for target_pack in blueprint["table"]:
		entity.addTarget(target_pack)

func build(_blueprint):
	return
