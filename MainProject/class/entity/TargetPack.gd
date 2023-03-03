extends Node
class_name TargetPack

var target_name		# String
var scene_type		# String
var scene_name		# String
var switch_type		# String

func _init():
	target_name = ""
	scene_type = ""
	scene_name = ""
	switch_type = ""

func copy():
	var ret = TypeUnit.type("TargetPack").new()
	ret.target_name = target_name
	ret.scene_type = scene_type
	ret.scene_type = scene_type
	ret.switch_type = switch_type

	return ret

# target_name
func getTargetName():
	return target_name

func setTargetName(target_name_):
	target_name = target_name_

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

	script_tree.addAttr("target_name", target_name)
	script_tree.addAttr("scene_type", scene_type)
	script_tree.addAttr("scene_name", scene_name)
	script_tree.addAttr("switch_type", switch_type)

	return script_tree

func loadScript(script_tree):
	target_name = script_tree.getStr("target_name")
	scene_type = script_tree.getStr("scene_type")
	scene_name = script_tree.getStr("scene_name")
	switch_type = script_tree.getStr("switch_type")
