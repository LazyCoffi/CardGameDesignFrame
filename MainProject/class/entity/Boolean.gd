extends Node
class_name Boolean

var ScriptTree = TypeUnit.type("ScriptTree")

var val

func _init():
	val = false

func getVal():
	return val

func setVal(val_):
	val = bool(val_)

func copy():
	var ret = TypeUnit.type("Boolean").new()

	ret.val = val

	return ret

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("val", val)

	return script_tree

func loadScript(script_tree):
	val = script_tree.getBool("val")
