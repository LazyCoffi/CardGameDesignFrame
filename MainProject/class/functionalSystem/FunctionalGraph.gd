extends Node
class_name FunctionalGraph

var ScriptTree = load("res://class/entity/ScriptTree.gd")
var Function = load("res://class/functionalSystem/Function.gd")

var root				# InnerNode
var request_params		# Array
var node_index			# int
var exec_graph			# Dict

class InnerNode:
	var functional		# Function
	var ch				# InnerNode_Array
	var index			# int

	func getFunctiontal():
		return functional.duplicate()
	
	func setFunctional(functional_):
		functional = functional_
	
	func getCh():
		return ch.duplicate()
	
	func addCh(inner_node):
		ch.append(inner_node)
	
	## TODO: 添加访问接口
	
	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addObject("functional", functional)
		script_tree.addObjectArray("ch", ch)
		script_tree.addAttr("index", index)

		return script_tree
	
	func loadScript(script_tree):
		functional = script_tree.getObject("functional", Function)
		ch = script_tree.getObjectArray("ch", InnerNode)
		index = script_tree.getInt("index")

func _init():
	root = InnerNode.new()
	node_index = 0

func setRoot(functional):
	root = {}
	root.functional = functional
	root.ch = []
	root.ch.resize(functional.getParamsNum())
	constructGraph()

func constructGraph():
	node_index = 0
	request_params = {}
	__dfsConstruct(root)

func isAdaptable(child_func, parent_func, param_index):
	Exception.assert(not parent_func.isVariable())
	Exception.assert(param_index < parent_func.getParamsNum())

	var ret_type = child_func.getRetType()
	var params_type = parent_func.getParamsType()
	
	return ret_type == params_type[param_index]

func isVariableAdaptable(child_func, parent_func):
	Exception.assert(parent_func.isVariable())

	var ret_type = child_func.getRetType()
	var params_type = parent_func.getParamsType()

	return ret_type == params_type[0]

func connectNode(child_node, parent_node, param_index):
	Exception.assert(isAdaptable(child_node.functional, parent_node.functional, param_index))

	parent_node.ch[param_index] = child_node
	
	constructGraph()

func connectVariableNode(child_node, parent_node):
	Exception.assert(isVariableAdaptable(child_node.functional, parent_node.functional))

	parent_node.ch.append(child_node)

	constructGraph()

func disconnectNode(parent_node, param_index):
	Exception.assert(param_index < parent_node["ch"].size())

	parent_node.ch[param_index] = null

	constructGraph()

func getParamsType():
	return request_params.duplicate()

func getRetType():
	return root.getRetType()
	
func exec(params):
	exec_graph = {}
	return __dfsExec(root, params)

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObject("root", root)
	script_tree.addAttr("request_params", request_params)
	script_tree.addAttr("node_index", node_index)

	return script_tree

func loadScript(script_tree):
	root = script_tree.getObject("root", InnerNode)
	request_params = script_tree.getAttr("request_params")
	node_index = script_tree.getAttr("node_index")

func __dfsConstruct(u):
	node_index += 1
	u.index = node_index

	var cur_func = u.functional
	var cur_request_params = cur_func.getParamsType()
	
	cur_request_params.resize(u.ch.size())
	
	# 处理可变参数函数的情况
	for index in range(u.ch.size()):
		if cur_request_params == null:
			cur_request_params[index] = cur_request_params[0]

	var param_index = 0
	for type in cur_request_params:
		if u.ch[param_index] == null:
			if not cur_func.hasStaticParam(param_index):
				request_params[str(node_index) + "_" + str(param_index)] = type
		else:
			__dfsConstruct(u.ch[param_index])

		param_index += 1

func __dfsExec(u, params):
	var cur_func = u.functional
	var cur_index = u.index
	var cur_params = []

	if exec_graph.has(cur_index):
		return exec_graph[cur_index]
	
	for param_index in range(u.ch.size()):
		if not u.ch[param_index] == null:
			cur_params[param_index] = __dfsExec(u.ch[param_index], params)
		else:
			cur_params[param_index] = params[str(cur_index) + "_" + str(param_index)]

	var ret = cur_func.exec(cur_params)
	exec_graph[cur_index] = ret

	return ret
