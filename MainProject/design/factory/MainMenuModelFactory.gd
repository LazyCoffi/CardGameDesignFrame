extends "res://design/factory/Factory.gd"
class_name MainMenuModelFactory

func _init():
	entity_type = "MainMenuModel"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addObjectMember("start_function", "HyperFunction", "setStartFunction")
	addObjectMember("continue_function", "HyperFunction", "setContinueFunction")
	addObjectMember("setting_function", "HyperFunction", "setSettingFunction")
	addObjectMember("exit_function", "HyperFunction", "setExitFunction")
