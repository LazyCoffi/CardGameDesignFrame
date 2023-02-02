extends Node
class_name CategoryTree

var ScriptTree = TypeUnit.type("ScriptTree")

var root			# Dict
var table			# Dict

func _init():
	root = {}
	table = {}

func copy():
	var ret = TypeUnit.type("CategoryTree").new()

	ret.root = root.duplicate(true)

	return ret

func addIndex(index_list):
	var node = root
	for index in index_list:
		if not node.has(index):
			node[index] = {}
		node = node[index]
	
func addEntry(index_list, entry):
	var node = root
	for index in index_list:
		if not node.has(index):
			node[index] = {}
		node = node[index]
	
	node[entry] = entry
	table[entry] = index_list

func getIndexList(entry):
	return table[entry]

func getChIndexList(index_list):
	var node = root
	for index in index_list:
		node = node[index]
	
	var ret = []

	for index in node.keys():
		if node[index] is Dictionary:
			ret.append(index)
	
	return ret

func getChEntryList(index_list):
	var node = root
	for index in index_list:
		node = node[index]

	var ret = []

	for index in node.keys():
		if node[index] is String:
			ret.append(index)
	
	return ret

func getChList(index_list):
	var node = root
	for index in index_list:
		node = node[index]
	
	var ret = []
	
	for index in node.keys():
		if node[index] is String:
			ret.append(["entry", index])
		if node[index] is Dictionary:
			ret.append(["index", index])
	
	return ret

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("root", root)
	script_tree.addAttr("table", table)

	return script_tree

func loadScript(script_tree):
	root = script_tree.getRawAttr("root")
	table = script_tree.getRawAttr("table")
