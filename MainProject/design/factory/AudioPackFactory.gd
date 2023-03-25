extends "res://design/factory/Factory.gd"
class_name AudioPackFactory

func _init():
	entity_type = "AudioPack"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addFuncMember("setAudioPath", [
		{"name" : "audio_path", "type" : "String", "param_type" : "path"}
	])
	addFuncMember("resetAudioPath", [])

func initOverviewList():
	addAttrOverview("audio_path", "getAudioPath")
