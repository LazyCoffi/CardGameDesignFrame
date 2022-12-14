extends Node

var attr_functional_set = load("res://class/AttrFunctionalSet.gd").new()

var func_tree = {}

func _init():
	initFunctionalType()

func initFunctionalType():
	func_tree["FunctionalSet"] = {}
	func_tree["FunctionalSet"]["AttrFunctionalSet"] = attr_functional_set

func getFunctionalSet(category):
	var arr = category.getCategory()
	var cur_node = func_tree
	for key in arr:
		cur_node = cur_node[key]
	
	return cur_node

func getRetType(category, func_name):
	var functional_set = getFunctionalSet(category)
	return functional_set.getRetType(func_name)

func getParamsType(category, func_name):
	var functional_set = getFunctionalSet(category)
	return functional_set.getParamsType(func_name)

func exec(f_name, category, params):
	var functional_set = getFunctionalSet(category)
	return functional.callv(f_name, params)

