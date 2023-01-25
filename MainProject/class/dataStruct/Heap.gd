extends Node
class_name Heap

var ScriptTree = load("res://class/entity/SceneTree.gd")

class HeapNode:
	var val
	var order
	var param_type

	func setParamType(param_type_):
		param_type = param_type_
	
	func getVal():
		return val
	
	func getOrder():
		return order

	func setVal(val_):
		val = val_
	
	func setOrder(order_):
		order = order_

	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addObject("val", val)
		script_tree.addAttr("order", order)

		return script_tree
	
	func loadScript(script_tree):
		val = script_tree.getObject("val", param_type)
		order = script_tree.getInt("order")

var heap

var param_type

func _init():
	heap = []

func setParamType(type):
	param_type = type

func append(val, order):
	Exception.assert(TypeUnit.isType(order, "int"))
	var heap_node = HeapNode.new()
	heap_node.setParamType(param_type)
	heap_node.val = val
	heap_node.order = order

	heap.append(heap_node)

	var index = heap.size() - 1
	while index > 0:
		if heap[index].order > heap[__fa(index)].order:
			__swap(index, __fa(index))
			index = __fa(index)
		else:
			break

func top():
	Exception.assert(not heap.empty())
	return heap[0].val

func pop():
	Exception.assert(not heap.empty())
	var ret = heap[0].val
	heap[0] = heap[heap.size() - 1]
	heap.resize(heap.size() - 1)
	
	var index = 0
	while index < heap.size():
		var target = index
		if __left(index) < heap.size() and heap[index] < heap[__left(index)]: 
			target = __left(index)

		if __right(index) < heap.size() and heap[target] < heap[__right(index)]:
			target = __right(index)

		if target == index:
			break

		__swap(index, target)
		index = target
	
	return ret

func size():
	return heap.size()

func empty():
	return heap.empty()

func pack():
	var script_tree = ScriptTree.new()
	
	script_tree.addObjectArray("heap", heap)

	return script_tree

func loadScript(script_tree):
	heap = script_tree.getTypeObjectArray("heap", HeapNode, param_type)

func __fa(index):
	return index >> 1

func __left(index):
	return index << 1

func __right(index):
	return (index << 1) + 1

func __swap(first, second):
	var temp = heap[first]
	heap[first] = heap[second]
	heap[second] = temp
