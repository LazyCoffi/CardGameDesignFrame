extends Node
class_name Card

var Category = load("res://class/entity/Category.gd")
var Info = load("res://class/entity/Info.gd")
var Attr = load("res://class/entity/Attr.gd")
var LocalFunction = load("res://class/functionalSystem/LocalFunction.gd")
var ScriptTree = load("res://class/entity/ScriptTree.gd")
var Filter = load("res://class/functionalSystem/Filter.gd")

var category				# Category
var info 					# Info
var attr					# Attr

func _init():
	category = category.new()
	info = Info.new()
	attr = Attr.new()

func getCardName():
	return info.getCardName()

func getAvatorName():
	return info.getAvatorName()

func getCategory():
	return category

func getInfo():
	return info

func getAttr():
	return attr

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObject("category", category)
	script_tree.addObject("info", info)
	script_tree.addObject("attr", attr)
	
	return script_tree

func loadScript(script_tree):
	category = script_tree.getObject("category", Category)
	info = script_tree.getObject("info", Info)
	attr = script_tree.getObject("attr", Attr)
