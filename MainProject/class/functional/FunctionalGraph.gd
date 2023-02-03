extends Node
class_name FunctionalGraph

var ScriptTree = TypeUnit.type("ScriptTree")
var Function = TypeUnit.type("Function")
var NullPack = TypeUnit.type("NullPack")

var root				# FuncGraphNode
var graph				# Array
var request_params		# Dict
var node_index			# int
var exec_graph			# Dict

class FuncGraphNode:
	var functional		# Function
	var ch				# InnerNode_Array
	var index			# int

	func _init():
		functional = null
		ch = []
		index = 0
	
	func copy():
		var ret = FuncGraphNode.new()
		ret.functional = functional.copy()
		ret.ch = []
		for node in ch:
			ret.ch.append(node.copy())
		ret.index = index

		return ret

	func getFunctional():
		return functional
	
	func setFunctional(functional_):
		functional = functional_
		ch.resize(functional.getParamsNum())
	
	func getCh(idx):
		return ch[idx]
	
	func getChList():
		return ch.duplicate()
	
	func getChSize():
		return ch.size()
	
	func resizeCh(size):
		ch.resize(size)
	
	func setCh(idx, param):
		ch[idx] = param

	# index
	func getIndex():
		return index

	func setIndex(index_):
		index = index_	
	
	func connectNode(child_node, param_index):
		ch[param_index] = child_node
	
	func disconnectNode(param_index):
		ch[param_index] = null
	
	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addObject("functional", functional)
		script_tree.addAttr("index", index)

		return script_tree
	
	func loadScript(script_tree):
		functional = script_tree.getObject("functional", Function)
		index = script_tree.getInt("index")

func _init():
	node_index = 0
	root = null
	graph = [null]
	request_params = {}
	exec_graph = {}
	
func copy():
	var ret = TypeUnit.type("FunctionalGraph").new()
	ret.root = root.copy()
	ret.graph = graph
	ret.request_params = request_params.duplicate(true)
	ret.node_index = node_index
	ret.exec_graph = {}
	for key in exec_graph.keys():
		ret.exec_graph[key] = exec_graph[key].copy()
	
	return ret

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

	script_tree.addAttr("graph", graph)
	script_tree.addAttr("request_params", request_params)
	script_tree.addAttr("node_index", node_index)

	var flat_tree = []
	flat_tree.resize(node_index)
	__getFlatTree(root, flat_tree)
	script_tree.addObjectArray("flat_tree", flat_tree)

	return script_tree

func loadScript(script_tree):
	graph = script_tree.getRawAttr("graph")
	request_params = script_tree.getStrDict("request_params")
	node_index = script_tree.getInt("node_index")

	var flat_tree = script_tree.getObjectArray("flat_tree", FuncGraphNode)
	__reconstructTree(flat_tree)

func __dfsConstruct(u):
	node_index += 1
	u.setIndex(node_index)

	graph.append([])

	var cur_func = u.getFunctional()
	var cur_request_params = cur_func.getParamsType()
	
	var param_index = 0
	for type in cur_request_params:
		if u.getCh(param_index) == null:
			if not cur_func.hasDefaultParam(param_index):
				request_params[__name(cur_func.getFuncName(), u.getIndex(), param_index)] = type
			graph[u.getIndex()].append(0) 
		else:
			__dfsConstruct(u.getCh(param_index))
			graph[u.getIndex()].append(u.getCh(param_index).getIndex())

		param_index += 1
	
func __getFlatTree(u, flat_tree):
	var cur_index = u.getIndex()
	flat_tree[cur_index - 1] = u
	for node in u.getChList():
		if node != null:
			__getFlatTree(node, flat_tree)

func __reconstructTree(flat_tree):
	for i in range(1, graph.size()):
		flat_tree[i - 1].resizeCh(graph[i].size())
		for j in range(graph[i].size()):
			if graph[i][j] != 0:
				flat_tree[i - 1].connectNode(flat_tree[graph[i][j] - 1], j)
	
	setRoot(flat_tree[0])

func __dfsExec(u, params):
	var cur_func = u.getFunctional()
	var cur_index = u.getIndex()
	var cur_params = []
	cur_params.resize(u.getChSize())

	if exec_graph.has(cur_index):
		return exec_graph[cur_index]
	
	for param_index in range(u.getChSize()):
		if u.getCh(param_index) != null:
			cur_params[param_index] = __dfsExec(u.getCh(param_index), params)
		else:
			if cur_func.hasDefaultParam(param_index):
				cur_params[param_index] = cur_func.getDefaultParam(param_index)
			else:
				cur_params[param_index] = params[__name(cur_func.getFuncName(), cur_index, param_index)]

	var ret = cur_func.exec(cur_params)
	exec_graph[cur_index] = ret

	return ret

func __name(func_name, cur_index, param_index):
	return func_name + "_" + str(cur_index) + "_" + str(param_index)
