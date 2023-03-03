extends "res://design/factory/Factory.gd"
class_name FuncGraphFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity_type = "FuncGraph"
	entity = TypeUnit.type(entity_type).new()

func __setMemberList():
	addObjectContainerMember("node_list", "FuncGraphNode")

func buildRef(blueprint):
	entity.setNodeList(blueprint["node_list"])
	entity.construct()

func build(_blueprint):
	return
