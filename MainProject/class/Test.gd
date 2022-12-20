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

func isTest():
	var Type = load("res://class/Attr.gd")
	var attr = Type.new()
	print(attr is Type)

func __paramTest(arr):
	var arr_ = arr
	arr_[2] = 5

func paramTest():
	var arr = [1, 2, 3, 4]
	__paramTest(arr)
	print(arr)

func exec(func_name):
	self.call(func_name)

func run():
	exec("paramTest")
