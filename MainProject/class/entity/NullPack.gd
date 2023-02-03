extends Node
class_name NullPack

var ScriptTree = TypeUnit.type("ScriptTree")

func _init():
	pass

func copy():
	return TypeUnit.type("NullPack").new()

func getVal():
	return null

func pack():
	return ScriptTree.new()

func loadScript(_script_tree):
	return
