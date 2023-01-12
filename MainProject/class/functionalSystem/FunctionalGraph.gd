extends Node
class_name FunctionalGraph

var ScriptTree = load("res://class/entity/ScriptTree.gd")

var root
var request_params
var node_index
var __exec_graph

## TODO: 添加node结构注释
class innerNode:
	var __func
	var __ch

func _init():
	root = innerNode.new()
	node_index = 0

func setRoot(functional):
	root = {}
	root.__func = functional
	root.__ch = []
	root.__ch.resize(functional.getParamsNum())
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
	Exception.assert(isAdaptable(child_node.__func, parent_node.__func, param_index))

	parent_node.__ch[param_index] = child_node
	
	constructGraph()

func connectVariableNode(child_node, parent_node):
	Exception.assert(isVariableAdaptable(child_node.__func, parent_node.__func))

	parent_node.__ch.append(child_node)

	constructGraph()

func disconnectNode(parent_node, param_index):
	Exception.assert(param_index < parent_node["ch"].size())

	parent_node.__ch[param_index] = null

	constructGraph()

func getParamsType():
	return request_params

func getRetType():
	return root.getRetType()
	
func exec(params):
	__exec_graph = {}
	return __dfsExec(root, params)

func pack():
	var script_tree = ScriptTree.new()

	var root_dict = {}
	root_dict["func"] = root.__func
	root_dict["ch"] = root.__ch

	script_tree.addAttr("root", root_dict)
	script_tree.addAttr("request_params", request_params)
	script_tree.addAttr("node_index", node_index)

	return script_tree

func loadScript(script_tree):
	var root_dict = script_tree.getAttr("root")
	root.__func = root_dict["func"]
	root.__ch = root_dict["ch"]
	request_params = script_tree.getAttr("request_params", request_params)
	node_index = script_tree.getAttr("node_index", node_index)

func __dfsConstruct(u):
	node_index += 1
	u["index"] = node_index

	var cur_func = u["func"]
	var cur_request_params = cur_func.getParamsType()
	
	cur_request_params.resize(u["ch"].size())
	
	# 处理可变参数函数的情况
	for index in range(u["ch"].size()):
		if cur_request_params == null:
			cur_request_params[index] = cur_request_params[0]

	var param_index = 0
	for type in cur_request_params:
		if u["ch"][param_index] == null:
			if not cur_func.hasStaticParam(param_index):
				request_params[str(node_index) + "_" + str(param_index)] = type
		else:
			__dfsConstruct(u["ch"][param_index])

		param_index += 1

func __dfsExec(u, params):
	var cur_func = u["func"]
	var cur_index = u["index"]
	var cur_params = []

	if __exec_graph.has(cur_index):
		return __exec_graph[cur_index]
	
	for param_index in range(u["ch"].size()):
		if not u["ch"][param_index] == null:
			cur_params[param_index] = __dfsExec(u["ch"][param_index], params)
		else:
			cur_params[param_index] = params[str(cur_index) + "_" + str(param_index)]

	var ret = cur_func.exec(cur_params)
	__exec_graph[cur_index] = ret

	return ret
