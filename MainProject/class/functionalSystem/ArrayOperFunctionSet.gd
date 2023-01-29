extends "res://class/functionalSystem/FunctionalSet.gd"
class_name ArrayOperFunctionSet

func _init():
	__initFuncForm()

func parallelOper(array, functional):
	for index in range(array.size()):
		array[index] = functional.exec(array[index])
	
	return array

func parallelOperArray(first, second, functional):
	Exception.assert(first.size() == second.size(), "Array has different size!")
	var ret = []
	for index in range(first.size()):
		ret.append(functional.exec(first[index], second[index]))
	
	return ret

func parallelOperArrayOverride(first, second, functional):
	Exception.assert(first.size() == second.size(), "Arrays has different size!")
	for index in range(first.size()):
		first[index] = functional.exec(first[index], second[index])
	
	return first

func linearOper(first, functional):
	if first.empty():
		return first

	var ret = first.front()
	for index in range(1, first.size()):
		ret = functional.exec(ret, first[index])
	
	return ret

func packArray(first):
	return [first]

func appendArray(first, second):
	return first.append_array(second)

func appendVal(first, second):
	return first.append(second)

func shrankArray(first, second):
	if second >= first.size():
		return first
	return first.resize(second)

func shrankArrayTo(first, second):
	if second.size() >= first.size():
		return first
	return first.resize(second.size())

func arraySize(first):
	return first.size()

func isArrayEmpty(first):
	return first.empty()

func arrayDeepCopy(first):
	var ret = []
	for node in first:
		ret.append(node.copy())

	return ret

func __initFuncForm():
	addFuncForm("parallelOper", "Array", ["Array", "Function"])
	addFuncForm("parallelOperArray", "Array", ["Array", "Array", "Function"])
	addFuncForm("parallelOperArrayOverride", "Array", ["Array", "Array", "Function"])
	addFuncForm("linearOper", "all", ["Array", "Function"])
	addFuncForm("packArray", "Array", ["all"])
	addFuncForm("appendArray", "Array", ["Array", "Array"])
	addFuncForm("appendVal", "Array", ["Array", "all"])
	addFuncForm("shrankArray", "Array", ["Array", "int"])
	addFuncForm("shrankArrayTo", "Array", ["Array", "Array"])
	addFuncForm("arraySize", "int", ["Array"])
	addFuncForm("isArrayEmpty", "bool", ["Array"])
	addFuncForm("arrayDeepCopy", "all", ["Array"])
