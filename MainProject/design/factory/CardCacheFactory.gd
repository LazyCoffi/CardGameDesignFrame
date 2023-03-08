extends "res://design/factory/Factory.gd"
class_name CardCacheFactory

func _init():
	entity_type = "CardCache"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addObjectDictMember("card_templates", "CardTemplate", "addTemplate", "delTemplate", "setTemplateName", "getTemplateName")
