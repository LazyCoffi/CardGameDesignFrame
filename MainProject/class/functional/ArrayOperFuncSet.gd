extends "res://class/functional/FuncSet.gd"
class_name ArrayOperFuncSet

var Heap = TypeUnit.type("Heap")

func _init():
	__initFuncForm()

func parallelOper(array, func_unit):
	for index in range(array.size()):
		array[index] = func_unit.exec(array[index])
	
	return array

func parallelMultiOper(array, func_unit_list):
	for index in range(array.size()):
		var result = array[index]
		for func_unit in func_unit_list:
			result = func_unit.exec(result)
		array[index] = result
	
	return array

func parallelOperArray(first, second, func_unit):
	Logger.assert(first.size() == second.size(), "Array has different size!")
	var ret = []
	for index in range(first.size()):
		ret.append(func_unit.exec(first[index], second[index]))
	
	return ret

func parallelOperArrayOverride(first, second, func_unit):
	Logger.assert(first.size() == second.size(), "Arrays has different size!")
	for index in range(first.size()):
		first[index] = func_unit.exec(first[index], second[index])
	
	return first

func linearOper(first, func_unit):
	if first.empty():
		return first

	var ret = first.front()
	for index in range(1, first.size()):
		ret = func_unit.exec(ret, first[index])
	
	return ret

func packArray(first):
	return [first]

func appendArray(first, second):
	first.append_array(second)

	return first

func appendVal(first, second):
	first.append(second)

	return first

func shrankArray(first, second):
	if second >= first.size():
		return first
	first.resize(second)

	return first

func shrankArrayTo(first, second):
	if second.size() >= first.size():
		return first
	first.resize(second.size())

	return first

func arraySize(first):
	return first.size()

func isArrayEmpty(first):
	return first.empty()

func arrayDeepCopy(first):
	var ret = []
	for node in first:
		ret.append(node.copy())

	return ret

func shuffle(first):
	return first.sort()

func shuffleOper(first, func_unit):
	var heap = Heap.new()

	for node in first:
		var order = func_unit.exec(node)
		heap.append(node, order)
	
	return heap.getSorted()

func shuffleMultiOper(first, func_unit_list):
	var heap = Heap.new()

	for node in first:
		var order = node
		for func_unit in func_unit_list:
			order = func_unit.exec(order)

		heap.append(node, order)
	
	return heap.getSorted()

func randomShuffle(first):
	for index in range(first.size()):
		var next_index = MathUnit.randInt(index, first.size() - 1)
		__swap(first, index, next_index)
	
	return first

func getAt(first, second):
	Logger.assert(second > 0 and second < first.size(), "Index is out of range!")
	return first[second]

func getFront(first):
	return first.front()

func getBack(first):
	return first.back()

func slice(first, second, third):
	Logger.assert(second > 0 and second < first.size(), "Index is out of range!")
	Logger.assert(third > 0 and third < first.size(), "Index is out of range!")

	var ret = []
	for index in range(second, third):
		ret.append(first[index])	
	
	return ret

func sliceFront(first, second):
	Logger.assert(second > 0 and second < first.size(), "Index is out of range!")

	var ret = []
	for index in range(second):
		ret.append(first[index])

	return ret

func sliceBack(first, second):
	Logger.assert(second > 0 and second < first.size(), "Index is out of range!")

	var ret = []
	for index in range(second, first.size()):
		ret.append(first[index])

	return ret

func __swap(array, first, second):
	Logger.assert(first < array.size() and second < array.size(),
				  "Swap index is out of range!")
	var temp = array[first]
	array[first] = array[second]
	array[second] = temp

func __initFuncForm():
	addFuncForm("parallelOper", "Array", ["Array", "FuncUnit"])
	addFuncForm("parallelOperArray", "Array", ["Array", "Array", "FuncUnit"])
	addFuncForm("parallelOperArrayOverride", "Array", ["Array", "Array", "FuncUnit"])
	addFuncForm("shuffle", "Array", ["Array"])
	addFuncForm("shuffleOper", "Array", ["Array", "FuncUnit"])
	addFuncForm("shuffleMultiOper", "Array", ["Array", "Array"])
	addFuncForm("randomShuffle", "Array", ["Array"])
	addFuncForm("linearOper", "all", ["Array", "FuncUnit"])
	addFuncForm("packArray", "Array", ["all"])
	addFuncForm("appendArray", "Array", ["Array", "Array"])
	addFuncForm("appendVal", "Array", ["Array", "all"])
	addFuncForm("shrankArray", "Array", ["Array", "int"])
	addFuncForm("shrankArrayTo", "Array", ["Array", "Array"])
	addFuncForm("arraySize", "int", ["Array"])
	addFuncForm("isArrayEmpty", "bool", ["Array"])
	addFuncForm("arrayDeepCopy", "all", ["Array"])
	addFuncForm("getAt", "all", ["Array", "int"])
	addFuncForm("getFront", "all", ["Array"])
	addFuncForm("getBack", "all", ["Array"])
	addFuncForm("slice", "Array", ["Array", "int", "int"])
	addFuncForm("sliceFront", "Array", ["Array", "int"])
	addFuncForm("sliceBack", "Array", ["Array", "int"])
