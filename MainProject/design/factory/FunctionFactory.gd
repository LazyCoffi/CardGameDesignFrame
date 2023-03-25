extends "res://design/factory/Factory.gd"
class_name FunctionFactory

func _init():
	entity_type = "Function"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addObjectMember("graph", "FuncGraph", "setGraph")
	addFuncMember("setMapIndex", [
		{"name" : "index", "type" : "int", "param_type" : "val"},
		{"name" : "param_index", "type" : "int", "param_type" : "val"}
	])

func initOverviewList():
	addAttrArrayOverview("param_map", "getMap")
