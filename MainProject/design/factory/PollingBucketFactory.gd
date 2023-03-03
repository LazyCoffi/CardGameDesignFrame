extends "res://design/factory/Factory.gd"
class_name PollingBucketFactory

func _init():
	__setMemberList()
	initMemberView()
	initConfigView()

	entity_type = "PollingBucket"
	entity = TypeUnit.type(entity_type).new()

func __setMemberList():
	addBaseMember("param_type", "StringPack")
	addObjectMember("init_shuffle_function", "Function")
	addObjectMember("regular_shuffle_function", "Function")

func buildRef(blueprint):
	entity.setInitShuffleFunction(blueprint["init_shuffle_function"])
	entity.setRegularShuffleFunction(blueprint["regular_shuffle_function"])
	
func build(blueprint):
	entity.setParamType(blueprint["param_type"])
