extends Node
class_name ScriptTree

var root

func _ready():
	pass

func setRoot(root_):
	root = root_

func getRoot():
	return root

func loadFromJson(path):
	var file = File.new()
	Exception.assert(file.file_exists(path))
	file.open(path, File.READ)
	var json_str = file.get_as_text()
	file.close()
	var json_ret = JSON.parse(json_str)
	Exception.assert(json_ret.error == 0)
	root = json_ret.result

func findNode(path_str):
	var path = path_str.split("/")
	var cur_node = root 
	for next_index in path:
		Exception.assert(cur_node.has(next_index))
		cur_node = cur_node[next_index]
	
	return cur_node

func add(param_name, param, path_str := ""):
	Exception.assert(root is Dictionary)
	var cur_node = findNode(path_str)
	cur_node[param_name] = param

func addScript(param_name, param, path_str := ""):
	Exception.assert(root is Dictionary)
	var cur_node = findNode(path_str)
	cur_node[param_name] = param.pack().getRoot()

func addScriptDict(param_name, param, path_str := ""):
	Exception.assert(root is Dictionary)
	var cur_node = findNode(path_str)
	var script_dict = {}
	for key in param.keys():
		script_dict[key] = param[key].pack().getRoot()
	
	cur_node[param_name] = script_dict

func addScriptArray(param_name, params, path_str := ""):
	Exception.assert(root is Dictionary)
	var cur_node = findNode(path_str)
	var script_array = []
	for param in params:
		script_array.append(param.pack().getRoot())

	cur_node[param_name] = script_array

func get(path_str):
	Exception.assert(root is Dictionary)
	return findNode(path_str)
	
func getScript(path_str):
	Exception.assert(root is Dictionary)
	var script = Script.new()
	script.setRoot(findNode(path_str))
	return script

func getScriptDict(path_str):
	Exception.assert(root is Dictionary)
	var scriptDict = findNode(path_str)
	Exception.assert(scriptDict is Dictionary)
	var ret = {}
	for key in scriptDict.keys():
		var script = Script.new()
		ret[key] = script.setRoot(scriptDict[key])
	
	return ret

func getScriptArray():
	Exception.assert(root is Array)
	var ret = []
	for raw_script in root:
		var script = Script.new()
		script.setRoot(raw_script)
		ret.append(script)
	
	return ret
