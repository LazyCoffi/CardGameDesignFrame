extends "res://design/factory/Factory.gd"
class_name ParamNodeFactory

var ParamNode = TypeUnit.type("ParamNode")

var entity

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity = ParamNode.new()

func __setMemberList():
	addBaseMember("param_type", "String")
	addCommonObjectMember("param")

func getEntity():
	return entity

func buildRef(_blueprint):
	return

func build(blueprint):
	entity.setParamType(blueprint["param_type"])
