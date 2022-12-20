extends Node
class_name AttrFunctionSet

var func_form = {}

func _init():
	initFuncForm()

func initFuncForm():
	addFuncForm("setAttr", ["Card"], ["Card", "String", "Object"])
	addFuncForm("addAttr", ["Card"], ["Card", "String", "Number"])
	addFuncForm("mulAttr", ["Card"], ["Card", "String", "Number"])
	addFuncForm("setAttrUpperBound", ["Card"], ["Card", "String", "Number"])
	addFuncForm("setAttrLowerBound", ["Card"], ["Card", "String", "Number"])

func addFuncForm(func_name, ret_form, params_form):
	var cur_form = {}
	cur_form["params"] = params_form
	cur_form["ret"] = ret_form

	func_form[func_name] = cur_form

func getParamsType(func_name):
	if not hasFunc(func_name):
		Exception.assert(false, "Wrong functional_name")

	return func_form[func_name]["params"]

func getRetType(func_name):
	if not hasFunc(func_name):
		Exception.assert(false, "Wrong functional_name")

	return func_form[func_name]["ret"]
	
func hasFunc(func_name):
	return func_form.has(func_name)

func setAttr(card, attr_name, val):
	if TypeUnit.isType(val, "int") or TypeUnit.isType(val, "float"):
		var upper = card.attr.getRange(attr_name).upper()
		var lower = card.attr.getRange(attr_name).lower()
		card.attr.setAttr(attr_name, max(lower, min(upper, val)))
	else:
		card.attr.setAttr(val)
	
	return [card]

func addAttr(card, attr_name, val):
	var upper = card.attr.upper(attr_name)
	var lower = card.attr.lower(attr_name)
	var attr = card.attr.getAttr(attr_name)
	card.attr.setAttr(attr_name, max(lower, min(upper, attr + val)))

	return [card]

func mulAttr(card, attr_name, val):
	var upper = card.attr.upper(attr_name)
	var lower = card.attr.lower(attr_name)
	var attr = card.attr.getAttr(attr_name)

	card.attr.setAttr(attr_name, max(lower, min(upper, attr * val)))
 
func setAttrUpperBound(card, attr_name, val):
	var lower = val
	if card.attr.hasLower(attr_name):
		lower = card.attr.lower(val, attr_name)
	
	card.attr.setUpper(max(lower, val), attr_name)
	
	return [card]

func setAttrLowerBound(card, attr_name, val):
	var upper = val
	if card.attr.hasUpper(attr_name):
		upper = card.attr.upper(attr_name)
	
	card.attr.setLower(min(upper, val), attr_name)
	
	return [card]
