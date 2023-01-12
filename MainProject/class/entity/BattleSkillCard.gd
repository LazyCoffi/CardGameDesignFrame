extends "res://class/entity/Card.gd"
class_name BattleSkillCard

var play_condition				# Filter
var target_condition			# Filter
var counter_condition			# Filter
var counter_target_condition	# Filter
var play_type					# int 
var effect_func					# LocalFunction 

func _init():
	play_type = 0

func isPlayCondition(params):
	return play_condition.exec(params)

func isTargetCondition(params):
	return target_condition.exec(params)

func isCounterCondition(params):
	return counter_condition.exec(params)

func isCounterTargetCondition(params):
	return counter_target_condition.exec(params)

func isPositive():
	return (play_type & 1) != 0

func isPassive():
	return (play_type & 2) != 0

func isAuto():
	return (play_type & 4) != 0

func exec(params):
	return effect_func.exec(params)

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObject("play_condition", play_condition)
	script_tree.addObject("target_condition", target_condition)
	script_tree.addObject("counter_condition", counter_condition)
	script_tree.addObject("counter_target_condition", counter_target_condition)
	script_tree.addAttr("play_type", play_type)
	script_tree.addObject("effect_func", effect_func)

	return script_tree

func loadScript(script_tree):
	play_condition = script_tree.loadObject("play_condition", Filter)
	target_condition = script_tree.loadObject("target_condition", Filter)
	counter_condition = script_tree.loadObject("counter_condition", Filter)
	counter_target_condition = script_tree.loadObject("counter_target_condition", Filter)
	play_type = script_tree.loadAttr("play_type")
	effect_func = script_tree.loadObject("effect_func", LocalFunction)


