extends "res://design/factory/Factory.gd"
class_name ParamListFactory

func _init():
	entity_type = "ParamList"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addObjectContainerMember("list", "ParamNode")

func buildRef(blueprint):
	entity.setList(blueprint["list"])

func build(_buleprint):
	return
