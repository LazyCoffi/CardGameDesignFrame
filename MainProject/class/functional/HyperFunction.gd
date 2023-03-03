extends Node
class_name HyperFunction

var Function = TypeUnit.type("Function")
var ScriptTree = TypeUnit.type("ScriptTree")
var ArrangeMap = TypeUnit.type("ArrangeMap")

var func_name			# String
var functions			# Function_Array
var param_map			# ArrangeMap 
var ret_map				# ArrangeMap

func _init():
	func_name = ""
	functions = []
	param_map = ArrangeMap.new()
	ret_map = ArrangeMap.new()

func copy():
	var ret = TypeUnit.type("HyperFunction").new()
	ret.func_name = func_name
	ret.functions = []
	for node in functions:
		ret.functions.append(node.copy())
	
	ret.param_map = param_map.copy()
	ret.ret_map = ret_map.copy()

	return ret

## FactoryInterface
func setFunctions(functions_):
	functions = functions_

func setFuncName(func_name_):
	func_name = func_name_

## RuntimeInterface
func peekParamMap():
	return param_map.getMap()

func setParamMap(map):
	param_map.setMap(map)

func initParamMap():
	var size = getParamsNum()
	var map = []
	for index in size:
		map.append(index)

	param_map.setMap(map)

func peekRetMap():
	return ret_map.getMap()

func setRetMap(map):
	ret_map.setMap(map)

func initRetMap():
	var size = getFunctionsNum()
	var map = []
	for index in size:
		map.append(index)

	ret_map.setMap(map)

func exec(params):
	var cur_params = param_map.trans(params)
	var ret = []

	for function in functions:
		var p_map = function.getParamMap().getMap()
		var function_params = []
		for _index in range(p_map.size()):
			function_params.append(cur_params.pop_front()) 
		ret.append(function.exec(function_params))

	return ret_map.trans(ret)

# func_name
func getFuncName():
	return func_name

func clearFunctions():
	functions.clear()


func getFunctions():
	return functions.duplicate()

func getFunction(index):
	Logger.assert(index < functions.size(), "Index out of size")

	return functions[index]

func getParamsType():
	var params_type = []
	for function in functions:
		params_type.append_array(function.getParamsType())
	
	return params_type

func getParamsNum():
	var ret = 0

	for function in functions:
		ret += function.getParamsNum()
	
	return ret

func getFunctionsNum():
	return functions.size()

func getRetType():
	var ret_type = []

	for function in functions:
		ret_type.append(function.getRetType())
	
	return ret_type

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("func_name", func_name)
	script_tree.addObjectArray("functions", functions)
	script_tree.addObject("param_map", param_map)
	script_tree.addObject("ret_map", ret_map)

	return script_tree

func loadScript(script_tree):
	func_name = script_tree.getStr("func_name")
	functions = script_tree.getObjectArray("functions", Function)
	param_map = script_tree.getObject("param_map", ArrangeMap)
	ret_map = script_tree.getObject("ret_map", ArrangeMap)
