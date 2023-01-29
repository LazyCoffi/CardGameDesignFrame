extends "res://class/functionalSystem/FunctionalSet.gd"
class_name BaseFunctionSet

func _init():
	func_form = {}
	__initFuncForm()

func packArray(params):
	return params

func staticVal(val):
	return val

func __initFuncForm():
	addFuncForm("packArray", "all_Array", ["all"])
	addFuncForm("staticVal", "all", ["all"])
