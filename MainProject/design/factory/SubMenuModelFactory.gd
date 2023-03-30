extends "res://design/factory/Factory.gd"
class_name SubMenuModelFactory

func _init():
	entity_type = "SubMenuModel"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addObjectMember("resume_function", "HyperFunction", "setResumeFunction")
	addObjectMember("setting_function", "HyperFunction", "setSettingFunction")
	addObjectMember("exit_function", "HyperFunction", "setExitFunction")
