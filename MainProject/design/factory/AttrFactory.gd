extends "res://design/factory/Factory.gd"
class_name AttrFactory

var Attr = TypeUnit.type("Attr")

var entity

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity = Attr.new()

func __setMemberList():
	addObjectContainerMember("table", "AttrNode")

func getEntity():
	return entity

func buildRef(blueprint):
	var table = blueprint["table"]
	for attr_node in table:
		entity.addAttr(attr_node)

func build(_buildprint):
	return
