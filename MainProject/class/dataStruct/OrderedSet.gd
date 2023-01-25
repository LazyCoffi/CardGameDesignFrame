extends Node
class_name OrderedSet

## 平衡树Treap

var MathUnit = load("res://class/toolUnit/MathUnit.gd")

class TreeNode:
	var ch		# 左右子树 Array
	var param	# 变量值
	var order	# 实际优先级
	var prio 	# 内部优先级
	var siz		# 子节点数量

	func _init():
		ch = [null, null]
		prio = MathUnit.randInt(0, 65536)
	
var root

## TODO
