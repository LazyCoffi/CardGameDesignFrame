extends "res://class/entity/Card.gd"
class_name BattleSkillCard

var play_condition				# Filter
var target_condition			# Filter
var counter_condition			# Filter
var counter_target_condition	# Filter
var play_type					# int 
var effect_func					# LocalFunction 

func _init():
	play_condition = Filter.new()
	target_condition = Filter.new()
	counter_condition = Filter.new()
	counter_target_condition = Filter.new()
	play_type = 0
	effect_func = LocalFunction.new()

func copy():
	var ret = TypeUnit.type("BattleSkillCard").new()
	ret.category = category.copy()
	ret.info = info.copy()
	ret.attr = attr.copy()
	ret.play_condition = play_condition.copy()
	ret.target_condition = target_condition.copy()
	ret.counter_condition = counter_condition.copy()
	ret.counter_target_condition = counter_target_condition.copy()
	ret.play_type = play_type
	ret.effect_func = effect_func.copy()

	return ret

## TODO: 用接口代替直接的Filter/LocalFunction调用
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

## TODO: 包装参数数组
func exec(params):
	return effect_func.exec(params)

func pack():
	var script_tree = .pack()

	script_tree.addObject("play_condition", play_condition)
	script_tree.addObject("target_condition", target_condition)
	script_tree.addObject("counter_condition", counter_condition)
	script_tree.addObject("counter_target_condition", counter_target_condition)
	script_tree.addAttr("play_type", play_type)
	script_tree.addObject("effect_func", effect_func)

	return script_tree

func loadScript(script_tree):
	.loadScript(script_tree)
	play_condition = script_tree.getObject("play_condition", Filter)
	target_condition = script_tree.getObject("target_condition", Filter)
	counter_condition = script_tree.getObject("counter_condition", Filter)
	counter_target_condition = script_tree.getObject("counter_target_condition", Filter)
	play_type = script_tree.getInt("play_type")
	effect_func = script_tree.getObject("effect_func", LocalFunction)
