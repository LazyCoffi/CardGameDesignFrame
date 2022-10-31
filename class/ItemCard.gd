extends Node
class_name ItemCard



var info = ItemInfo.new()
var attr = ItemAttr.new()

func pack():
	var data_pack = {}
	data_pack["info"] = info.pack()
	data_pack["attr"] = attr.pack()
	
	return data_pack

func loadResource():
	info.loadAvator()
	attr.loadSkils()

static func loadPack(data_pack):
	var card = load("res://class/InfoCard.gd").new()
	var ItemInfo = load("res://class/ItemInfo.gd")
	var ItemAttr = load("res://class/ItemAttr.gd")
	
	card.info = ItemInfo.loadPack(data_pack["info"])
	card.attr = ItemAttr.loadPack(data_pack["attr"])
	
	return card
