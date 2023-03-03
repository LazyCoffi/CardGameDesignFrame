extends "res://design/factory/Factory.gd"
class_name CardTemplateFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()
	
	entity_type = "CardTemplate"
	entity = TypeUnit.type(entity_type).new()

func buildRef(blueprint):
	entity.setCardTemplate(blueprint["card_template"])
	entity.setReviseFunction(blueprint["revise_function"])

func build(blueprint):
	entity.setTemplateName(blueprint["template_name"])
	entity.setCardType(blueprint["card_type"])

func __setMemberList():
	addBaseMember("template_name", "String")
	addBaseMember("card_type", "String")
	addCommonObjectMember("card_template")
	addObjectMember("revise_function", "Function")

