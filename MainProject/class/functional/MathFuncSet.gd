extends "res://class/functional/FuncSet.gd"
class_name MathFuncSet

func _init():
	func_form = {}
	__initFuncForm()

func constVal(first):
	return first

func randInt(first, second):
	return MathUnit.randInt(first, second)

func randFloat(first, second):
	return MathUnit.randFloat(first, second)

func plusInt(first, second):
	return int(first + second)

func plusFloat(first, second):
	return float(first + second)

func mulInt(first, second):
	return int(first * second)

func mulFloat(first, second):
	return float(first * second)

func minusInt(first, second):
	return int(first - second)

func minusFloat(first, second):
	return float(first - second)

func divInt(first, second):
	return int(first / second)

func divFloat(first, second):
	return float(first / second)

func powInt(first, second):
	return __quickPow(first, second)

func powFloat(first, second):
	return pow(first, second)

func lowerBoundInt(first, second):
	return int(max(first, second))

func upperBoundInt(first, second):
	return int(min(first, second))

func lowerBoundFloat(first, second):
	return float(max(first, second))

func upperBoundFloat(first, second):
	return float(min(first, second))

func __quickPow(first, second):
	var ret = 1

	while second > 0:
		if second & 1 == 0:
			ret = ret * first

		first = first * first
		
		second = second >> 1
	
	return ret

func __initFuncForm():
	addFuncForm("constVal", "all", ["all"])
	addFuncForm("randInt", "int", ["int", "int"])
	addFuncForm("randFloat", "float", ["float", "float"])
	addFuncForm("plusInt", "int", ["int", "int"])
	addFuncForm("plusFloat", "float", ["float", "float"])
	addFuncForm("mulInt", "int", ["int", "int"])
	addFuncForm("mulFloat", "float", ["float", "float"])
	addFuncForm("minusInt", "int", ["int", "int"])
	addFuncForm("minusFloat", "float", ["float", "float"])
	addFuncForm("divInt", "int", ["int", "int"])
	addFuncForm("divFloat", "float", ["float", "float"])
	addFuncForm("powInt", "int", ["int", "int"])
	addFuncForm("powFloat", "float", ["float", "float"])
	addFuncForm("lowerBoundInt", "int", ["int", "int"])
	addFuncForm("upperBoundInt", "int", ["int", "int"])
	addFuncForm("lowerBoundFloat", "float", ["float", "float"])
	addFuncForm("upperBoundFloat", "float", ["float", "float"])
