extends Node
class_name Float

var ScriptTree = TypeUnit.type("ScriptTree")

var val

func _init():
	val = 0.0

func getVal():
	return val

func setVal(val_):
	val = val_

func copy():
	var ret = TypeUnit.type("Float").new()
	ret.val = val

	return ret

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("val", val)

	return script_tree

func loadScript(script_tree):
	val = script_tree.getFloat("val")
