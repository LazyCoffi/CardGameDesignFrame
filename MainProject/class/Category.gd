extends Node
class_name Category

var category

var ScriptTree = load("res://class/ScriptTree.gd")

func _ready():
	pass

func parsePath(path):
	category = path.split("/")

func genPath():
	var ret = ""
	for index in category:
		ret += index + "/"

	return ret

func add(path):
	Exception.assert(category is Array)
	category.append_array(path.split("/"))

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("category", category)

	return script_tree

func loadScript(script_tree):
	category = script_tree.getAttr("category")
