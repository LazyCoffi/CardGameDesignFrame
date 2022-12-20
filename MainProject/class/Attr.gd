extends Node
class_name Attr

var ScriptTree = load("res://class/ScriptTree.gd")
var ValRange = load("res://class/ValRange.gd")

var attr
var attr_type
var val_range

func _init():
	attr = {}
	attr_type = {}
	val_range = {}

func getType(attr_name):
	Exception.assert(attr_type.has(attr_name))
	return attr_type[attr_name]

func getRange(attr_name):
	Exception.assert(val_range.has(attr_name))
	return val_range[attr_name]

func getAttr(attr_name):
	Exception.assert(attr.has(attr_name))
	return attr[attr_name]

func setAttr(val, attr_name):
	Exception.assert(attr.has(attr_name))
	Exception.assert(attr_type.has(attr_name))
	
	attr[attr_name] = val

func setUpper(val, attr_name):
	Exception.assert(TypeUnit.isType(val, attr_type[attr_name]))

	val_range[attr_name].setUpper(val)

func setLower(val, attr_name):
	Exception.assert(TypeUnit.isType(val, attr_type[attr_name]))

	val_range[attr_name].setLower(val)

func upper(attr_name):
	return val_range[attr_name].upper()

func lower(attr_name):
	return val_range[attr_name].lower()

func hasUpper(attr_name):
	return val_range[attr_name].hasUpper()

func hasLower(attr_name):
	return val_range[attr_name].hasLower()

func delUpper(attr_name):
	val_range[attr_name].delUpper()

func delLower(attr_name):
	val_range[attr_name].delLower()

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("attr", attr)
	script_tree.addAttr("type", type)
	script_tree.addObject("val_range", val_range)

	return script_tree

func loadScript(script_tree):
	attr = script_tree.getAttr("attr")
	type = script_tree.getAttr("type")
	script_tree = script_tree.getObject("val_range", ValRange)
