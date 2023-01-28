extends Node

var attr_function_set = load("res://class/functionalSystem/AttrFunctionSet.gd").new()
var math_function_set = load("res://class/functionalSystem/MathFunctionSet.gd").new()

var func_tree

func _init():
	func_tree = {}
	__initFunctionalType()

func getFunctionalSet(category):
	var arr = category.getCategory()
	var cur_node = func_tree.duplicate()
	for key in arr:
		cur_node = cur_node[key]
	
	return cur_node

func isVariable(category, func_name):
	var functional_set = getFunctionalSet(category)
	return functional_set.isVariable(func_name)

func getRetType(category, func_name):
	var functional_set = getFunctionalSet(category)
	return functional_set.getRetType(func_name)

func getParamsType(category, func_name):
	var functional_set = getFunctionalSet(category)
	return functional_set.getParamsType(func_name)

func exec(f_name, category, params):
	var functional_set = getFunctionalSet(category)
	return functional_set.callv(f_name, params)

func __initFunctionalType():
	func_tree["FunctionSet"] = {}
	__addFunctionalSet("FunctionSet", "AttrFunctionSet", attr_function_set)
	__addFunctionalSet("FunctionSet", "MathFunctionSet", math_function_set)

func __addFunctionalSet(type, func_name, functional):
	func_tree[type][func_name] = functional

