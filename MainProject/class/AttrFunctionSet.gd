extends "res://class/FunctionalSet.gd"
class_name AttrFunctionSet

func _init():
	func_form = {}
	__initFuncForm()

func __initFuncForm():
	addFuncForm("setAttr", false, "Attr", ["Attr", "String", "all"])
	addFuncForm("plusAttrInt", false, "Attr", ["Attr", "String", "int"])
	addFuncForm("plusAttrFloat", false, "Attr", ["Attr", "String", "float"])
	addFuncForm("mulAttrInt", false, "Attr", ["Attr", "String", "float"])
	addFuncForm("setAttrUpperBoundInt", false, "Attr", ["Attr", "String", "int"])
	addFuncForm("setAttrUpperBoundFloat", false, "Attr", ["Attr", "String", "float"])
	addFuncForm("setAttrLowerBoundInt", false, "Attr", ["Attr", "String", "int"])
	addFuncForm("setAttrLowerBoundFloat", false, "Attr", ["Attr", "String", "float"])

func setAttr(attr, attr_name, val):
	if TypeUnit.isType(val, "int") or TypeUnit.isType(val, "float"):
		var upper = attr.getRange(attr_name).upper()
		var lower = attr.getRange(attr_name).lower()
		attr.setAttr(attr_name, max(lower, min(upper, val)))
	else:
		attr.setAttr(val)
	
	return [attr]

func plusAttrInt(attr, attr_name, val):
	Exception.assert(TypeUnit.isType(val, "int"))
	return __plusAttr(attr, attr_name, val)

func plusAttrFloat(attr, attr_name, val):
	Exception.assert(TypeUnit.isType(val, "float"))
	return __plusAttr(attr, attr_name, val)
	
func __plusAttr(attr, attr_name, val):
	var upper = attr.upper(attr_name)
	var lower = attr.lower(attr_name)

	attr.setAttr(attr_name, max(lower, min(upper, attr + val)))

	return [attr]

func mulAttrInt(attr, attr_name, val):
	Exception.assert(TypeUnit.isType(val, "int"))
	return __mulAttr(attr, attr_name, val)

func mulAttrFloat(attr, attr_name, val):
	Exception.assert(TypeUnit.isType(val, "float"))
	return __mulAttr(attr, attr_name, val)

func __mulAttr(attr, attr_name, val):
	var upper = attr.upper(attr_name)
	var lower = attr.lower(attr_name)

	attr.setAttr(attr_name, max(lower, min(upper, attr * val)))
	
	return [attr]

func setAttrUpperBoundInt(attr, attr_name, val):
	Exception.assert(TypeUnit.isType(val, "int"))
	return __setAttrUpperBound(attr, attr_name, val)

func setAttrUpperBoundFloat(attr, attr_name, val):
	Exception.assert(TypeUnit.isType(val, "float"))
	return __setAttrUpperBound(attr, attr_name, val)

func __setAttrUpperBound(attr, attr_name, val):
	var lower = val
	if attr.hasLower(attr_name):
		lower = attr.lower(val, attr_name)
	
	attr.setUpper(max(lower, val), attr_name)
	
	return [attr]

func setAttrLowerBoundInt(attr, attr_name, val):
	Exception.assert(TypeUnit.isType(val, "int"))
	return __setAttrLowerBound(attr, attr_name, val)

func setAttrLowerBoundFloat(attr, attr_name, val):
	Exception.assert(TypeUnit.isType(val, "float"))
	return __setAttrLowerBound(attr, attr_name, val)

func __setAttrLowerBound(attr, attr_name, val):
	var upper = val
	if attr.hasUpper(attr_name):
		upper = attr.upper(attr_name)
	
	attr.setLower(min(upper, val), attr_name)
	
	return [attr]
