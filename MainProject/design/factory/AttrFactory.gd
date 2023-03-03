extends "res://design/factory/Factory.gd"
class_name AttrFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity_type = "Attr"
	entity = TypeUnit.type(entity_type).new()

func __setMemberList():
	addObjectContainerMember("table", "AttrNode")

func buildRef(blueprint):
	entity.setTable(blueprint["table"])
	
func build(_buildprint):
	return
