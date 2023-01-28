extends Node
class_name SettingTable

var ScriptTree = load("res://class/entity/ScriptTree.gd")

var table	# Dict

func _init():
	table = {}

func getAttr(attr_name):
	Exception.assert(table.has(attr_name))

	return attr_name

func setAttr(attr_name, attr):
	Exception.assert(table.has(attr_name))

	table[attr_name] = attr

func addListNode(attr_name):
	table[attr_name] = null

func getList():
	return table.keys()

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr(table)

	return script_tree

func loadScript(script_tree):
	table = script_tree.getRawAttr("table")
