extends "res://class/functional/FuncSet.gd"
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
	addFuncForm("orGate", "bool", ["bool", "bool"])
	addFuncForm("andGate", "bool", ["bool", "bool"])
	addFuncForm("notGate", "bool", ["bool"])
	addFuncForm("xorGate", "bool", ["bool", "bool"])
	addFuncForm("orGateComb", "bool", ["bool"])
	addFuncForm("andGateComb", "bool", ["bool"])
	addFuncForm("xorGateComb", "bool", ["bool"])
	addFuncForm("packArray", "bool", ["bool_Array"])
	addFuncForm("trueGate", "bool", [])
	addFuncForm("falseGate", "bool", [])
