extends Node
class_name SkillCard

var info
var attr

var SkillInfo = load("res://class/SkillInfo.gd")
var SkillAttr = load("res://class/SkillAttr.gd")

func pack():
	var data_pack = {}
	data_pack["info"] = info.pack()
	data_pack["attr"] = attr.pack()
	
	return data_pack

func loadResource():
	info.loadAvator()

func loadPack(data_pack):
	assert(data_pack is Dictionary)
	
	info = SkillInfo.new()
	info.loadPack(data_pack["info"])
	attr = SkillAttr.new()
	attr.loadPack(data_pack["attr"])
