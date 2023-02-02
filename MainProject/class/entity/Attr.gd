extends Node
class_name Attr

var ScriptTree = TypeUnit.type("ScriptTree")
var Filter = TypeUnit.type("Filter")

var table

class AttrNode:
	var attr_name
	var attr
	var attr_type
	var getter_filter
	var setter_filter

	func _init():
		attr_name = ""
		attr_type = ""
		attr = null
		getter_filter = null
		setter_filter = null

	func copy():
		var ret = AttrNode.new()
		ret.attr_name = attr_name
		ret.attr_type = attr_type
		ret.attr = attr
		ret.getter_filter = getter_filter.copy()
		ret.setter_filter = setter_filter.copy()

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

	# getter_filter
	func getter(cur_attr):
		return getter_filter.exec([cur_attr])
	
	func setGetterFilter(getter_filter_):
		getter_filter = getter_filter_
	
	# setter_filter
	func setter(cur_attr):
		return setter_filter.exec([cur_attr])

	func setSetterFilter(setter_filter_):
		setter_filter = setter_filter_
	
	func pack():
		var script_tree = ScriptTree.new()
		
		script_tree.addAttr("attr_name", attr_name)
		script_tree.addAttr("attr_type", attr_type)
		script_tree.addAttr("attr", attr)
		script_tree.addObject("getter_filter", getter_filter)
		script_tree.addObject("setter_filter", setter_filter)

		return script_tree
	
	func loadScript(script_tree):
		attr_name = script_tree.getStr("attr_name")
		attr_type = script_tree.getStr("attr_type")
		attr = script_tree.getRawAttr("attr")
		getter_filter = script_tree.getObject("getter_filter", Filter)
		setter_filter = script_tree.getObjectDict("setter_filter", Filter)

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
		if attr_node != null
			ret.append(attr_node.getAttr())

	return ret

func setAttr(attr_name, attr):
	table[attr_name].setAttr(attr)

func addAttr(attr_name, attr_type, attr, getter_filter, setter_filter):
	var attr_node = AttrNode.new()
	attr_node.setAttrName(attr_name)
	attr_node.setAttrType(attr_type)
	attr_node.setAttr(attr)
	attr_node.setGetterFilter(getter_filter)
	attr_node.setSetterFilter(setter_filter)

	table[attr_name] = attr_node

func delAttr(attr_name):
	table[attr_name] = null

func getIndexList():
	var ret = []
	for key in table.keys():
		if table[key] != null
			ret.append(key)

	return ret

func getFullIndexList():
	return table.keys()

func addIndex(index):
	table[index] = null

func delIndex(index):
	table.erase(index)

func getAttrType(attr_name):
	return table[attr_name].getAttrType()

func setAttrType(attr_name, attr_type):
	table[attr_name] = attr_type	

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObjectDict("table", table)

	return script_tree

func loadScript(script_tree):
	table = script_tree.getObjectDict("table", AttrNode)
