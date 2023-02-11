extends "res://class/functional/FuncSet.gd"
class_name MathConditionSet

func _init():
	__initFuncForm()

func isLessInt(first, second):
	return first < second

func isLessEqualInt(first, second):
	return first <= second

func isLessFloat(first, second):
	return first < second

func isLessEqualFloat(first, second):
	return first <= second

func isGreaterInt(first, second):
	return first > second

func isGreaterEqualInt(first, second):
	return first >= second

func isGreaterFloat(first, second):
	return first > second

func isGreaterEqualFloat(first, second):
	return first >= second

func __initFuncForm():
	func_form = {}
	addFuncForm("isLessInt", "bool", ["int", "int"])
	addFuncForm("isLessEqualInt", "bool", ["int", "int"])
	addFuncForm("isLessFloat", "bool", ["float", "float"])
	addFuncForm("isLessFloat", "bool", ["float", "float"])
	addFuncForm("isGreaterInt", "bool", ["int", "int"])
	addFuncForm("isGreaterEqualInt", "bool", ["int", "int"])
	addFuncForm("isGreaterFloat", "bool", ["float", "float"])
	addFuncForm("isGreaterFloat", "bool", ["float", "float"])

