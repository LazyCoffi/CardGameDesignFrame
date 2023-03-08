extends Node
class_name FuncGraphNode

var FuncUnit = TypeUnit.type("FuncUnit")

var func_unit		# Function
var ch_list			# InnerNode_Array
var ch_index_list	# Array

func _init():
	func_unit = FuncUnit.new()
	ch_list = []
	ch_index_list = []

func copy():
	var ret = TypeUnit.type("FuncGraphNode").new()
	ret.func_unit = func_unit.copy()
	ret.ch_index_list = ch_index_list.duplicate()

	return ret

# func_unit
func setFunc(func_set_name, func_name):
	func_unit.setFuncSetName(func_set_name)
	func_unit.setFuncName(func_name)
	func_unit.initDefaultParams()

func setDefaultParam(param_type, param, index):
	func_unit.setDefaultParam(param_type, param, index)

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
func setChIndex(ch_id, ch_index):
	if ch_index_list.size() < ch_index:
		ch_index_list.resize(ch_index + 1)

	ch_index_list[ch_index] = ch_id

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
