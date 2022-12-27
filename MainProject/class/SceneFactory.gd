extends Node
class_name SceneFactory

var ScriptTree = load("res://class/ScriptTree.gd")
var MainMenuScene = load("res://scene/MainMenuScene/MainMenuScene.tscn")

var raw_scene_scripts
var type_table

func _init():
	__initTypeTable()
	__preloadScript()

func getSceneNode(scene_name):
	var raw_info = raw_scene_scripts[scene_name]
	var scene_type = raw_info["type"]
	var raw_script = raw_info["script"]

	var script_tree = ScriptTree.new()
	script_tree.setRoot(raw_script)

	var scene = scene_type.instance()
	scene.loadScript(script_tree)

	var scene_node = {}
	scene_node["type"] = scene_type
	scene_node["scene_name"] = scene_name
	scene_node["scene"] = scene

	return scene_node

func __initTypeTable():
	type_table = {}
	type_table["MainMenuScene"] = MainMenuScene

func __preloadScript():
	raw_scene_scripts = {}
	var script_tree = ScriptTree.new()
	script_tree.loadFromJson("res://scripts/system/sceneScriptList.json")
	raw_scene_scripts = script_tree.getAttr("raw_scene_script")

