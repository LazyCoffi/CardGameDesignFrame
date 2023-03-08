extends "res://design/factory/Factory.gd"
class_name FuncGraphFactory

func _init():
	entity_type = "FuncGraph"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addObjectArrayMember("node_list", "FuncGraphNode", "addNode", "delNode")
	addFuncMember("construct", [])
