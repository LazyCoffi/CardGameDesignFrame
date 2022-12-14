extends Node
class_name LocalFunction

var functions = []

var Functional = load("res://class/Functional.gd")
var ScriptTree = load("res://class/ScriptTree.gd")

func _ready():
	pass

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObjectArray("functions", functions)

	return script_tree

func loadScript(script_tree):
	functions = script_tree.getObjectArray("functions", Functional)


