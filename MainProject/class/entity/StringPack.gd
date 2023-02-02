extends Node
class_name StringPack

var ScriptTree = TypeUnit.type("ScriptTree")

var val

func _init():
	val = ""

func copy():
	var ret = TypeUnit.type("StringPack").new()
	ret.val = val

	return ret

func getVal():
	return val

func setVal(val_):
	val = str(val_)

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("val", val)

	return script_tree

func loadScript(script_tree):
	val = script_tree.getStr("val")
