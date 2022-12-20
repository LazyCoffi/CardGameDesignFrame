extends Node
class_name LocalFunction


var FunctionalInterface = load("res://class/FunctionalInterface.gd")
var ScriptTree = load("res://class/ScriptTree.gd")

var interfaces = []
var condition_interface

func isExecuable(condition_params_):
	var condition_params = condition_params_.duplicate()
	var ret = condition_interface.exec(condition_params)
	Exception.assert(TypeUnit.isType(ret, "bool"))

	return ret

func exec(params_arr_, condition_params_):
	Exception.assert(isExecuable(condition_params_))
	Exception.assert(params_arr_.size() == interfaces.size())
	var params_arr = params_arr_.duplicate()
	
	var ret_arr = []

	var index = 0
	for params in params_arr:
		ret_arr.append(interfaces[index].exec(params))
		index += 1
	
	return ret_arr

func setInterfaces(interfaces_):
	interfaces = interfaces_

func setConditionInterface(condition_interface_):
	condition_interface = condition_interface_

func getInterfaces():
	return interfaces

func getConditionInterface():
	return condition_interface

func getRequirement():
	pass

func getConditionRequirement():
	pass


func pack():
	var script_tree = ScriptTree.new()

	# TODO

	return script_tree

func loadScript(script_tree):
	# TODO

