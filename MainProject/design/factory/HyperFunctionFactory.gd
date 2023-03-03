extends "res://design/factory/Factory.gd"
class_name HyperFunctionFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity_type = "HyperFunction"
	entity = TypeUnit.type(entity_type).new()

func __setMemberList():
	addBaseMember("func_name", "String")
	addObjectContainerMember("functions", "Function")
	addContainerMember("param_map", "int")
	addContainerMember("ret_map", "int")

func buildRef(blueprint):
	entity.setFunctions(blueprint["functions"])
		
func build(blueprint):
	entity.setFuncName(blueprint["func_name"])
	entity.setParamMap(blueprint["param_map"])
	entity.setRetMap(blueprint["ret_map"])
