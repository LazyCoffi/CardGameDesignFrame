extends "res://design/factory/Factory.gd"
class_name CardCacheFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity_type = "CardCache"
	entity = TypeUnit.type(entity_type).new()

func __setMemberList():
	addObjectContainerMember("table", "CardTemplate")

func buildRef(blueprint):
	entity.setTable(blueprint["table"])

func build(_blueprint):
	return
