extends "res://design/factory/Factory.gd"
class_name ParamNodeFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity_type = "ParamNode"
	entity = TypeUnit.type(entity_type).new()

func __setMemberList():
	addBaseMember("param_type", "String")
	addCommonObjectMember("param")

func buildRef(blueprint):
	entity.setParam(blueprint["param"])

func build(blueprint):
	entity.setParamType(blueprint["param_type"])
