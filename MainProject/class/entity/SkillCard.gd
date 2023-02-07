extends "res://class/entity/Card.gd"
class_name SkillCard

var BitFlag = TypeUnit.type("BitFlag")

var play_condition			# Function
var type_flag				# BitFlag
var effect_func				# HyperFunction 
func _init():
	play_condition = null
	type_flag = BitFlag.new()
	effect_func = null

func copy():
	var ret = TypeUnit.type("SkillCard").new()

	ret.card_name = card_name
	ret.avator_name = avator_name
	ret.introduction = introduction
	ret.template_name = template_name
	ret.card_attr = card_attr.copy()

	ret.play_condition = play_condition.copy()
	ret.type_flag = type_flag.copy()
	ret.effect_func = effect_func.copy()

	return ret

# play_condition
func isPlayCondition(card):
	return play_condition.exec([card])

func setPlayCondition(play_condition_):
	play_condition = play_condition_

# effect_func
func exec(source, target):
	return effect_func.exec([source, target])

func setEffectFunc(effect_func_):
	effect_func = effect_func_

func pack():
	var script_tree = .pack()

	script_tree.addObject("play_condition", play_condition)
	script_tree.addObject("type_flag", type_flag)
	script_tree.addObject("effect_func", effect_func)

	return script_tree

func loadScript(script_tree):
	.loadScript(script_tree)
	play_condition = script_tree.getObject("play_condition", Function)
	type_flag = script_tree.getObject("type_flag", BitFlag)
	effect_func = script_tree.getObject("effect_func", HyperFunction)
