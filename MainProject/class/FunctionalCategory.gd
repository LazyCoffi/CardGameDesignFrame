extends Node

var attr_function_set = load("res://class/AttrFunctionSet.gd").new()

var func_tree

func _init():
	func_tree = {}
	initFunctionalType()

func initFunctionalType():
	func_tree["FunctionSet"] = {}
	func_tree["FunctionSet"]["AttrFunctionSet"] = attr_function_set

func getFunctionalSet(category):
	var arr = category.getCategory()
	var cur_node = func_tree
	for key in arr:
		cur_node = cur_node[key]
	
	return cur_node

func isVariable(category, func_name):
	var functional_set = getFunctionalSet(category)
	return functional_set.isVariable()

func getRetType(category, func_name):
	var functional_set = getFunctionalSet(category)
	return functional_set.getRetType(func_name)

func getParamsType(category, func_name):
	var functional_set = getFunctionalSet(category)
	return functional_set.getParamsType(func_name)

func exec(f_name, category, params):
	var functional_set = getFunctionalSet(category)
	return functional_set.callv(f_name, params)

