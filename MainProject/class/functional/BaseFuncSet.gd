extends "res://class/functional/FuncSet.gd"
class_name BaseFuncSet

func _init():
	func_form = {}
	__initFuncForm()

func returnVal(val):
	return val

func __initFuncForm():
	addFuncForm("returnVal", "all", ["all"])
