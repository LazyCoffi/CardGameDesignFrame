extends Node
class_name Attr

var ScriptTree = TypeUnit.type("ScriptTree")
var Function = TypeUnit.type("Function")

var table

class AttrNode:
	var attr_name
	var attr
	var attr_type
	var getter_function
	var setter_function

	func _init():
		attr_name = ""
		attr_type = ""
		attr = null
		getter_function = null
		setter_function = null

	func copy():
		var ret = AttrNode.new()
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
		return getter(attr)

	func setAttr(attr_):
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
		setter_function = script_tree.getObjectDict("setter_function", Function)

func _init():
	table = {}

func copy():
	var ret = TypeUnit.type("Attr").new()
	ret.table = {}
	for key in table.keys():
		ret.table[key] = table[key].copy()
	
	return ret

func getAttr(attr_name):
	return table[attr_name].getAttr()

func getAttrType(attr_name):
	return table[attr_name].getAttrType()

func getAttrList():
	var ret = []
	for attr_node in table.values():
		if attr_node != null:
			ret.append(attr_node.getAttr())

	return ret

func setAttr(attr_name, attr):
	table[attr_name].setAttr(attr)

func addAttr(attr_name, attr_type, attr, getter_function, setter_function):
	var attr_node = AttrNode.new()
	attr_node.setAttrName(attr_name)
	attr_node.setAttrType(attr_type)
	attr_node.setAttr(attr)
	attr_node.setGetterFunction(getter_function)
	attr_node.setSetterFunction(setter_function)

	table[attr_name] = attr_node

func delAttr(attr_name):
	table[attr_name] = null

func getIndexList():
	var ret = []
	for key in table.keys():
		if table[key] != null:
			ret.append(key)

	return ret

func getFullIndexList():
	return table.keys()

func addIndex(index):
	table[index] = null

func delIndex(index):
	table.erase(index)

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObjectDict("table", table)

	return script_tree

func loadScript(script_tree):
	table = script_tree.getObjectDict("table", AttrNode)
