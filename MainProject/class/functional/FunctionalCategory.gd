extends Node

var array_oper_function_set = TypeUnit.type("ArrayOperFunctionSet").new()
var attr_function_set = TypeUnit.type("AttrFunctionSet").new()
var base_function_set = TypeUnit.type("BaseFunctionSet").new()
var battle_function_set = TypeUnit.type("BattleFunctionSet").new()
var card_oper_function_set = TypeUnit.type("CardOperFunctionSet").new()
var math_function_set = TypeUnit.type("MathFunctionSet").new()
var scene_oper_function_set = TypeUnit.type("SceneOperFunctionSet").new()

var attr_condition_set = TypeUnit.type("AttrConditionSet").new()
var base_condition_set = TypeUnit.type("BaseConditionSet").new()

var category_tree = TypeUnit.type("CategoryTree").new()
var table 

func _init():
	__initFunctionalType()

func getIndexList(func_set_name):
	return category_tree.getIndexList(func_set_name)

func getFunctionalSet(func_set_name):
	return table[func_set_name]

func getRetType(func_set_name, func_name):
	var functional_set = getFunctionalSet(func_set_name)
	return functional_set.getRetType(func_name)

func getParamsType(func_set_name, func_name):
	var functional_set = getFunctionalSet(func_set_name)
	return functional_set.getParamsType(func_name)

func exec(f_name, func_set_name, params):
	var functional_set = getFunctionalSet(func_set_name)
	return functional_set.callv(f_name, params)

func __initFunctionalType():
	table = {}
	__addFunctionalSet(["FunctionSet"], "ArrayOperFunctionSet", array_oper_function_set)
	__addFunctionalSet(["FunctionSet"], "AttrFunctionSet", attr_function_set)
	__addFunctionalSet(["FunctionSet"], "BaseFunctionSet", base_function_set)
	__addFunctionalSet(["FunctionSet"], "BattleFunctionSet", battle_function_set)
	__addFunctionalSet(["FunctionSet"], "CardOperFunctionSet", card_oper_function_set)
	__addFunctionalSet(["FunctionSet"], "MathFunctionSet", math_function_set)
	__addFunctionalSet(["FunctionSet"], "SceneOperFunctionSet", scene_oper_function_set)

	__addFunctionalSet(["ConditionSet"], "AttrConditionSet", attr_function_set)
	__addFunctionalSet(["ConditionSet"], "BaseConditionSet", base_condition_set)

func __addFunctionalSet(index_list, func_set_name, functional):
	table[func_set_name] = functional
	category_tree.addEntry(index_list, func_set_name)
