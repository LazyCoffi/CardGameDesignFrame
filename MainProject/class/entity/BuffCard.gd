extends "res://class/entity/Card.gd"
class_name BuffCard

var TriggerTimer = TypeUnit.type("TriggerTimer")

var is_active			# bool
var is_continuous		# bool
var effect_func			# LocalFunction
var deactive_trigger	# TriggerTimer 

func _init():
	is_continuous = true
	is_active = false
	effect_func = null
	deactive_trigger = null

func copy():
	var ret = TypeUnit.type("BuffCard").new()
	ret.card_name = card_name
	ret.avator_name = avator_name
	ret.introduction = introduction
	ret.template_name = template_name
	ret.card_attr = card_attr.copy()
	ret.is_active = is_active
	ret.is_continuous = is_continuous
	ret.effect_func = effect_func.copy()
	ret.deactive_trigger = deactive_trigger.copy()

	return ret

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

# effect_func
func exec():
	if not is_continuous:
		active()
	
	return effect_func.exec()

func setEffectFunc(effect_func_):
	effect_func = effect_func_

# deactive_trigger
func setTimer(time):
	deactive_trigger.setTimer(time)

func stopTimer():
	deactive_trigger.resetTimer()

func tickTimer():
	deactive_trigger.tick()

func setDeactiveTrigger(deactive_trigger_):
	deactive_trigger = deactive_trigger_

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
