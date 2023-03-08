extends "res://design/factory/Factory.gd"
class_name RootFactory

func _init():
	entity_type = "Root"

func initMemberList():
	addObjectMember("GlobalSetting", "GlobalSetting", null)
	addObjectMember("CardCache", "CardCache", null)
	addObjectMember("ResourceUnit", "ResourceUnit", null)
	addObjectArrayMember("MainMenuScene", "MainMenuScene", null, null, "getSceneName")
	addObjectArrayMember("SubMenuScene", "SubMenuScene", null, null, "getSceneName")
	addObjectArrayMember("LinearBattleScene", "LinearBattleScene", null, null, "getSceneName")
	addObjectArrayMember("ArchiveScene", "ArchiveScene", null, null, "getSceneName")
