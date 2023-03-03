extends "res://design/factory/Factory.gd"
class_name FunctionFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity_type = "Function"
	entity_type = TypeUnit.type(entity_type).new()

func __setMemberList():
	addObjectMember("graph", "FuncGraph")
	addContainerMember("param_map", "StringPack")

func buildRef(blueprint):
	entity.setGraph(blueprint["graph"])

func build(blueprint):
	entity.setMap(blueprint["param_map"])
