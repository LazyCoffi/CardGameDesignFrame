extends Node
class_name SwitchTargetTable

var ScriptTree = TypeUnit.type("ScriptTree")

class TargetPack:
	var scene_type		# String
	var scene_name		# String

	func _init():
		scene_type = ""
		scene_name = ""

	func copy():
		var ret = TargetPack.new()
		ret.scene_type = scene_type
		ret.scene_type = scene_type

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

	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("scene_type", scene_type)
		script_tree.addAttr("scene_name", scene_name)

		return script_tree

	func loadScript(script_tree):
		scene_type = script_tree.getStr("scene_type")
		scene_name = script_tree.getStr("scene_name")
		
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
	Exception.assert(table.has(target_name))
	return table[target_name].getSceneType()

func getTargetSceneName(target_name):
	Exception.assert(table.has(target_name))
	return table[target_name].getSceneName()

func addTarget(target_name, scene_type, scene_name):
	var target_pack = TargetPack.new()

	target_pack.setSceneType(scene_type)
	target_pack.setSceneName(scene_name)

	table[target_name] = target_pack

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObjectDict("table", table)

	return script_tree

func loadScript(script_tree):
	table = script_tree.getObjectDict("table", TargetPack)
