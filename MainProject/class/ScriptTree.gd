extends Node
class_name ScriptTree

var root

func _init():
	root = {}
	
func setRoot(root_):
	Exception.assert(root_ is Dictionary)
	root = root_

func getRoot():
	return root

func has(name_):
	return root.has(name_)

func loadFromJson(path):
	var file = File.new()
	Exception.assert(file.file_exists(path))
	file.open(path, File.READ)
	var json_str = file.get_as_text()
	file.close()
	var json_ret = JSON.parse(json_str)
	Exception.assert(json_ret.error == 0)
	root = json_ret.result

func getAttr(obj_name):
	Exception.assert(root.has(obj_name))
	return root[obj_name]

func getObject(obj_name, obj_type):
	Exception.assert(root.has(obj_name))

	var ScriptTree = load("res://class/ScriptTree.gd")
	var script_tree = ScriptTree.new()
	script_tree.setRoot(root[obj_name])

	var obj = obj_type.new()
	obj.loadScript(script_tree)

	return obj

func getObjectDict(dict_name, obj_type):
	Exception.assert(root.has(dict_name))

	var cur_dict = root[dict_name]
	Exception.assert(cur_dict is Dictionary)

	var dict = {}
	var ScriptTree = load("res://class/ScriptTree.gd")
	for key in cur_dict.keys():
		var script_tree = ScriptTree.new()
		script_tree.setRoot(cur_dict[key])

		var obj = obj_type.new()
		obj.loadScript(script_tree)

		dict[key] = obj
	
	return dict

func getObjectArray(arr_name, obj_type):
	Exception.assert(root.has(arr_name))

	var cur_arr = root[arr_name]
	Exception.assert(cur_arr is Array)

	var arr = {}
	var ScriptTree = load("res://class/ScriptTree.gd")
	for raw_script in arr:
		var script_tree = ScriptTree.setRoot(raw_script)

		var obj = obj_type.new()
		obj.loadScript(script_tree)

		arr.append(obj)
	
	return arr


func addAttr(attr_name, attr):
	root[attr_name] = attr

func addObject(obj_name, obj):
	root[obj_name] = obj.pack()

func addObjectDict(obj_name, cur_dict):
	var dict = {}
	for key in cur_dict.keys():
		dict[key] = cur_dict[key].pack()
	
	root[obj_name] = dict

func addObjectArray(obj_name, cur_arr):
	var arr = []
	for obj in cur_arr:
		arr.append(obj.pack())
	
	root[obj_name] = arr
