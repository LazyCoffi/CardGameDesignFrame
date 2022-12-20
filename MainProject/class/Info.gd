extends Node

var card_name
var avator
var introduction

# TODO: 考虑是否添加长文本类

var ScriptTree = load("res://class/ScriptTree.gd")

func _ready():
	pass

func setCardName(card_name_):
	card_name = card_name_

func setAvator(avator_):
	# TODO: 添加图片类与图片类的assert
	avator = avator_

func setIntroduction(introduction):
	# TODO: 确定Introduction所属类后添加assert
	introduction = introduction_

func getCardName():
	return card_name

func getAvator():
	return avator

func getIntroduction():
	return introduction

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("card_name", card_name)
	script_tree.addAttr("avator", avator)
	script_tree.addAttr("introduction", introduction)
	
	return script_tree

func loadScript(script_tree):
	Exception.assert(script_tree is ScriptTree)
	card_name = script_tree.getAttr("card_name")
	
	# TODO: 处理avator图像

	introduction = script_tree.getAttr("introduction")
