extends Node

class HeapNode:
	var __val
	var __order

var heap

func _init():
	heap = []

func append(val, order):
	Exception.assert(TypeUnit.isType(order, "int"))
	var heap_node = HeapNode.new()
	heap_node.__val = val
	heap_node.__order = order

	heap.append(heap_node)

	var index = heap.size() - 1
	while index > 0:
		if heap[index].__order > heap[__fa(index)].__order:
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
