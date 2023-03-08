extends "res://design/factory/Factory.gd"
class_name AttrFactory

func _init():
	entity_type = "Attr"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addFuncMember("addAttr", [
		{"name" : "attr_name", "type" : "String", "param_type" : "val"},
		{"name" : "attr_type", "type" : "String", "param_type" : "val"},
		{"name" : "val", "type" : "String", "param_type" : "val"},
		{"name" : "getter", "type" : "Function", "param_type" : "object"},
		{"name" : "setter", "type" : "Function", "param_type" : "object"}
	])
