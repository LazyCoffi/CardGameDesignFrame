extends Node
class_name Attr

var attr

func _ready():
	pass

func getAttr(attr_name):
	Exception.assert(attr.has(attr_name))
	return attr[attr_name]

func pack():
	return attr

func loadScript(script):
	attr = script.getRoot()
