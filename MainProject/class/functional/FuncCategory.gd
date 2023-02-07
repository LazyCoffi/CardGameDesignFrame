extends Node

var array_oper_func_set = TypeUnit.type("ArrayOperFuncSet").new()
var attr_func_set = TypeUnit.type("AttrFuncSet").new()
var base_func_set = TypeUnit.type("BaseFuncSet").new()
var battle_func_set = TypeUnit.type("BattleFuncSet").new()
var card_func_set = TypeUnit.type("CardFuncSet").new()
var math_func_set = TypeUnit.type("MathFuncSet").new()
var scene_oper_func_set = TypeUnit.type("SceneOperFuncSet").new()

var attr_condition_set = TypeUnit.type("AttrConditionSet").new()
var base_condition_set = TypeUnit.type("BaseConditionSet").new()

var category_tree = TypeUnit.type("CategoryTree").new()
var table 

func _init():
	__initFuncType()

func getIndexList(func_set_name):
	return category_tree.getIndexList(func_set_name)

func getFuncSet(func_set_name):
	return table[func_set_name]

func getRetType(func_set_name, func_name):
	var func_set = getFuncSet(func_set_name)
	return func_set.getRetType(func_name)

func getParamsType(func_set_name, func_name):
	var func_set = getFuncSet(func_set_name)
	return func_set.getParamsType(func_name)

func exec(f_name, func_set_name, params):
	var funcal_set = getFuncSet(func_set_name)
	return funcal_set.callv(f_name, params)

func __initFuncType():
	table = {}
	__addFuncSet(["Func"], "ArrayOperFuncSet", array_oper_func_set)
	__addFuncSet(["Func"], "AttrFuncSet", attr_func_set)
	__addFuncSet(["Func"], "BaseFuncSet", base_func_set)
	__addFuncSet(["Func"], "BattleFuncSet", battle_func_set)
	__addFuncSet(["Func"], "CardFuncSet", card_func_set)
	__addFuncSet(["Func"], "MathFuncSet", math_func_set)
	__addFuncSet(["Func"], "SceneOperFuncSet", scene_oper_func_set)

	__addFuncSet(["Condition"], "AttrConditionSet", attr_func_set)
	__addFuncSet(["Condition"], "BaseConditionSet", base_condition_set)

func __addFuncSet(index_list, func_set_name, funcal):
	table[func_set_name] = funcal
	category_tree.addEntry(index_list, func_set_name)
