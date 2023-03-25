extends "res://design/factory/Factory.gd"
class_name FuncGraphNodeFactory

func _init():
	entity_type = "FuncGraphNode"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addFuncMember("setFunc", [
		{"name" : "func_set_name", "type" : "String", "param_type" : "val"},
		{"name" : "func_name", "type" : "String", "param_type" : "val"}
	])
	addFuncMember("setDefaultParam", [
		{"name" : "index", "type" : "int", "param_type" : "val"},
		{"name" : "param", "type" : null, "param_type" : "common_obj"}
	])
	addFuncMember("setChIndex", [
		{"name" : "ch_id", "type" : "int", "param_type" : "val"},
		{"name" : "ch_index", "type" : "int", "param_type" : "val"}
	])

func initOverviewList():
	addAttrOverview("func_set_name", "getFuncSetName")
	addAttrOverview("func_name", "getFuncName")
	addAttrArrayOverview("default_params", "getDefaultParamList")
	addAttrArrayOverview("ch_index_list", "getChIndexList")
