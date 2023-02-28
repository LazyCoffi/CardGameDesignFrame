extends "res://design/factory/Factory.gd"
class_name AttrNodeFactory

var AttrNode = TypeUnit.type("AttrNode")

var entity

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity = AttrNode.new()

func getEntity():
	return entity

func __setMemberList():
	addBaseMember("attr_name", "String")
	addBaseMember("attr_type", "String")
	addBaseMember("attr", "String")
	addObjectMember("getter_function", Function)
	addObjectMember("setter_function", Function)

func buildRef(blueprint):
	entity.setGetterFunction(blueprint["getter_function"])
	entity.setSetterFunction(blueprint["setter_function"])

func build(blueprint):
	entity.setAttrName(blueprint["attr_name"])
	entity.setAttrType(blueprint["attr_type"])

	if blueprint["attr_type"] == "Integer":
		entity.setAttr(int(blueprint["attr"]))
	
	if blueprint["attr_type"] == "Float":
		entity.setAttr(float(blueprint["attr"]))

	if blueprint["attr_type"] == "String":
		entity.setAttr(str(blueprint["attr"]))
