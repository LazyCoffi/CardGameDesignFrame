extends "res://design/factory/Factory.gd"
class_name BooleanFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity_type = "Boolean"
	entity = TypeUnit.type(entity_type).new()

func __setMemberList():
	addBaseMember("val", "bool")

func buildRef(_blueprint):
	return

func build(blueprint):
	entity.setVal(blueprint["val"])
