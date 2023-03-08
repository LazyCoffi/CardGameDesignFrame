extends "res://design/factory/Factory.gd"
class_name CardTemplateFactory

func _init():
	entity_type = "CardTemplate"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addFuncMember("setCardType", [
		{"name" : "card_type", "type" : "String", "param_type" : "val"}
	])
	addCommonObjectMember("card_template", "setCardTemplate")
	addObjectMember("revise_function", "Function", "setReviseFunction")
