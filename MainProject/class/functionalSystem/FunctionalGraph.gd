extends Node
class_name FunctionalGraph

var ScriptTree = load("res://class/entity/ScriptTree.gd")
var Function = load("res://class/functionalSystem/Function.gd")

var root				# InnerNode
var request_params		# Dict
var node_index			# int
var exec_graph			# Dict

class FuncGraphNode:
	var functional		# Function
	var ch				# InnerNode_Array
	var index			# int

	func _init():
		functional = Function.new()
		ch = []

	func getFunctional():
		return functional
	
	func setFunctional(functional_):
		functional = functional_
		if not functional_.isVariable():
			ch.resize(functional.getParamsNum())
	
	func getCh():
		return ch.duplicate()
	
	func getChSize():
		return ch.size()
		
	func cleanChNode(node_index):
		ch[node_index] = null

	func setIndex(index_):
		index = index_	
	
	func getIndex():
		return index

	func isVariable():
		return functional.isVariable()
	
	func connectNode(child_node, param_index):
		Exception.assert(not isVariable())
		Exception.assert(__isAdaptable(child_node, param_index))

		__setChNode(param_index, child_node)
	
	func varConnectNode(child_node):
		Exception.assert(isVariable())
		Exception.assert(__isVariableAdaptable(child_node))

		__appendChNode(child_node)
	
	func disconnectNode(param_index):
		Exception.assert(param_index < ch.size())
		__removeChNode(param_index)
	
	func disconnectBackNode():
		ch.pop_back()

	func __removeChNode(node_index):
		## TODO: 添加warning
		ch.remove(node_index)

	func __setChNode(node_index, inner_node):
		Exception.assert(node_index < ch.size())

		ch[node_index] = inner_node
	
	func __popBackNode():
		ch.pop_back()

	func __appendChNode(inner_node):
		ch.append(inner_node)

	func __isAdaptable(child_node, param_index):
		Exception.assert(param_index < functional.getParamsNum())

		var ret_type = child_node.getFunctional().getRetType()
		var params_type = functional.getParamsType()
	
		return ret_type == params_type[param_index]
	
	func __isVariableAdaptable(child_node):
		var ret_type = child_node.getFunctional().getRetType()
		var params_type = functional.getParamsType()

		return ret_type == params_type[0]

	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addObject("functional", functional)
		script_tree.addObjectArray("ch", ch)
		script_tree.addAttr("index", index)

		return script_tree
	
	func loadScript(script_tree):
		functional = script_tree.getObject("functional", Function)
		ch = script_tree.getObjectArray("ch", FuncGraphNode)
		index = script_tree.getInt("index")

func genNode(functional):
	var node = FuncGraphNode.new()
	node.setFunctional(functional)
	return node

func setRoot(node):
	root = node
	constructGraph()

func constructGraph():
	node_index = 0
	request_params = {}
	__dfsConstruct(root)

func getParamsType():
	return request_params.duplicate()

func getParamsNum():
	return request_params.size()

func getRetType():
	return root.getFunctiontal().getRetType()
	
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
	root = script_tree.getObject("root", FuncGraphNode)
	request_params = script_tree.getStrDict("request_params")
	node_index = script_tree.getInt("node_index")

func __dfsConstruct(u):
	node_index += 1
	u.setIndex(node_index)

	var cur_func = u.getFunctional()
	var cur_request_params = cur_func.getParamsType()
	
	cur_request_params.resize(u.ch.size())
	
	# 处理可变参数函数的情况
	for index in range(u.getChSize()):
		if cur_request_params == null:
			cur_request_params[index] = cur_request_params[0]

	var param_index = 0
	for type in cur_request_params:
		if u.getCh()[param_index] == null:
			if not cur_func.hasStaticParam(param_index):
				request_params[cur_func.getFuncName() + "_" + str(node_index) + "_" + str(param_index)] = type
		else:
			__dfsConstruct(u.getCh()[param_index])

		param_index += 1

func __dfsExec(u, params):
	var cur_func = u.getFunctional()
	var cur_index = u.getIndex()
	var cur_params = []
	cur_params.resize(u.getChSize())

	if exec_graph.has(cur_index):
		return exec_graph[cur_index]
	
	for param_index in range(u.getChSize()):
		if not u.getCh()[param_index] == null:
			cur_params[param_index] = __dfsExec(u.getCh()[param_index], params)
		else:
			if cur_func.hasStaticParam(param_index):
				cur_params[param_index] = cur_func.getStaticParam(param_index)
			else:
				cur_params[param_index] = params[cur_func.getFuncName() + "_" + str(cur_index) + "_" + str(param_index)]

	var ret = cur_func.exec(cur_params)
	exec_graph[cur_index] = ret

	return ret
