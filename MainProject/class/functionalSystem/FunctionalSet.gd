extends Node
class_name FunctionalSet

var func_form

func addFuncForm(func_name, variable, ret_form, params_form):
	var cur_form = {}
	cur_form["params"] = params_form
	cur_form["ret"] = ret_form
	cur_form["variable"] = variable

	func_form[func_name] = cur_form

func getParamsType(func_name):
	if not hasFunc(func_name):
		Exception.assert(false, "Wrong functional_name")

	return func_form[func_name]["params"]

func getRetType(func_name):
	Exception.assert(hasFunc(func_name), "Wrong functional_name")

	return func_form[func_name]["ret"]

func isVariable(func_name):
	return func_form[func_name]["variable"]
	
func hasFunc(func_name):
	return func_form.has(func_name)
