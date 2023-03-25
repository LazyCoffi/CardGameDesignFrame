extends "res://design/factory/Factory.gd"
class_name FuncUnitFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity_type = "FuncUnit"
	entity = TypeUnit.type(entity_type).new()

func __setMemberList():
	addBaseMember("func_name", "String")
	addBaseMember("func_set_name", "String")
	addObjectMember("default_params", "ParamList")

func buildRef(blueprint):
	entity.setDefaultParams(blueprint["default_params"])

func build(blueprint):
	entity.setFuncName(blueprint["func_name"])
	entity.setFuncSetName(blueprint["func_set_name"])
