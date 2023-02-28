extends "res://design/factory/Factory.gd"
class_name ParamListFactory

var ParamList = TypeUnit.type("ParamList")

var entity

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

func __setMemberList():
	addObjectContainerMember("list", "ParamNode")

func getEntity():
	return entity

func buildRef(blueprint):
	entity.setList(blueprint["list"])

func build(_buleprint):
	return
