extends "res://design/factory/Factory.gd"
class_name MainMenuModelFactory

func _init():
	entity_type = "MainMenuModel"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	return
