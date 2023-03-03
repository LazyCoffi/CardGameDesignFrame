extends Node
class_name FuncGraphNode

var func_unit		# Function
var ch_list			# InnerNode_Array
var ch_index_list	# Array

func _init():
	func_unit = null
	ch_list = []
	ch_index_list = []

func copy():
	var ret = TypeUnit.type("FuncGraphNode").new()
	ret.func_unit = func_unit.copy()
	ret.ch_index_list = ch_index_list.duplicate()

	return ret

## FactoryInterface
func setFuncUnit(func_unit_):
	func_unit = func_unit_

func setChIndexList(ch_index_list_):
	ch_index_list = ch_index_list_

## RuntimeInterface
# func_unit
func getFuncUnit():
	return func_unit

# ch_list
func getCh(idx):
	return ch_list[idx]

func getChList():
	return ch_list

func getChSize():
	return ch_list.size()

func resizeChList(size):
	ch_list.resize(size)

# ch_index_list
func getChIndex(index):
	return ch_index_list[index]

func getChIndexList():
	return ch_index_list

func getChIndexSize():
	return ch_index_list.size()

func connectNode(child_node, param_index):
	ch_list[param_index] = child_node

func disconnectNode(param_index):
	ch_list[param_index] = null

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObject("func_unit", func_unit)
	script_tree.addAttr("ch_index_list", ch_index_list)

	return script_tree

func loadScript(script_tree):
	func_unit = script_tree.getObject("func_unit", FuncUnit)
	ch_index_list = script_tree.getIntArray("ch_index_list")
