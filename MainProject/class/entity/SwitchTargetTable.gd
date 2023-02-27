extends Node
class_name SwitchTargetTable

var ScriptTree = TypeUnit.type("ScriptTree")

class TargetPack:
	var scene_type		# String
	var scene_name		# String
	var switch_type		# String

	func _init():
		scene_type = ""
		scene_name = ""
		switch_type = ""

	func copy():
		var ret = TargetPack.new()
		ret.scene_type = scene_type
		ret.scene_type = scene_type
		ret.switch_type = switch_type

		return ret

	# scene_type
	func getSceneType():
		return scene_type
	
	func setSceneType(scene_type_):
		scene_type = scene_type_

	# scene_name
	func getSceneName():
		return scene_name
	
	func setSceneName(scene_name_):
		scene_name = scene_name_

	# switch_type
	func getSwitchType():
		return switch_type
	
	func setSwitchType(switch_type_):
		switch_type = switch_type_

	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("scene_type", scene_type)
		script_tree.addAttr("scene_name", scene_name)
		script_tree.addAttr("switch_type", switch_type)

		return script_tree

	func loadScript(script_tree):
		scene_type = script_tree.getStr("scene_type")
		scene_name = script_tree.getStr("scene_name")
		switch_type = script_tree.getStr("switch_type")
		
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

	target_pack.setSceneType(scene_type)
	target_pack.setSceneName(scene_name)
	target_pack.setSwitchType(switch_type)

	table[target_name] = target_pack

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObjectDict("table", table)

	return script_tree

func loadScript(script_tree):
	table = script_tree.getObjectDict("table", TargetPack)
