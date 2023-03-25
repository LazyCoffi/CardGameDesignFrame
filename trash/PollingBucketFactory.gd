extends "res://design/factory/Factory.gd"
class_name PollingBucketFactory

func _init():
	entity_type = "PollingBucket"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addBaseMember("param_type", "String")
	addObjectMember("init_shuffle_function", "Function")
	addObjectMember("regular_shuffle_function", "Function")

func buildRef(blueprint):
	entity.setInitShuffleFunction(blueprint["init_shuffle_function"])
	entity.setRegularShuffleFunction(blueprint["regular_shuffle_function"])
	
func build(blueprint):
	entity.setParamType(blueprint["param_type"])
