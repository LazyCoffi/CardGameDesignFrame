extends Node
class_name LocalFunction

var FunctionalInterface = load("res://class/functionalSystem/FunctionalInterface.gd")
var ScriptTree = load("res://class/entity/ScriptTree.gd")

var func_name
var interfaces
var condition_interface

func _init():
	interfaces = []

func isExecuable(condition_params_):
	var condition_params = condition_params_.duplicate()
	var ret = condition_interface.exec(condition_params)
	Exception.assert(TypeUnit.isType(ret, "bool"))

	return ret

func exec(params_arr_):
	Exception.assert(params_arr_.size() == interfaces.size())
	var params_arr = params_arr_.duplicate()
	
	var ret_arr = []

	var index = 0
	for params in params_arr:
		ret_arr.append(interfaces[index].exec(params))
		index += 1
	
	return ret_arr

func setFuncName(func_name_):
	Exception.assert(TypeUnit.isType(func_name_, "String"))
	func_name = func_name_

func setInterfaces(interfaces_):
	interfaces = interfaces_

func setConditionInterface(condition_interface_):
	condition_interface = condition_interface_

func getInterfaces():
	return interfaces

func getConditionInterface():
	return condition_interface

func getRequirement():
	var requirement = []
	for interface in interfaces:
		requirement.append(interface.getParamsType())
	
	return requirement

func getRetRequirement():
	var requirement = []
	for interface in interfaces:
		requirement.append(interface.getRetType())
	
	return requirement

func getConditionRequirement():
	return condition_interface.getParamsType()

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("func_name", func_name)
	script_tree.addObjectArray("interfaces", interfaces)
	script_tree.addObject("condition_interface", condition_interface)

	return script_tree

func loadScript(script_tree):
	func_name = script_tree.getAttr("func_name")
	interfaces = script_tree.getObjectArray("interfaces", FunctionalInterface)
	condition_interface = script_tree.getObject("condition_interface", FunctionalInterface)
