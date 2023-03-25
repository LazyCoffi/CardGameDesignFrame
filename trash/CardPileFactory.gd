extends "res://design/factory/Factory.gd"
class_name CardPileFactory

var CardPile = TypeUnit.type("CardPile")

var entity
var param_type		# String

func _init(param_type_):
	param_type = param_type_

	__setMemberList()
	initMemberView()
	initConfigView()

	entity = CardPile.new()

func __setMemberList():
	addObjectContainerMember("card_pile", param_type)
	addObjectContainerMember("trash_pile", param_type)
	addBaseMember("is_random", "Boolean")

func getEntity():
	return entity

func buildRef(blueprint):
	entity.setCardPile(blueprint["card_pile"])
	entity.setTrashPile(blueprint["trash_pile"])

func build(blueprint):
	if blueprint["is_random"]:
		entity.randomOn()
	else:
		entity.randomOff()
