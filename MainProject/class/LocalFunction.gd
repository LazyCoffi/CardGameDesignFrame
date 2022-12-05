extends Node
class_name LocalFunction

var functions = []

func _ready():
	pass

func loadScript(script):
	var raw_functions = script.getScriptArray()
	var Function = load("res://class/Function.gd")
	for raw_function in raw_functions:
		var function = Function.new()
		function.loadScript(raw_function)
		functions.append(function)

func pack():
	var script = Script.new()
	script.addScriptArray("functions", functions)

	return script

