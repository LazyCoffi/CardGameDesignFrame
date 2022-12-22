extends "res://class/FunctionalSet.gd"
class_name BaseFunctionSet

func _init():
	func_form = {}
	__initFuncForm()

func packArray(params):
	return params

func staticVal(val):
	return val

func __initFuncForm():
	addFuncForm("packArray", true, "all_Array", "all")
	addFuncForm("staticVal", false, "all", "all")
