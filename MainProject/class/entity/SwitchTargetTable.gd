extends Node
class_name SwitchTargetTable

var ScriptTree = load("res://class/entity/ScriptTree.gd")

class TargetPack:
	var scene_type		# String
	var scene_name		# String
	var switch_signal	# String
	
	func getSceneType():
		return scene_type

	func getSceneName():
		return scene_name

	func getSignalName():
		return switch_signal

	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("scene_type", scene_type)
		script_tree.addAttr("scene_name", scene_name)
		script_tree.addAttr("switch_signal", switch_signal)

		return script_tree

	func loadScript(script_tree):
		scene_type = script_tree.getStr("scene_type")
		scene_name = script_tree.getStr("scene_name")
		switch_signal = script_tree.getStr("swtich_signal")
		
var table	# Dict

func _init():
	table = {}

func getTarget(target_name):
	Exception.assert(table.has(target_name))
	return table[target_name]

func addTarget(target_name, scene_name, scene_pack_requirement, signal_name):
	var target_pack = TargetPack.new()
	target_pack.scene_name = scene_name
	target_pack.scene_pack_requirement = scene_pack_requirement
	target_pack.signal_name = signal_name

	table[target_name] = target_pack

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObjectDict("table", table)

	return script_tree

func loadScript(script_tree):
	script_tree.getObjectDict("table", TargetPack)

