extends Node
class_name SettingTable

var ScriptTree = TypeUnit.type("ScriptTree")

var table	# Dict

func _init():
	table = {}

func copy():
	var ret = TypeUnit.type("SettingTable").new()
	ret.table = table.duplicate(true)

	return ret

func getAttr(attr_name):
	Exception.assert(table.has(attr_name))

	return table[attr_name]

func setAttr(attr_name, attr):
	Exception.assert(table.has(attr_name))

	table[attr_name] = attr

func addIndex(index):
	table[index] = null

func getIndexList():
	return table.keys()

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("table", table)

	return script_tree

func loadScript(script_tree):
	table = script_tree.getRawAttr("table")
