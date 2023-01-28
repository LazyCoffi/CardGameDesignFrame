extends "res://class/functionalSystem/FunctionalSet.gd"
class_name MathFunctionSet

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

func powInt(first, second, p := null):
	return __quickPow(first, second, p)

func powFloat(first, second):
	return pow(first, second)

func __quickPow(first, second, p := null):
	var ret = 1

	while second > 0:
		if second & 1 == 0:
			ret = ret * first
			if p != null:
				ret = ret % p

		first = first * first
		if p != null:
			first = first % p
		
		second = second >> 1
	
	return ret

func __initFuncForm():
	addFuncForm("constVal", false, "all", ["all"])
	addFuncForm("randInt", false, "int", ["int", "int"])
	addFuncForm("randFloat", false, "float", ["float", "float"])
	addFuncForm("plusInt", false, "int", ["int", "int"])
	addFuncForm("plusFloat", false, "float", ["float", "float"])
	addFuncForm("mulInt", false, "int", ["int", "int"])
	addFuncForm("mulFloat", false, "float", ["float", "float"])
	addFuncForm("minusInt", false, "int", ["int", "int"])
	addFuncForm("minusFloat", false, "float", ["float", "float"])
	addFuncForm("divInt", false, "int", ["int", "int"])
	addFuncForm("divFloat", false, "float", ["float", "float"])
	addFuncForm("powInt", false, "int", ["int", "int"])
	addFuncForm("powFloat", false, "float", ["float", "float"])
