extends "res://design/factory/Factory.gd"
class_name RootFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

func __setMemberList():
	addObjectMember("GlobalSetting", "GlobalSetting")
	addObjectMember("CardCache", "CardCache")
	addObjectContainerMember("MainMenuScene", "MainMenuScene")
	addObjectContainerMember("SubMenuScene", "SubMenuScene")
	addObjectContainerMember("LinearBattleScene", "LinearBattleScene")
	addObjectContainerMember("ArchiveScene", "ArchiveScene")
