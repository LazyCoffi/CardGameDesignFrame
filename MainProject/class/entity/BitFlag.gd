extends Node
class_name BitFlag

var ScriptTree = TypeUnit.type("ScriptTree")

var flag			# int 

func _init():
	flag = 0

func copy():
	var ret = TypeUnit.type("BitFlag").new()
	ret.flag = flag

	return ret

func setFlag(head, tail := null):
	flag |= __mask(head, tail)

func resetFlag(head, tail := null):
	flag &= (~__mask(head, tail))

func getFlag(head, tail := null):
	return (flag & __mask(head, tail)) >> head

func __mask(head, tail := null):
	var ret = 0
	ret |= (1 << head)
	if tail != null:
		while head <= tail:
			ret |= (1 << head)

	return ret

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("flag", flag)

	return script_tree

func loadScript(script_tree):
	flag = script_tree.getInt("flag")
