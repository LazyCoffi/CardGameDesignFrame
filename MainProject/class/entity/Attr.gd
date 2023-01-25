extends Node
class_name Attr

var ScriptTree = load("res://class/entity/ScriptTree.gd")
var ValRange = load("res://class/entity/ValRange.gd")

var table

class AttrNode:
	var attr_name
	var val
	var val_type
	var val_range

	func _init():
		val_range = ValRange.new()
	
	func getAttrName():
		return attr_name
	
	func setAttrName(attr_name_):
		attr_name = attr_name_

	func getVal():
		return val

	func setVal(val_):
		val = val_
	
	func getValType():
		return val_type
	
	func setValType(val_type_):
		val_type = val_type_

	# TODO：扩充ValRange接口
	func setLower(lower_bound):
		val_range.setLower(lower_bound)
	
	func setUpper(upper_bound):
		val_range.setUpper(upper_bound)
	
	func delLower():
		val_range.delLower()
	
	func delUpper():
		val_range.delUpper()
	
	func activeBound():
		val_range.activeBound()
	
	func getValRange():
		return val_range.duplicate()
	
	func hasBound():
		return val_range.hasBound()
	
	func activeBound():
		val_range.activeBound()
	
	func pack():
		var script_tree = ScriptTree.new()
		
		script_tree.addAttr("attr_name", attr_name)
		script_tree.addAttr("val_type", val_type)
		script_tree.addAttr("val", val)
		script_tree.addObject("val_range", val_range)

		return script_tree
	
	func loadScript(script_tree):
		attr_name = script_tree.getStr("attr_name")
		val_type = script_tree.getStr("val_type")
		val = script_tree.getAttr("val", val_type)
		val_range = script_tree.getObject("val_range", ValRange)

func _init():
	attr = {}

func getVal(attr_name):
	Exception.assert(table.has(attr_name))
	return table[attr_name].getVal()

func getValType(attr_name):
	Exception.assert(table.has(attr_name))
	return table[attr_name].getValType()

func getValRange(attr_name):
	Exception.assert(table.has(attr_name))
	return table[attr_name].getValRange()

func addAttr(attr_name, val, val_type, val_range):
	table[attr_name].setAttrName(attr_name)
	table[attr_name].setVal(val)
	table[attr_name].setValType(val_type)
	table[attr_name].setValRange(val_range)

func delAttr(attr_name):
	table.erase(attr_name)

func setVal(attr_name, val):
	Exception.assert(table.has(attr_name))

	table[attr_name].setVal(val)

func setValType(attr_name, val_type):
	Exception.assert(table.has(attr_name))

	table[attr_name].setValType(val_type)

func setUpper(attr_name, val):
	Exception.assert(table.has(attr_name))

	table[attr_name].setUpper(val)

func setLower(val, attr_name):
	Exception.assert(table.has(attr_name))
	table[attr_name].setLower(val)

func delUpper(attr_name):
	Exception.assert(table.has(attr_name))
	
	table[attr_name].delUpper()

func delLower(attr_name):
	Exception.assert(table.has(attr_name))

	table[attr_name].delLower()
	
func getValRange(attr_name):
	return table[attr_name].getValRange()

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObjectDict("table", table)

	return script_tree

func loadScript(script_tree):
	table = script_tree.getObjectDict("table", AttrNode)
