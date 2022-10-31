extends Node
class_name SkillCard

var info
var attr

func pack():
	var data_pack = {}
	data_pack["info"] = info.pack()
	data_pack["attr"] = attr.pack()
	
	return data_pack

func loadResource():
	info.loadAvator()

static func loadPack(data_pack):
	var card = load("res://class/SkillCard.gd").new()
	var SkillInfo = load("res://class/SkillInfo.gd")
	var SkillAttr = load("res://class/SkillAttr.gd")
	card.info = SkillInfo.loadPack(data_pack["info"])
	card.attr = SkillAttr.loadPack(data_pack["attr"])
	
	return card
