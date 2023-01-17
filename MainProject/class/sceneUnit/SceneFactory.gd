extends Node
class_name SceneFactory

var ScriptTree = load("res://class/entity/ScriptTree.gd")
var SceneCache = load("res://class/sceneUnit/SceneCache.gd")

var raw_scene_scripts

func _init():
	__initScript()

func getSceneNode(scene_name):
	var raw_info = raw_scene_scripts[scene_name]
	var type = raw_info["type"]
	var scene_type = TypeUnit.getTypeByName(type)
	var raw_script = raw_info["script"]

	var script_tree = ScriptTree.new()
	script_tree.setRoot(raw_script)

	var scene = scene_type.instance()
	scene.initScript(script_tree)

	var scene_node = SceneCache.SceneNode.new()	
	scene_node.type = type
	scene_node.scene_name = scene_name
	scene_node.scene = scene

	return scene_node

func __initScript():
	raw_scene_scripts = {}
	var script_tree = ScriptTree.new()
	script_tree.loadFromJson("res://scripts/scene/sceneFactory.json")
	raw_scene_scripts = script_tree.getAttr("raw_scene_script")
