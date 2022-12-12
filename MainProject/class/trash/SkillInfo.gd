extends Node
class_name SkillInfo

var s_name setget setName
var introduction setget setIntroduction
var avator_name setget setAvatorName
var avator

func setName(name_):
	if s_name != null:
		return
	s_name = name_

func setIntroduction(introduction_):
	if introduction != null:
		return
	introduction = introduction_

func setAvatorName(avator_name_):
	if avator_name_ != null:
		return
	avator_name = avator_name_

func pack():
	var data_pack = {}
	data_pack["s_name"] = s_name
	data_pack["introduction"] = introduction
	data_pack["avator_name"] = avator_name
	
	return data_pack

func loadAvator():
	avator = ResourceTool.loadImage(avator_name)

func loadPack(data_pack):
	assert(data_pack is Dictionary)

	s_name = data_pack["s_name"]
	introduction = data_pack["introduction"]
	avator_name = data_pack["avator_name"]
