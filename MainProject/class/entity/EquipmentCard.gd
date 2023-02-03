extends "res://class/entity/Card.gd"
class_name EquipmentCard

var equip_func 			# LocalFunction
var unequip_func 		# LocalFunction
var equip_condition		# Filter 

func _init():
	equip_func = null
	unequip_func = null
	equip_condition = null

func copy():
	var ret = TypeUnit.type("EquipmentCard").new()
	ret.card_name = card_name
	ret.avator_name = avator_name
	ret.introduction = introduction
	ret.template_name = template_name
	ret.card_attr = card_attr.copy()
	ret.equip_func = equip_func.copy()
	ret.unequip_func = unequip_func.copy()
	ret.equip_condition = equip_condition.copy()

	return ret

func equip(card):
	return equip_func.exec([card])

func unequip(card):
	return unequip_func.exec([card])

func isEquipCondition(card):
	return equip_condition.exec([card])

func pack():
	var script_tree = .pack()

	script_tree.addObject("equip_func", equip_func)
	script_tree.addObject("unequip_func", unequip_func)
	script_tree.addObject("equip_condition", equip_condition)

	return script_tree

func loadScript(script_tree):
	.loadScript(script_tree)
	equip_func = script_tree.loadObject("equip_func", LocalFunction)
	unequip_func = script_tree.loadObject("unequip_func", LocalFunction)
	equip_condition = script_tree.loadObject("equip_condition", Filter)
