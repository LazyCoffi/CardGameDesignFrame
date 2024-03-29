extends Node
class_name FuncUnit

var ScriptTree = TypeUnit.type("ScriptTree")
var ParamList = TypeUnit.type("ParamList")

var func_name				# String
var func_set_name			# String
var default_params			# ParamList 

func _init():
	func_name = ""
	func_set_name = ""
	default_params = ParamList.new()

func copy():
	var ret = TypeUnit.type("FuncUnit").new()

	ret.func_name = func_name
	ret.func_set_name = func_set_name
	ret.default_params = default_params.copy()

	return ret

func exec(params):
	return FuncCategory.exec(func_name, func_set_name, params)

# func_name
func getFuncName():
	return func_name

func setFuncName(func_name_):
	func_name = func_name_

# func_set_name
func getFuncSetName():
	return func_set_name

func setFuncSetName(func_set_name_):
	func_set_name = func_set_name_

# default_params
func hasDefaultParam(index):
	return default_params.hasParam(index)

func getDefaultParam(index):
	return default_params.getParam(index)

func getDefaultParams():
	return default_params.getParamsList()

func initDefaultParams():
	default_params.resize(getParamsNum())

func setDefaultParam(param_type, param, index):
	default_params.setParam(param_type, param, index)

func delDefaultParam(index):
	default_params.delParam(index)

func getRetType():
	return FuncCategory.getRetType(func_set_name, func_name)

func getParamsType():
	return FuncCategory.getParamsType(func_set_name, func_name)

func getParamsNum():
	return getParamsType().size()

func setDefaultParams(default_params_):
	default_params = default_params_

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("func_name", func_name)
	script_tree.addAttr("func_set_name", func_set_name)
	script_tree.addObject("default_params", default_params)

	return script_tree

func loadScript(script_tree):
	func_name = script_tree.getStr("func_name")
	func_set_name = script_tree.getStr("func_set_name")
	default_params = script_tree.getObject("default_params", ParamList)
