extends "res://class/functional/FuncSet.gd"
class_name AttrFuncSet

func _init():
	func_form = {}
	__initFuncForm()

func setConst(attr, attr_name, val):
	if TypeUnit.isType(val, "int") or TypeUnit.isType(val, "float"):
		var upper = attr.getRange(attr_name).upper()
		var lower = attr.getRange(attr_name).lower()
		attr.setAttr(attr_name, max(lower, min(upper, val)))
	else:
		attr.setAttr(val)
	
	return attr

func plusConstInt(attr, attr_name, val):
	Exception.assert(TypeUnit.isType(val, "int"))
	return __plusConst(attr, attr_name, val)

func plusConstFloat(attr, attr_name, val):
	Exception.assert(TypeUnit.isType(val, "float"))
	return __plusConst(attr, attr_name, val)

func mulConstInt(attr, attr_name, val):
	Exception.assert(TypeUnit.isType(val, "int"))
	return __mulConst(attr, attr_name, val)

func mulConstFloat(attr, attr_name, val):
	Exception.assert(TypeUnit.isType(val, "float"))
	return __mulConst(attr, attr_name, val)

func settUpperBoundConstInt(attr, attr_name, val):
	Exception.assert(TypeUnit.isType(val, "int"))
	return __setUpperBoundConst(attr, attr_name, val)

func setUpperBoundConstFloat(attr, attr_name, val):
	Exception.assert(TypeUnit.isType(val, "float"))
	return __setUpperBoundConst(attr, attr_name, val)

func setLowerBoundConstInt(attr, attr_name, val):
	Exception.assert(TypeUnit.isType(val, "int"))
	return __setLowerBoundConst(attr, attr_name, val)

func setLowerBoundConstFloat(attr, attr_name, val):
	Exception.assert(TypeUnit.isType(val, "float"))
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

func __initFuncForm():
	addFuncForm("setConst", "Attr", ["Attr", "String", "all"])
	addFuncForm("plusIntConst", "Attr", ["Attr", "String", "int"])
	addFuncForm("plusFloatConst", "Attr", ["Attr", "String", "float"])
	addFuncForm("mulConstInt", "Attr", ["Attr", "String", "float"])
	addFuncForm("setUpperBoundConstInt", "Attr", ["Attr", "String", "int"])
	addFuncForm("setUpperBoundConstFloat", "Attr", ["Attr", "String", "float"])
	addFuncForm("setLowerBoundConstInt", "Attr", ["Attr", "String", "int"])
	addFuncForm("setLowerBoundConstFloat", "Attr", ["Attr", "String", "float"])
	addFuncForm("plusAttrInt", "int", ["Attr", "String", "Attr", "String", "Attr", "String"])
	addFuncForm("plusAttrFloat", "float", ["Attr", "String", "Attr", "String", "Attr", "String"])
	addFuncForm("mulAttrInt", "int", ["Attr", "String", "Attr", "String", "Attr", "String"])
	addFuncForm("mulAttrFloat", "float", ["Attr", "String", "Attr", "String", "Attr", "String"])
	addFuncForm("minusAttrInt", "int", ["Attr", "String", "Attr", "String", "Attr", "String"])
	addFuncForm("minusAttrFloat", "float", ["Attr", "String", "Attr", "String", "Attr", "String"])
	addFuncForm("divAttrInt", "int", ["Attr", "String", "Attr", "String", "Attr", "String"])
	addFuncForm("divAttrFloat", "float", ["Attr", "String", "Attr", "String", "Attr", "String"])
	addFuncForm("plusAttrIntOverride", "int", ["Attr", "String", "Attr", "String"])
	addFuncForm("plusAttrFloatOverride", "float", ["Attr", "String", "Attr", "String"])
	addFuncForm("mulAttrIntOverride", "int", ["Attr", "String", "Attr", "String"])
	addFuncForm("mulAttrFloatOverride", "float", ["Attr", "String", "Attr", "String"])
	addFuncForm("minusAttrIntOverride", "int", ["Attr", "String", "Attr", "String"])
	addFuncForm("minusAttrFloatOverride", "float", ["Attr", "String", "Attr", "String"])
	addFuncForm("divAttrIntOverride", "int", ["Attr", "String", "Attr", "String"])
	addFuncForm("divAttrFloatOverride", "float", ["Attr", "String", "Attr", "String"])
