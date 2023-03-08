extends "res://design/factory/Factory.gd"
class_name HyperFunctionFactory

func _init():
	entity_type = "HyperFunction"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addFuncMember("setFuncName", [
		{"name" : "func_name", "type" : "String", "param_type" : "val"}
	])
	addObjectArrayMember("functions", "Function", "addFunction", "delFunction")
	addFuncMember("setParamMapIndex", [
		{"name" : "param_index", "type" : "int", "param_type" : "val"},
		{"name" : "index", "type" : "index", "param_type" : "val"}
	])
	addFuncMember("setRetMapIndex", [
		{"name" : "ret_index", "type" : "int", "param_type" : "val"},
		{"name" : "index", "type" : "index", "param_type" : "val"}
	])

