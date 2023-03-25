extends "res://design/factory/Factory.gd"
class_name AnimationPackFactory

func _init():
	entity_type = "AnimationPack"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addFuncMember("addTexturePath", [
		{"name" : "texture_path", "type" : "String", "param_type" : "path"}
	])
	addFuncMember("delTexturePath", [
		{"name" : "del_index", "type" : "int", "param_type" : "val"}
	])
	addFuncMember("setGap", [
		{"name" : "gap", "type" : "float", "param_type" : "val"}
	])
	addFuncMember("resetGap", [])

func initOverviewList():
	addAttrArrayOverview("texture_path_list", "getTexturePathList")
	addAttrOverview("gap", "getGap")
