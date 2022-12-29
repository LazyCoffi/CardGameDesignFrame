extends "res://class/functionalSystem/FunctionalSet.gd"
class_name BaseConditionSet

func _init():
	func_form = {}
	__initFuncForm()

func orGate(first, second):
	return __or(first, second)

func andGate(first, second):
	return __and(first, second)

func notGate(first):
	return __not(first)

func xorGate(first, second):
	return __xor(first, second)

func orGateComb(params):
	var ret = false
	for param in params:
		ret = __or(ret, param)
	
	return ret

func andGateComb(params):
	var ret = true
	for param in params:
		ret = __and(ret, param)
	
	return ret

func xorGateComb(params):
	var ret = params[0]
	for index in range(1, params.size()):
		ret = __xor(ret, params[index])
	
	return ret

func trueGate():
	return true

func falseGate():
	return false

func packArray(params):
	return params

func __or(first, second):
	return first or second

func __and(first, second):
	return first and second

func __not(first):
	return not first

func __xor(first, second):
	return (first or second) and (not (first and second))

func __initFuncForm():
	addFuncForm("orGate", false, "bool", ["bool", "bool"])
	addFuncForm("andGate", false, "bool", ["bool", "bool"])
	addFuncForm("notGate", false, "bool", ["bool"])
	addFuncForm("xorGate", false, "bool", ["bool", "bool"])
	addFuncForm("orGateComb", true, "bool", ["bool"])
	addFuncForm("andGateComb", true, "bool", ["bool"])
	addFuncForm("xorGateComb", true, "bool", ["bool"])
	addFuncForm("packArray", true, "bool", ["bool_Array"])
	addFuncForm("trueGate", false, "bool", [])
	addFuncForm("falseGate", false, "bool", [])
