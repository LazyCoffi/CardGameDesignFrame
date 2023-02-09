extends Node
class_name CharacterCard

var info
var attr
var state

var CharacterInfo = load("res://class/CharacterInfo.gd")
var CharacterAttr = load("res://class/CharacterAttr.gd")
var CharacterState = load("res://class/CharacterState.gd")

func pack():
	var data_pack = {}
	data_pack["info"] = info.pack()
	data_pack["attr"] = attr.pack()
	data_pack["state"] = state.pack()
	
	return data_pack

func loadResource():
	info.loadAvator()

func loadPack(data_pack):
	assert(data_pack is Dictionary)

	info = CharacterInfo.new()
	info.loadPack(data_pack["info"])
	attr = CharacterAttr.new()
	attr.loadPack(data_pack["attr"])
	state = CharacterState.new()
	state.loadPack(data_pack["state"])
