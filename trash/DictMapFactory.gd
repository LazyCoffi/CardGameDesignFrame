extends "res://design/factory/Factory.gd"
class_name DictMapFactory

var DictMap = TypeUnit.type("DictMap")

var entity

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity = DictMap.new()

func __setMemberList():
	addContainerMember("map", "Integer")

func buildRef(_blueprint):
	return

func build(blueprint):
	entity.setMap(blueprint["map"])
