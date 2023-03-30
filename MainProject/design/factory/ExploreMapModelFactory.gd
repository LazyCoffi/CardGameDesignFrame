extends "res://design/factory/Factory.gd"
class_name ExploreMapModelFactory

func _init():
	entity_type = "ExploreMapModel"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addFuncMember("addMapNode", [
		{"name" : "coordinate_x", "type" : "int", "param_type" : "val"},
		{"name" : "coordinate_y", "type" : "int", "param_type" : "val"},
		{"name" : "effect_func", "type" : "HyperFunction", "param_type" : "obj"},
		{"name" : "is_interactive", "type" : "bool", "param_type" : "val"}
	])
	addFuncMember("delMapNode", [
			{"name" : "node_index", "type" : "int", "param_type" : "val"}
	])
	addFuncMember("addMapNodeCh", [
		{"name" : "node_index", "type" : "int", "param_type" : "val"},
		{"name" : "ch_node_index", "type" : "int", "param_type" : "val"},
	])
	addFuncMember("delMapNodeCh", [
		{"name" : "node_index", "type" : "int", "param_type" : "val"},
		{"name" : "ch_node_index", "type" : "int", "param_type" : "val"},
	])
	addFuncMember("setNodeInteractive", [
		{"name" : "node_index", "type" : "int", "param_type" : "val"},
	])
	addFuncMember("resetNodeInteractive", [
		{"name" : "node_index", "type" : "int", "param_type" : "val"},
	])

	addObjectMember("sub_menu_function", "HyperFunction", "setSubMenuFunction")

func initOverviewList():
	addArrayOverview("map_node_list", "getMapNodeList", [
	{"attr_name" : "coordinate_x", "func_name" : "getCoordinateX"},
	{"attr_name" : "coordinate_y", "func_name" : "getCoordinateY"},
	{"attr_name" : "is_interactive" , "func_name" : "isInteractive"}
	])
