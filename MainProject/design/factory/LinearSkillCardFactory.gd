extends "res://design/factory/Factory.gd"
class_name LinearSkillCardFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity_type = "LinearSkillCard"
	entity = TypeUnit.type(entity_type).new()

func __setMemberList():
	addBaseMember("card_name", "String")
	addBaseMember("avator_name", "String")
	addBaseMember("introduction", "String")
	addBaseMember("template_name", "String")
	addObjectMember("card_attr", "Attr")
	addObjectMember("play_condition", "Function")
	addObjectMember("effect_func", "HyperFunction")
	addBaseMember("isOffensive", "Boolean")
	addBaseMember("isAuto", "Boolean")
	addBaseMember("discard_mode", "String")
	addBaseMember("play_discard_mode", "String")
	addObjectMember("target_condition", "Function")
	addObjectMember("auto_condition", "Function")

func buildRef(blueprint):
	entity.setCardAttr(blueprint["card_attr"])
	entity.setPlayCondition(blueprint["play_condition"])
	entity.setEffectFunc(blueprint["effect_func"])
	entity.setTargetCondition(blueprint["target_condition"])
	entity.setAutoCondition(blueprint["auto_condition"])
	
func build(blueprint):
	entity.setCardName(blueprint["card_name"])
	entity.setAvatorName(blueprint["avator_name"])
	entity.setIntroduction(blueprint["introduction"])
	entity.setTemplateName(blueprint["template_name"])

	if blueprint["isOffensive"]:
		entity.setOffensive()
	else:
		entity.resetOffensive()
	
	if blueprint["isAuto"]:
		entity.setAuto()
	else:
		entity.resetAuto()
	
	match blueprint["discard_mode"]:		
		"Recyclable":
			entity.setRecyclable()
		"Retainable":
			entity.setRetainable()
		"Destroy":
			entity.setDestroy()
	
	match blueprint["play_discard_mode"]:
		"Recyclable":
			entity.setPlayRecyclable()
		"Retainable":
			entity.setPlayRetainable()
		"Destroy":
			entity.setPlayDestroy()
