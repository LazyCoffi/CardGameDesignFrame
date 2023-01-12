extends Node
class_name TriggerTimer

var ScriptTree = load("res://class/entity/ScriptTree.gd")

signal timeout_signal

var timer		# int
var is_active

func _init():
	timer = 0
	is_active = false

func setTimer(time):
	TypeUnit.isType(time, "int")
	is_active = true
	timer = time

func pause():
	is_active = false

func resetTimer():
	is_active = false
	timer = 0

func tick():
	if not is_active:
		return

	timer -= 1

	if timer == 0:
		is_active = false
		emit_signal("timeout_signal")
	
func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("timer", timer)
	script_tree.addAttr("is_active", is_active)

	return script_tree

func loadScript(script_tree):
	timer = script_tree.loadAttr("timer")
	is_active = script_tree.loadAttr("is_active")
