extends Node
class_name SwitchTargetTable

var ScriptTree = TypeUnit.type("ScriptTree")

class TargetPack:
	var scene_type		# String
	var scene_name		# String
	var signal_name	# String

	func copy():
		var ret = TargetPack.new()
		ret.scene_type = scene_type
		ret.scene_type = scene_type
		ret.signal_name = signal_name

		return ret

	func getSceneType():
		return scene_type

	func getSceneName():
		return scene_name

	func getSignalName():
		return signal_name

	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("scene_type", scene_type)
		script_tree.addAttr("scene_name", scene_name)
		script_tree.addAttr("signal_name", signal_name)

		return script_tree

	func loadScript(script_tree):
		scene_type = script_tree.getStr("scene_type")
		scene_name = script_tree.getStr("scene_name")
		signal_name = script_tree.getStr("signal_name")
		
var table	# Dict

func _init():
	table = {}

func copy():
	var ret = TypeUnit.type("SwitchTargetTable").new()
	ret.table = {}
	for key in table.keys():
		ret.table[key] = table[key].copy()
	
	return ret

func getTarget(target_name):
	Exception.assert(table.has(target_name))
	return table[target_name]

func addTarget(target_name, scene_type, scene_name, signal_name):
	var target_pack = TargetPack.new()

	target_pack.scene_type = scene_type
	target_pack.scene_name = scene_name
	target_pack.signal_name = signal_name

	table[target_name] = target_pack

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObjectDict("table", table)

	return script_tree

func loadScript(script_tree):
	script_tree.getObjectDict("table", TargetPack)
