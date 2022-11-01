extends Node
class_name ItemCard

var info
var attr

var ItemInfo = load("res://class/ItemInfo.gd")
var ItemAttr = load("res://class/ItemAttr.gd")

func pack():
	var data_pack = {}
	data_pack["info"] = info.pack()
	data_pack["attr"] = attr.pack()
	
	return data_pack

func loadResource():
	info.loadAvator()
	attr.loadSkills()

func loadPack(data_pack):
	assert(data_pack is Dictionary)
	
	info = ItemInfo.new()
	info.loadPack(data_pack["info"])
	attr = ItemAttr.new()
	attr.loadPack(data_pack["attr"])
