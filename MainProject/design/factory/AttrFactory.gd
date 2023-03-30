extends "res://design/factory/Factory.gd"
class_name AttrFactory

func _init():
	entity_type = "Attr"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addFuncMember("addAttr", [
		{"name" : "attr_name", "type" : "String", "param_type" : "val"},
		{"name" : "attr_type", "type" : "String", "param_type" : "val"},
		{"name" : "getter", "type" : "Function", "param_type" : "obj"},
		{"name" : "setter", "type" : "Function", "param_type" : "obj"}
	])
	addFuncMember("delAttr", [
		{"name" : "attr_name", "type" : "String", "param_type" : "val"},
	])
	addFuncMember("setAttr", [
		{"name" : "attr_name", "type" : "String", "param_type" : "val"},
		{"name" : "val", "type" : "String", "param_type" : "val"}
	])
	addFuncMember("resetAttr", [])

func initOverviewList():
	addArrayOverview("Attrs", "getAttrNodeList", [
		{"attr_name" : "attr_name", "func_name" : "getAttrName"},
		{"attr_name" : "attr_type", "func_name" : "getAttrType"}
	])
