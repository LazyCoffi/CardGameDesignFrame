extends Node
class_name Integer

var ScriptTree = TypeUnit.type("ScriptTree")

var val

func _init():
	val = 0

func getVal():
	return val

func setVal(val_):
	val = int(val_)

func copy():
	var ret = TypeUnit.type("Integer").new()
	ret.val = val

	return ret
	
func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("val", val)

	return script_tree

func loadScript(script_tree):
	val = script_tree.getInt("val")
