extends Node
class_name Card

var Category = load("res://class/entity/Category.gd")
var Info = load("res://class/entity/Info.gd")
var Attr = load("res://class/entity/Attr.gd")
var LocalFunction = load("res://class/functionalSystem/LocalFunction.gd")
var ScriptTree = load("res://class/entity/ScriptTree.gd")
var Filter = load("res://class/functionalSystem/Filter.gd")

var category				# 卡牌类型
var info 					# 卡牌信息
var attr					# 卡牌参数

func _ready():
	pass # Replace with function body.

func getCardName():
	return info.getCardName()

func getAvatorName():
	return info.getAvatorName()

func getCategory():
	return category.duplicate()

func getInfo():
	return info.duplicate()

func getAttr():
	return attr.duplicate()

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObject("category", category)
	script_tree.addObject("info", info)
	script_tree.addObject("attr", attr)
	
	return script_tree

func loadScript(script_tree):
	Exception.assert(script_tree is ScriptTree)
	category = script_tree.getObject("category", Category)
	info = script_tree.getObject("info", Info)
	attr = script_tree.getObject("attr", Attr)
