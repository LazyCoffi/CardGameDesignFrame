extends "res://design/factory/Factory.gd"
class_name LinearCharacterCardFactory

var CardPile = TypeUnit.type("CardPile")

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity_type = "LinearCharacterCard"
	entity = TypeUnit.type(entity_type).new()

func __setMemberList():
	addBaseMember("card_name", "String")
	addBaseMember("avator_name", "String")
	addBaseMember("introduction", "String")
	addBaseMember("template_name", "String")
	addObjectMember("card_attr", "Attr")
	addObjectContainerMember("card_pile", "LinearSkillCard")
	addObjectMember("ai_is_action_condition", "Function")
	addObjectMember("ai_choose_target_function", "Function")
	addObjectMember("ai_choose_card_function", "Function")

func buildRef(blueprint):
	entity.setCardAttr(blueprint["card_attr"])
	
	var card_list = blueprint["card_pile"]
	var card_pile = CardPile.new()
	card_pile.setParamType(LinearSkillCard)
	for card in card_list:
		card_pile.pushFront(card)
	entity.setCardPile(card_pile)

	entity.setAiIsActionCondition(blueprint["ai_is_action_condition"])
	entity.setChooseTargetFunction(blueprint["ai_choose_target_function"])
	entity.setChooseCardFunction(blueprint["ai_choose_card_function"])

func build(blueprint):
	entity.setCardName(blueprint["card_name"])
	entity.setAvatorName(blueprint["avator_name"])
	entity.setIntroduction(blueprint["introduction"])
	entity.setTemplateName(blueprint["template_name"])
