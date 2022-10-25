extends Node
class_name SkillInfo

var s_name setget setName
var introduction setget setIntroduction
var avator setget setAvator

func setName(name_):
	if s_name != null:
		return
	s_name = name_

func setIntroduction(introduction_):
	if introduction != null:
		return
	introduction = introduction_

func setAvator(avator_):
	if avator != null:
		return
	avator = avator_

func load_pack(data_pack):
	#TODO
	pass

func pack():
	#TODO
	pass
