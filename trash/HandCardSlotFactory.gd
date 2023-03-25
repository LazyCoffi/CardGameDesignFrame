extends "res://design/factory/Factory.gd"
class_name HandCardSlotFactory

var HandCardSlot = TypeUnit.type("HandCardSlot")

var entity
var param_type

func _init(param_type_):
	param_type = param_type_

	__setMemberList()
	initMemberView()
	initConfigView()

	entity = HandCardSlot.new()

func __setMemberList():
	addObjectContainerMember("card_slot", param_type)

func getEntity():
	return entity

func buildRef(blueprint):
	entity.setCardSlot(blueprint["card_slot"])

func build(_blueprint):
	return
