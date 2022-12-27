extends "res://class/FunctionalSet.gd"
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
	addFuncForm("isLowerInt", false, "bool", ["Attr", "String", "int"])
	addFuncForm("isLowerFloat", false, "bool", ["Attr", "String", "float"])
	addFuncForm("isGreaterInt", false, "bool", ["Attr", "String", "int"])
	addFuncForm("isGreaterFloat", false, "bool", ["Attr", "String", "float"])
	addFuncForm("isLowerEqualInt", false, "bool", ["Attr", "String", "int"])
	addFuncForm("isLowerEqualFloat", false, "bool", ["Attr", "String", "float"])
	addFuncForm("isGreaterEqualInt", false, "bool", ["Attr", "String", "int"])
	addFuncForm("isGreaterEqualFloat", false, "bool", ["Attr", "String", "float"])
