extends Node
class_name Functional

var func_name
var category

var ScriptTree = load("res://class/ScriptTree.gd")
var FunctionalCategory = load("res://class/FunctionalCategory.gd")

func _ready():
	pass

func exec(params):
	return FunctionalCategory.exec(func_name, category, params)

func getRetType():
	return FunctionalCategory.getRetType(func_name)

func getParmsType():
	return FunctionalCategory.getParmsType(func_name)

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("func_name", func_name)
	script_tree.addObject("category", category)

	return script_tree

func loadScript(script_tree):
	func_name = script_tree.getAttr("func_name")
	category = script_tree.getObject("category")
