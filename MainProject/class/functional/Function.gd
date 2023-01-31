extends Node
class_name Function

var ScriptTree = TypeUnit.type("ScriptTree")
var Category = TypeUnit.type("Category")
var ParamList = TypeUnit.type("ParamList")

var func_name			# String
var category			# Category
var default_params		# ParamList 

func _init():
	category = Category.new()
	default_params = ParamList.new()

func copy():
	var ret = TypeUnit.type("Function").new()
	ret.func_name = func_name
	ret.category = category.copy()
	ret.default_params = default_params.copy()
	return ret

func exec(params):
	return FunctionalCategory.exec(func_name, category, params)

# func_name
func getFuncName():
	return func_name

func setFuncName(func_name_):
	func_name = func_name_

# category
func getCategory():
	return category

func setCategory(category_):
	category = category_

# default_params
func getDefaultParams():
	return default_params

func hasDefaultParam(index):
	return default_params.hasParam(index)

func getDefaultParam(index):
	return default_params.getParam(index)

func setDefaultParams():
	return default_params

func initDefaultParams():
	default_params.resize(getParamsNum())

func setDefaultParam(index, param_type, param):
	default_params.setParam(index, param_type, param)

func addDefaultParam(param_type, param):
	default_params.addParam(param_type, param)

func addDefaultParamGap():
	default_params.addGap()

func delDefaultParam(index):
	default_params.delParam(index)

func removeDefaultParam(index):
	default_params.removeParam(index)

func getRetType():
	return FunctionalCategory.getRetType(category, func_name)

func getParamsType():
	return FunctionalCategory.getParamsType(category, func_name)

func getParamsNum():
	return getParamsType().size()

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("func_name", func_name)
	script_tree.addObject("category", category)
	script_tree.addObject("default_params", default_params)

	return script_tree

func loadScript(script_tree):
	func_name = script_tree.getStr("func_name")
	category = script_tree.getObject("category", Category)
	default_params = script_tree.getObject("default_params", ParamList)
