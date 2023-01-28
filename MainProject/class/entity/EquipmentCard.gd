extends "res://class/entity/Card.gd"
class_name EquipmentCard

var equip_func 			# LocalFunction
var unequip_func 		# LocalFunction
var equip_condition		# Filter 

func _init():
	equip_func = LocalFunction.new()
	unequip_func = LocalFunction.new()
	equip_condition = Filter.new()

func equip(params):
	return equip_func.exec(params)

func unequip(params):
	return unequip_func.exec(params)

func isEquipCondition(params):
	return equip_condition.exec(params)

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

