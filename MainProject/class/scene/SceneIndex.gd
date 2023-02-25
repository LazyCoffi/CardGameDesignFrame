extends Node
class_name SceneIndex

var ScriptTree = TypeUnit.type("ScriptTree")

var type			# String
var scene_name	# String
var is_complete		# bool

func getType():
	return type

func setType(type_):
	type = type_

func getSceneName():
	return scene_name

func setSceneName(scene_name_):
	scene_name = scene_name_

func isComplete():
	return is_complete

func setIsComplete(is_complete_):
	is_complete = is_complete_

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("type", type)
	script_tree.addAttr("scene_name", scene_name)
	script_tree.addAttr("is_complete", is_complete)

	return script_tree

func loadScript(script_tree):
	type = script_tree.getStr("type")
	scene_name = script_tree.getStr("scene_name")
	is_complete = script_tree.getBool("is_complete")
