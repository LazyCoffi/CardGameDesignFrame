extends "res://design/factory/Factory.gd"
class_name ArrangeMapFactory

var entity
var ArrangeMap = TypeUnit.type("ArrangeMap")

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity = ArrangeMap.new()

func __setMemberList():
	addContainerMember("map", "int")

func getEntity():
	return entity

func buildRef(_blueprint):
	return

func build(blueprint):
	entity.setMap(blueprint["map"])
