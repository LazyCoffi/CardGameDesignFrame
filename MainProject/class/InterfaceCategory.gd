extends Node

var interface_tree

var card_interface_set = load("res://class/CardInterfaceSet.gd").new()

func _init():
	interface_tree = {}
	initInterfaceType()

func initInterfaceType():
	interface_tree["InterfaceSet"] = {}
	interface_tree["InterfaceSet"]["CardInterfaceSet"] = card_interface_set

func getInterfaceSet(category):
	var arr = category.getCategory()
	var cur_node = interface_tree
	for key in arr:
		cur_node = cur_node[key]
	
	return cur_node

func getRetType(category, interface_name):
	var interface_set = getInterfaceSet(category)
	return interface_set.getRetType(interface_name)
	
func getParamsType(category, interface_name):
	var interface_set = getInterfaceSet(category)
	return interface_set.getParamsType(interface_name)

func exec(i_name, category, params):
	var interface_set = getInterfaceSet(category)
	return interface_set.callv(i_name, params)
