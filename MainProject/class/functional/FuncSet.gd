extends Node
class_name FuncSet

var func_form

func _init():
	func_form = {}

func addFuncForm(func_name, ret_form, params_form):
	var cur_form = {}
	cur_form["params"] = params_form
	cur_form["ret"] = ret_form

	func_form[func_name] = cur_form

func getParamsType(func_name):
	if not hasFunc(func_name):
		Logger.assert(false, "Wrong functional_name")

	return func_form[func_name]["params"]

func getRetType(func_name):
	Logger.assert(hasFunc(func_name), "Wrong functional_name")

	return func_form[func_name]["ret"]

func hasFunc(func_name):
	return func_form.has(func_name)
