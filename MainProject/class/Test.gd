extends Node

func ScriptTreeTest():
	var ScriptTree = load("res://class/ScriptTree.gd")
	var script_tree = ScriptTree.new()
	script_tree.loadFromJson("res://scripts/debug.json")
	var Card = load("res://class/Card.gd")
	var card = Card.new()
	card.loadScript(script_tree)
	
	var info = card.info
	print(info.card_name)

func ExceptionTest():
	Exception.warning(false, "false test")
	Exception.error(false, "exit")

func IsTest():
	var a = 1
	print(a is int)

func exec(func_name):
	self.call(func_name)

func run():
	pass
