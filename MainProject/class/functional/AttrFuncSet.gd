extends "res://class/functional/FuncSet.gd"
class_name AttrFuncSet

func _init():
	__initFuncForm()

func setConst(attr, attr_name, val):
	attr.setAttr(attr_name, val)
	
	return attr

func getAttrInt(attr, attr_name):
	return attr.getAttr(attr_name)

func getAttrFloat(attr, attr_name):
	return attr.getAttr(attr_name)

func getAttrStr(attr, attr_name):
	return attr.getAttr(attr_name)

func plusConstInt(attr, attr_name, val):
	return __plusConst(attr, attr_name, val)

func plusConstFloat(attr, attr_name, val):
	return __plusConst(attr, attr_name, val)

func mulConstInt(attr, attr_name, val):
	return __mulConst(attr, attr_name, val)

func mulConstFloat(attr, attr_name, val):
	return __mulConst(attr, attr_name, val)

func settUpperBoundConstInt(attr, attr_name, val):
	return __setUpperBoundConst(attr, attr_name, val)

func setUpperBoundConstFloat(attr, attr_name, val):
	return __setUpperBoundConst(attr, attr_name, val)

func setLowerBoundConstInt(attr, attr_name, val):
	return __setLowerBoundConst(attr, attr_name, val)

func setLowerBoundConstFloat(attr, attr_name, val):
	return __setLowerBoundConst(attr, attr_name, val)

func __plusConst(attr, attr_name, val):
	var upper = attr.upper(attr_name)
	var lower = attr.lower(attr_name)

	attr.setAttr(attr_name, max(lower, min(upper, attr + val)))

	return attr

func __mulConst(attr, attr_name, val):
	var upper = attr.upper(attr_name)
	var lower = attr.lower(attr_name)

	attr.setAttr(attr_name, max(lower, min(upper, attr * val)))
	
	return attr

func __setUpperBoundConst(attr, attr_name, val):
	var lower = val
	if attr.hasLower(attr_name):
		lower = attr.lower(val, attr_name)
	
	attr.setUpper(max(lower, val), attr_name)
	
	return attr

func __setLowerBoundConst(attr, attr_name, val):
	var upper = val
	if attr.hasUpper(attr_name):
		upper = attr.upper(attr_name)
	
	attr.setLower(min(upper, val), attr_name)
	
	return attr

func setAttrZeroInt(attr, attr_name):
	attr.setAttr(attr_name, 0)

	return attr

func setAttrZeroFloat(attr, attr_name):
	attr.setAttr(attr_name, 0.0)

	return attr

func plusAttrInt(first, first_name, second, second_name, third, third_name):
	third.setAttr(third_name, int(first.getAttr(first_name) + second.getAttr(second_name)))

	return third

func plusAttrFloat(first, first_name, second, second_name, third, third_name):
	third.setAttr(third_name, float(first.getAttr(first_name) + second.getAttr(second_name)))

	return third

func mulAttrInt(first, first_name, second, second_name, third, third_name):
	third.setAttr(third_name, int(first.getAttr(first_name) * second.getAttr(second_name)))

	return third

func mulAttrFloat(first, first_name, second, second_name, third, third_name):
	third.setAttr(third_name, float(first.getAttr(first_name) * second.getAttr(second_name)))

	return third

func minusAttrInt(first, first_name, second, second_name, third, third_name):
	third.setAttr(third_name, int(first.getAttr(first_name) - second.getAttr(second_name)))

	return third

func minusAttrFloat(first, first_name, second, second_name, third, third_name):
	third.setAttr(third_name, float(first.getAttr(first_name) - second.getAttr(second_name)))

	return third

func divAttrInt(first, first_name, second, second_name, third, third_name):
	third.setAttr(third_name, int(first.getAttr(first_name) / second.getAttr(second_name)))

	return third

func divAttrFloat(first, first_name, second, second_name, third, third_name):
	third.setAttr(third_name, float(first.getAttr(first_name) / second.getAttr(second_name)))

	return third

func plusAttrIntOverride(first, first_name, second, second_name):
	first.setAttr(first_name, int(first.getAttr(first_name) + second.getAttr(second_name)))

	return first

func plusAttrFloatOverride(first, first_name, second, second_name):
	first.setAttr(first_name, float(first.getAttr(first_name) + second.getAttr(second_name)))

	return first

func mulAttrIntOverride(first, first_name, second, second_name):
	first.setAttr(first_name, int(first.getAttr(first_name) * second.getAttr(second_name)))

	return first

func mulAttrFloatOverride(first, first_name, second, second_name):
	first.setAttr(first_name, float(first.getAttr(first_name) * second.getAttr(second_name)))

	return first

func minusAttrIntOverride(first, first_name, second, second_name):
	first.setAttr(first_name, int(first.getAttr(first_name) - second.getAttr(second_name)))

	return first

func minusAttrFloatOverride(first, first_name, second, second_name):
	first.setAttr(first_name, float(first.getAttr(first_name) - second.getAttr(second_name)))

	return first

func divAttrIntOverride(first, first_name, second, second_name):
	first.setAttr(first_name, int(first.getAttr(first_name) / second.getAttr(second_name)))

	return first

func divAttrFloatOverride(first, first_name, second, second_name):
	first.setAttr(first_name, float(first.getAttr(first_name) / second.getAttr(second_name)))

	return first

func minusAttrWithAttrBeforeInt(first, first_name, second, second_name, third, third_name):
	var val = third.getAttr(third_name)
	var first_val = first.getAttr(first_name)
	var second_val = second.getAttr(second_name)
	if second_val >= val:
		second.setAttr(second_name, second_val - val)
	else:
		second.setAttr(second_name, 0)
		first.setAttr(first_name, first_val - (val - second_val))
		
	return first

func __initFuncForm():
	func_form = {}
	addFuncForm("getAttrInt", "int", ["Attr", "String"])
	addFuncForm("getAttrFloat", "float", ["Attr", "String"])
	addFuncForm("getAttrStr", "String", ["Attr", "String"])
	addFuncForm("setConst", "Attr", ["Attr", "String", "all"])
	addFuncForm("plusIntConst", "Attr", ["Attr", "String", "int"])
	addFuncForm("plusFloatConst", "Attr", ["Attr", "String", "float"])
	addFuncForm("mulConstInt", "Attr", ["Attr", "String", "float"])
	addFuncForm("setUpperBoundConstInt", "Attr", ["Attr", "String", "int"])
	addFuncForm("setUpperBoundConstFloat", "Attr", ["Attr", "String", "float"])
	addFuncForm("setLowerBoundConstInt", "Attr", ["Attr", "String", "int"])
	addFuncForm("setLowerBoundConstFloat", "Attr", ["Attr", "String", "float"])
	addFuncForm("plusAttrInt", "Attr", ["Attr", "String", "Attr", "String", "Attr", "String"])
	addFuncForm("plusAttrFloat", "Attr", ["Attr", "String", "Attr", "String", "Attr", "String"])
	addFuncForm("mulAttrInt", "Attr", ["Attr", "String", "Attr", "String", "Attr", "String"])
	addFuncForm("mulAttrFloat", "Attr", ["Attr", "String", "Attr", "String", "Attr", "String"])
	addFuncForm("minusAttrInt", "Attr", ["Attr", "String", "Attr", "String", "Attr", "String"])
	addFuncForm("minusAttrFloat", "Attr", ["Attr", "String", "Attr", "String", "Attr", "String"])
	addFuncForm("divAttrInt", "Attr", ["Attr", "String", "Attr", "String", "Attr", "String"])
	addFuncForm("divAttrFloat", "Attr", ["Attr", "String", "Attr", "String", "Attr", "String"])
	addFuncForm("plusAttrIntOverride", "Attr", ["Attr", "String", "Attr", "String"])
	addFuncForm("plusAttrFloatOverride", "Attr", ["Attr", "String", "Attr", "String"])
	addFuncForm("mulAttrIntOverride", "Attr", ["Attr", "String", "Attr", "String"])
	addFuncForm("mulAttrFloatOverride", "Attr", ["Attr", "String", "Attr", "String"])
	addFuncForm("minusAttrIntOverride", "Attr", ["Attr", "String", "Attr", "String"])
	addFuncForm("minusAttrFloatOverride", "Attr", ["Attr", "String", "Attr", "String"])
	addFuncForm("divAttrIntOverride", "Attr", ["Attr", "String", "Attr", "String"])
	addFuncForm("divAttrFloatOverride", "Attr", ["Attr", "String", "Attr", "String"])
	addFuncForm("setAttrZeroInt", "Attr", ["Attr", "String"])
	addFuncForm("setAttrZeroFloat", "Attr", ["Attr", "String"])
	addFuncForm("minusAttrWithAttrBeforeInt", "Attr", ["Attr", "String", "Attr", "String", "Attr", "String"])
