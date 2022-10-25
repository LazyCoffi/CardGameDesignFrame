extends Node
class_name CharacterCard
var CharacterInfo = load("res://class/CharacterInfo.gd")
var CharacterAttr = load("res://class/CharacterAttr.gd")
var CharacterState = load("res://class/CharacterState.gd")

var info = CharacterInfo.new()
var attr = CharacterAttr.new()
var state = CharacterState.new()

func load_data(data_pack):
	#TODO
	pass

func pack():
	#TODO
	pass
