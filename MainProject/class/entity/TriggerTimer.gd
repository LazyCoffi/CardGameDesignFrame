extends Node
class_name TriggerTimer

var ScriptTree = TypeUnit.type("ScriptTree")

signal timeout_signal

var timer			# int
var is_active		# bool

func _init():
	timer = 0
	is_active = false

func copy():
	var ret = TypeUnit.type("TriggerTimer").new()
	ret.timer = timer
	ret.is_active = is_active

	return ret

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
	timer = script_tree.getInt("timer")
	is_active = script_tree.getBool("is_active")
