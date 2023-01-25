extends Node
class_name Function

var ScriptTree = load("res://class/entity/ScriptTree.gd")
var Category = load("res://class/entity/Category.gd")

var func_name			# String
var category			# Category
var static_params		# Array

func _init():
	static_params = []

## TODO: 包装参数数组
func exec(params):
	if isVariable():
		return __variableExec(params)
	else:
		return __exec(params)
	
func setFuncName(func_name_):
	Exception.assert(TypeUnit.isType(func_name_, "String"))
	func_name = func_name_

func setCategory(category_):
	Exception.assert(TypeUnit.isType(category_, "Category"))
	category = category_

func setStaticParams(params):
	Exception.assert(params.size() == getParamsNum())
	static_params = params

func hasStaticParam(index):
	return static_params[index] != null

func isVariable():
	return FunctionalCategory.isVariable(category, func_name)

func getRetType():
	return FunctionalCategory.getRetType(category, func_name)

func getRetNum():
	return getRetType().size()

func getParamsType():
	return FunctionalCategory.getParamsType(category, func_name)

func getParamsNum():
	return getParamsType().size()

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("func_name", func_name)
	script_tree.addObject("category", category)

	return script_tree

func loadScript(script_tree):
	func_name = script_tree.getStr("func_name")
	category = script_tree.getObject("category", Category)

func __exec(params):
	var index = 0
	for static_param in static_params:
		if static_param != null:
			params[index] = static_param
		index += 1
	
	var params_form = getParamsType()

	Exception.assert(TypeUnit.verifyParamsAdaptable(params, params_form))

	return FunctionalCategory.exec(func_name, category, params)

func __variableExec(params):
	var param_type = getParamsType()[0]
	for param in params:
		Exception.assert(TypeUnit.isType(param, param_type))
	
	return FunctionalCategory.exec(func_name, category, [params])

