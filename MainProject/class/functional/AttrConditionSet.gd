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

func isAttrLessInt(first, first_name, second, second_name):
	return first.getAttr(first_name) < second.getAttr(second_name)

func isAttrLessEqualInt(first, first_name, second, second_name):
	return first.getAttr(first_name) <= second.getAttr(second_name)

func isAttrGreaterInt(first, first_name, second, second_name):
	return first.getAttr(first_name) > second.getAttr(second_name)

func isAttrGreaterEqualInt(first, first_name, second, second_name):
	return first.getAttr(first_name) >= second.getAttr(second_name)

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
	addFuncForm("isAttrLessEqualInt", "bool", ["Attr", "String", "Attr", "String"])
	addFuncForm("isAttrLessEqualFloat", "bool", ["Attr", "String", "Attr", "String"])
	addFuncForm("isAttrGreaterEqualInt", "bool", ["Attr", "String", "Attr", "String"])
	addFuncForm("isAttrGreaterEqualFloat", "bool", ["Attr", "String", "Attr", "String"])
