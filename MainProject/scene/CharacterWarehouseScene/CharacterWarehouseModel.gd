extends Node
class_name CharacterWarehouseModel

var ScriptTree = load("res://class/entity/ScriptTree.gd")
var LinearCharacterCard = load("res://class/entity/LinearCharacterCard.gd")
var DictArray = load("res://class/dataStruct/DictArray.gd")

var param_map

var cur_character_group		# LinearCharacterCard_DictArray

func _init():
	__setParamMap()

func getParam(param_name):
	return param_map[param_name]

func addCurCharacter(character_card):
	var card_name = character_card.getCardName()
	cur_character_group.append(card_name, character_card)
func delCurCharacter(character_name):
	cur_character_group.del(character_name)

func setCurCharacterGroup(character_group):
	cur_character_group = character_group

func __setParamMap():
	__addParam("cur_character_group", cur_character_group)

func __addParam(param_name, param):
	param_map[param_name] = param

func pack():
	var script_tree = ScriptTree.new()
	
	script_tree.addTypeObject("cur_character_group", cur_character_group)

	return script_tree

func loadScript(script_tree):
	cur_character_group = script_tree.getTypeObject("cur_character_group", DictArray, LinearCharacterCard)
