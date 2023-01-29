extends "res://class/functionalSystem/FunctionalSet.gd"
class_name AttrConditionSet

func _init():
	func_form = {}
	__initFuncForm()

func isLowerInt(attr, attr_name, val):
	return __isLower(attr, attr_name, val)
	
func isLowerFloat(attr, attr_name, val):
	return __isLower(attr, attr_name, val)

func isLowerEqualInt(attr, attr_name, val):
	return __isLowerEqual(attr, attr_name, val)
	
func isLowerEqualFloat(attr, attr_name, val):
	return __isLowerEqual(attr, attr_name, val)

func isGreaterInt(attr, attr_name, val):
	return __isGreater(attr, attr_name, val)

func isGreaterFloat(attr, attr_name, val):
	return __isGreater(attr, attr_name, val)

func isGreaterEqualInt(attr, attr_name, val):
	return __isGreaterEqual(attr, attr_name, val)

func isGreaterEqualFloat(attr, attr_name, val):
	return __isGreaterEqual(attr, attr_name, val)

func isEqual(attr, attr_name, val):
	return attr.getAttr(attr_name) == val
	
func __isLower(attr, attr_name, val):
	return attr.getAttr(attr_name) < val

func __isGreater(attr, attr_name, val):
	return attr.getAttr(attr_name) > val

func __isLowerEqual(attr, attr_name, val):
	return attr.getAttr(attr_name) <= val

func __isGreaterEqual(attr, attr_name, val):
	return attr.getAttr(attr_name) >= val

func __initFuncForm():
	addFuncForm("isLowerInt", "bool", ["Attr", "String", "int"])
	addFuncForm("isLowerFloat", "bool", ["Attr", "String", "float"])
	addFuncForm("isGreaterInt", "bool", ["Attr", "String", "int"])
	addFuncForm("isGreaterFloat", "bool", ["Attr", "String", "float"])
	addFuncForm("isLowerEqualInt", "bool", ["Attr", "String", "int"])
	addFuncForm("isLowerEqualFloat", "bool", ["Attr", "String", "float"])
	addFuncForm("isGreaterEqualInt", "bool", ["Attr", "String", "int"])
	addFuncForm("isGreaterEqualFloat", "bool", ["Attr", "String", "float"])
