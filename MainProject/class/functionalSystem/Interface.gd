extends Node
class_name Interface

var ScriptTree = load("res://class/entity/ScriptTree.gd")

var request_table

func _init():
	request_table = {}

func registerInterface(interface_name, request_params):
	request_table[interface_name] = request_params

func verify(interface_name, target):
	Exception.assert(request_table.has(interface_name))
	var request_params = request_table[interface_name]
	var params = target.getParamsType()

	if request_params.size() != params.size():
		return false
	
	for index in request_params.size():
		if request_params[index] != params[index]:
			return false

	return true
