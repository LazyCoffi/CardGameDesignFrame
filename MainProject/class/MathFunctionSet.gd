extends "res://class/FunctionaSet.gd"
class_name MathFunctionSet

func _init():
	func_form = {}
	__initFuncForm()

func randInt(l, r):
	return MathUnit.randInt(l, r)

func randFloat(l, r):
	return MathUnit.randFloat(l, r)

func __initFuncForm():
	pass
