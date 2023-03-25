extends "res://design/factory/Factory.gd"
class_name RootFactory

func _init():
	entity_type = "ScriptExporter"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addObjectMember("GlobalSetting", "GlobalSetting", "setGlobalSetting")
	addObjectMember("CardCache", "CardCache", "setCardCache")
	addObjectMember("ResourceUnit", "ResourceUnit", "setResourceUnit")
	addObjectArrayMember("MainMenuScene", "MainMenuScene", "addMainMenuScene", "delMainMenuScene")
	addObjectArrayMember("SubMenuScene", "SubMenuScene", "addSubMenuScene", "delSubMenuScen")
	addObjectArrayMember("LinearBattleScene", "LinearBattleScene", "addLinearBattleScene", "delLinearBattleScene")
	addObjectArrayMember("ArchiveScene", "ArchiveScene", "addArchiveScene", "delArchiveScene")
	addObjectArrayMember("ExploreMapScene", "ExploreMapScene", "addExploreMapScene", "delExploreMapScene")
