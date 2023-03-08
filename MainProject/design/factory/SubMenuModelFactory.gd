extends "res://design/factory/Factory.gd"
class_name SubMenuModelFactory

func _init():
	entity_type = "SubMenuModel"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	return
