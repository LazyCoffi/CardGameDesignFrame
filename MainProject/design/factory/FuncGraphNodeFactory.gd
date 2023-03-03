extends "res://design/factory/Factory.gd"
class_name FuncGraphNodeFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity_type = "FuncGraphNode"
	entity = TypeUnit.type(entity_type).new()

func __setMemberList():
	addObjectMember("func_unit", "FuncUnit")
	addContainerMember("ch_index_list", "int")

func buildRef(blueprint):
	entity.setFuncUnit(blueprint["func_unit"])

func build(blueprint):
	entity.setChIndexList(blueprint["ch_index_list"])
