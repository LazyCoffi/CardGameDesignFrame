extends "res://class/functional/FunctionalSet.gd"
class_name AttrFunctionSet

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

func __initFuncForm():
	addFuncForm("setConst", "Attr", ["Attr", "String", "all"])
	addFuncForm("plusIntConst", "Attr", ["Attr", "String", "int"])
	addFuncForm("plusFloatConst", "Attr", ["Attr", "String", "float"])
	addFuncForm("mulConstInt", "Attr", ["Attr", "String", "float"])
	addFuncForm("setUpperBoundConstInt", "Attr", ["Attr", "String", "int"])
	addFuncForm("setUpperBoundConstFloat", "Attr", ["Attr", "String", "float"])
	addFuncForm("setLowerBoundConstInt", "Attr", ["Attr", "String", "int"])
	addFuncForm("setLowerBoundConstFloat", "Attr", ["Attr", "String", "float"])
