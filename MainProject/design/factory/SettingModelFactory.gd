extends "res://design/factory/Factory.gd"
class_name SettingModelFactory

func _init():
	entity_type = "SettingModelScene"
	entity = TypeUnit.type(entity_type).instance()

func initMemberList():
	addObjectMember("return_function", "HyperFunction", "setReturnFunction")

