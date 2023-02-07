extends Node
class_name SceneFactory

var ScriptTree = load("res://class/entity/ScriptTree.gd")

var script_tree

func getSceneNode(scene_name):
	var script_node = script_tree.getScriptTree(scene_name)
	var type = script_node.getStr("type")
	var scene_type = TypeUnit.type(type)
	var scene = scene_type.instance()

	var cur_script_tree = ScriptTree.new()
	cur_script_tree.loadFromJson(script_node.getStr("path"))
	scene.loadScript(cur_script_tree)

	return SceneCache.genSceneNode(type, scene_name, scene)
	
func initScript():
	script_tree = ScriptTree.new()
	script_tree.loadFromJson("res://scripts/system/scene_factory.json")
