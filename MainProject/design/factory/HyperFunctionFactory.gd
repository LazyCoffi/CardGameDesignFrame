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
		{"name" : "index", "type" : "int", "param_type" : "val"},
		{"name" : "param_index", "type" : "index", "param_type" : "val"}
	])
	addFuncMember("setRetMapIndex", [
		{"name" : "index", "type" : "int", "param_type" : "val"},
		{"name" : "ret_index", "type" : "index", "param_type" : "val"}
	])

func initOverviewList():
	addAttrOverview("hyper_func_name", "getFuncName")
	addAttrArrayOverview("func_name_list", "getFuncNameList")
	addAttrArrayOverview("func_set_name_list", "getFuncSetNameList")
	addAttrArrayOverview("param_map", "peekParamMap")
	addAttrArrayOverview("ret_map", "peekRetMap")
