extends Node
class_name Attr

var attr
var type
var val_range

var ScriptTree = load("res://class/ScriptTree.gd")
var ValRange = load("res://class/ValRange.gd")

func _init():
	attr = {}
	type = {}
	val_range = {}

func _ready():
	pass

func adaptType(val, attr_name):
	var val_type = type[attr_name]
	match val_type:
		"int":
			return val as int
		"float":
			return val as float
		"String":
			return val
		"Attr":
			return val
		_:
			return false

func isAdaptable(val, attr_name):
	var val_type = type[attr_name]
	match val_type:
		"int":
			return val is int or val is float
		"float":
			return val is int or val is float
		"String":
			return val is String
		"Attr":
			return val is Attr
		_:
			return false

func isType(val, attr_name):
	var val_type = type[attr_name]
	match val_type:
		"int":
			return val is int
		"float":
			return val is float
		"String":
			return val is String
		"Attr":
			return val is Attr
		_:
			return false

func getType(attr_name):
	Exception.assert(type.has(attr_name))
	return type[attr_name]

func getRange(attr_name):
	Exception.assert(val_range.has(attr_name))
	return val_range[attr_name]

func getAttr(attr_name):
	Exception.assert(attr.has(attr_name))
	return attr[attr_name]

func setAttr(val, attr_name):
	Exception.assert(attr.has(attr_name))
	Exception.assert(type.has(attr_name))
	
	val = adaptType(val, attr_name)
	attr[attr_name] = val

func setUpper(val, attr_name):
	val = adaptType(val, attr_name)
	val_range[attr_name].setUpper(val)

func setLower(val, attr_name):
	val = adaptType(val, attr_name)
	val_range[attr_name].setLower(val)

func upper(attr_name):
	return val_range[attr_name].lower()

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
