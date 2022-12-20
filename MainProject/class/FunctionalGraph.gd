extends Node
class_name FunctionalGraph

var ScriptTree = load("res://class/ScriptTree.gd")

var root
var request_params
var node_index

var __exec_graph

func _init():
	root = null
	node_index = 0

func setRoot(functional):
	root = {}
	root["func"] = functional
	root["ch"] = []
	var siz = functional.getParamsNum()
	root["ch"].resize(siz)

	constructGraph()

func constructGraph():
	node_index = 0
	request_params = {}
	__dfsConstruct(root)

func isAdaptable(child_func, ret_index, parent_func, param_index):
	Exception.assert(ret_index < child_func.getRetNum())
	Exception.assert(param_index < parent_func.getParamsNum())
	var rets_type = child_func.getRetType()
	var params_type = parent_func.getParamsType()

	var param_type = params_type[param_index]
	var ret_type = rets_type[ret_index]

	if (param_type != ret_type):
		return false
	return true

func connectNode(child_node, ret_index, parent_node, param_index):
	Exception.assert(isAdaptable(child_node["func"], ret_index,
								 parent_node["func"], param_index), "Connect Fail!")
	parent_node["ch"][param_index] = [child_node, ret_index]
	
	constructGraph()

func disconnectNode(parent_node, param_index):
	Exception.assert(param_index < parent_node["ch"].size())
	parent_node["ch"][param_index] = null

	constructGraph()

func getRequestParams():
	return request_params
	
func exec(params):
	__exec_graph = {}
	return __dfsExec(root, params)

func __dfsConstruct(u):
	node_index += 1
	u["index"] = node_index

	var cur_func = u["func"]
	var cur_request_params = cur_func.getParamsType()

	var param_index = 0
	for type in cur_request_params:
		if u[param_index] == null:
			request_params[str(node_index) + "_" + str(param_index)] = type
		else:
			__dfsConstruct(u[param_index])

		param_index += 1

func __dfsExec(u, params):
	var cur_func = u["func"]
	var cur_index = u["index"]
	var cur_params = []
	var cur_params_type = cur_func.getParamsType()

	var param_index = 0

	if __exec_graph.has(cur_index):
		return __exec_graph[cur_index]

	for type in cur_params_type:
		if not u[param_index] == null:
			cur_params[param_index] = __dfsExec(u[param_index], params)
		else:
			cur_params[param_index] = params[str(cur_index) + "_" + str(param_index)]
	var ret = cur_func.exec(cur_params)
	__exec_graph[cur_index] = ret

	return ret

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("root", root)
	script_tree.addAttr("request_params", request_params)
	script_tree.addAttr("node_index", node_index)

	return script_tree

func loadScript(script_tree):
	root = script_tree.getAttr("root")
	request_params = script_tree.getAttr("request_params", request_params)
	node_index = script_tree.getAttr("node_index", node_index)
