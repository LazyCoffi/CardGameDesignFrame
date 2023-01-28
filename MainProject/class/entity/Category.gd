extends Node
class_name Category

var category 		# Array

var ScriptTree = load("res://class/entity/ScriptTree.gd")

func _init():
	category = []

func addCategory(category_):
	Exception.assert(TypeUnit.isType(category_, "Array"))
	category.append_array(category_)

func setCategory(category_):
	Exception.assert(TypeUnit.isType(category_, "Array"))
	category = category_

func getCategory():
	return category.duplicate()

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("category", category)

	return script_tree

func loadScript(script_tree):
	category = script_tree.getStrArray("category")
