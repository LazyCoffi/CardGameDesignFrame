extends Node
class_name AttrNode

var attr_name			# String
var attr				# String
var attr_type			# Value
var getter_function		# Function
var setter_function		# Function

func _init():
	attr_name = ""
	attr_type = ""
	attr = null
	getter_function = null
	setter_function = null

func copy():
	var ret = TypeUnit.type("AttrNode").new()
	ret.attr_name = attr_name
	ret.attr_type = attr_type
	ret.attr = attr
	ret.getter_function = getter_function.copy()
	ret.setter_function = setter_function.copy()

	return ret

# attr_name
func getAttrName():
	return attr_name

func setAttrName(attr_name_):
	attr_name = attr_name_

# attr_type
func getAttrType():
	return attr_type

func setAttrType(attr_type_):
	attr_type = attr_type_

# attr
func getAttr():
	match attr_type:
		"Integer" :
			return getter(int(attr))
		"Float":
			return getter(float(attr))
		"StringPack":
			return getter(str(attr))

func setAttr(attr_):
	match attr_type:
		"Integer" :
			attr_ = int(attr_)
		"Float":
			attr_ = float(attr_)
		"StringPack":
			attr_ = str(attr_)

	attr = setter(attr_)

# getter_function
func getter(cur_attr):
	return getter_function.exec([cur_attr])

func setGetterFunction(getter_function_):
	getter_function = getter_function_

# setter_function
func setter(cur_attr):
	return setter_function.exec([cur_attr])

func setSetterFunction(setter_function_):
	setter_function = setter_function_

func pack():
	var script_tree = ScriptTree.new()
	
	script_tree.addAttr("attr_name", attr_name)
	script_tree.addAttr("attr_type", attr_type)
	script_tree.addAttr("attr", attr)
	script_tree.addObject("getter_function", getter_function)
	script_tree.addObject("setter_function", setter_function)

	return script_tree

func loadScript(script_tree):
	attr_name = script_tree.getStr("attr_name")
	attr_type = script_tree.getStr("attr_type")
	attr = script_tree.getRawAttr("attr")
	getter_function = script_tree.getObject("getter_function", Function)
	setter_function = script_tree.getObject("setter_function", Function)

