extends "res://design/factory/Factory.gd"
class_name BooleanFactory

func _init():
	entity_type = "Boolean"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addFuncMember("setTrue", [])
	addFuncMember("setFalse", [])

func initOverviewList():
	addAttrOverview("val", "getVal")
