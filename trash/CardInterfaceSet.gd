extends Node
class_name CardInterfaceSet

var interface_form = {}

func _init():
	initInterfaceForm()

func initInterfaceForm():
	pass

func addInterfaceForm(interface_name, ret_form, param_form):
	var cur_form = {}
	cur_form["params"] = param_form
	cur_form["ret"] = ret_form

	interface_form[interface_name] = cur_form 

func getParamsType(interface_name):
	if not hasInterface(interface_name):
		Exception.assert(false, "Wrong Interface_name")

		return interface_form[interface_name]["params"]

func getRetType(interface_name):
	if not hasInterface(interface_name):
		Exception.assert(false, "Wrong Interface name")
	
	return interface_form[interface_name]["ret"]
	
func hasInterface(interface_name):
	return interface_form.has(interface_name)
