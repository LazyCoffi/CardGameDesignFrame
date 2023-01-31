extends Node
class_name ScriptTree

var root

func _init():
	root = {}

func copy():
	var ret = TypeUnit.type("ScriptTree").new()
	ret.root = root.duplicate(true)
	return ret

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

func exportAsJson(path):
	var file = File.new()
	Exception.assert(file.file_exists(path))
	file.open(path, File.WRITE)
	var json_str = JSON.print(root, "\t")
	file.store_string(json_str)
	file.close()

func addAttr(attr_name, attr):
	root[attr_name] = attr

func addObject(obj_name, obj):
	root[obj_name] = obj.pack().__getRoot()

func addObjectDict(dict_name, cur_dict):
	var dict = {}
	for key in cur_dict.keys():
		dict[key] = cur_dict[key].pack().__getRoot()
	
	root[dict_name] = dict

func addObjectArray(arr_name, cur_arr):
	var arr = []
	for obj in cur_arr:
		arr.append(obj.pack().__getRoot())
	
	root[arr_name] = arr

func addScriptTree(script_name, script_tree):
	if script_tree == null:
		root[script_name] = null
		return

	addAttr(script_name, script_tree.__getRoot())

func addScriptTreeDict(dict_name, cur_dict):
	var dict = {}	
	for key in cur_dict:
		dict[key] = cur_dict[key].__getRoot()
	
	root[dict_name] = dict

func addScriptTreeArray(arr_name, cur_arr):
	var arr = []
	for script_tree in cur_arr:
		arr.append(script_tree.__getRoot())

	root[arr_name] = arr

func addTypeObject(container_name, container):
	addObject(container_name, container)

func addTypeObjectDict(dict_name, cur_dict):
	addObjectDict(dict_name, cur_dict)

func addTypeObjectArray(arr_name, cur_arr):
	addObjectArray(arr_name, cur_arr)

func getInt(obj_name):
	Exception.assert(root.has(obj_name))
	return int(root[obj_name])

func getIntDict(dict_name):
	Exception.assert(root.has(dict_name))
	for key in root[dict_name].keys():
		root[dict_name][key] = int(root[dict_name][key])
	
	return root[dict_name]

func getIntArray(arr_name):
	Exception.assert(root.has(arr_name))
	for index in range(root[arr_name].size()):
		root[arr_name][index] = int(root[arr_name][index])
	
	return root[arr_name]

func getFloat(obj_name):
	Exception.assert(root.has(obj_name))
	return float(root[obj_name])

func getFloatDict(dict_name):
	Exception.assert(root.has(dict_name))
	for key in root[dict_name].keys():
		root[dict_name][key] = float(root[dict_name][key])
	
	return root[dict_name]

func getFloatArray(arr_name):
	Exception.assert(root.has(arr_name))
	for index in range(root[arr_name].size()):
		root[arr_name][index] = float(root[arr_name][index])
	
	return root[arr_name]

func getStr(obj_name):
	Exception.assert(root.has(obj_name))
	return str(root[obj_name])

func getStrDict(dict_name):
	Exception.assert(root.has(dict_name))
	for key in root[dict_name].keys():
		root[dict_name][key] = str(root[dict_name][key])
	
	return root[dict_name]

func getStrArray(arr_name):
	Exception.assert(root.has(arr_name))
	for index in range(root[arr_name].size()):
		root[arr_name][index] = str(root[arr_name][index])
	
	return root[arr_name]


func getBool(obj_name):
	Exception.assert(root.has(obj_name))
	Exception.assert(root[obj_name] is bool)
	return root[obj_name]

func getBoolDict(dict_name):
	Exception.assert(root.has(dict_name))
	for obj in root[dict_name].values():
		Exception.assert(obj is bool)
	
	return root[dict_name]

func getBoolArray(arr_name):
	Exception.assert(root.has(arr_name))
	for obj in root[arr_name]:
		Exception.assert(obj is bool)
	
	return root[arr_name]

func getAttr(attr_name, attr_type):
	match attr_type:
		"int":
			return getInt(attr_name)
		"float":
			return getFloat(attr_name)
		"String":
			return getStr(attr_name)
		"bool":
			return getBool(attr_name)
	
	Exception.assert(false)

func getAttrDict(dict_name, attr_type):
	match attr_type:
		"int":
			return getIntDict(dict_name)
		"float":
			return getFloatDict(dict_name)
		"String":
			return getStrDict(dict_name)
		"bool":
			return getBoolDict(dict_name)
	
	Exception.assert(false)

func getAttrArray(arr_name, attr_type):
	match attr_type:
		"int":
			return getIntArray(arr_name)
		"float":
			return getFloatArray(arr_name)
		"String":
			return getStrArray(arr_name)
		"bool":
			return getBoolArray(arr_name)
	
	Exception.assert(false)

func getObject(obj_name, obj_type):
	Exception.assert(root.has(obj_name))

	var script_tree = TypeUnit.type("ScriptTree").new()
	script_tree.__setRoot(root[obj_name])

	var obj = obj_type.new()
	obj.loadScript(script_tree)

	return obj

func getObjectDict(dict_name, obj_type):
	Exception.assert(root.has(dict_name))

	var cur_dict = root[dict_name]
	Exception.assert(cur_dict is Dictionary)

	var dict = {}
	for key in cur_dict.keys():
		var script_tree = TypeUnit.type("ScriptTree").new()
		script_tree.__setRoot(cur_dict[key])

		var obj = obj_type.new()
		obj.loadScript(script_tree)

		dict[key] = obj
	
	return dict

func getObjectArray(arr_name, obj_type):
	Exception.assert(root.has(arr_name))

	var cur_arr = root[arr_name]
	Exception.assert(cur_arr is Array)

	var arr = {}
	for raw_script in arr:
		var script_tree = TypeUnit.type("ScriptTree").new()
		script_tree.__setRoot(raw_script)

		var obj = obj_type.new()
		obj.loadScript(script_tree)

		arr.append(obj)
	
	return arr

func getScriptTree(script_name):
	Exception.assert(root.has(script_name))

	var script_tree = TypeUnit.type("ScriptTree").new()

	script_tree.__setRoot(root[script_name])

	return script_tree
	
func getScripTreeDict(dict_name):
	Exception.assert(root.has(dict_name))

	var script_dict = root[dict_name]
	var ret = {}
	for key in script_dict.keys():
		var script_tree = TypeUnit.type("ScriptTree").new()
		script_tree.__setRoot(script_dict[key])
		ret[key] = script_tree
	
	return ret

func getScriptTreeArray(arr_name):
	Exception.assert(root.has(arr_name))

	var script_arr = root[arr_name]
	var ret = []
	for raw_script in script_arr:
		var script_tree = TypeUnit.type("ScriptTree").new()
		script_tree.__setRoot(raw_script)
	
	return ret

func getTypeObject(obj_name, obj_type, inner_type):
	Exception.assert(root.has(obj_name))

	var obj = obj_type.new()
	obj.setParamType(inner_type)
	
	var script_tree = TypeUnit.type("ScriptTree").new()
	script_tree.__setRoot(root[obj_name])

	obj.loadScript(script_tree)

	return obj

func getTypeObjectDict(dict_name, obj_type, inner_type):
	Exception.assert(root.has(dict_name))

	var ret = {}
	var cur_dict = root[dict_name]
	for key in cur_dict.keys():
		var script_tree = TypeUnit.type("ScriptTree").new()
		script_tree.__setRoot(cur_dict[key])
		
		var obj = obj_type.new()
		obj.setParamType(inner_type)
		obj.loadScript(script_tree)
		ret[key] = obj
	
	return ret

func getTypeObjectArray(arr_name, obj_type, inner_type):
	Exception.assert(root.has(arr_name))

	var ret = []
	var cur_arr = root[arr_name]
	for raw_script in cur_arr:
		var script_tree = TypeUnit.type("ScriptTree").new()
		script_tree.__setRoot(raw_script)

		var obj = obj_type.new()
		obj.setParamType(inner_type)
		obj.loadScript(script_tree)
		ret.append(obj)
	
	return ret

func getRawAttr(attr_name):
	Exception.assert(root.has(attr_name))
	
	return root[attr_name]

func __setRoot(root_):
	Exception.assert(root_ is Dictionary)
	root = root_

func __getRoot():
	return root
