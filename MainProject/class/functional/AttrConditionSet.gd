extends "res://class/functional/FuncSet.gd"
class_name AttrConditionSet

func _init():
	func_form = {}
	__initFuncForm()

func isLessInt(attr, attr_name, val):
	return __isLess(attr, attr_name, val)
	
func isLessFloat(attr, attr_name, val):
	return __isLess(attr, attr_name, val)

func isLessEqualInt(attr, attr_name, val):
	return __isLessEqual(attr, attr_name, val)
	
func isLessEqualFloat(attr, attr_name, val):
	return __isLessEqual(attr, attr_name, val)

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
	
func __isLess(attr, attr_name, val):
	return attr.getAttr(attr_name) < val

func __isGreater(attr, attr_name, val):
	return attr.getAttr(attr_name) > val

func __isLessEqual(attr, attr_name, val):
	return attr.getAttr(attr_name) <= val

func __isGreaterEqual(attr, attr_name, val):
	return attr.getAttr(attr_name) >= val

func __initFuncForm():
	addFuncForm("isLessInt", "bool", ["Attr", "String", "int"])
	addFuncForm("isLessFloat", "bool", ["Attr", "String", "float"])
	addFuncForm("isGreaterInt", "bool", ["Attr", "String", "int"])
	addFuncForm("isGreaterFloat", "bool", ["Attr", "String", "float"])
	addFuncForm("isLessEqualInt", "bool", ["Attr", "String", "int"])
	addFuncForm("isLessEqualFloat", "bool", ["Attr", "String", "float"])
	addFuncForm("isGreaterEqualInt", "bool", ["Attr", "String", "int"])
	addFuncForm("isGreaterEqualFloat", "bool", ["Attr", "String", "float"])
