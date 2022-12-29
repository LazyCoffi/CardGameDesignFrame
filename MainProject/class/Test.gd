extends Node

func ScriptTreeTest():
	var ScriptTree = load("res://class/entity/ScriptTree.gd")
	var script_tree = ScriptTree.new()
	script_tree.loadFromJson("res://scripts/debug.json")
	var Card = load("res://class/entity/Card.gd")
	var card = Card.new()
	card.loadScript(script_tree)
	
	var info = card.info
	print(info.card_name)

func ExceptionTest():
	Exception.warning(false, "false test")
	Exception.error(false, "exit")

class Con:
	var a

func ObjectTest():
	var a = Con.new()
	a.a = 1
	__ObjectTest(a)
	print(a.a)
	var b = a
	b.a = 3
	print(a.a)

func __ObjectTest(obj):
	obj.a = 2
	

func isTest():
	var Type = load("res://class/entity/Attr.gd")
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
	pass
