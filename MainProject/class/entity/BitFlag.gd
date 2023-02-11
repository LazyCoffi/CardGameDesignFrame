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

func setFlag(index):
	flag |= __mask(index)

func resetFlag(index):
	flag &= (~__mask(index))

func getFlag(index):
	return (flag & __mask(index)) >> index

func setMultiFlag(head, tail):
	flag |= __maskMulti(head, tail)

func resetMultiFlag(head, tail):
	flag &= (~__maskMulti(head, tail))

func getMultiFlag(head, tail):
	return (flag & __maskMulti(head, tail)) >> head

func __mask(index):
	return (1 << index)

func __maskMulti(head, tail):
	var ret = 0
	ret |= (1 << head)
	if tail != null:
		while head <= tail:
			ret |= (1 << head)
			head += 1

	return ret

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("flag", flag)

	return script_tree

func loadScript(script_tree):
	flag = script_tree.getInt("flag")
