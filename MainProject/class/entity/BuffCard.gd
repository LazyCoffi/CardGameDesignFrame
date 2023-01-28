extends "res://class/entity/Card.gd"
class_name BuffCard

var TriggerTimer = load("res://class/entity/TriggerTimer.gd")

var is_active			# bool
var is_continuous		# bool
var effect_func			# LocalFunction
var deactive_trigger	# TriggerTimer 

func _init():
	is_continuous = true
	is_active = false
	effect_func = LocalFunction.new()
	deactive_trigger = TriggerTimer.new()

	## TODO: 考虑此处是否需要直接连接信号
	self.connect("deactive", deactive_trigger, "timeout_signal")

func isExcuable():
	if is_continuous:
		return true
	
	if is_active:
		return false
	
	return true

func active():
	is_active = true

func deactive():
	is_active = false

## TODO: 包装参数数组
func exec(params):
	if not is_continuous:
		active()
	
	return effect_func.exec(params)

func setTimer(time):
	deactive_trigger.setTimer(time)

func stopTimer():
	deactive_trigger.resetTimer()

func tickTimer():
	deactive_trigger.tick()

func pack():
	var script_tree = .pack()

	script_tree.addAttr("is_active", is_active)
	script_tree.addAttr("is_continuous", is_continuous)
	script_tree.addObject("effect_func", effect_func)
	script_tree.addObject("deactive_trigger", deactive_trigger)

	return script_tree

func loadScript(script_tree):
	.loadScript(script_tree)
	is_active = script_tree.getBool("is_active")
	is_continuous = script_tree.getBool("is_continuous")
	effect_func = script_tree.getObject("effect_func", LocalFunction)
	deactive_trigger = script_tree.getObject("deactive_trigger", TriggerTimer)
