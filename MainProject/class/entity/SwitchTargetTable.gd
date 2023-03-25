extends Node
class_name SwitchTargetTable

var ScriptTree = TypeUnit.type("ScriptTree")
var TargetPack = TypeUnit.type("TargetPack")
		
var table	# Dict

func _init():
	table = {}

func copy():
	var ret = TypeUnit.type("SwitchTargetTable").new()

	ret.table = {}
	for key in table.keys():
		ret.table[key] = table[key].copy()
	
	return ret

func getTargetSceneType(target_name):
	Logger.assert(table.has(target_name), "Table doesn't have " + target_name + "!")
	return table[target_name].getSceneType()

func getTargetSceneName(target_name):
	Logger.assert(table.has(target_name), "Table doesn't have " + target_name + "!")
	return table[target_name].getSceneName()

func getTargetSwitchType(target_name):
	Logger.assert(table.has(target_name), "Table doesn't have " + target_name + "!")
	return table[target_name].getSwitchType()

func addTarget(target_name, scene_type, scene_name, switch_type):
	var target_pack = TargetPack.new()

	target_pack.setTargetName(target_name)
	target_pack.setSceneType(scene_type)
	target_pack.setSceneName(scene_name)
	target_pack.setSwitchType(switch_type)

	table[target_name] = target_pack

func getTable():
	return table

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObjectDict("table", table)

	return script_tree

func loadScript(script_tree):
	table = script_tree.getObjectDict("table", TargetPack)
