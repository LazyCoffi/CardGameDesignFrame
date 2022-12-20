extends Node
class_name Function

var ScriptTree = load("res://class/ScriptTree.gd")

var func_name
var category
var static_params

func _init():
	static_params = []

func exec(params):
	var index = 0
	for static_param in static_params:
		if static_param != null:
			params[index] = static_param
		index += 1
	
	var params_form = getParamsType()
	Exception.assert(TypeUnit.verifyParamsAdaptable(params, params_form))

	return FunctionalCategory.exec(func_name, category, params)

func setFuncName(func_name_):
	Exception.assert(TypeUnit.isType(func_name_, "String"))
	func_name = func_name_

func setCategory(category_):
	Exception.assert(TypeUnit.isType(category_, "Category"))
	category = category_

func setStaticParams(params):
	Exception.assert(params.size() == getParamsNum())
	static_params = params

func getRetType():
	return FunctionalCategory.getRetType(func_name)

func getRetNum():
	return getRetType().size()

func getParamsType():
	return FunctionalCategory.getParamsType(func_name)

func getParamsNum():
	return getParamsType().size()

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("func_name", func_name)
	script_tree.addObject("category", category)

	return script_tree

func loadScript(script_tree):
	func_name = script_tree.getAttr("func_name")
	category = script_tree.getObject("category")
