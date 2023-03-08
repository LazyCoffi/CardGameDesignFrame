extends "res://design/factory/Factory.gd"
class_name ArchiveModelFactory

func _init():
	entity_type = "ArchiveModel"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	return
