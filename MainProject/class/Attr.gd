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

func isType(val, val_type):
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

func setAttr(attr_name, val):
	Exception.assert(attr.has(attr_name))
	Exception.assert(type.has(attr_name))
	Exception.assert(isType(val, type[attr_name]))
	
	attr[attr_name] = val

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
