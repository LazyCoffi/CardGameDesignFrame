extends Node

var card_name
var avator_name
var introduction

# TODO: 考虑是否添加长文本类

var ScriptTree = load("res://class/entity/ScriptTree.gd")

func _ready():
	pass

func setCardName(card_name_):
	card_name = card_name_

func setAvatorName(avator_name_):
	avator_name = avator_name_

func setIntroduction(introduction_):
	# TODO: 确定Introduction所属类后添加assert
	introduction = introduction_

func getCardName():
	return card_name

func getAvatorName():
	return avator_name

func getIntroduction():
	return introduction

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("card_name", card_name)
	script_tree.addAttr("avator_name", avator_name)
	script_tree.addAttr("introduction", introduction)
	
	return script_tree

func loadScript(script_tree):
	Exception.assert(script_tree is ScriptTree)
	card_name = script_tree.getAttr("card_name")
	avator_name = script_tree.getAttr("avator_name")
	introduction = script_tree.getAttr("introduction")
