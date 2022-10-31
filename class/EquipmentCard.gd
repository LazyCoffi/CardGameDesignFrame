extends Node
class_name EquipmentCard

var info
var attr
var require

func pack():
	var data_pack = {}
	data_pack["info"] = info.pack()
	data_pack["attr"] = attr.pack()
	data_pack["require"] = require.pack()
	
	return data_pack

func loadResource():
	info.loadAvator()
	attr.loadSkills()

static func loadPack(data_pack):
	var card = load("res://class/EquipmentCard.gd").new()
	var EquipmentInfo = load("res://class/EquipmentInfo.gd")
	var EquipmentAttr = load("res://class/EquipmentAttr.gd")
	var EquipmentRequire = load("res://class/EquipmentRequire.gd")
	card.info = EquipmentInfo.loadPack(data_pack["info"])
	card.attr = EquipmentAttr.loadPack(data_pack["attr"])
	card.require = EquipmentRequire.loadPack(data_pack["require"])
	
	return card
