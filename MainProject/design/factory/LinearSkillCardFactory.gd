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
	addObjectMember("animation_pack", "AnimationPack", "setAnimationPack")
	addObjectMember("audio_pack", "AudioPack", "setAudioPack")

func initOverviewList():
	addAttrOverview("is_offensive", "isOffensive")
	addAttrOverview("is_auto", "isAuto")
	addAttrOverview("is_recyclable", "isRecyclable")
	addAttrOverview("is_retainable", "isRetainable")
	addAttrOverview("is_destroy", "isDestroy")
	addAttrOverview("is_play_recyclable", "isPlayRecyclable")
	addAttrOverview("is_play_destory", "isPlayDestory")
	addAttrOverview("is_play_retainable", "isPlayRetainable")
