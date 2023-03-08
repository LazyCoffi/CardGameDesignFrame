extends "res://design/factory/Factory.gd"
class_name LinearCharacterCardFactory

var CardPile = TypeUnit.type("CardPile")

func _init():
	entity_type = "LinearCharacterCard"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addFuncMember("setInfo", [
		{"name" : "card_name", "type" : "String", "param_type" : "val"},
		{"name" : "avator_name", "type" : "String", "param_type" : "val"},
		{"name" : "introduction", "type" : "String", "param_type" : "val"},
		{"name" : "template_name", "type" : "String", "param_type" : "val"},
	])
	addObjectMember("card_attr", "Attr", "setCardAttr")
	addObjectMember("init_card_pile_condition", "Function", "setInitCardPileFunction")
	addObjectMember("ai_is_action_condition", "Function", "setAiIsActionCondition")
	addObjectMember("ai_choose_target_function", "Function", "setAiChooseTargetFunction")
	addObjectMember("ai_choose_card_function", "Function", "setAiChooseCardFunction")
