extends Node

var card_name
var avator
var introduction

var ScriptTree = load("res://class/ScriptTree.gd")

func _ready():
	pass

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
