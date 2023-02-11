extends "res://class/entity/SkillCard.gd"
class_name LinearSkillCard

var target_condition			# Function
var auto_condition				# Function

func _init():
	target_condition = null
	auto_condition = null

func copy():
	var ret = TypeUnit.type("LinearSkillCard").new()

	ret.card_name = card_name
	ret.avator_name = avator_name
	ret.introduction = introduction
	ret.template_name = template_name
	ret.card_attr = card_attr.copy()

	ret.play_condition = play_condition.copy()
	ret.type_flag = type_flag.copy()
	ret.effect_func = effect_func.copy()

	ret.target_condition = target_condition.copy()
	ret.auto_condition = auto_condition.copy()

	return ret

# type_flag
func isPositive():
	return type_flag.getFlag(0) != 0

func setPositive():
	type_flag.setFlag(0)

func unsetPositive():
	type_flag.resetFlag(0)

func isAuto():
	return type_flag.getFlag(1) != 0

func setAuto():
	type_flag.setFlag(1)

func unsetAuto():
	type_flag.resetFlag(1)

func isRecycleable():
	return type_flag.getFlag(2, 3) == 0

func isRetainable():
	return type_flag.getFlag(2, 3) == 1

func isDestroy():
	return type_flag.getFlag(2, 3) == 2

func setRecycleable():
	type_flag.resetFlag(2, 3)

func setRetainable():
	type_flag.resetFlag(2, 3)
	type_flag.setFlag(2)

func setDestroy():
	type_flag.resetFlag(2, 3)
	type_flag.setFlag(3)

func isPlayRecyclable():
	return type_flag.getFlag(4, 5) == 0

func isPlayDestroy():
	return type_flag.getFlag(4, 5) == 1

func isPlayRetainable():
	return type_flag.getFlag(4, 5) == 2

func setPlayRecyclable():
	type_flag.resetFlag(4, 5)

func setPlayRetainable():
	type_flag.resetFlag(4, 5)
	type_flag.setFlag(4)

func setPlayDestory():
	type_flag.resetFlag(4, 5)
	type_flag.setFlag(5)

# target_condition
func isTargetCondition(card, scene_name):
	return target_condition.exec([card, scene_name])

func setTargetCondition(target_condition_):
	target_condition = target_condition_

# auto_condition
func isAutoCondition(card, scene_name):
	auto_condition.exec([card, scene_name])

func setAutoCondition(auto_condition_):
	auto_condition = auto_condition_

# card_slot
func afterPlayDiscard(card_pile, card_slot):
	if isPlayRecyclable():
		card_slot.erase(self)
		card_pile.pushTrashBack(self)
	elif isPlayDestroy():
		card_slot.erase(self)
	elif isPlayRetainable():
		return

func positiveDiscard(card_pile, card_slot):
	if isRecycleable():
		card_pile.pushTrashBack(self)
	elif isRetainable():
		card_pile.pushTrashBack(self)
		card_slot.erase(self)
	elif isDestroy():
		card_slot.erase(self)

func passiveDiscard(card_pile, card_slot):
	if isRecycleable():
		card_pile.pushTrashBack(self)
		card_slot.erase(self)
		return true
	elif isRetainable():
		return false
	elif isDestroy():
		card_slot.erase(self)
		return true
	
func pack():
	var script_tree = .pack()

	script_tree.addObject("target_condition", target_condition)
	script_tree.addObject("auto_condition", auto_condition)

	return script_tree

func loadScript(script_tree):
	.loadScript(script_tree)
	target_condition = script_tree.getObject("target_condition", Function)
	auto_condition = script_tree.getObject("auto_condition", Function)
