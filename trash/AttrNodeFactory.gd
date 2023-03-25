extends "res://design/factory/Factory.gd"
class_name AttrNodeFactory

func _init():

	entity_type = "AttrNode"
	entity = TypeUnit.type(entity_type).new()

func initMemberList()
	addBaseMember("attr_name", "String")
	addBaseMember("attr_type", "String")
	addBaseMember("attr", "String")
	addObjectMember("getter_function", "Function")
	addObjectMember("setter_function", "Function")

func buildRef(blueprint):
	entity.setGetterFunction(blueprint["getter_function"])
	entity.setSetterFunction(blueprint["setter_function"])

func build(blueprint):
	entity.setAttrName(blueprint["attr_name"])
	entity.setAttrType(blueprint["attr_type"])

	if blueprint["attr"] == null:
		entity.setAttr(null)
		return

	if blueprint["attr_type"] == "int":
		entity.setAttr(int(blueprint["attr"]))
	
	if blueprint["attr_type"] == "float":
		entity.setAttr(float(blueprint["attr"]))

	if blueprint["attr_type"] == "String":
		entity.setAttr(str(blueprint["attr"]))
