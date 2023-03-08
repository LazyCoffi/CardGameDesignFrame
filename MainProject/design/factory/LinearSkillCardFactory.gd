extends "res://design/factory/Factory.gd"
class_name LinearSkillCardFactory

func _init():
	entity_type = "LinearSkillCard"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addFuncMember("setInfo", [
		{"name" : "card_name", "type" : "String", "param_type" : "val"},
		{"name" : "avator_name", "type" : "String", "param_type" : "val"},
		{"name" : "introduction", "type" : "String", "param_type" : "val"},
		{"name" : "template_name", "type" : "String", "param_type" : "val"},
	])
	addObjectMember("card_attr", "Attr", "setCardAttr")
	addObjectMember("play_condition", "Function", "setPlayCondition")
	addObjectMember("effect_func", "HyperFunction", "setEffectFunc")
	addFuncMember("setOffensive", [])
	addFuncMember("resetOffensive", [])
	addFuncMember("setAuto", [])
	addFuncMember("resetAuto", [])
	addFuncMember("setRecyclable", [])
	addFuncMember("setRetainable", [])
	addFuncMember("setDestroy", [])
	addFuncMember("setPlayRecyclable", [])
	addFuncMember("setPlayRetainable", [])
	addFuncMember("setPlayDestroy", [])
	addObjectMember("target_condition", "Function", "setTargetCondition")
	addObjectMember("auto_condition", "Function", "setAutoCondition")
