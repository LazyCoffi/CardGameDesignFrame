extends "res://class/functional/FunctionalSet.gd"
class_name BaseFunctionSet

func _init():
	func_form = {}
	__initFuncForm()

func returnVal(val):
	return val

func __initFuncForm():
	addFuncForm("returnVal", "all", ["all"])
