extends "res://design/factory/Factory.gd"
class_name ArchiveModelFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity_type = "ArchiveModel"
	entity = TypeUnit.type(entity_type).new()

func __setMemberList():
	return

func buildRef(_blueprint):
	return

func build(_blueprint):
	return
