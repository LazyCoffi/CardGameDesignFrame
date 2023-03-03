extends Node
class_name FuncGraph

var ScriptTree = TypeUnit.type("ScriptTree")
var FuncUnit = TypeUnit.type("FuncUnit")
var NullPack = TypeUnit.type("NullPack")
var FuncGraphNode = TypeUnit.type("FuncGraphNode")

var node_list			# Array
var request_params		# Dict
var exec_graph			# Dict
var mark_map			# Dict

func _init():
	node_list = []
	request_params = {}
	exec_graph = {}
	mark_map = {}
	
func copy():
	var ret = TypeUnit.type("FuncGraph").new()

	for node in node_list:
		ret.node_list.append(node.copy())
	ret.request_params = request_params.duplicate(true)
	ret.exec_graph = {}
	
	return ret

## FactoryInterface
func setNodeList(node_list_):
	node_list = node_list_

## RuntimeInterface
func addNode(graph_node):
	node_list.append(graph_node)

func construct():
	__flatConstruct()

	request_params = {}
	mark_map = {}

	__dfsConstruct(0)

func getParamsType():
	return request_params.duplicate()

func getParamsNum():
	return request_params.size()

func getRetType():
	return node_list[0].getFuncUnit().getRetType()
	
func exec(params):
	exec_graph = {}
	return __dfsExec(0, params)

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("request_params", request_params)
	script_tree.addObjectArray("node_list", node_list)

	return script_tree

func loadScript(script_tree):
	request_params = script_tree.getStrDict("request_params")
	node_list = script_tree.getObjectArray("node_list", FuncGraphNode)

func __flatConstruct():
	for node in node_list:
		var ch_index_list = node.getChIndexList()
		node.resizeChList(ch_index_list.size())
		for param_index in range(ch_index_list.size()):
			var ch_index = node.getChIndex(param_index)

			if ch_index == null:
				node.disconnectNode(param_index)
			else:
				var ch_node = node_list[ch_index]
				node.connectNode(ch_node, param_index)

func __dfsConstruct(u):
	if mark_map.has(u):
		return
	mark_map[u] = null

	var node = node_list[u]
	var node_func = node.getFuncUnit()
	var node_request_params = node_func.getParamsType()
	
	for param_index in range(node_request_params.size()):
		var type = node_request_params[param_index]

		if node.getChIndex(param_index) == null:
			if not node_func.hasDefaultParam(param_index):
				var request_name = __name(node_func.getFuncName(), u, param_index)
				request_params[request_name] = type
		else:
			var ch_index = node.getChIndex(param_index)
			__dfsConstruct(ch_index)
	
func __dfsExec(u, params):
	if exec_graph.has(u):
		return exec_graph[u]

	var node = node_list[u]
	var node_func = node.getFuncUnit()
	var node_params = []
	node_params.resize(node.getChIndexSize())
		
	for param_index in range(node.getChIndexSize()):
		var v = node.getChIndex(param_index)
		if node.getChIndex(param_index) != null:
			node_params[param_index] = __dfsExec(v, params)
		else:
			if node_func.hasDefaultParam(param_index):
				node_params[param_index] = node_func.getDefaultParam(param_index)
			else:
				node_params[param_index] = params[__name(node_func.getFuncName(), u, param_index)]

	var ret = node_func.exec(node_params)
	exec_graph[u] = ret

	return ret

func __name(func_name, node_index, param_index):
	return func_name + "_" + str(node_index) + "_" + str(param_index)
