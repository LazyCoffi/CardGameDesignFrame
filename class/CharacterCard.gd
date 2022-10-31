extends Node
class_name CharacterCard

var info
var attr
var state

func pack():
	var data_pack = {}
	data_pack["info"] = info.pack()
	data_pack["attr"] = attr.pack()
	data_pack["state"] = state.pack()
	
	return data_pack

func loadResource():
	info.loadAvator()

static func loadPack(data_pack):
	assert(data_pack is Dictionary)
	
	var card = load("res://class/CharacterCard.gd").new()
	var CharacterInfo = load("res://class/CharacterInfo.gd")
	var CharacterAttr = load("res://class/CharacterAttr.gd")
	var CharacterState = load("res://class/CharacterState.gd")
	card.info = CharacterInfo.loadPack(data_pack["info"])
	card.attr = CharacterAttr.loadPack(data_pack["attr"])
	card.state = CharacterState.loadPack(data_pack["state"])
	
	return card
